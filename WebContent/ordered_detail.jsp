<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<title>Ordered List</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
           <form action = "Ordered_Detail.jsp" method = "post"> 
                                                                                      
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
		
		  int c_num = 0;
			
		  ResultSet rs = null;
			Statement stmt = con.createStatement();
			
			String sql = "select * from ORD_ITEML where O_NUM =" + request.getParameter("num");
			rs = stmt.executeQuery(sql);
		  %>
		  
  <table class="w3-table-all w3-margin-top" id="myTable">
 <tr>
  	   <th style="width:10%;">NUM</th>
 	   <th style="width:45%;">ITEM</th>
 	   <th style="width:45%;">PRICE</th>
		
		  <% 
			
		 String sql2 = null;
		 ResultSet rs2 = null;
		 Statement st = con.createStatement();
		int count = 1;
		
		ArrayList<Integer> list = new ArrayList<Integer>();
		  while(rs.next()){
			  list.add(rs.getInt(2));
		  }
		  
		
		  while(list.size() >= count){
			  sql2 = "select NAME, PRICE from ITEM where I_NUM = " + list.get(count-1);
			  st = con.createStatement();
			  rs2 = st.executeQuery(sql2);
			  while(rs2.next()) {
			  	String name = rs2.getString(1);
			  	int price = rs2.getInt(2);
			  	out.println("<tr> <td>"+count+ "</td><td>"+ name +"</td><td>" + price  + "</td></tr>");
			  count++;
			  }
		  }
				
%>

<!뒤로가기>
<a href="ordered.jsp"><span class="w3-left w3-xxlarge">« Go Back</span></a>

                                           
</table>
</form> 

</body>
</html>