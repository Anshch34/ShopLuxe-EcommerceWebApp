<%@ page import="ecommerce.model.Cart" %>
<%@ page import="ecommerce.model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page import="ecommerce.model.User" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.getTotalQuantity() : 0;
    double totalPrice = (cart != null) ? cart.getTotalPrice() : 0.0;
    User user = (User) session.getAttribute("currentUser");
    String username = (user != null) ? user.getName() : "Guest";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - ShopLuxe</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            min-height: 100vh;
            color: white;
            padding-top: 70px;
        }
        .navbar {
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            height: 70px;
            background: rgba(30, 34, 90, 0.45);
            box-shadow: 0 4px 24px 0 rgba(31, 38, 135, 0.13);
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px 0 10px;
            z-index: 100;
        }
        .navbar-left {
            display: flex;
            align-items: center;
        }
        .navbar-right {
            position: relative;
            display: flex;
            align-items: center;
        }
        .site-title {
            font-size: 2rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-shadow: 0 2px 8px #0008;
            background: linear-gradient(90deg, #6a11cb, #2575fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
        }
        .icon-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.18);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(99,102,241,0.18);
            border: 2px solid rgba(106,17,203,0.25);
            overflow: hidden;
            margin-right: 24px;
        }
        .icon-btn:last-child { margin-right: 0; }
        .icon-btn:hover {
            box-shadow: 0 4px 16px rgba(99,102,241,0.18);
        }
        .user-dropdown {
            display: none;
            position: absolute;
            top: 54px;
            right: 0;
            min-width: 170px;
            background: rgba(30, 34, 90, 0.95);
            border-radius: 14px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.25);
            padding: 18px 20px 14px 20px;
            z-index: 200;
            flex-direction: column;
            align-items: flex-start;
            animation: fadeIn 0.2s;
        }
        .user-dropdown.show {
            display: flex;
        }
        .dropdown-welcome {
            font-size: 1rem;
            margin-bottom: 12px;
            color: #fff;
            font-weight: 500;
        }
        .logout-btn {
            width: 100%;
            padding: 10px 0;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
            box-sizing: border-box;
            display: block;
            margin-top: 2px;
            text-align: center;
            text-decoration: none;
        }
        .cart-container {
            max-width: 900px;
            margin: 40px auto 0 auto;
            background: rgba(255,255,255,0.08);
            border-radius: 18px;
            padding: 32px 32px 24px 32px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 24px;
        }
        th, td {
            padding: 14px 10px;
            text-align: center;
        }
        th {
            background: linear-gradient(90deg, #6a11cb, #2575fc);
            color: #fff;
            font-size: 1.1rem;
        }
        tr {
            background: rgba(255,255,255,0.10);
        }
        tr:nth-child(even) {
            background: rgba(255,255,255,0.16);
        }
        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 10px;
        }
        .total-row td {
            font-weight: bold;
            font-size: 1.1rem;
            background: rgba(106,17,203,0.18);
        }
        .order-btn {
            width: 100%;
            padding: 14px 0;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 18px;
            box-shadow: 0 4px 16px rgba(99,102,241,0.12);
            transition: background 0.3s, transform 0.2s;
        }
        .order-btn:hover {
            background: linear-gradient(to right, #2575fc, #6a11cb);
            transform: translateY(-2px) scale(1.03);
        }
        .empty-cart {
            text-align: center;
            font-size: 1.2rem;
            color: #ffb347;
            margin: 40px 0 20px 0;
        }
        @media (max-width: 600px) {
            .cart-container { padding: 10px 2px; }
            th, td { padding: 7px 2px; font-size: 13px; }
            .order-btn { font-size: 15px; }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-left">
            <span class="site-title">ShopLuxe</span>
        </div>
        <div class="navbar-right">
            <a href="home" class="icon-btn" title="Home">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M3 10.5L12 4l9 6.5V20a1 1 0 0 1-1 1h-4a1 1 0 0 1-1-1v-4H9v4a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V10.5z" stroke="#6a11cb" stroke-width="2" fill="#fff"/>
                </svg>
            </a>
            <div class="icon-btn" id="userIcon">
                <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="20" cy="20" r="20" fill="url(#userGradient)"/>
                    <defs>
                        <linearGradient id="userGradient" x1="0" y1="0" x2="40" y2="40" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#6a11cb"/>
                            <stop offset="1" stop-color="#2575fc"/>
                        </linearGradient>
                    </defs>
                    <circle cx="20" cy="15" r="7" fill="#fff" fill-opacity="0.92"/>
                    <ellipse cx="20" cy="28" rx="11" ry="7" fill="#fff" fill-opacity="0.7"/>
                </svg>
            </div>
            <div class="user-dropdown" id="userDropdown">
                <% if (user != null) { %>
                    <div class="dropdown-welcome">Welcome, <%= username %>!</div>
                    <a href="LogoutServlet" class="logout-btn">Logout</a>
                <% } else { %>
                    <a href="login.jsp" class="logout-btn">Login</a>
                <% } %>
            </div>
        </div>
    </div>
    <div class="cart-container">
        <h2 style="text-align:center; margin-bottom: 30px;">Your Shopping Cart</h2>
        <% if (cart == null || cart.getItems().isEmpty()) { %>
            <div class="empty-cart">Your cart is empty.</div>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CartItem item : cart.getItems()) { %>
                        <tr>
                            <td><img class="product-img" src="images/<%= item.getImage() %>" alt="<%= item.getName() %>" /></td>
                            <td><%= item.getName() %></td>
                            <td><%= item.getPrice() %></td>
                            <td><%= item.getQuantity() %></td>
                            <td><%= item.getTotalPrice() %></td>
                        </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td colspan="4" style="text-align:right;">Total:</td>
                        <td><%= totalPrice %></td>
                    </tr>
                </tfoot>
            </table>
            <form action="OrderServlet" method="post">
                <button type="submit" class="order-btn">Order</button>
            </form>
        <% } %>
    </div>
    <script>
        const userIcon = document.getElementById('userIcon');
        const userDropdown = document.getElementById('userDropdown');
        document.addEventListener('click', function(event) {
            if (userIcon.contains(event.target)) {
                userDropdown.classList.toggle('show');
            } else {
                userDropdown.classList.remove('show');
            }
        });
    </script>
</body>
</html> 