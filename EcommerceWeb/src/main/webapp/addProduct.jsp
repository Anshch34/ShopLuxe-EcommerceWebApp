<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
  
    String adminUser = (String)session.getAttribute("currentAdmin");
    if(adminUser == null){
        response.sendRedirect("adminLogin.jsp"); // Create this if not present
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Add Product</title>
    <style>
        body {
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            color: white;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding-top: 70px; /* Add space for navbar */
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
            background: linear-gradient(90deg, #6a11cb, #2575fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
            transition: text-shadow 0.3s ease;
        }
        .site-title:hover {
            text-shadow: none;
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
        .logout-btn:hover {
            background: linear-gradient(to right, #2575fc, #6a11cb);
            text-decoration: none;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .form-container {
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.25);
            width: 400px;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 12px;
            background: rgba(255,255,255,0.1);
            border: none;
            border-radius: 8px;
            color: white;
        }
        input[type="submit"] {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            cursor: pointer;
            font-weight: 600;
            transition: 0.3s;
        }
        input[type="submit"]:hover {
            background: linear-gradient(to right, #2575fc, #6a11cb);
        }
        label {
            font-weight: 500;
        }
        .site-header {
            display: none;
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
                <div class="dropdown-welcome">Welcome, <%= adminUser %>!</div>
                <a href="LogoutServlet" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>
    <div class="form-container">
        <form action="AddProductServlet" method="post" enctype="multipart/form-data">
            <h2>Add New Product</h2>
            <label>Product Name:</label>
            <input type="text" name="name" required>
            
            <label>Description:</label>
            <textarea name="description" required></textarea>
            
            <label>Price:</label>
            <input type="number" name="price" step="0.01" required>
            
            <label>Image (upload from computer):</label>
            <input type="file" name="image" accept="image/*" required>

            <input type="submit" value="Add Product" style="display: block; width: 100%;">
        </form>
        <div style="text-align:center; margin-top:18px;">
            <a href="ShowDeleteProductsServlet" style="color:#2c16ea; text-decoration:underline; font-weight:600;">Delete Product?</a>
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
