package ecommerce.servlet;

import ecommerce.dao.ProductDAO;
import ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/AddProductServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,     // 1 MB
                 maxFileSize = 5 * 1024 * 1024,       // 5 MB
                 maxRequestSize = 10 * 1024 * 1024)   // 10 MB
public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // 1. Get form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = 0.0;
        try {
            price = Double.parseDouble(request.getParameter("price"));
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid price value.");
            return;
        }
        Part imagePart = request.getPart("image");

        // 2. Get image filename and sanitize
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        fileName = fileName.replaceAll("[^a-zA-Z0-9._-]", "_"); // Basic sanitization

        // 3. Define path to save image
        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs(); // Use mkdirs for nested dirs

        // 4. Save image file
        imagePart.write(uploadPath + File.separator + fileName);

        // 5. Create Product object and save to DB
        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setImage(fileName);  // Store only filename
        System.out.println(name);
        System.out.println(description);
        System.out.println(price);
        System.out.println(fileName);
        // TODO: For better performance, reuse ProductDAO via dependency injection or singleton
        ProductDAO dao = new ProductDAO();
        if (dao.saveProduct(product)) {
            response.sendRedirect("addProduct.jsp");
        } else {
            response.getWriter().println("Failed to add product.");
        }
    }
}
