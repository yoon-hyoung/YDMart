<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
<title>manager</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-content" style="max-width:1200px">
<form action="manager_item2.jsp">
<%
//get ID value
String Id = null; //initializie to 0
Id = (String)session.getAttribute("ID");
//  out.println(Id);

//connect to DB
Connection con = null;
String url = "jdbc:mysql://localhost:3306/SYDMART?serverTimezone = UTC";
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		System.out.println("after forName");
		con = DriverManager.getConnection(url, "knu","comp322");
		System.out.println("DBms connection success");
		System.out.println("DB load success");
	} catch(Exception e) {
		System.out.println("DB load fail" + e.toString());
	}	
	

String k = request.getParameter("Item");
int item= Integer.parseInt(k);

//increase retailer stock
String sql = "select NAME from ITEM where I_NUM="+item;
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);
String name=null;
while(rs.next()) {
	name = rs.getString(1);
}


out.println("<h2>"+name+"</h2>");
out.println("<input type='text' name='Plus' value='0'>");

%>
<select name = "City">
<option value=1>Seoul</option>
<option value=2>Incheon</option>
<option value=3>Gyeongi</option>
<option value=4>Gwagnwon</option>
<option value=5>Choongchugn</option>
<option value=6>Daegu</option>
<option value=7>Ulsan</option>
<option value=8>Gyeongsang</option>
<option value=9>Busan</option>
<option value=10>Jeolla</option>
<option value=11>Sejong</option>
<option value=12>Daejun</option>
<option value=13>Gwangju</option>
<option value=14>Jeju</option>       
</select> 
<%
out.println("<input type='submit' value="+k+" name='Item'>");

%>
</form>

</body>
</html>