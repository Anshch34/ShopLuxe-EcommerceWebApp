<%@ page import="javax.servlet.http.HttpSession" %>
<%
   
    String error = (String) session.getAttribute("adminLoginError");
    session.removeAttribute("adminLoginError");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - ShopLuxe</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            height: 100vh;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: rgba(255,255,255,0.06);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.25);
            backdrop-filter: blur(10px);
            width: 320px;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #fff;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: none;
            border-radius: 8px;
            background: rgba(255,255,255,0.1);
            color: white;
        }

        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
        }

        button:hover {
            background: linear-gradient(to right, #2575fc, #6a11cb);
        }

        .error {
            color: #ff4c4c;
            text-align: center;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .site-header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            z-index: 10;
            padding: 24px 0 0 40px;
            pointer-events: none;
        }
        .site-title {
            font-size: 2rem;
            font-weight: 700;
            color: #fff;
            letter-spacing: 2px;
            text-shadow: 0 2px 8px #0008;
            background: linear-gradient(90deg, #6a11cb, #2575fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
    </style>
</head>
<body>
    <div class="site-header">
        <span class="site-title">ShopLuxe</span>
    </div>
    <div class="login-container">
        <h2>Admin Login</h2>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>
        <form action="AdminLoginServlet" method="post">
            <input type="text" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
