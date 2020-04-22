<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language ="java" import ="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<title>login_manager</title>


<body>

<%
//db connect
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
		session.invalidate();
		out.println("<script>alert('bye! See you next time');");
		response.sendRedirect("login_input.jsp");
%>

</body>
</html>