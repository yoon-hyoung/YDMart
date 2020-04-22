<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer, java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<title>CART</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<form action="ordering_input.jsp" class="w3-container w3-card-4" method = "post">
  <!-- Top menu on small screens -->
                  <header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
                  <div class="w3-bar-item w3-padding w3-wide"><a href = "main.jsp" style="text-decoration:none">SYD MART</a></div>
              <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
                                </header>  

<%
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
		
		//get ID value
		  String Id = null; //initializie to 0
			  Id = (String)session.getAttribute("ID");
		  if(Id == null || Id == "" )
			  Id = "gi6";
		  %>
		  <br/><br/>
		  <bt/><br/><br/>
		  <bt/>
		  <h2><%=Id %>'s CART</h2>
		  <hr></hr>
		  
		 *** Check what you want to buy ! ***</br></br>
		 Unchecked items are out of stock now...&nbsp;&nbsp;:<<br>
		 		  <hr></hr>
		 <br>
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
			
			/*고객의 장바구니에 있는 item number 가져오기*/
			sql1 = "select I_NUM, COUNT(I_NUM) from SH_ITEML where SH_NUM = " + c_num +" GROUP BY I_NUM";	
			
			rs = null;
			rs = stmt.executeQuery(sql1);

			ArrayList<Integer> list = new ArrayList<Integer>();
			ArrayList<Integer> nlist = new ArrayList<Integer>();
			int count = 0;
			int temp = 0;
			while(rs.next()) {
				temp = rs.getInt(1);
				list.add(temp);
				nlist.add(rs.getInt(2));
				count++;
			}
			
			String sql2 = null;
		
			for(int i = 0; i < count; i++) {
				sql2 = "select NAME, PRICE, TOTAL_STOCK, COUNT(NAME) from ITEM where I_NUM = " + list.get(i);
				rs = stmt.executeQuery(sql2);
				while(rs.next()) {
					String name = rs.getString(1);
					String price = rs.getString(2);	
					if(rs.getInt(3) < nlist.get(i)) {
						out.println("<p><label>" + name + " &nbsp;&nbsp; "+ price+" (won) &nbsp;&nbsp"+ nlist.get(i)+"</label></p>");
					}
					else {
					%>
						<p> <input class="w3-radio" type="checkbox" name="item" value="<%=list.get(i)%>"  checked> 
						<a href = "item_detail.jsp?item=<%=name%>"><label><%=name%></a> &nbsp;&nbsp;<%=price%> (won) &nbsp;&nbsp;
						<%=nlist.get(i)%></label></p>
					<% 
					}
				}
			}
					
%>
 <a href = "ordering_input.jsp" ><input type = "submit" value = "Order"></input></a>
</form>

<form action = "cart_change.jsp" method = "post">
<a href = "cart_change.jsp" ><input type = "submit" value = "Delete Item"></input></a>
</form>

</body>
</html> 