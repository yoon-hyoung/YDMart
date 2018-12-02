<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer, java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<title>Purchasing</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<form action="purchasing.jsp" class="w3-container w3-card-4" method = "post">
  <!-- Top menu on small screens -->
  <header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
  <div class="w3-bar-item w3-padding-24 w3-wide"><a href = "main.jsp" style="text-decoration:none">SYD MART</a></div>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
  </header>  

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
	
		  /*get ID*/
		  String Id = null; //initializie to 0
		  Id = (String)session.getAttribute("ID");
		  if(Id == null || Id == "" )
			  Id = "gi6";
		  
			/*get i_num information*/
			String [] itemList = null;
			itemList = request.getParameterValues("item");
			/*get item fail*/
			if(itemList == null) System.out.println("err");
			/*get item success*/
			else {
				
			/*get delivery information*/
			String name = request.getParameter("Name");
			String zip = request.getParameter("Zip");
			String city = request.getParameter("City");
			String phone = request.getParameter("Phone");
			
			System.out.println(name);
			System.out.println(zip);
			System.out.println(city);
			System.out.println(phone);


			
			/*GET C_NUM from CUSTOMER TABLE*/
			Statement stmt = con.createStatement();
			String sql1 = "select C_NUM FROM CUSTOMER WHERE ID = '" + Id +"'";
			ResultSet rs = null;
			rs = stmt.executeQuery(sql1);

			int c_num = 0;
			if(rs.next()) {
				c_num = rs.getInt(1);
			}
			
			/*total item account count*/
			int total_inum = 0;
			ArrayList<Integer> act = new ArrayList<Integer>(); //for each item account
			/*count each item*/
			for(int i = 0; i < itemList.length; i++) {
				sql1 = "select COUNT(*) from SH_ITEML where SH_NUM = " + c_num + " AND I_NUM =" + itemList[i];
				rs = stmt.executeQuery(sql1);
				while(rs.next()) {
					act.add(rs.getInt(1));
					total_inum += rs.getInt(1);
				}
			}
			
			/*SHOPPINGBAG TOTAL ITEM UPDATE*/
			sql1 = "Update SHOPPINGBAG SET TOTAL_INUM = TOTAL_INUM-"+ total_inum +" WHERE C_NUM = " + c_num + ";"; 
			stmt = con.prepareStatement(sql1);
			stmt.executeUpdate(sql1);
			
			/*Delete items from cart*/
			for(int i = 0; i < itemList.length; i++) {
				sql1 = "DELETE FROM SH_ITEML WHERE SH_NUM = " 
						+ c_num +" AND I_NUM = " + itemList[i] + ";";
				stmt = con.prepareStatement(sql1);
				stmt.executeUpdate(sql1);
			}
			
		}
			
%>
</form>

</body>
</html> 