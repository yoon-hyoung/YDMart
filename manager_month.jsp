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

      <h2>Month sale chart</h2>
<p>If you enter the month, you can see date chart</p>
      
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
   										out.println("<form action='manager_date.jsp'>");
   									out.println("<input class='w3-input w3-border' name='year' value="+y+">");
   										%>
   										 <input class="w3-input w3-border" name="month" type="text" placeholder="month">
   										 
   <p class="w3-center">
<button class="w3-button w3-section w3-blue w3-ripple"> Search </button>
   										  </form>
   										  
   										  
   										<% 
   										
  int i=1;
while(i!=13){
	out.println("<p>"+y+i+"</p>");
	out.println("<div class='w3-light-grey'>");
	
String sql = "select SUM(PRICE) from ITEM WHERE I_NUM IN (select I_NUM from ORD_ITEML WHERE O_NUM IN (select O_NUM from ORDERED WHERE ORDER_DATE > '"+y+"-"+i+"-01' AND ORDER_DATE < '"+y+"-"+i+"-28'))";
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

while(rs.next()) {
	int sale;
	String a = rs.getString(1);
	if(a==null)sale=0;
	else sale = Integer.parseInt(a);
	out.println(" <div class='w3-container w3-green w3-center' style='width:");
	out.println(sale/6213+"%'>");
	out.println(sale+"WON");
}
out.println("</div>");
i++;
}

      %>
   

 
    </div>
    </div>
   
        
</body>
</html> 