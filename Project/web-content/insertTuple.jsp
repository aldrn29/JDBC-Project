<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ include file="/dbConnect.jsp" %>
<%!
   public boolean strCheck (String str){
   if(str==""){
       return false;
    }
    char check;
   for(int i = 0; i<str.length(); i++){
      check = str.charAt(i);
      if( check < 48 || check > 58)
      {
          return false;
      }
   }
   return true;
}
%>
<% 

    String fname = request.getParameter("insert_fname");
    String minit = request.getParameter("insert_minit");
    String lname = request.getParameter("insert_lname");
    String ssn_s = request.getParameter("insert_ssn");
    String bdate = request.getParameter("insert_bdate");
    String address = request.getParameter("insert_address");
    String sex = request.getParameter("insert_sex");
    String salary_s = request.getParameter("insert_salary");
    String super_ssn_s = request.getParameter("insert_super_ssn");
    String dno_s = request.getParameter("insert_dno");
   
    // 예외처리 1 : ssn, salary, super_ssn, dno 중 하나라도 정수가 아니거나 비어있다면 에러 출력
    if(!strCheck(ssn_s) || !strCheck(salary_s) || !strCheck(super_ssn_s) || !strCheck(dno_s)){
       System.out.println("ERROR : ssn, salary, super_ssn, dno must be integer");
       response.sendRedirect("index.jsp");
       return;
    }
    
    // 예외처리 2 : Fname, Lname, Bdate 이 비어있다면 에러 출력
    // 다른속성은 빈칸이어도 괜찮은데 Bdate 가 mysql 에서 date 형식이라서 빈칸이거나 yyyy-mm-dd 형식이 아니면 오류가 납니다. 
    if(fname=="" || lname=="" || bdate==""){
       System.out.println("Error : Fname or Lname is empty");
       response.sendRedirect("index.jsp");
       return;
    }
    
    int ssn = Integer.parseInt(request.getParameter("insert_ssn"));
    int salary = Integer.parseInt(request.getParameter("insert_salary"));
    int super_ssn = Integer.parseInt(request.getParameter("insert_super_ssn"));
    int dno = Integer.parseInt(request.getParameter("insert_dno"));
    
    String stmt5 = "INSERT INTO EMPLOYEE VALUES(?,?,?,?,?,?,?,?,?,?)";
    PreparedStatement p5 = conn.prepareStatement(stmt5);
    
    p5.clearParameters();
    p5.setString(1, fname);
    p5.setString(2, minit);
    p5.setString(3, lname);
    p5.setInt(4, ssn);
    p5.setString(5, bdate);
    p5.setString(6, address);
    p5.setString(7, sex);
    p5.setInt(8, salary);
    p5.setInt(9, super_ssn);
    p5.setInt(10, dno);
    
    p5.executeUpdate();
    response.sendRedirect("index.jsp");
%>