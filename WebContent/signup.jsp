<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language ="java" import ="java.text.*,java.sql.*" %>
<%@ page language ="java" import ="java.lang.Integer" %>
<!DOCTYPE html>
<html>
<head>
<meta charset = "UTF-8">
<title>SYD sign-up management Page</title>
</head>
<body>
<%
Connection conn = null;
String url = "jdbc:mysql://localhost:3306/SYDMART?serverTimezone = UTC";
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			System.out.println("after forName");
			conn = DriverManager.getConnection(url, "knu","comp322");
			System.out.println("DBms connection success");
			System.out.println("DB load success");
		} catch(Exception e) {
			System.out.println("DB load fail" + e.toString());
		}

		Statement pstmt = conn.createStatement();
		ResultSet rs = null;
		
		String query = "INSERT INTO CUSTOMER (ID, PW, ZIPCODE, NAME, PHONENUM, CITY, AGE, GENDER, JOB)" 
				+" VALUES( ";
		
		//get value
		String id = request.getParameter("Id");
		query += "'"+id+"',";
		String pw = request.getParameter("Password");
		query += "'"+pw+"'";
		String zip = request.getParameter("Zipcode");
			query += ","+zip;
		String name = request.getParameter("Name");
		query += ",'"+name+"'";
		String phone = request.getParameter("Phone");
		if(phone == "")
			query += ",null";
		else
			query += ",'"+phone+"'";
		String city = request.getParameter("City");
			query += ",'"+city+"'";
		String age = request.getParameter("Age");
		if(age == "")
			query += ",null";
		else
			query += ","+age;
		String gender =  request.getParameter("Gender") ;
		if(gender == "")
			query += ",null";
		else
			query += ",'"+gender+"'";
		String job = request.getParameter("Job");
		if(job == "")
			query += ",null";
		else
			query += ",'"+job+"'";
		
		query += ");";

		
		//같은 아이디 있는지 확인 
		String query1 = "select * from CUSTOMER where ID = " + "'" +id + "'";
		
		pstmt = conn.prepareStatement(query1);
		rs = pstmt.executeQuery(query1);
		
		if(rs.next() || id.equals("SYD") {
			out.println("<script>alert('ID duplicate'); location.href='signup_input.jsp'</script>");
		}
		else if(id =="" || pw == "" || name == "" || phone == "" || zip == "" || city == "")
		{
			out.println("<script>alert('Input essential info'); location.href='signup_input.jsp'</script>");
		}
		else {
			/*sign-up success*/
		out.println(query);
		Statement stmt = conn.prepareStatement(query);
		stmt.executeUpdate(query);
		
			/*Get C_NUM*/
		stmt = conn.createStatement();
		String sql1 = "select C_NUM FROM CUSTOMER WHERE ID = '" + id +"'";
		stmt.executeQuery(sql1);
		rs = null;
		rs = stmt.executeQuery(sql1);

		int c_num = 0;
		if(rs.next()) {
			c_num = rs.getInt(1);
		}
		
		/*make cart*/
		query = "Insert into SHOPPINGBAG values (" + c_num  +", 0)";
		stmt.executeUpdate(query);
		
		out.println("<script>location.href='signup_output.jsp'</script>");
		}
	
	pstmt.close();
	conn.close();
	
%>

</body>