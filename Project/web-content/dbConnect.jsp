<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import -->
<%@ page import = "java.sql.*" %>                    
<%@ page import="java.util.*"%>

<%
	Connection conn = null;
	String dbacct, passwrd, dbname;
	String depart_name = "depart";
	
	try {
	    Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC 드라이버 연결
	} catch (ClassNotFoundException e) {
	    e.printStackTrace();
	}
	
	dbacct="aldrn";
	passwrd="";
	dbname="testdb";
	
	String url="jdbc:mysql://localhost:3306/"+dbname+"?serverTimezone=UTC";
	conn=DriverManager.getConnection(url, dbacct, passwrd);
%>
 