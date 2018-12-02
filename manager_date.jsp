<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
<title>W3.CSS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-content" style="max-width:1200px">

<div class="w3-container">

      <h2>Date sale chart</h2>
    
      
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
   										String y=request.getParameter("year");
   										String m =request.getParameter("month");
   										
  int d=1;
while(d!=29){
	out.println("<p>"+y+m+d+"</p>");
	out.println("<div class='w3-light-grey'>");
	
String sql = "select SUM(PRICE) from ITEM WHERE I_NUM IN (select I_NUM from ORD_ITEML WHERE O_NUM IN (select O_NUM from ORDERED WHERE ORDER_DATE = '"+y+"-"+m+"-"+d+"'))";
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

while(rs.next()) {
	int sale;
	String a = rs.getString(1);
	if(a==null)sale=0;
	else sale = Integer.parseInt(a);
	out.println(" <div class='w3-container w3-green w3-center' style='width:");
	out.println(sale/3000+"%'>");
	out.println(sale+"WON");
}
out.println("</div>");
d++;
}

      %>
   

 
    </div>
    </div>
   
        
</body>
</html> 