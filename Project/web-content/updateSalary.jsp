<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ include file="/dbConnect.jsp" %>
<%

   double newSalary = Double.parseDouble(request.getParameter("pInput"));
   System.out.println(newSalary);

   String inVal = "";
   String value[] = request.getParameterValues("checkbox"); // 선택한 tuple의 ssn이 value에 담긴다. 

   for(int i = 0; i < value.length; i++) {
      if (i != 0) inVal = inVal + ",";
      inVal = inVal + '"' + value[i] + '"';
   }

   String stmt4 = "update EMPLOYEE set salary = ("+newSalary+")  where ssn in ("+inVal+")"; 
   PreparedStatement p4 = conn.prepareStatement(stmt4, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
   
   out.println(p4);
   int updateNum = p4.executeUpdate(); 
   out.println(updateNum);

   response.sendRedirect("index.jsp");
   
%>



