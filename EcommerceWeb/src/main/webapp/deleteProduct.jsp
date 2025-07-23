<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="ecommerce.model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Product</title>
    <style>
        body {
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            color: white;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.25);
            width: 500px;
            max-height: 90vh;
            overflow-y: auto;
        }
        .product-card {
            background: rgba(255,255,255,0.08);
            border-radius: 12px;
            padding: 18px 16px 12px 16px;
            margin-bottom: 18px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
            display: flex;
            align-items: center;
            gap: 18px;
        }
        .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            background: #fff2;
        }
        .product-info {
            flex: 1;
        }
        .product-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 4px;
        }
        .product-desc {
            font-size: 0.95rem;
            color: #e0e0e0;
            margin-bottom: 6px;
        }
        .product-id {
            font-size: 0.85rem;
            color: #bdbdbd;
        }
        .delete-btn {
            background: linear-gradient(to right, #ff416c, #ff4b2b);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        .delete-btn:hover {
            background: linear-gradient(to right, #ff4b2b, #ff416c);
        }
        .no-products {
            text-align: center;
            color: #ffb3b3;
            margin: 30px 0 0 0;
            font-weight: 600;
        }
        a {
            color: #fff;
            text-decoration: underline;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Delete Product</h2>
        <% String message = (String)request.getAttribute("message"); if (message != null) { %>
            <div style="margin-bottom:16px; color:#ffb3b3; font-weight:600; text-align:center;">
                <%= message %>
            </div>
        <% } %>
        <%
            List<Product> productList = (List<Product>)request.getAttribute("productList");
            if (productList != null && !productList.isEmpty()) {
                for (Product product : productList) {
        %>
            <div class="product-card">
                <img class="product-img" src="images/<%= product.getImage() %>" alt="<%= product.getName() %>" />
                <div class="product-info">
                    <div class="product-title"><%= product.getName() %></div>
                    <div class="product-desc"><%= product.getDescription() %></div>
                    <div class="product-id">ID: <%= product.getId() %></div>
                </div>
                <form action="DeleteProductServlet" method="post" style="margin:0;">
                    <input type="hidden" name="productId" value="<%= product.getId() %>" />
                    <input type="submit" value="Delete" class="delete-btn" onclick="return confirm('Are you sure you want to delete this product?');" />
                </form>
            </div>
        <%      }
            } else { %>
            <div class="no-products">No products available to delete.</div>
        <% } %>
        <div style="text-align:center; margin-top:18px;">
            <a href="addProduct.jsp">Back to Add Product</a>
        </div>
    </div>
</body>
</html> 