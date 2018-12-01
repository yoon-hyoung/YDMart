<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<title>Ordered List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
           <form action = "Ordered_Detail.jsp" method = "post">    
             
                                <!-- Top menu on small screens -->
                                <header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
                                    <div class="w3-bar-item w3-padding-24 w3-wide"><a href = "main.jsp" style="text-decoration:none">SYD MART</a></div>
                                    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
                                </header>                                                                        
<%
//connect to DB
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
		
		//get ID value
		  String Id = null; //initializie to 0
			  Id = (String)session.getAttribute("ID");
		  if(Id == null || Id == "" )
			  Id = "gi6";
		  %><br/><br/>
		  <bt/><br/><br/>
		  <bt/>
		  <h2><%=Id %>'s Ordered List</h2>
  <br/>
  <table class="w3-table-all w3-margin-top" id="myTable">
 <tr>
 	   <th style="width:5%;">NUM</th>
       <th style="width:20%;">ORDER_DATE</th>
       <th style="width:20%;">STATE</th>
       <th style="width:20%;">CITY</th>
       <th style="width:20%;">ZIPCODE</th>
       <th style="width:15%;">DETAIL</th>

		  <% 
		
			/*GET C_NUM from CUSTOMER TABLE*/
			Statement stmt = con.createStatement();
			String sql1 = "select C_NUM FROM CUSTOMER WHERE ID = '" + Id +"'";
			stmt.executeQuery(sql1);
			ResultSet rs = null;
			rs = stmt.executeQuery(sql1);

			int c_num = 0;
			
			if(rs.next()) {
				c_num = rs.getInt(1);
			}
			
			String sql = "select ORDER_DATE,STATE,CITY,ZIPCODE, O_NUM from ORDERED where CUS_NUM =" + c_num ;
			rs = stmt.executeQuery(sql);
			int count = 1;
			while(rs.next()) {
				String date = rs.getString(1);
				String state = rs.getString(2);
				String city = rs.getString(3);
				String zip = rs.getString(4);
				String num = rs.getString(5);

				out.println("<tr> <td>"+count+ "</td><td>" +date+"</td><td>" +state + "</td><td>" + city + "</td><td>" + zip 
						+ "</td><td><input type = 'submit' value = '"+num+"' name = 'num'> </td></tr>");
				count++;
			}
				
%>
                                           
</table>
</form> 

</body>
</html>