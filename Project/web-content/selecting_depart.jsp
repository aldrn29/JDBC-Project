<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/dbConnect.jsp" %>

<%
	String selected_department[] = request.getParameterValues("selecting_department");
	//System.out.println(selected_department[0]);
%>

<%
	HashMap<Integer, String> depart_list = new HashMap<Integer, String>();
   	ArrayList<String> delete_tuple = new ArrayList<String>();

   	String stmt1="select Dname,Dnumber from department";
   	
   	PreparedStatement p = conn.prepareStatement(stmt1);
   
   	p.clearParameters();
   	ResultSet r = p.executeQuery();
   
   	int depart_num = 0;
   
   	while (r.next()) {
		depart_name = r.getString(1);
      	depart_num = r.getInt(2);
      	depart_list.put(depart_num, depart_name);
   	}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>메인화면</title>
<style>
table {
	border-collapse: collapse;
}
th {
	text-align: center;
	background-color: powderblue;
}
td { 
	text-align: center;
	cellpadding: 10;
}
#sort {
	position: relative;
	left: 922px;
	bottom: 1px;
}
</style>
</head>
<body>
   <form id="form">
      <select>
          <option value="all">전체</option>
          <option value="depart">부서별</option>
      </select>
      
      <select id = "selecting_department" name = "selecting_department">
          <option value="all_depart">전체</option>
          <%
             Set<Integer> keys = depart_list.keySet();
             for (Integer key : keys) {
          %>
             <option value="<%=depart_list.get(key)%>" name="<%=depart_list.get(key)%>" 
             id="<%=depart_list.get(key)%>"><%=depart_list.get(key)%></option>
          <% 
             }
          %>
      </select>
      
       <label><input type="checkbox" name="attribute1" value="fname" checked="checked">Fname</label>
       <label><input type="checkbox" name="attribute2" value="minit" checked="checked">Minit</label>
       <label><input type="checkbox" name="attribute3" value="lname" checked="checked">Lname</label>
       <label><input type="checkbox" name="attribute4" value="ssn" checked="checked">Ssn</label>
       <label><input type="checkbox" name="attribute5" value="bdate" checked="checked">Bdate</label>
       <label><input type="checkbox" name="attribute6" value="address" checked="checked">Address</label>
       <label><input type="checkbox" name="attribute7" value="sex" checked="checked">Sex</label>
       <label><input type="checkbox" name="attribute8" value="salary" checked="checked">Salary</label>
       <label><input type="checkbox" name="attribute9" value="super_name" checked="checked">Super_name</label>
       <label><input type="checkbox" name="attribute10" value="dname" checked="checked">Dname</label>
         
       <input type="text" id="resultCnt" name="resultCnt" value="" style="visibility:hidden;"></input>
            
       <p><input type="submit" value="검색" onclick="selecting_depart();">
       <input type="submit" value="삭제" onclick="deleteTuple();"></p>
       
       <br>new salary value<br>
       <input type="text" name = "pInput" id="pInput" size=10>
       <input type="submit" value="수정" onclick="updateSalary();"><br><br><br>
       
       <!-- select id="sort" name="sort" onclick="selecting_depart();">
          <option value="sort">정렬</option>
          <option value="asc">오름차순</option>
          <option value="desc">내림차순</option>
       </select -->
      
   <table width="1000" border="1">
       <tr>
          <% if(request.getParameter("attribute1") != null) %> <th>Fname</th>
          <% if(request.getParameter("attribute2") != null) %> <th>Minit</th>
          <% if(request.getParameter("attribute3") != null) %> <th>Lname</th>
          <% if(request.getParameter("attribute4") != null) %> <th>Ssn</th>
          <% if(request.getParameter("attribute5") != null) %> <th>Bdate</th>
          <% if(request.getParameter("attribute6") != null) %> <th>Address</th>
          <% if(request.getParameter("attribute7") != null) %> <th>Sex</th>
          <% if(request.getParameter("attribute8") != null) %> <th>Salary</th>
          <% if(request.getParameter("attribute9") != null) %> <th>Super_name</th>
          <% if(request.getParameter("attribute10") != null) %> <th>Dname</th>
          <th>Delete & modify</th>      
      </tr>
      
      <%
         String stmt2;
         String temp = "all_depart";
         if(selected_department[0].toString().equals(temp)){ // 부서를 선택하지 않은 경우
            stmt2 = "select * from EMPLOYEE"; 
         }
         else{ // 부서를 선택한 경우
            stmt2 = "select * from EMPLOYEE as E, DEPARTMENT as D where E.Dno = D.Dnumber and D.Dname = (?)";
         }
         
       	 //sort
         /*String selected_sort[] = request.getParameterValues("sort");
         if (selected_sort[0].toString().equals("sort")){ // 정렬을 하지 않은 경우
         } else if (selected_sort[0].toString().equals("asc")){ // 오름차순
       	  stmt2 += "order by Salary ASC"; 
         } else { // 내림차순
       	  stmt2 += "order by Salary DESC"; 
         }*/
         
         //System.out.println(stmt2);
		 PreparedStatement p2 = conn.prepareStatement(stmt2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
   
         //Statement의 첫번째 ?에 넣는다.
         p2.clearParameters();
         if(!selected_department[0].toString().equals(temp)){
            p2.setString(1, selected_department[0]);
         }
         
         ResultSet r2 = p2.executeQuery();
         r2.last();                                 //커서의 위치를 제일 뒤로 이동
         int r2_rowcount = r2.getRow();             //현재 커서의 Row Index 값을 저장
         r2.beforeFirst();
         
         
         //Super_ssn 대신 이름을 출력하기 위한 저장용 해시맵
         HashMap<Integer, String> name_list = new HashMap<Integer, String>();
         while(r2.next()){
             String fname = r2.getString(1);
             int ssn = r2.getInt(4);
             name_list.put(ssn, fname);
         }
          
         r2.beforeFirst();
          
         int count = -1;
         while(r2.next()) {
            String fname = r2.getString(1);
            String minit = r2.getString(2);
            String lname = r2.getString(3);
             int ssn = r2.getInt(4);
             String bdate = r2.getString(5);
             String address = r2.getString(6);
             String sex = r2.getString(7);
             Double salary = r2.getDouble(8);    
             int super_ssn = r2.getInt(9);
             int dno = r2.getInt(10);
             String dname = depart_list.get(dno);
             count = count + 1;
          
      %>
      
      <tr>
         <% if(request.getParameter("attribute1") != null) {%> <td width="20"><%=fname%></td>
          <%} if(request.getParameter("attribute2") != null) {%> <td width="20"><%=minit%></td>
          <%} if(request.getParameter("attribute3") != null) {%> <td width="20"><%=lname%></td>
          <%} if(request.getParameter("attribute4") != null) {%> <td width="80" id="ssn_<%=count%>"><%=ssn%></td>
          <%} if(request.getParameter("attribute5") != null) {%> <td width="100"><%=bdate%></td>
          <%} if(request.getParameter("attribute6") != null) {%> <td width="200"><%=address%></td>
          <%} if(request.getParameter("attribute7") != null) {%> <td width="10"><%=sex%></td>
          <%} if(request.getParameter("attribute8") != null) {%> <td width="60"><%=salary%></td>
          <%} if(request.getParameter("attribute9") != null) {%> <td width="10"><%=name_list.get(super_ssn)%></td>
          <%} if(request.getParameter("attribute10") != null) {%> <td width="110"><%=dname%></td> <%}%>
         <td><label><input type="checkbox" name="checkbox" value="<%=ssn%>" id="checkbox_<%=count%>"></label></td> 
      </tr>
      
      <% 
         }
         
      %>
      </table>
      
      <br><hr>
        직원 추가(Ssn, Salary, Super_ssn, Dno 는 정수입력)<br><br>

      <table width= auto border=0>
       <tr>
          <td>Fname</td>
          <td>Minit</td>
          <td>Lname</td>
          <td>Ssn</td>
          <td>Bdate</td>
          <td>Address</td>
          <td>Sex</td>
          <td>Salary</td>
          <td>Super_ssn</td>
          <td>Dno</td> 
      </tr>
      <tr>
         <td><input type="text" name = "insert_fname" id="insert_fname" size=10></td>
         <td><input type="text" name = "insert_minit" id="insert_minit" size=3></td>
         <td><input type="text" name = "insert_lname" id="insert_lname" size=10></td>
         <td><input type="text" name = "insert_ssn" id="insert_ssn" size=10></td>
         <td><input type="text" name = "insert_bdate" id="insert_bdate" size=10></td>
         <td><input type="text" name = "insert_address" id="insert_address" size=10></td>
         <td><input type="text" name = "insert_sex" id="insert_sex" size=3></td>
         <td><input type="text" name = "insert_salary" id="insert_salary" size=10></td>
         <td><input type="text" name = "insert_super_ssn" id="insert_super_ssn" size=10></td>
         <td><input type="text" name = "insert_dno" id="insert_dno" size=3 ></td>
      </tr>
      <tr>
         <td><input type="submit" value="추가" onclick="insertTuple();"><td>
      </tr>
   </table>
   </form>
</body>
</html>

<script>
function deleteTuple() {
   document.getElementById("resultCnt").value = '<%=r2_rowcount%>';
   document.getElementById("form").action = "deleteTuple.jsp";
   document.getElementById("form").submit();
   return;
}
</script>


<script>
function selecting_depart() {
   document.getElementById("form").action = "selecting_depart.jsp";
   document.getElementById("form").submit();
}
</script>

<script>
function updateSalary() {
   document.getElementById("pInput").value;
   document.getElementById("form").action = "updateSalary.jsp";
   document.getElementById("form").submit();
}
</script>

<script>
function insertTuple() {
   document.getElementById("form").action = "insertTuple.jsp";
   document.getElementById("form").submit();
}
</script>