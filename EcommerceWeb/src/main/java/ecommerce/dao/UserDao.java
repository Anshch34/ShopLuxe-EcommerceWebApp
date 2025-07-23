package ecommerce.dao;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import ecommerce.model.User;
public class UserDao {
private SessionFactory factory;

public UserDao() {
	factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(User.class).buildSessionFactory();
}
public boolean saveUser(User user) {
	Transaction tx = null;
	try(Session session = factory.openSession()){
		tx = session.beginTransaction();
		session.persist(user);
		tx.commit();
		return true;
	}catch(Exception e) {
		 if (tx != null) tx.rollback();
         e.printStackTrace();
         return false;
	}
	
}

}
