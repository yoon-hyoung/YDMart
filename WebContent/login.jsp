<%@ page contentType="text/html;charset=euc-kr"
             import="cookie.LoginManager"%>
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer" %>


<!DOCTYPE html>
<html>
<title>login_manager</title>


<body>
 
<%
//db connect
Connection con = null;
String url = "jdbc:mysql://localhost:3306/SYDMART?serverTimezone = UTC";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("after forName");
			con = DriverManager.getConnection(url, "knu","comp322");
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
		/*************************************************************************************************/
		else if(id.equals("SYD")){
			if(pw.equals("SYD") && pw.equals("SYD")) {
			/*manager login success*/
				session.setAttribute("ID", id);
				out.println("<script>alert('Manager LoginSuccess'); location.href='manager.jsp'</script>");
			}
			/*manager login fail*/
			else
				out.println("<script>alert('Manager Password Error !'); location.href='login_input.jsp'</script>");
		}
	
		//check id and pw are correct
		String sql = "SELECT ID, PW " 
			+ "FROM CUSTOMER"
			+ " WHERE EXISTS"
			+ " (SELECT * FROM CUSTOMER WHERE"
			+ " ID = '" + id +"'"
			+ " And PW = '" + pw + "')";

	Statement stmt = null;
	
	stmt = con.createStatement();
	stmt.executeQuery(sql);
	
	
	ResultSet rs = null;
	rs = stmt.executeQuery(sql);
	
	if(rs.next()) {
		//login success
		LoginManager loginManager = LoginManager.getInstance();
		
		 if(!loginManager.isUsing(id)){
            loginManager.setSession(session, id);
            session.setAttribute("ID", id);
            response.sendRedirect("main.jsp");
		}
		else{
			// 이미 로그인중
			out.println("<script>alert('Id already login!'); location.href='login_input.jsp'</script>");
		}
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