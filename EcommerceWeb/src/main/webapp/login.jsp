
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
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

        .form-container {
            background: rgba(255, 255, 255, 0.05);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            width: 350px;
            margin-top: 40px;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #f8f9fa;
            text-shadow: 1px 1px 2px #000;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px 0;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            outline: none;
            font-size: 16px;
            box-sizing: border-box;
            display: block;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            border: none;
            border-radius: 10px;
            font-size: 16px;
            color: #fff;
            cursor: pointer;
            transition: background 0.3s;
            margin: 0 0 0 0;
            box-sizing: border-box;
            display: block;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background: linear-gradient(to right, #2575fc, #6a11cb);
            text-decoration: none;
        }

        ::placeholder {
            color: #ccc;
        }

        @media (max-width: 480px) {
            .form-container {
                width: 95vw;
                padding: 20px 8px;
            }
            .site-header {
                padding-left: 12px;
            }
            .site-title {
                font-size: 1.3rem;
            }
        }
        .login-link {
            text-align: center;
            margin-top: 18px;
            font-size: 15px;
        }
        .login-link a {
            color: #6a11cb;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }
        .login-link a:hover {
            color: #2575fc;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="site-header">
        <span class="site-title">ShopLuxe</span>
    </div>
    <div class="form-container">
        <h2>Welcome Back</h2>
        <form action="LoginServlet" method="post">
    
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
            <div class="login-link">
                New to ShopLuxe? <a href="register.jsp">Create an account</a>
            </div>
        </form>
    </div>
</body>
</html>
