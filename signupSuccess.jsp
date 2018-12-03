<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer" %>
<%@ page import ="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>~! signup Success !~</title>
</head>
<body>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div style="text-align:center"><h2>signup success !</h2></div>
<a href = "main.jsp"><button>go to SYDMart</button></a>
<%
	/*get ID value*/
	String Id = null; //initializie to 0
	Id = (String)session.getAttribute("ID");
	
	/*connect to DB*/
	Connection con = null;
	String url = "jdbc:mysql://localhost:3306/SYDMart?serverTimezone = UTC";
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(url, "root","ekdms1234");
	} catch(Exception e) {
		System.out.println("DB load fail" + e.toString());
	}
	
	Statement stmt = con.createStatement();
	ResultSet rs = null;
	
	String sql = "SELECT C_NUM, AGE, GENDER FROM CUSTOMER WHERE ID = " + Id;
	rs = stmt.executeQuery(sql);
	
	int cnum = 0, age = 0;
	String gender = null;
	while(rs.next()){
		cnum = rs.getInt(1);
		age = rs.getInt(2);
		gender = rs.getString(3);
	}
	
	System.out.println("cnum = " + cnum + "   age = " + age + "   gender = " + gender);
	
	ArrayList<Integer> inum = new ArrayList<Integer>();
	if(age !=0 || gender != null) {
	/*get customer information*/
		if(age != 0 && gender == null){
			if(age < 20){
				/*get top5 items*/
				sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
							+" IN (SELECT C_NUM FROM CUSTOMER WHERE AGE < 20)) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				for(int j = 0; rs.next(); j++){
					inum.add(rs.getInt(1));
				}
			}
			else if(19 < age  && age < 30)
			{
				/*get top5 items*/
				sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
							+" IN (SELECT C_NUM FROM CUSTOMER WHERE 19 < AGE AND AGE < 30)) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				for(int j = 0; rs.next(); j++){
					inum.add(rs.getInt(1));
				}
			}
			else if(29 < age && age < 40)
			{
				/*get top5 items*/
				sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
							+" IN (SELECT C_NUM FROM CUSTOMER WHERE 29 < AGE AND AGE < 40)) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				for(int j = 0; rs.next(); j++){
					inum.add(rs.getInt(1));
				}			
			}
			else if(39 < age && age <50)
			{
				/*get top5 items*/
				sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
							+" IN (SELECT C_NUM FROM CUSTOMER WHERE 39 < AGE AND AGE < 40)) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				for(int j = 0; rs.next(); j++){
					inum.add(rs.getInt(1));
				}			
			}
			else if(49 < age && age < 60)
			{	
				/*get top5 items*/
				sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
							+" IN (SELECT C_NUM FROM CUSTOMER WHERE 49 < AGE AND AGE < 50)) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				for(int j = 0; rs.next(); j++){
					inum.add(rs.getInt(1));
				}			
			}
			else{
				/*60 < age*/
				/*get top5 items*/
				sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
							+" IN (SELECT C_NUM FROM CUSTOMER WHERE AGE < 60)) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				for(int j = 0; rs.next(); j++){
					inum.add(rs.getInt(1));
				}			
			}	
		}	
		else if(age != 0 && gender != null) {
			if(age < 20){
				if(gender.equals("F")){
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE AGE < 20> AND GENDER = 'F')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}
				else{
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE AGE < 20 AND GENDER = 'M')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}
			}	
			else if(19 < age  && age < 30)
			{
				if(gender.equals("F")){
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 19 < AGE AND AGE < 30 AND GENDER = 'F')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}
				else{
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 19 < AGE AND AGE < 30 AND GENDER = 'M')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}			
			}	
			else if(29 < age && age < 40)
			{
				if(gender.equals("F")){
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 29 < AGE AND AGE < 40 AND GENDER = 'F')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}
				else{
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 29 < AGE AND AGE < 40 AND GENDER = 'M')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}
			}
			else if(39 < age && age <50)
			{
				if(gender.equals("F")){
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 39 < AGE AND AGE < 50 AND GENDER = 'F')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}
				else{
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 39 < AGE AND AGE < 50 AND GENDER = 'M')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}			
			}
			else if(49 < age && age < 60)
			{
				if(gender.equals("F")){
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 49 < AGE AND AGE < 50 AND GENDER = 'F')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}
				else{
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 49 < AGE AND AGE < 50 AND GENDER = 'M')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}			
			}
			else{
				/*60 < age*/
				if(gender.equals("F")){
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 59 < AGE AND GENDER = 'F')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}
				else{
					/*get top5 items*/
					sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
								+" IN (SELECT C_NUM FROM CUSTOMER WHERE 59 < AGE AND GENDER = 'M')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
					rs = stmt.executeQuery(sql);
					System.out.println(sql);
					for(int j = 0; rs.next(); j++){
						inum.add(rs.getInt(1));
					}
				}			
			}
		}	
		else if(gender != null)
		{
			if(gender.equals("F")){
				/*get top5 items*/
				sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
							+" IN (SELECT C_NUM FROM CUSTOMER WHERE GENDER = 'F')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				for(int j = 0; rs.next(); j++){
					inum.add(rs.getInt(1));
				}
			}
			else{
				/*get top5 items*/
				sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month AND CUS_NUM" 
							+" IN (SELECT C_NUM FROM CUSTOMER WHERE GENDER = 'M')) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
				rs = stmt.executeQuery(sql);
				System.out.println(sql);
				for(int j = 0; rs.next(); j++){
					inum.add(rs.getInt(1));
				}
			}
		}
	}
	
	if(inum.size() == 0){
		sql = "SELECT I_NUM, COUNT(I_NUM) FROM ORD_ITEML WHERE O_NUM IN (SELECT O_NUM FROM ORDERED WHERE ORDER_DATE > CURRENT_TIMESTAMP - INTERVAL 6 month) GROUP BY I_NUM ORDER BY COUNT(I_NUM) DESC LIMIT 5";
		rs = stmt.executeQuery(sql);
		System.out.println(sql);
		for(int j = 0; rs.next(); j++){
			inum.add(rs.getInt(1));
		}
	}
	
	%>
	<table class="w3-table-all w3-margin-top" id="myTable">
	<caption>Recommend Items</caption>
 <tr>
 	   <th style="width:10%;">NUM</th>
       <th style="width:45%;">NAME</th>
       <th style="width:45%;">PRICE</th> 
	
	<% 
	
	for(int i = 1; i <= inum.size(); i++) {
		sql = "SELECT NAME, PRICE FROM ITEM WHERE I_NUM =" + inum.get((i-1));
		rs = stmt.executeQuery(sql);
		System.out.println(sql);
		if(rs.next())%>
		<tr><td><%=i %></td>
		<td><a href = "itemdetail.jsp?item=<%=rs.getString(1)%>"><%=rs.getString(1)%></a></td>
		<td><%=rs.getInt(2)%> (won) </td></tr>
<% 	
}
	
%>
	</tr>
	</table>
</body>
</html>