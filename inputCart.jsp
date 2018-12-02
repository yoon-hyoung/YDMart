<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer" %>
<!DOCTYPE html>
<html>
<title>상품페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

<% 
/*get ID*/
String Id = null;
Id = (String)session.getAttribute("ID");

int c_num = 0;

	Connection con = null;
	String url = "jdbc:mysql://localhost:3306/SYDMart?serverTimezone = UTC";
	
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(url, "root","ekdms1234");
		} catch(Exception e) {
			System.out.println("DB load fail" + e.toString());
		}

		//get ITEM NUMBER, ITEM AMOUNT
	String item = (String)request.getParameter("Item");
	String amt = (String)request.getParameter("amount");
	
	int n = Integer.parseInt(amt);
	if(n == 0) n = 2;
	
		if(item == null || item == "")
			item = "1";
		//GET C_NUM from CUSTOMER TABLE
	Statement stmt = con.createStatement();
	String sql1 = "select C_NUM FROM CUSTOMER WHERE ID = '" + Id +"'";
	System.out.println(sql1);
	stmt.executeQuery(sql1);
	ResultSet rs = null;
	rs = stmt.executeQuery(sql1);

	if(rs.next()) {
		c_num = rs.getInt(1);
	}
	
	/*get SH_ITEML count*/
	rs = null;
	
	String sql2 = "SELECT COUNT(*) FROM SH_ITEML WHERE SH_NUM = " + c_num;
	System.out.println(sql2);

	rs = stmt.executeQuery(sql2);
	int num = 1;
	if(rs.next()) {
		num = rs.getInt(1);
	}
	
	/*get I_NUM*/
	sql2 = "select I_NUM from ITEM WHERE NAME = '" + item + "'";
	System.out.println(sql2);

	rs = stmt.executeQuery(sql2);
	int inum = 0;
	if(rs.next()) {
		inum = rs.getInt(1);
	}
	
	for(int i = 0; i < n; i++) {
	/*insert item*/	
	sql2 = null;
	sql2 = "Insert Into SH_ITEML VALUES(" + c_num +","+ inum +","+ (++num) +");";	
	System.out.println(sql2);

	stmt = con.prepareStatement(sql2);
	stmt.executeUpdate(sql2);
	
	}
		
	stmt = con.createStatement();
	/*SHOPPINGBAG TOTAL ITEM UPDATE*/
	String query = "Update SHOPPINGBAG SET TOTAL_INUM = TOTAL_INUM+ "+ n +" WHERE C_NUM = " + c_num + ";"; 
	stmt = con.prepareStatement(query);
	stmt.executeUpdate(query);
		
	out.println("<script>alert('Item input success !'); location.href='cart.jsp'</script>");

	rs.close();
	stmt.close();
	con.close();
	
	
%>

</body>
</html>
