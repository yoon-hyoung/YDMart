<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer, java.util.ArrayList" %>

<script>
function check() {	
	  if(fr.Name.value == "") {
	    alert("Input name");
	    fr.Name.focus();
	    return false;
	  }
	  else if(fr.City.value == "") {
		  alert("Input city");
		  fr.City.focus();
		  return false;
	  }
	  else if(fr.Zipcode.value == "") {
	    alert("Input zipcode");
	    fr.Zipcode.focus();
	    return false;
	  }
	  else if(fr.Phone.value == "") {
		    alert("Input Phone number");
		    fr.Phone.focus();
		    return false;
	  }

}
</script>

<!DOCTYPE HTML5>
<html>
<title>Purchase</title>
<meta name="viewport" content="width=device-width, initial-scale=1" charset = "UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<body>

<form action="charging.jsp" class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin"
	 method = "post" name="fr" onsubmit="return check()">
<h2 class="w3-center">Purchase Item</h2>

<%
	/*connect to DB*/
	Connection con = null;
	String url = "jdbc:mysql://localhost:3306/SYDMart?serverTimezone = UTC";
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			//System.out.println("after forName");
			con = DriverManager.getConnection(url, "root","ekdms1234");
			//System.out.println("DBms connection success");
			//System.out.println("DB load success");
		} catch(Exception e) {
			System.out.println("DB load fail" + e.toString());
		}
		
		/*get ID value*/
		  String Id = null; //initializie to 0
			  Id = (String)session.getAttribute("ID");
		  if(Id == null || Id == "" )
			  Id = "gi6";
		  
			/*get item information*/
			String [] itemList = null;
			itemList = request.getParameterValues("item");
		  
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
			
			if (itemList == null){
				out.println("<script>alert('Select items !'); location.href='cart.jsp'</script>");
			}
			else{
				/*get Total price*/
				int tp = 0;
				for(int i = 0; i < itemList.length; i++) {
					sql1 = "select PRICE FROM ITEM WHERE I_NUM = " + itemList[i];
					rs = stmt.executeQuery(sql1);
					while(rs.next()){
						tp += rs.getInt(1);
					}
				}
				
				out.println("<table class='w3-table-all w3-margin-top' id='myTable'> <tr>"	
		  			+  " <th style='width:10%;'>NUM</th> <th style='width:45%;'>NAME</th> <th style='width:45%;'>PRICE</th>");
			
				for(int i= 0; i < itemList.length; i++) {
					out.println("<input type = 'hidden' name = 'item' value = '" + itemList[i] + "' >");
					sql1 = "select NAME,PRICE from ITEM where I_NUM = " + itemList[i];
					stmt = con.createStatement();
					rs = stmt.executeQuery(sql1);
				  	while(rs.next()) {
						out.println("<tr> <td>"+(i+1)+ "</td><td>"+ rs.getString(1) +"</td><td>" + rs.getInt(2)  + "</td></tr>");
					}
				}
				out.println("tatal price : " + tp + "(won)<br>");
			}
			
%>	
</table>

<h2 class="w3-center">Deliver Address</h2>


<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Name" type="text" placeholder="Name">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope-o"></i></div>
    <div class="w3-rest">
<select name = "City">
       <option value="Seoul">Seoul</option>
       <option value="Incheon">Incheon</option>
       <option value="Gyeongi">Gyeongi</option>
       <option value="Gwagnwon">Gwagnwon</option>
       <option value="Chungchugn">Chungchugn</option>
       <option value="Daegu">Daegu</option>
       <option value="Ulsan">Ulsan</option>
       <option value="Gyeongsang">Gyeongsang</option>
       <option value="Busan">Busan</option>
       <option value="Jeonla">Jeonla</option>
       <option value="Sejong">Sejong</option>
       <option value="Daejun">Daejun</option>
       <option value="Jeju">Jeju</option>       
</select>   
</div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope-o"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Zipcode" type="text" placeholder="Zipcode">
    </div>
</div>


<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-phone"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Phone" type="text" placeholder="Phone">
    </div>
</div>
<input type = "submit" value = "Charging"></input>
<p class="w3-center">
</p>
</form>
</body>
</html> 
