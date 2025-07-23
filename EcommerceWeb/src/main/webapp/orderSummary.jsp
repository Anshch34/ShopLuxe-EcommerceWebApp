<%@ page import="ecommerce.model.Cart" %>
<%@ page import="ecommerce.model.CartItem" %>
<%@ page import="ecommerce.model.User" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.getTotalQuantity() : 0;
    double totalPrice = (cart != null) ? cart.getTotalPrice() : 0.0;
    User user = (User) session.getAttribute("currentUser");
    String username = (user != null) ? user.getName() : "Guest";
    String orderConfirmed = request.getParameter("orderConfirmed");
    if (orderConfirmed != null) {
        session.removeAttribute("cart");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Summary - ShopLuxe</title>
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
            position: relative;
        }
        .icon-btn:last-child { margin-right: 0; }
        .icon-btn:hover {
            box-shadow: 0 4px 16px rgba(99,102,241,0.18);
        }
        .cart-badge {
            position: absolute;
            top: 4px;
            right: 4px;
            background: #ff4d4f;
            color: #fff;
            border-radius: 50%;
            padding: 2px 7px;
            font-size: 13px;
            font-weight: bold;
            min-width: 22px;
            text-align: center;
            line-height: 18px;
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
        .summary-container {
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
        .total-row td {
            font-weight: bold;
            font-size: 1.1rem;
            background: rgba(106,17,203,0.18);
        }
        .form-section {
            margin-top: 30px;
        }
        .form-label {
            font-size: 1.1rem;
            margin-bottom: 8px;
            display: block;
        }
        .address-input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: none;
            font-size: 1rem;
            margin-bottom: 18px;
        }
        .payment-options {
            margin-bottom: 18px;
        }
        .payment-checkbox {
            margin-right: 18px;
            font-size: 1rem;
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
        .order-confirmed {
            text-align: center;
            font-size: 1.5rem;
            color: #4fff7b;
            margin-top: 30px;
            font-weight: bold;
        }
        @media (max-width: 600px) {
            .summary-container { padding: 10px 2px; }
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
            <a href="cart.jsp" class="icon-btn" title="Cart">
                <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="20" cy="20" r="20" fill="url(#cartGradient)"/>
                    <defs>
                        <linearGradient id="cartGradient" x1="0" y1="0" x2="40" y2="40" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#ffb347"/>
                            <stop offset="1" stop-color="#ffcc33"/>
                        </linearGradient>
                    </defs>
                    <path d="M13 28c-1.1 0-1.99.9-1.99 2S11.9 32 13 32s2-.9 2-2-.9-2-2-2zm14 0c-1.1 0-1.99.9-1.99 2S25.9 32 27 32s2-.9 2-2-.9-2-2-2zM13.16 24l.84-2h11.45c.75 0 1.41-.41 1.75-1.03l3.24-5.88A1 1 0 0 0 25.45 14H9.21l-.94-2H5v2h2l3.6 7.59-1.35 2.44C10.52 25.37 11.48 27 13 27h16v-2H13.42c-.14 0-.25-.11-.25-.25z" fill="#fff"/>
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
    <div class="summary-container">
        <h2 style="text-align:center; margin-bottom: 30px;">Order Summary</h2>
        <% if (orderConfirmed != null) { %>
            <div class="order-confirmed">Order Confirmed!!!!</div>
        <% } else if (cart == null || cart.getItems().isEmpty()) { %>
            <div class="order-confirmed" style="color:#ffb347;">Your cart is empty.</div>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1; for (CartItem item : cart.getItems()) { %>
                        <tr>
                            <td><%= i++ %></td>
                            <td><%= item.getName() %></td>
                            <td><%= item.getPrice() %></td>
                            <td><%= item.getQuantity() %></td>
                        </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td colspan="3" style="text-align:right;">Total:</td>
                        <td><%= totalPrice %></td>
                    </tr>
                </tfoot>
            </table>
            <form method="post" action="orderSummary.jsp" class="form-section">
                <label class="form-label" for="address">Delivery Address:</label>
                <input type="text" id="address" name="address" class="address-input" placeholder="Enter your address..." required />
                <div class="form-label">Mode of Payment:</div>
                <div class="payment-options">
                    <label class="payment-checkbox"><input type="radio" name="paymentMode" value="COD" required /> Cash on Delivery</label>
                    <label class="payment-checkbox"><input type="radio" name="paymentMode" value="UPI" /> UPI</label>
                    <label class="payment-checkbox"><input type="radio" name="paymentMode" value="Card" /> Card</label>
                </div>
                <button type="submit" name="orderConfirmed" value="true" class="order-btn">Order</button>
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