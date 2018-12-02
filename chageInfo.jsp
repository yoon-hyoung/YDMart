<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language ="java" import ="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>change info management</title>
</head>
<body>
<%
Connection conn = null;
String url = "jdbc:mysql://localhost:3306/SYDMart?serverTimezone = UTC";
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			System.out.println("after forName");
			conn = DriverManager.getConnection(url, "root","ekdms1234");
			System.out.println("DBms connection success");
			System.out.println("DB load success");
		} catch(Exception e) {
			System.out.println("DB load fail" + e.toString());
		}

		String id = request.getParameter("Id");
		//String pw = request.getParameter("Password");
		
		//update query
	String query = "UPDATE CUSTOMER SET " 
			+ "ZIPCODE=" + request.getParameter("Zipcode")
			+ ",NAME='" + request.getParameter("Name") + "',"
			+  "PHONENUM= '"+request.getParameter("Phone")
			+ "' ,CITY='" + request.getParameter("City") + "'"
			+ ",GENDER='"+ request.getParameter("Gender") + "',"
			+  "AGE="+request.getParameter("Age")
			+ ",JOB='"+ request.getParameter("Job")
			+ "' WHERE ID = '"+ id +"';" ;
	
	//out.println(query);
	
	
	//query start
	Statement stmt = conn.prepareStatement(query);
	stmt.executeUpdate(query);
	stmt.close();
	conn.close();
	
	out.println("<script>alert('Personal Information successfully Changed !'); location.href='main.jsp'</script>");
	
%>

</body>
</html>