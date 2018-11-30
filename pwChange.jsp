<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language ="java" import ="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Change password Management</title>
</head>
<body>

<%
Connection con = null;
String url = "jdbc:mysql://localhost:3306/SYDMart?serverTimezone = UTC";
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			System.out.println("after forName");
			con = DriverManager.getConnection(url, "root","ekdms1234");
			System.out.println("DBms connection success");
			System.out.println("DB load success");
		} catch(Exception e) {
			System.out.println("DB load fail" + e.toString());
		}
		
	String pw1 = request.getParameter("Password2");
	String pw2 = request.getParameter("Password3");
	String id = request.getParameter("Id");
	
	if(pw1.equals("") || pw1 == null || pw2.equals("") || pw2 == null) {
		out.println("<script>alert('Input new password'); location.href='pwChange_input.jsp'</script>");

	}
	if(!pw1.equals(pw2)) {
		out.println("<script>alert('Password not match'); location.href='pwChange_input.jsp'</script>");
	}
	
	String sql = "UPDATE CUSTOMER SET " 
		+ "PW='" + pw1 +"'"+ " WHERE ID='" + id +"';";
	
	Statement stmt = con.prepareStatement(sql);
	stmt.executeUpdate(sql);

	out.println("<script>alert('Password successfully Changed !'); location.href='main.jsp'</script>");
	
	
	stmt.close();
	con.close();
	
%>

</body>
</html>