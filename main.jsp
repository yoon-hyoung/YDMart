<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer" %>

<!DOCTYPE HTML5>
<html>
    <title>SYD MART</title>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
                    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
                        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                            <style>
                                .w3-sidebar a {font-family: "Roboto", sans-serif}
                                body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
                                </style>
                            <body class="w3-content" style="max-width:1200px">
                            	<form action="itemdetail.jsp" method = "post" >      
                                 <%//get ID value
  									  String Id = null; //initializie to 0
   									  Id = (String)session.getAttribute("ID");
   									//  out.println(Id);
   									  
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
   											
   										String sql = "select * from CATEGORY";
                                        Statement stmt = con.createStatement();
                                        ResultSet rs = stmt.executeQuery(sql);
                                        
                                        String cat[] = new String[3];
                                        String sub[][] = new String[3][3];
                                        
                                    
                                        while(rs.next()) {
                                        	cat[rs.getInt(1)-1] = rs.getString(2);
                                        }
   										
   										sql = "select * from SUBCATEGORY";
                                        stmt = con.createStatement();
                                        rs = stmt.executeQuery(sql);
                                        

                                        while(rs.next()) {                              
            	                         	sub[rs.getInt(1)-1][rs.getInt(2)-1] = rs.getString(3);
                                        }
 								 %>
                                
                                <!-- Sidebar/menu -->
                                <nav class="w3-sidebar w3-bar-block w3-white w3-collapse w3-top" style="z-index:3;width:300px" id="mySidebar">
                                    <div class="w3-container w3-display-container w3-padding-16">
                                        <%
                                        for(int i = 0; i < 3; i++){
                                        	out.println("<a onclick='myAccFunc"+(i+1)+"()' href='javascript:void(0)' class='w3-button w3-block w3-white w3-left-align w3-large' id='myBtn1'>");
                                        	out.println(cat[i] +"<i class='fa fa-caret-down'></i> </a>");
                                        	out.println("<div id='demoAcc"+(i+1)+"' class='w3-bar-block w3-hide w3-padding-large w3-medium'>");
                                        	for(int j = 0; j < 3; j++) {
                                        		out.println("<a href='"+(i+1)+"-"+(j+1)+"_main.jsp'class='w3-bar-item w3-button'>"+sub[i][j]+"</a>");
                                        	}
                                        	out.println("</div>");
                                        }
                                        	%>
                              			</div>
                                    
                                    <!-- link other thing -->
                                    <a href="changeInfo_input.jsp" class="w3-bar-item w3-button w3-padding" >Change Information</a>
                                    <a href="pwChange_input.jsp" class="w3-bar-item w3-button w3-padding" >Change Password</a>
                              		<a href="Ordered.jsp" class="w3-bar-item w3-button w3-padding" >Ordered list</a>
                              		<a href="cart.jsp" class="w3-bar-item w3-button w3-padding" >Cart</a>
                               		<a href="logout.jsp" class="w3-bar-item w3-button w3-padding" >logout</a>
                              		
                                </nav>
                                
                                <!-- Top menu on small screens -->
                                <header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
                                    <div class="w3-bar-item w3-padding-24 w3-wide"><a href = "main.jsp" style="text-decoration:none">SYD MART</a></div>
                                    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
                                </header>
                                
                                <!-- Overlay effect when opening sidebar on small screens -->
                                <div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>
                                
                                <!-- !PAGE CONTENT! -->
                                <div class="w3-main" style="margin-left:250px">
                                    
                                    <!-- Push down content on small screens -->
                                    <div class="w3-hide-large" style="margin-top:83px"></div>
                                    
                                    <!-- Top header -->
                                    <header class="w3-container w3-xlarge">
                                        <p class="w3-left">Item</p>
                                    </header>
                                    
                                    <!-- Search && show item list section-->
                                    <div class="w3-container w3-black w3-padding-32">
                                        <h1>Is there something looking for?</h1>
                                        <p><input class="w3-input w3-border w3-padding" type="text" placeholder="Search for names.." id="myInput" onkeyup="myFunction()"></p>
                                            <button type="button" class="w3-button w3-red w3-margin-bottom">Searching</button>
                                            </div>
                                    	<table class="w3-table-all w3-margin-top" id="myTable">
                                        <tr>
                                            <th style="width:60%;">Name</th>
                                            <th style="width:40%;">Price</th>
                                            
                                            <%
                                            sql = "select NAME, PRICE, I_NUM from ITEM";
                                            stmt = con.createStatement();
                                            rs = stmt.executeQuery(sql);
                            				while(rs.next()) {
                            					String name = rs.getString(1);
                            					String price = rs.getString(2);
                            					String item = rs.getString(3);
            									//session.setAttribute("item", item);
            									//out.println("<input type = 'hidden' value = '" + item + "' name = 'item'/>");
                            					out.println("<tr><td> <input type = 'submit' value = '" + name + "' name = 'item''/></td><td>" + price + "</a></td></tr>");
                            				}
											out.println("</table>");
											
											stmt.close();
											rs.close();
											con.close();
                                            %>
                                   </div>                                                               
                                    <!-- End page content -->
                               
                                
                                <script>
                                    //상품 검색
                                    function myFunction() {
                                        var input, filter, table, tr, td, i;
                                        input = document.getElementById("myInput");
                                        filter = input.value.toUpperCase();
                                        table = document.getElementById("myTable");
                                        tr = table.getElementsByTagName("tr");
                                        for (i = 0; i < tr.length; i++) {
                                            td = tr[i].getElementsByTagName("td")[0];
                                            if (td) {
                                                if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                                                    tr[i].style.display = "";
                                                } else {
                                                    tr[i].style.display = "none";
                                                }
                                            }
                                        }
                                    }
                                
                                // Accordion
                                function myAccFunc1() {
                                    var x = document.getElementById("demoAcc1");
                                    if (x.className.indexOf("w3-show") == -1) {
                                        x.className += " w3-show";
                                    } else {
                                        x.className = x.className.replace(" w3-show", "");
                                    }
                                }
                                
                                // Click on the cat1 link on page load to open the accordion for demo purposes
                                document.getElementById("myBtn1").click();
                                
                                // Accordion
                                function myAccFunc2() {
                                    var x = document.getElementById("demoAcc2");
                                    if (x.className.indexOf("w3-show") == -1) {
                                        x.className += " w3-show";
                                    } else {
                                        x.className = x.className.replace(" w3-show", "");
                                    }
                                }
                                
                                // Click on the cat2 link on page load to open the accordion for demo purposes
                                document.getElementById("myBtn2").click();
                                
                                // Accordion
                                function myAccFunc3() {
                                    var x = document.getElementById("demoAcc3");
                                    if (x.className.indexOf("w3-show") == -1) {
                                        x.className += " w3-show";
                                    } else {
                                        x.className = x.className.replace(" w3-show", "");
                                    }
                                }
                                
                                // Click on the cat3 link on page load to open the accordion for demo purposes
                                document.getElementById("myBtn3").click();
                                
                                
                                
                                
                                // Script to open and close sidebar
                                function w3_open() {
                                    document.getElementById("mySidebar").style.display = "block";
                                    document.getElementById("myOverlay").style.display = "block";
                                }
                                
                                function w3_close() {
                                    document.getElementById("mySidebar").style.display = "none";
                                    document.getElementById("myOverlay").style.display = "none";
                                }                               
                                
                                </script>
                                
                            </body>
</html>
