package ecommerce.model;

import javax.persistence.Entity;
import javax.persistence.*;

@Entity
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
private int id;
private String name;
private String email;
private String password;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
@Override
public String toString() {
	return "user [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + "]";
}
public User(String name, String email, String password) {
	super();
	
	this.name = name;
	this.email = email;
	this.password = password;
}
public User() {
	super();
	// TODO Auto-generated constructor stub
}

}
