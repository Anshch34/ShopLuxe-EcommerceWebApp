package ecommerce.servlet;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.hibernate.*;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;



import ecommerce.model.User;


public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Configuration cfg = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(User.class);
            SessionFactory factory = cfg.buildSessionFactory();
            Session session = factory.openSession();

            String hql = "FROM User U WHERE U.email = :email AND U.password = :password";
            Query<User> query = session.createQuery(hql, User.class);
            query.setParameter("email", email);
            query.setParameter("password", password);

            User user = query.uniqueResult();

            if (user != null) {
                // Login successful
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("currentUser", user);
                response.sendRedirect("home");
            } else {
                // Login failed
                request.setAttribute("error", "Invalid email or password");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }

            session.close();
            factory.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login error: " + e.getMessage());
        }
    }
}
