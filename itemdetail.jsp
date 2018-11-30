<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer" %>

<!DOCTYPE html>
<html>
<title>상품페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

<% 
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
		
	//받아오는 값으로 수정 **int item = (int)request.getAttribute("I_NUM");
	//item = request.getParameter(ITEM);
	String item = "1"; 
	 
	/*get ID*/
	String Id = null;
	Id = (String)session.getAttribute("ID");
	//request.setAttribute("I_NUM", item);

	if (Id == null || Id.equals("")){
		Id = "1";
	}
	
	Statement stmt = con.createStatement();
	String sql = "select * from ITEM where I_NUM =" + item;
	stmt.executeQuery(sql);

	ResultSet rs = null;
	rs = stmt.executeQuery(sql);

	int cate = 1, subcate = 1;
	String name = null, price = null, importer = null, exp_date = null, madein = null, total = null;
		//item info from db 
		while(rs.next()) {
			cate = rs.getInt("CATEGORY");
			//out.print(cate);
			subcate = rs.getInt("SUB_CAT");
			//out.print(subcate);
			name = rs.getString(4);
			//out.print(name);
			price = rs.getString(5);
			//out.print(price);
			importer = rs.getString(6);
			//out.print(importer);
			exp_date = rs.getString(7);
			//out.print(exp_date);
			madein = rs.getString(8);
			total = rs.getString(9);
		}
	
		//cate info
		String sql2 = "select NAME from CATEGORY WHERE CATE_NUM = " + cate;
		stmt.executeQuery(sql2);
		rs.close();
		
		rs = null;

		rs = stmt.executeQuery(sql2);
		String catname = null;
		while(rs.next()) {
			catname = rs.getString(1);
		}

		//subcate info
		String sql3 = "select NAME from SUBCATEGORY WHERE CAT_NUM = " 
							+ cate +" AND MY_NUM = " + subcate;
		rs.close();
		
		rs = null;
		rs = stmt.executeQuery(sql3);
		
		String subcatname = null;
		while(rs.next()) {
			subcatname = rs.getString(1);
		}
%>
<form action = "inputCart.jsp" method = "post">


<div class="w3-container w3-teal w3-margin-bottom">
<h1><% out.print(name); %></h1>
</div>

<div class="w3-row-padding ">

<div class="">
   <h2>상품</h2>
  <table class="w3-table w3-striped w3-bordered w3-border">
  <thead class="w3-teal"><th style="width:%"><% out.print("category : " + catname + " / " + subcatname ); %></th></thead>
  <tr><td style="width:30%">
  NAME</td><td><% out.print(name); %></td></tr>
  <tr><td>PRICE</td><td><% out.print(price); %></td></tr>
  <tr><td>IMPORTER</td><td><% if(importer.equals("null")) out.print("no importer");
  else out.print(importer); %></td></tr>
  <tr><td>EXP_DATE</td><td><% out.print(exp_date); %></td></tr>
  <tr><td>MADE_IN</td><td><% out.print(madein); %></td></tr>
  </table>
  </div>
  
<!뒤로가기>
<a href="main.jsp"><span class="w3-left w3-xxlarge">« Go Back</span></a>

<!상품장바구니에 넣기>
<input type=hidden name="Item" value="<%=item%>"></input>
<a href="inputCart.jsp"><span><input type = submit class="w3-right w3-xxlarge" value = "Input it in my Cart √"> </span></a>
</form>

</div>
</body>
</html>
