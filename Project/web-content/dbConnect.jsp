<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import -->
<%@ page import = "java.sql.*" %>                    
<%@ page import="java.util.*"%>

<%
	Connection conn = null;
	String dbacct, passwrd, dbname;
	String depart_name = "depart";
	
	try {
	    Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC ����̹� ����
	} catch (ClassNotFoundException e) {
	    e.printStackTrace();
	}
	
	dbacct="aldrn";
	passwrd="";
	dbname="testdb";
	
	String url="jdbc:mysql://localhost:3306/"+dbname+"?serverTimezone=UTC";
	conn=DriverManager.getConnection(url, dbacct, passwrd);
%>
 