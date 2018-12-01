<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language ="java" import ="java.text.*,java.sql.*" %>

<!DOCTYPE html>
<html>
<title>SYD Mart _ Change Information</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<body>

<form action="chageInfo.jsp" class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin" method = "post">
<h2 class="w3-center">Customer Info Change</h2>
 
 <%
String id = (String)request.getAttribute("ID");
 
 if(id == null || id =="")
	 id = "1";
 
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

	String sql = "select * from CUSTOMER where ID = '" + id + "'";
	Statement stmt = conn.createStatement();
	stmt.executeQuery(sql);

	ResultSet rs = null;
	rs = stmt.executeQuery(sql);
	
	String zip = null, name = null, phone = null, city = null, gen = null, age = null, job = null;
	
	while(rs.next()) {
		zip = rs.getString("ZIPCODE");
		name = rs.getString("NAME");
		phone = rs.getString("PHONENUM");
		city = rs.getString("CITY");
		gen = rs.getString("GENDER");
		age = rs.getString("AGE");
		job = rs.getString("JOB");
	}
	
	conn.close();
	
%>
 

    	
      <input class="w3-input w3-border" name="Id" type = "hidden" value=<%out.println(id);%>>
 

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-large fa">zipcode</i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Zipcode" type="text" value=<%out.println(zip);%>  placeholder="New Zipcode">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-large fa">name</i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Name" type="text" value=<%out.println(name);%>  placeholder="New Name">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-large fa">phone</i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Phone" type="text" value=<%out.println(phone);%>  placeholder="New Phone">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-large fa">city</i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="City" type="text" value=<%out.println(city);%>  placeholder="New City">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-large fa">gender</i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Gender" type="text" value=<%out.println(gen);%>  placeholder="New Gender(F/M)">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-large fa">age</i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Age" type="text" value=<%out.println(age);%>  placeholder="New Age">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-large fa">job</i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Job" type="text" value=<%out.println(job);%>  placeholder="New Job">
    </div>
</div>

<p class="w3-center">
<button class="w3-button w3-section w3-blue w3-ripple"> Send </button>
</p>
</form>

</body>
</html> 