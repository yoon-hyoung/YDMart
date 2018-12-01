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
//request.setAttribute("I_NUM", item);

if (Id == null || Id.equals("")){
	Id = "1";
}
	
int c_num = 0;

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

		//get ITEM NUMBER
	String item = (String)request.getParameter("Item");
	
		if(item == null || item == "")
			item = "1";
		//GET C_NUM from CUSTOMER TABLE
	Statement stmt = con.createStatement();
	String sql1 = "select C_NUM FROM CUSTOMER WHERE ID = '" + Id +"'";
	stmt.executeQuery(sql1);
	ResultSet rs = null;
	rs = stmt.executeQuery(sql1);

	if(rs.next()) {
		c_num = rs.getInt(1);
	}
	
	/*get SH_ITEML count*/
	rs = null;
	
	String sql2 = "SELECT COUNT(SH_NUM) FROM SH_ITEML WHERE SH_NUM = " + c_num;

	rs = stmt.executeQuery(sql2);
	int num = 1;
	if(rs.next()) {
		num = rs.getInt(1);
	}
	
	/*get I_NUM*/
	sql2 = "select I_NUM from ITEM WHERE NAME = '" + item + "'";
	rs = stmt.executeQuery(sql2);
	int inum = 0;
	if(rs.next()) {
		inum = rs.getInt(1);
	}
	
	
		/*insert item*/
	sql2 = null;
	sql2 = "Insert Into SH_ITEML VALUES(" + c_num +","+ inum +","+ (++num) +");";	

	//out.println(sql2);
	stmt = con.prepareStatement(sql2);
	stmt.executeUpdate(sql2);
	
	/*SHOPPINGBAG TOTAL ITEM UPDATE*/
	sql2 = "Update SHOPPINGBAG SET TOTAL_INUM = TOTAL_INUM+1 WHERE C_NUM = " + c_num + ";"; 
	stmt = con.prepareStatement(sql2);
	stmt.executeUpdate(sql2);
	
	out.println("<script>alert('Item input success !'); location.href='cart.jsp'</script>");

	rs.close();
	stmt.close();
	con.close();
	
%>

</body>
</html>
