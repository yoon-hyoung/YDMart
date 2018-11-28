<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<!-- [IMPORTANT] Complete your scripting. -->
<%@ page language ="java" import ="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>COMP322003/004: Databases</title>
</head>
<body>
	<h2>Lab #9: Oracle-Tomcat Conjunction</h2>
<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	String user = "knu";
	String pass = "comp322";
	//Complete your code.
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection(url,user,pass);
	
	String query = "INSERT INTO CUSTOMER(C_ID,PW,ZIPCODE,NAME,PHONENUM,CITY,GENDER,AGE,JOB)" 
			+ " VALUES('" + request.getParameter("Id")+"'"
			+ ",'" + request.getParameter("Password")+"',"
			+  request.getParameter("Zipcode")
			+ ",'" + request.getParameter("Name") + "',"
			+  request.getParameter("Phone")
			+ ",'" + request.getParameter("City") + "'"
			+ ",'"+ request.getParameter("Gender") + "',"
			+  request.getParameter("Age")
			+ ",'"+ request.getParameter("Job")
			+ "')";
	
	out.println(query);
	
	pstmt = conn.prepareStatement(query);
	rs=pstmt.executeQuery();
%>
    <h4>------ Q1 Result ------</h4>
<% 

	// Complete your code.
	out.println(request.getParameter("Id"));
	out.println(request.getParameter("Password"));
	out.println("customer signup success!");
	
	ResultSetMetaData rsmd;
	int cnt;
	out.println("<table border=\"1\">");
	rsmd =rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i=1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		for(int i=1;i<=cnt;i++){
			out.println("<td>"+rs.getString(i)+"</td>");
		}
		out.println("</tr>");
	}
	out.println("</table>");
	pstmt.close();
	conn.close();
	
%>

</body>
</html>