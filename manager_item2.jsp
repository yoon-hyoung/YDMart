<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
<title>manager</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-content" style="max-width:1200px">
               <%        
               //get ID value
				  String Id = null; //initializie to 0
				  Id = (String)session.getAttribute("ID");
				//  out.println(Id);
				  
				  //connect to DB
				Connection con = null;
				String url = "jdbc:mysql://localhost:3306/SYDMART?serverTimezone = UTC";
					try {
						Class.forName("com.mysql.jdbc.Driver").newInstance();
						System.out.println("after forName");
						con = DriverManager.getConnection(url, "knu","comp322");
						System.out.println("DBms connection success");
						System.out.println("DB load success");
					} catch(Exception e) {
						System.out.println("DB load fail" + e.toString());
					}	

                               /*decrease retailer stock*/
		String i = request.getParameter("City");
		int city= Integer.parseInt(i);
		out.println(i);
		
		String k = request.getParameter("Item");
		int item= Integer.parseInt(k);
		out.println(k);
		
		
		String j = request.getParameter("Plus");
		int plus= Integer.parseInt(j);
		out.println(j);
	
	
				//increase retailer stock
				String sql = "Update POSSESS_ITEM SET STOCK=STOCK+ "+plus+" WHERE R_NUM="+city+ " AND ITEM_NUM="+item;
				 Statement stmt = con.prepareStatement(sql);
				stmt.executeUpdate(sql);
				
				
				//increase total stock
				sql = "Update ITEM SET TOTAL_STOCK=TOTAL_STOCK+ "+plus+" WHERE I_NUM="+item;
				stmt = con.prepareStatement(sql);
				stmt.executeUpdate(sql);
				
				out.println("<script>alert('Success!'); location.href='manager.jsp'</script>");
				
				%>
				
</body>
</html>