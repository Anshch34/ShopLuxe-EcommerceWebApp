<html>

	<head>
    <meta charset="UTF-8">
    <title>Employee Input Form</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e0e7ff 0%, #f0f4f8 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(12px) saturate(180%);
            -webkit-backdrop-filter: blur(12px) saturate(180%);
            padding: 36px 44px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.18);
            width: 350px;
            border: 1px solid rgba(255,255,255,0.3);
            transition: box-shadow 0.3s;
        }

        .form-container:hover {
            box-shadow: 0 12px 40px rgba(31, 38, 135, 0.22);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 28px;
            color: #222;
            letter-spacing: 1px;
        }

        .form-group {
            position: relative;
            margin-bottom: 24px;
        }

        label {
            position: absolute;
            top: 12px;
            left: 14px;
            background: transparent;
            color: #888;
            font-weight: 500;
            font-size: 15px;
            pointer-events: none;
            transition: 0.2s ease all;
            padding: 0 4px;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 18px 14px 10px 14px;
            border: 1.5px solid #d1d5db;
            border-radius: 10px;
            font-size: 16px;
            background: rgba(255,255,255,0.6);
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 2px #6366f133;
            outline: none;
        }

        input:focus + label,
        input:not(:placeholder-shown) + label {
            top: -10px;
            left: 10px;
            background: #fff;
            color: #6366f1;
            font-size: 13px;
            padding: 0 6px;
            border-radius: 4px;
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(90deg, #6366f1 0%, #60a5fa 100%);
            border: none;
            color: white;
            font-size: 17px;
            font-weight: 600;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 4px 16px rgba(99,102,241,0.12);
            transition: background 0.3s, transform 0.2s;
        }

        .submit-btn:hover {
            background: linear-gradient(90deg, #4f46e5 0%, #2563eb 100%);
            transform: translateY(-2px) scale(1.03);
        }

        @media (max-width: 480px) {
            .form-container {
                width: 95vw;
                padding: 20px 8px;
            }
        }
    </style>
</head>
<body>

    <form class="form-container" method="get" action="test.jsp">
        <h2>Employee Details</h2>

        <div class="form-group">
            <input type="number" id="eno" name="eno" required placeholder=" ">
            <label for="eno">Employee Number</label>
        </div>

        <div class="form-group">
            <input type="text" id="name" name="name" required placeholder=" ">
            <label for="name">Name</label>
        </div>

        <div class="form-group">
            <input type="number" id="sal" name="sal" required placeholder=" ">
            <label for="sal">Salary</label>
        </div>

        <button type="submit" class="submit-btn">Submit</button>
    </form>

</body>
</html>
