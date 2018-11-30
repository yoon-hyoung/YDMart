<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<title>장바구니</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<form action="cart.jsp" class="w3-container w3-card-4" method = "post">

 <h2>Charging</h2>

<%
	/*connect to DB*/
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
		
		/*get ID value*/
		  String Id = null; //initializie to 0
			  Id = (String)session.getAttribute("ID");
		  if(Id == null || Id == "" )
			  Id = "gi6";
		  
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
			
			/*get checked I_NUM*/
			String [] itemList = request.getParameterValues("item");		
			for(int i = 0; i < itemList.length; i++) {
				out.print(itemList[i]);
			}
%>
 
 
 <a href = "cart.jsp" ><input type = "submit" value = "Charging"></input></a>
 
</form>

</body>
</html> 