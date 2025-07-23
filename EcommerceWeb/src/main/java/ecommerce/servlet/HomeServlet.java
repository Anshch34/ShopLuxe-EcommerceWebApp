package ecommerce.servlet;

import javax.servlet.http.HttpServlet;

import ecommerce.dao.ProductDAO;
import ecommerce.model.Product;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class HomeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	public HomeServlet() {
		super();
	}
	 @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        // Get list of products from DAO
	        ProductDAO productDao = new ProductDAO();
	        List<Product> productList = productDao.getAllProducts();

	        // Set products in request attribute
	        request.setAttribute("productList", productList);

	        // Forward to home.jsp
	        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
	        dispatcher.forward(request, response);
	    }
	
}
