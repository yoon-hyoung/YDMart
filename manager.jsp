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
    
							%>
  					
					<!-- Stock section -->

                                <!-- !PAGE CONTENT! -->
                                <div class="w3-main" style="margin-left:250px">
                                    
                                    <!-- Push down content on small screens -->
                                    <div class="w3-hide-large" style="margin-top:10px"></div>
                                    
                                    <!-- Top header -->
                                    <header class="w3-container w3-xlarge w3-blue">
                                        <p class="w3-left">Manager Mode</p>
                                    </header>
                                    
                                            
                                         <h1>Stock grouping by retailer</h1>
                            			 <p>If click item, you can see item_detail page</p>
                                    	<table class="w3-table-all w3-margin-top" id="myTable">
                                        <tr>
                                            <th style="width:40%;">Name</th>
                                            <th style="width:10%;">Stock</th>
                                            
                                            <th style="width:20%;">Plus</th>
                                            <th style="width:10%;">check</th>
                                        </tr>
                                      <%       
                                            String sql = "select NAME, TOTAL_STOCK from ITEM ORDER BY TOTAL_STOCK";
                                            Statement stmt = con.createStatement();
                                            ResultSet rs = stmt.executeQuery(sql);
                                            
                            				while(rs.next()) {
                            					String name = rs.getString(1);
                            					String stock = rs.getString(2);
            									//session.setAttribute("item", item);
            									//out.println("<input type = 'hidden' value = '" + item + "' name = 'item'/>");
                            					out.println("<tr><td>"+ name + "</td><td>" + stock + "</td>");
                            					out.println("<td><input type='text' name='plus'></td>");
                            					out.println("<td><button >+</button></td></tr>");
                            				}
											out.println("</table>");
										
                                            %>
                                   </div>                                                               
                           
                            </div>
                                              
                                
    <!--Profit section -->
<div class="w3-container">

<h1>Total sale chart</h1>

<div class="w3-light-grey">

<%

sql = "select SUM(PRICE) from ITEM WHERE I_NUM IN (select I_NUM  from ORD_ITEML WHERE O_NUM IN (select O_NUM  from ORDERED WHERE ORDER_DATE > '2016-01-01' AND ORDER_DATE < '2018-12-31'))";
stmt = con.createStatement();
rs = stmt.executeQuery(sql);

while(rs.next()) {
	String a = rs.getString(1);
	int sale = Integer.parseInt(a);
	out.println(" <div class='w3-container w3-green w3-center' style='width:");
	out.println(sale/6213+"%'>");
	out.println(sale+"WON");
}
out.println("</div>");

stmt.close();
rs.close();
con.close();

%>

</div><br>
<form action="manager_month.jsp" >
<p>If you enter the year, you can see month chart</p>
 <input class="w3-input w3-border" name="year" type="text" placeholder="year">
   <p class="w3-center">
<button class="w3-button w3-section w3-blue w3-ripple"> Search </button>
   										
    </form>
 
    
</div>
</body>
</html> 