<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.*" %>

<!DOCTYPE html>
<html>

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
	
	String item = request.getParameter("item");
	//String item = request.getParameter("item");
	
	//String item = "1"; 
	 
	/*get ID*/
	String Id = null;
	Id = (String)session.getAttribute("ID");
	
	if (Id == null || Id.equals("")){
		Id = "1";
	}
	
	Statement st = con.createStatement();
	
	Statement stmt = con.createStatement();
	/*get item iformation*/
	String sql = "select * from ITEM where NAME = '" + item +"'";
		
	stmt.executeQuery(sql);

	ResultSet rs = null;
	rs = stmt.executeQuery(sql);

	int cate = 1, subcate = 1;
	int inum = 0;
	String name = null, price = null, importer = null, exp_date = null, madein = null, total = null;
		//item info from db 
		while(rs.next()) {
			inum = rs.getInt("I_NUM");
			cate = rs.getInt("CATEGORY");
			//out.print(cate);
			subcate = rs.getInt("SUB_CAT");
			//out.print(subcate);
			name = rs.getString(4);
			//out.print(name);
			price = rs.getString(5);
			//out.print(price);
			importer = rs.getString(6);
			if(importer == null || importer.equals("null"))
				importer = "not imported";
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
		
		/*get producer information*/
		sql3 = "select * from PRODUCER_LOCATION WHERE I_NUM = " + inum;
	
		
		rs = null;
		rs = stmt.executeQuery(sql3);
		
		String p = null;
		String s = null;
		String na = null;
		
		while(rs.next()) {
			p = rs.getString(2);
			s = rs.getString(3);
			na = rs.getString(4);
		}
		
%>
<title><%=name %></title>
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
  <form action = "inputCart.jsp" method = "post">
                                <!-- Top menu on small screens -->
                                <header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
                                    <div class="w3-bar-item w3-padding-24 w3-wide"><a href = "main.jsp" style="text-decoration:none">SYD MART</a></div>
                                    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
                                </header>



<hr><br/><br/>
<h1><% out.print(name); %></h1>
<font size="1em"><hr><br/></font>
</div>

<div class="w3-row-padding ">


<!-- item information -->
<div class="">
   <h2>Item Information</h2>
  <table class="w3-table w3-striped w3-bordered w3-border">
  <thead class="w3-teal"><th style="width:10%"><% out.print("category : " + catname + " / " + subcatname ); %></th></thead>
  <tr><td style="width:30%">
  NAME</td><td><% out.print(name); %></td></tr>
  <tr><td>PRICE</td><td><% out.print(price + "&nbsp;(won)"); %></td></tr>
  <tr><td>IMPORTER</td><td><% 
 /* if(importer.equals("null") || importer == null || importer.equals("")) 
	  out.println("no importer");
  else 
	  out.println(importer);*/
	out.println(importer);  
%></td></tr>
  <tr><td>EXP_DATE</td><td><% out.print(exp_date); %></td></tr>
  <tr><td>MADE_IN</td><td><% out.print(madein); %></td></tr>
  </table>
  </div>
  
  
  <br/>
  
  <!-- producer information -->
<div class="">
   <h2>Producer Information</h2>
  <table class="w3-table w3-striped w3-bordered w3-border">
  <tr><td style="width:30%">
  NAME</td><td><% out.print(na); %></td></tr>
  <tr><td>STATE</td><td><% out.print(s); %></td></tr>
  <tr><td>PHONE NUM</td><td><% out.println(p);%></td></tr>
  </table>
  </div>
  <br/><br/>
  
<!뒤로가기>
<a href="main.jsp"><span class="w3-left w3-large">« Go Back</span></a>

<!상품장바구니에 넣기>
<input type=hidden name="Item" value="<%=item%>"></input>
<div class = "" align = "right">
<select name = "amount">
       <option value="1">1</option>
       <option value="2">2</option>
       <option value="3">3</option>
       <option value="4">4</option>
       <option value="5">5</option>
       <option value="6">6</option>
       <option value="7">7</option>
</select>

<a href="inputCart.jsp"><span><input type = submit class="w3-right w3-large" value = "Input it in my Cart √"> </span></a>
</form>
</div>
</div>
</body>
</html>
