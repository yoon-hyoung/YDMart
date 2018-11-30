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
		
		//get id and pw
		String id = request.getParameter("Id");
		String pw = request.getParameter("Password");
		
		//check input id and pw
		if(id == "" || pw == "") {
			out.println("<script>alert('Input your ID and PW !'); location.href='login_input.jsp'</script>");
		}
		
		//check id and pw are correct
		String sql = "SELECT ID, PW " 
			+ "FROM CUSTOMER"
			+ " WHERE EXISTS"
			+ " (SELECT * FROM customer WHERE"
			+ " ID = '" + id +"'"
			+ " And PW = '" + pw + "')";
		
	
	Statement stmt = con.createStatement();
	stmt.executeQuery(sql);
	
	ResultSet rs = null;
	rs = stmt.executeQuery(sql);
	
	if(rs.next()) {
		//login success
		session.setAttribute("ID",id);
		out.println("<script>alert('LoginSuccess'); location.href='main.jsp'</script>");
	}
	else {
		//login fail
		out.println("<script>alert('Id or Password Error !'); location.href='login_input.jsp'</script>");
	}

	stmt.close();
	con.close();
	
%>

</body>
</html>