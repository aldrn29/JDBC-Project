<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/dbConnect.jsp" %>

<%
   HashMap<Integer, String> depart_list = new HashMap<Integer, String>();
   ArrayList<String> delete_tuple = new ArrayList<String>();

   String stmt1="select Dname,Dnumber from department";
   PreparedStatement p = conn.prepareStatement(stmt1);
   
   //Statement의 첫번째 ?에 넣는다.
   p.clearParameters();
   //p.setString(1, ssn);
   ResultSet r = p.executeQuery();
   
   int depart_num = 0;
   
   while(r.next()){
      depart_name = r.getString(1);
      //depart_list.add(depart_name);
      depart_num = r.getInt(2);
      depart_list.put(depart_num, depart_name);
   }
   System.out.println(depart_list);
%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>메인화면</title>
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
             String stmt2 = "select * from EMPLOYEE"; // 정석은 select 문에서 선별하여 보여줘야 해 --> 아래 태그에서 선별해서 보여주는 것 야매..ㅋㅋ
            PreparedStatement p2 = conn.prepareStatement(stmt2, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            p2.clearParameters();
            //p.setString(1, ssn); 
            ResultSet r2 = p2.executeQuery();
            //ResultSet r2 = (ResultSet)request.getAttribute("selectedTuple");
            r2.last();     
             int r2_rowcount = r2.getRow();
             
             
             Set<Integer> keys = depart_list.keySet();
             for(Integer key : keys){
             //for(int i=0; i<depart_list.size(); i++){
          %>
             <option value="<%=depart_list.get(key)%>" name="<%=depart_list.get(key)%>" id="<%=depart_list.get(key)%>"><%=depart_list.get(key)/*depart_list.get(i)*/%></option>
             
             <%
                //out.println(depart_list.get(key));
             %>
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
            
       <p><input type="submit" value="검색" onclick="selecting_depart();"></p>
   
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

<%

   try {
       if (conn != null)
           conn.close();
   }catch(SQLException e){
   
   }
%>   