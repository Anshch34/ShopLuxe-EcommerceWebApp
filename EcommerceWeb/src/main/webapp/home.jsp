<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="ecommerce.model.Product" %>
<%@ page import="ecommerce.model.User" %>
<%@ page import="ecommerce.model.Cart" %>
<%

HttpSession currentSession = session;

// Check if user is logged in
User user = (User) currentSession.getAttribute("currentUser");

// Removed redirect to login.jsp so guests can view the page

String username = (user != null) ? user.getName() : "Guest";

// Get product list (may be null if not set by controller/servlet)
List<Product> productList = (List<Product>) request.getAttribute("productList");

ecommerce.model.Cart cart = (ecommerce.model.Cart) session.getAttribute("cart");
int cartCount = (cart != null) ? cart.getTotalQuantity() : 0;

%>

<!DOCTYPE html>
<html>
<head>
    <title>ShopLuxe - Home</title>
    <style>
        /* Reuse your existing dark + gradient styles */
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            min-height: 100vh;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            /* Removed justify-content: center; */
            padding-top: 70px; /* Add space for navbar */
        }

        .site-header {
            display: none;
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
            padding: 0 20px 0 40px;
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
        .user-icon {
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
            margin-right: 60px;
        }
        .user-icon:hover {
            box-shadow: 0 4px 16px rgba(99,102,241,0.18);
        }
        .user-dropdown {
            display: none;
            position: absolute;
            top: 54px;
            right: 60px;
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
        .product-section {
    padding: 40px 0; /* Remove left/right padding */
    max-width: 1200px;
    margin: 0 auto 60px auto; /* Center horizontally */
    width: 100%;
    box-sizing: border-box;
}

.section-title {
    font-size: 2rem;
    text-align: center;
    margin-bottom: 30px;
    color: #fff;
    text-shadow: 0 2px 10px rgba(0,0,0,0.3);
}

.product-container {
    margin-top: 40px;
    padding: 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    width: 100%;
    max-width: 1200px;
    box-sizing: border-box;
}

.product-card {
    background: rgba(255, 255, 255, 0.08);
    border-radius: 18px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    transition: transform 0.2s ease;
}

.product-card:hover {
    transform: translateY(-8px);
}

.product-img {
    width: 100%;
    height: 180px;
    object-fit: cover;
    border-radius: 12px;
    margin-bottom: 15px;
}

.price-add {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 15px;
}

.price {
    font-weight: bold;
    color: #fff;
    font-size: 18px;
}

.add-btn {
    padding: 8px 14px;
    background: linear-gradient(to right, #6a11cb, #2575fc);
    color: white;
    border: none;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s ease;
}

.add-btn:hover {
    background: linear-gradient(to right, #2575fc, #6a11cb);
}
        
        .logout-btn:hover {
            background: linear-gradient(to right, #2575fc, #6a11cb);
            text-decoration: none;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 480px) {
            .navbar {
                padding: 0 4px 0 12px;
            }
            .site-title {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-left">
            <span class="site-title">ShopLuxe</span>
        </div>
        <div class="navbar-right">
            <a href="cart.jsp" class="cart-icon" style="margin-right: 24px; display: flex; align-items: center; width: 40px; height: 40px; border-radius: 50%; background: rgba(255,255,255,0.18); justify-content: center; box-shadow: 0 2px 8px rgba(255, 204, 51, 0.18); border: 2px solid rgba(255,179,71,0.25); overflow: hidden; position: relative;">
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
                <% if (cartCount > 0) { %>
                    <span style="position: absolute; top: 4px; right: 4px; background: #ff4d4f; color: #fff; border-radius: 50%; padding: 2px 7px; font-size: 13px; font-weight: bold; min-width: 22px; text-align: center; line-height: 18px;"> <%= cartCount %> </span>
                <% } %>
            </a>
            <div class="user-icon" id="userIcon">
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
    <div class="product-section">
    <h2 class="section-title">Featured Products</h2>
    <div class="product-container">
        <%
            if (productList != null && !productList.isEmpty()) {
                for (ecommerce.model.Product product : productList) {
        %>
            <div class="product-card">
                <img class="product-img" src="images/<%= product.getImage() %>" alt="<%= product.getName() %>" />
                <h3><%= product.getName() %></h3>
                <p><%= product.getDescription() %></p>
                <div class="price-add">
                    <span class="price">Price: <%= product.getPrice() %></span>
                    <form method="post" action="AddToCartServlet" style="display:inline; margin:0; padding:0;">
                        <input type="hidden" name="productId" value="<%= product.getId() %>" />
                        <button type="submit" class="add-btn">Add to Cart</button>
                    </form>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <p style="text-align:center; margin-top: 40px;">No products available at the moment.</p>
        <%
            }
        %>
    </div>
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
