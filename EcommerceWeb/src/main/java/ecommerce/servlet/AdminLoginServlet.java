package ecommerce.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    private final String ADMIN_EMAIL = "admin@shopluxe.com";
    private final String ADMIN_PASSWORD = "admin123"; // You can hash this later for security

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);

        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            session.setAttribute("currentAdmin", email);
            response.sendRedirect("addProduct.jsp"); // or adminDashboard.jsp if you have one
        } else {
            session.setAttribute("adminLoginError", "Invalid admin credentials.");
            response.sendRedirect("adminLogin.jsp");
        }
    }
}
