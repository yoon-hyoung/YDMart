<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer, java.util.ArrayList, java.text.SimpleDateFormat, java.util.Date" %>

<!DOCTYPE html>
<html>
<title>Purchasing</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<form action="purchasing.jsp" class="w3-container w3-card-4" method = "post">
  <!-- Top menu on small screens -->
  <header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
  <div class="w3-bar-item w3-padding-24 w3-wide"><a href = "main.jsp" style="text-decoration:none">SYD MART</a></div>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding-24 w3-right" onclick="w3_open()"><i class="fa fa-bars"></i></a>
  </header>  

<%
	/*connect to DB*/
	Connection con = null;
	String url = "jdbc:mysql://localhost:3306/SYDMart?serverTimezone = UTC";
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(url, "root","ekdms1234");
		} catch(Exception e) {
			System.out.println("DB load fail" + e.toString());
		}
		
		/*Set near city*/
		String near_city[] = new String[15];
		
		/*case 1*/
		near_city[1] = "Seoul";
		near_city[2] = "Incheon";
		near_city[3] = "Gyeongi";
		near_city[4] = "Gwagnwon";
		/*case 2*/
		near_city[5] = "Choongchugn";
		near_city[6] = "Daegu";
		near_city[7] = "Ulsan";
		near_city[8] = "Gyeongsang";
		near_city[9] = "Busan";
		/*case 3*/
		near_city[10] = "Jeolla";
		near_city[11] = "Sejong";
		near_city[12] = "Daejun";
		near_city[13] = "Gwangju";
		/*case 4*/
		near_city[14] = "jeju";

		  /*get ID*/
		  String Id = null; //initializie to 0
		  Id = (String)session.getAttribute("ID");
		  if(Id == null || Id == "" )
			  Id = "gi6";
		  
			/*get i_num information*/
			String [] itemList = null;
			itemList = request.getParameterValues("item");
			/*get item fail*/
			if(itemList == null) System.out.println("err");
			/*get item success*/
			else {
				
			/*get delivery information*/
			String name = request.getParameter("Name");
			String zip = request.getParameter("Zipcode");
			String city = request.getParameter("City");
			String phone = request.getParameter("Phone");
			
			System.out.println(name);
			System.out.println(zip);
			System.out.println(city);
			System.out.println(phone);
			
			/*GET C_NUM from CUSTOMER TABLE*/
			Statement stmt = con.createStatement();
			String sql1 = "select C_NUM FROM CUSTOMER WHERE ID = '" + Id +"'";
			ResultSet rs = null;
			rs = stmt.executeQuery(sql1);

			int c_num = 0;
			if(rs.next()) {
				c_num = rs.getInt(1);
			}
			
			/*total item account count*/
			int total_inum = 0;
			ArrayList<Integer> act = new ArrayList<Integer>(); //for each item account
			/*count each item*/
			for(int i = 0; i < itemList.length; i++) {
				sql1 = "select COUNT(*) from SH_ITEML where SH_NUM = " + c_num + " AND I_NUM =" + itemList[i];
				rs = stmt.executeQuery(sql1);
				while(rs.next()) {
					act.add(rs.getInt(1));
					total_inum += rs.getInt(1);
				}
			}
			
		/*transaction*/	
		try{
			
			/*set autocommit false*/
			con.setAutoCommit(false);
			
			/*SHOPPINGBAG TOTAL ITEM UPDATE*/
			sql1 = "Update SHOPPINGBAG SET TOTAL_INUM = TOTAL_INUM-"+ total_inum +" WHERE C_NUM = " + c_num + ";"; 
			stmt = con.prepareStatement(sql1);
			stmt.executeUpdate(sql1);
			
			/*Delete items from cart*/
			for(int i = 0; i < itemList.length; i++) {
				sql1 = "DELETE FROM SH_ITEML WHERE SH_NUM = " 
						+ c_num +" AND I_NUM = " + itemList[i] + ";";
				stmt = con.prepareStatement(sql1);
				stmt.executeUpdate(sql1);
			}
			
			int cur = Integer.parseInt(city);
			int count = 0;
			int dir = 1;
			int temp = 0;
			boolean check = false;
			if(cur == 13) dir = -1;
			for(int i = 0; i < itemList.length; i++) {
				/*재고 있는 매장 찾기*/
				while(!check){
					sql1 = "SELECT STOCK FROM POSSESS_ITEM WHERE R_NUM = " + cur + " AND ITEM_NUM = " + itemList[i];
					stmt = con.prepareStatement(sql1);
					System.out.println(sql1);
					rs = stmt.executeQuery(sql1);
					while(rs.next())
						temp = rs.getInt(1);
					System.out.println("temp");
					/*retailer has stock*/
					if(temp > act.get(i)) {
							check = true;
							System.out.println("Success1");
					}
					else {
						cur += dir;
						count++;
						/*Do not fall in infinite loop!!*/
						if(count > 28){
							break;
						}
						if(cur > 14){
							dir = -1;
						}
						else if(cur < 1){
							dir = +1;
							cur = 14;
						}
					}
				}
				if(count > 28) {
					cur = Integer.parseInt(city);
					dir = 1;
					int ct = act.get(i);
					count = 0;
					if(cur == 13) dir = -1;
					/*재고 있는 매장 찾기*/
					while(!check){
						sql1 = "SELECT STOCK FROM POSSESS_ITEM WHERE R_NUM = " + cur + " AND ITEM_NUM = " + itemList[i];
						stmt = con.prepareStatement(sql1);
						System.out.println(sql1);
						rs = stmt.executeQuery(sql1);
						while(rs.next())
							temp = rs.getInt(1);
						rs.close();
						/*retailer has stock*/
						System.out.println(temp);
						if(temp > 0) {
							System.out.println("in");
							if(ct > temp)
								ct -= temp;	
							/*************************************************************************/
							else if(temp == ct) {
								temp = ct;
								ct = 0;
							}
							sql1 = "Update POSSESS_ITEM SET STOCK = STOCK-" + temp + " WHERE R_NUM = "+ cur + " AND ITEM_NUM = " + itemList[i] + ";";
							stmt = con.prepareStatement(sql1);
							stmt.executeUpdate(sql1);
							if(ct == 0){
								System.out.println("Success2");
								break;
							}
							System.out.println(ct);
						}
						else {								
							cur += dir;
							count++;
							/*Do not fall in infinite loop!!*/
							if(count > 28){
								/*err*/
								try{con.rollback();}catch(SQLException sql){}
								out.println("<script>alert('Occurred unexpected error !'); location.href='cart.jsp'</script>");
								break;
							}
							if(cur > 14){
								dir = -1;
							}
							else if(cur < 1){
								dir = +1;
								cur = 14;
							}
						}
					}
				}
				else{
				/*decrease retailer stock*/
				sql1 = "Update POSSESS_ITEM SET STOCK = STOCK-" + act.get(i) + " WHERE R_NUM = "+ cur + " AND ITEM_NUM = " + itemList[i] + ";";
				stmt.executeUpdate(sql1);
				}
			
				/*decrease total stock*/
				sql1 = "Update ITEM SET TOTAL_STOCK = TOTAL_STOCK-" + act.get(i) + " WHERE I_NUM = "+ itemList[i] + ";";
				stmt.executeUpdate(sql1);
				
			}
			
			/*data for get today date*/
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			/*add to ordered*/
			sql1 = "INSERT INTO ORDERED(CUS_NUM , RETAILER_NUM , ORDER_DATE , CITY, ZIPCODE) VALUE(" + c_num + "," + cur + ", '" + sdf.format(d) + "' , '"
					+ city + "', " + zip+ ");"; 
			stmt = con.prepareStatement(sql1);
			stmt.executeUpdate(sql1);	
			
			/*get O_NUM for add to ord_list*/
			int onum = 0;
			sql1 = "SELECT MAX(O_NUM) FROM ORDERED";
			rs = stmt.executeQuery(sql1);
			while(rs.next()) {
				onum = rs.getInt(1);
			}

			/*add to ord_list*/
			for(int i = 0; i < itemList.length; i++) {
				sql1 = "INSERT INTO ORD_ITEML VALUE (" + onum + ", " + itemList[i] + ", " + (i+1) + ");";
				stmt = con.prepareStatement(sql1);
				stmt.executeUpdate(sql1);	
			}
			
			/*commit*/
			con.commit();
		}
		catch(SQLException sqle){
			//if exception occurred -> rollback
			if(con != null) try{con.rollback();}catch(SQLException sql){}
		}
			con.setAutoCommit(true);
			out.println("<script>alert('Item purchasing success !'); location.href='cart.jsp'</script>");
	}
%>
</form>

</body>
</html> 