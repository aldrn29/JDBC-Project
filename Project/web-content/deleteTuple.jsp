<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ include file="/dbConnect.jsp" %>

<% 

	int resultCnt = Integer.parseInt(request.getParameter("resultCnt"));
	
	String inVal = "";
	String value[] = request.getParameterValues("checkbox"); // 선택한 tuple의 ssn이 value에 담긴다. 
	
	for(int i = 0; i < value.length; i++) {
		if (i != 0) inVal = inVal + ",";
		
		inVal = inVal + '"' + value[i] + '"';
	}


	String stmt3 = "delete from EMPLOYEE where ssn in (" + inVal + ")"; 
	PreparedStatement p3 = conn.prepareStatement(stmt3, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		
	out.println(p3);
	int deleteNum = p3.executeUpdate(); 
	out.println(deleteNum);
	
	response.sendRedirect("index.jsp");

%>