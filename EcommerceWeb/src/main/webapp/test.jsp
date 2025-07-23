<%@ page import="org.hibernate.Transaction"%>
<%@ page import="org.hibernate.Session"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="org.hibernate.cfg.Configuration"%>
<%@ page import="ecommerce.emp"%>

<%
	try{
	int eno = Integer.parseInt(request.getParameter("eno"));
	String name = request.getParameter("name");
	int sal = Integer.parseInt(request.getParameter("sal"));
	
	emp s1 = new emp(eno,name,sal);
	Configuration cnfg = new Configuration();
	cnfg.configure("hibernate.cfg.xml");
	SessionFactory factory = cnfg.buildSessionFactory();
	Session ses = factory.openSession();
	
	Transaction trns = ses.beginTransaction();
	ses.persist(s1);
	trns.commit();
	}
catch(Exception e){
	out.println(e);
}
	
%>