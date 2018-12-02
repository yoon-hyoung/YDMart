<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<title>CART ITEM DELETE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<form action="complete_cart.jsp" class="w3-container w3-card-4" method = "post">

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

	//get ID value
	String Id = null; //initializie to 0
		  Id = (String)session.getAttribute("ID");
	if(Id == null || Id == "" )
		  Id = "gi6";
	
	/*get items for delete*/
	String [] itemList = null;
	itemList = request.getParameterValues("item");
	

		/*GET C_NUM from CUSTOMER TABLE*/
			Statement stmt = conn.createStatement();
			String sql = "select C_NUM FROM CUSTOMER WHERE ID = '" + Id +"'";
			stmt.executeQuery(sql);
			ResultSet rs = null;
			rs = stmt.executeQuery(sql);

			int c_num = 0;
			
			if(rs.next()) {
				c_num = rs.getInt(1);
			}
								
			if(itemList == null) {
				out.println("<script>alert('Select items !'); location.href='change_cart.jsp'</script>");
			}
			else {
				int num = 0;
				for(int i = 0; i < itemList.length; i++) {
					String query = "SELECT COUNT(*) FROM SH_ITEML WHERE"
								+" SH_NUM = " +c_num +" AND I_NUM = " + itemList[i];
					stmt = conn.prepareStatement(query);
					
					/*get item account*/
					rs = stmt.executeQuery(query);
					while(rs.next()) {
						num = rs.getInt(1);
					}
					
					query = "DELETE FROM SH_ITEML WHERE SH_NUM = " 
							+ c_num +" AND I_NUM = " + itemList[i] + ";";
					stmt = conn.prepareStatement(query);
					stmt.executeUpdate(query);
								
					/*Update shoppingbag total inum*/
					query = "Update SHOPPINGBAG SET TOTAL_INUM = TOTAL_INUM-"+ num +" WHERE C_NUM = " + c_num + ";"; 
					stmt = conn.prepareStatement(query);
					stmt.executeUpdate(query);
				}
			}
			
			//out.println("<script>alert('Item delete success !'); location.href='cart.jsp'</script>");

				
%>
</form>

</body>
</html> 