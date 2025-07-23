package ecommerce;

import javax.persistence.Entity;
import javax.persistence.Id;



@Entity
public class emp {
@Id
int eno;
String name;
int sal;
public int getEno() {
	return eno;
}
public void setEno(int eno) {
	this.eno = eno;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getSal() {
	return sal;
}
public void setSal(int sal) {
	this.sal = sal;
}
public emp(int eno, String name, int sal) {
	super();
	this.eno = eno;
	this.name = name;
	this.sal = sal;
}
public emp() {
	super();
	// TODO Auto-generated constructor stub
}
@Override
public String toString() {
	return "emp [eno=" + eno + ", name=" + name + ", sal=" + sal + "]";
}

}
