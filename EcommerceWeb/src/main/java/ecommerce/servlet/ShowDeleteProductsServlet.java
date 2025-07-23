package ecommerce.servlet;

import ecommerce.dao.ProductDAO;
import ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ShowDeleteProductsServlet")
public class ShowDeleteProductsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> productList = new ProductDAO().getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("deleteProduct.jsp").forward(request, response);
    }
} 