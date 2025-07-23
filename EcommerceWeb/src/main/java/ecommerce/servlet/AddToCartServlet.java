package ecommerce.servlet;

import ecommerce.dao.ProductDAO;
import ecommerce.model.Cart;
import ecommerce.model.CartItem;
import ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }
        // Fetch product details from DB
        ProductDAO productDAO = new ProductDAO();
        Product product = null;
        for (Product p : productDAO.getAllProducts()) {
            if (p.getId() == productId) {
                product = p;
                break;
            }
        }
        if (product != null) {
            CartItem item = new CartItem(product.getId(), product.getName(), product.getPrice(), 1, product.getImage());
            cart.addItem(item);
        }
        session.setAttribute("cart", cart);
        response.sendRedirect("home");
    }
} 