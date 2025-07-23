# ShopLuxe Ecommerce Web Application

A modern, full-featured e-commerce web application built with Java (Servlets, JSP, Hibernate), Maven, and MySQL.

## 🚀 Features
- User registration and login
- Admin login and product management
- Product listing with images
- Shopping cart (session-based)
- Order summary and confirmation
- Responsive, modern UI (JSP + CSS)
- Session management and authentication

## 📁 Project Structure
```
EcommerceWeb/
├── src/
│   ├── main/
│   │   ├── java/ecommerce/...
│   │   ├── resources/hibernate.cfg.xml
│   │   └── webapp/*.jsp, images/
│   └── test/
├── pom.xml
├── .gitignore
└── README.md
```

## ⚙️ Setup Instructions
1. **Clone the repository:**
   ```sh
   git clone https://github.com/YOUR-USERNAME/ShopLuxe-EcommerceWebApp.git
   cd ShopLuxe-EcommerceWebApp
   ```
2. **Configure the database:**
   - Create a MySQL database (e.g., `ecom`).
   - Update `src/main/resources/hibernate.cfg.xml` with your DB credentials.
3. **Build the project:**
   ```sh
   mvn clean install
   ```
4. **Run on Tomcat/Jetty:**
   - Deploy the generated WAR file from `target/` to your servlet container.
   - Or run directly from Eclipse/IDE.
5. **Access the app:**
   - Open [http://localhost:8080/EcommerceWeb](http://localhost:8080/EcommerceWeb) (or your server URL)

## 🛠️ Technologies Used
- Java Servlets & JSP
- Hibernate ORM
- MySQL
- Maven
- HTML, CSS, JavaScript

## 👤 Admin Credentials (default)
- **Email:** admin@shopluxe.com
- **Password:** admin123


## 📄 License
This project is for educational/demo purposes. Feel free to use and modify! 
