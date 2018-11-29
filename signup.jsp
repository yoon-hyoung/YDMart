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

		Statement pstmt = conn.createStatement();
		ResultSet rs = null;
		
		String query = "INSERT INTO CUSTOMER (ID, PW, ZIPCODE, NAME, PHONENUM, CITY, GENDER, AGE, JOB)" 
				+" VALUES( ";
		
		//값 받아오기 
		String id = request.getParameter("Id");
		query += "'"+id+"',";
		String pw = request.getParameter("Password");
		query += "'"+pw+"'";
		String zip = request.getParameter("Zipcode");
		if(zip == "") {
			query += ",null";
		}
		else
			query += ","+zip;
		String name = request.getParameter("Name");
		query += ",'"+name+"'";
		String phone = request.getParameter("Phone");
		if(phone == "")
			query += ",null";
		else
			query += ",'"+phone+"'";
		String city = request.getParameter("City");
		if(city == "")
			query += ",null";
		else
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
		
		/*
		out.println(id);
		out.println(pw);
		out.println(zip);
		out.println(name);
		out.println(phone);
		out.println(city);
		out.println(age);
		*/
		
		//같은 아이디 있는지 확인 
		String query1 = "select * from CUSTOMER where ID = " + "'" +id + "'";
		//System.out.println(id);
		pstmt = conn.prepareStatement(query1);
		rs = pstmt.executeQuery(query1);
		
		if(rs.next()) {
			out.println("<script>alert('ID duplicate'); location.href='signup_input.jsp'</script>");
		}
		else if(id =="" || pw == "" || name == "" || phone == "")
		{
			out.println("<script>alert('Input essential info'); location.href='signup_input.jsp'</script>");
		}
		else {
		out.println(query);
		Statement stmt = conn.prepareStatement(query);
		stmt.executeUpdate(query);
		
		out.println("<script>location.href='signupSuccess.jsp'</script>");
		}
	
	pstmt.close();
	conn.close();
	
%>

</body>
