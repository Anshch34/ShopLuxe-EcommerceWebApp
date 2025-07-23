package ecommerce.servlet;

import java.io.IOException;

public class LogoutServlet extends javax.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles GET or POST requests
    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) 
            throws javax.servlet.ServletException, IOException {

        // Get the current session, if exists
        javax.servlet.http.HttpSession session = request.getSession(false); // false = don't create new one

        if (session != null) {
            session.invalidate(); // destroy session (logout)
        }

        // Redirect to login page after logout
        response.sendRedirect("login.jsp");
    }

    // Optional: handle POST requests as well
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) 
            throws javax.servlet.ServletException, IOException {
        doGet(request, response); // reuse doGet logic
    }
}
