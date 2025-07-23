package ecommerce.servlet;

import ecommerce.dao.*;
import ecommerce.model.User;



import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

public class RegisterServlet extends HttpServlet {
	 public RegisterServlet() {
	        super();
	    }

	   
	    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(name, email, password);
        UserDao dao = new UserDao();

        if (dao.saveUser(user)) {
            response.sendRedirect("login.jsp");
        } else {
            response.getWriter().println("Error while registering user.");
        }
    }
}
