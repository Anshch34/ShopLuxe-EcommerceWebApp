package ecommerce.dao;

import ecommerce.model.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;


import java.util.*;
import java.util.List;

public class ProductDAO {
    private static SessionFactory factory = new Configuration().configure().buildSessionFactory();

    public ProductDAO() {
        // factory = new Configuration().configure().buildSessionFactory();
    }

    public boolean saveProduct(Product product) {
        Transaction transaction = null;
        try { // Use the existing factory
            Session session = factory.openSession();
            transaction = session.beginTransaction();
            session.save(product);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
        return false;
    }

    public List<Product> getAllProducts() {
        try (Session session = factory.openSession()) {
            return session.createQuery("from Product", Product.class).list();
           
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>(); // Return empty list instead of null
    }

    public void close() {
        if (factory != null) {
            factory.close();
        }
    }

    public static boolean deleteProductById(int id) {
        Transaction transaction = null;
        try (Session session = factory.openSession()) {
            transaction = session.beginTransaction();
            Product product = session.get(Product.class, id);
            if (product != null) {
                session.delete(product);
                transaction.commit();
                return true;
            } else {
                if (transaction != null) transaction.rollback();
                return false;
            }
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
        return false;
    }
}
