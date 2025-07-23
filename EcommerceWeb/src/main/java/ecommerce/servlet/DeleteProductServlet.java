package ecommerce.servlet;

import ecommerce.dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("productId");
        String message;
        try {
            int productId = Integer.parseInt(idStr);
            boolean deleted = ProductDAO.deleteProductById(productId);
            if (deleted) {
                message = "Product deleted successfully.";
            } else {
                message = "Product not found or could not be deleted.";
            }
        } catch (Exception e) {
            message = "Invalid product ID.";
        }
        request.setAttribute("message", message);
        request.getRequestDispatcher("deleteProduct.jsp").forward(request, response);
    }
} 