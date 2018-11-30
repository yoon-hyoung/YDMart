<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer" %>
<!DOCTYPE html>
<html>
    <title>YD MART</title>
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
 								 %>
                                
                                <!-- Sidebar/menu -->
                                <nav class="w3-sidebar w3-bar-block w3-white w3-collapse w3-top" style="z-index:3;width:250px" id="mySidebar">
                                    <div class="w3-container w3-display-container w3-padding-16">
                                        <i onclick="w3_close()" class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>
                                        <h3 class="w3-wide"><b>YD MART</b></h3>
                                    </div>
                                    <div class="w3-padding-64 w3-large w3-text-grey" style="font-weight:bold">
                                        <a onclick="myAccFunc1()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn1">
                                            과일/견과 <i class="fa fa-caret-down"></i>
                                        </a>
                                        <div id="demoAcc1" class="w3-bar-block w3-hide w3-padding-large w3-medium">
                                            <a href="#" class="w3-bar-item w3-button w3-light-grey"><i class="fa fa-caret-right w3-margin-right"></i>감/곶감</a>
                                            <a href="#" class="w3-bar-item w3-button">감귤/한라봉</a>
                                            <a href="#" class="w3-bar-item w3-button">사과/배</a>
                                        </div>
                                        
                                        <a onclick="myAccFunc2()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn2">
                                            채소 <i class="fa fa-caret-down"></i>
                                        </a>
                                        <div id="demoAcc2" class="w3-bar-block w3-hide w3-padding-large w3-medium">
                                            <a href="#" class="w3-bar-item w3-button w3-light-grey"><i class="fa fa-caret-right w3-margin-right"></i>고구마/호박/감자</a>
                                            <a href="#" class="w3-bar-item w3-button">두부/콩나물</a>
                                            <a href="#" class="w3-bar-item w3-button">샐러드/새싹/무순/어린잎/드레싱</a>
                                        </div>
                                        
                                        <a onclick="myAccFunc3()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn3">
                                            수산물/해산물/건어물 <i class="fa fa-caret-down"></i>
                                        </a>
                                        <div id="demoAcc3" class="w3-bar-block w3-hide w3-padding-large w3-medium">
                                            <a href="#" class="w3-bar-item w3-button w3-light-grey"><i class="fa fa-caret-right w3-margin-right"></i>김</a>
                                            <a href="#" class="w3-bar-item w3-button">멸치/ 천연조미료</a>
                                            <a href="#" class="w3-bar-item w3-button">생선회</a>
                                        </div>
                                    </div>
                                    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding" onclick="document.getElementById('private').style.display='block'">회원정보 수정</a>
                                    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-padding" onclick="document.getElementById('password').style.display='block'">비밀번호 수정</a>
                                </nav>
                                
                                <!-- Top menu on small screens -->
                                <header class="w3-bar w3-top w3-hide-large w3-black w3-xlarge">
                                    <div class="w3-bar-item w3-padding-24 w3-wide">YD MART</div>
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
                                        <p class="w3-left">물품</p>
                                        <p class="w3-right">
                                        <i class="fa fa-shopping-cart w3-margin-right"></i>
                                        <i class="fa fa-search"></i>
                                        </p>
                                    </header>
                                    
                                    <!-- Search section -->
                                    <div class="w3-container w3-black w3-padding-32">
                                        <h1>찾는 상품이 있습니까?</h1>
                                        <p><input class="w3-input w3-border w3-padding" type="text" placeholder="Search for names.." id="myInput" onkeyup="myFunction()"></p>
                                            <button type="button" class="w3-button w3-red w3-margin-bottom">검색하기</button>
                                            </div>
                                    <table class="w3-table-all w3-margin-top" id="myTable">
                                        <tr>
                                            <th style="width:60%;">Name</th>
                                            <th style="width:40%;">Price</th>
                                        </tr>
                                        <tr>
                                            <td>Alfreds Futterkiste</td>
                                            <td>10</td>
                                        </tr>
                                        <tr>
                                            <td>Berglunds snabbkop</td>
                                            <td>20</td>
                                        </tr>
                                        <tr>
                                            <td>Island Trading</td>
                                            <td>30</td>
                                        </tr>
                                        <tr>
                                            <td>...</td>
                                            <td>...</td>
                                        </tr>
                                    </table>
                                    
                                    <div class="w3-container w3-text-grey" id="jeans">
                                        <p>저희 가게의 상품입니다.</p>
                                    </div>
                                    
                                    <!-- Product grid -->
                                    <div class="w3-row w3-grayscale">
                                        <div class="w3-col l3 s6">
                                            <div class="w3-container">
                                                <div class="w3-display-container">
                                                    <img src="/w3images/jeans2.jpg" style="width:100%">
                                                        <div class="w3-display-middle w3-display-hover">
                                                            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
                                                        </div>
                                                        </div>
                                                <p>Mega Ripped Jeans<br><b>$19.99</b></p>
                                            </div>
                                            <div class="w3-container">
                                                <div class="w3-display-container">
                                                    <img src="/w3images/jeans2.jpg" style="width:100%">
                                                        <div class="w3-display-middle w3-display-hover">
                                                            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
                                                        </div>
                                                        </div>
                                                <p>Mega Ripped Jeans<br><b>$19.99</b></p>
                                            </div>
                                        </div>
                                        
                                        <div class="w3-col l3 s6">
                                            <div class="w3-container">
                                                <div class="w3-display-container">
                                                    <img src="/w3images/jeans2.jpg" style="width:100%">
                                                        <div class="w3-display-middle w3-display-hover">
                                                            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
                                                        </div>
                                                        </div>
                                                <p>Mega Ripped Jeans<br><b>$19.99</b></p>
                                            </div>
                                            <div class="w3-container">
                                                <div class="w3-display-container">
                                                    <img src="/w3images/jeans4.jpg" style="width:100%">
                                                        <div class="w3-display-middle w3-display-hover">
                                                            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
                                                        </div>
                                                        </div>
                                                <p>Vintage Skinny Jeans<br><b class="w3-text-red">$14.99</b></p>
                                            </div>
                                        </div>
                                        
                                        <div class="w3-col l3 s6">
                                            <div class="w3-container">
                                                <div class="w3-display-container">
                                                    <img src="/w3images/jeans4.jpg" style="width:100%">
                                                        <div class="w3-display-middle w3-display-hover">
                                                            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
                                                        </div>
                                                        </div>
                                                <p>Vintage Skinny Jeans<br><b class="w3-text-red">$14.99</b></p>
                                            </div>
                                            <div class="w3-container">
                                                <div class="w3-display-container">
                                                    <img src="/w3images/jeans4.jpg" style="width:100%">
                                                        <div class="w3-display-middle w3-display-hover">
                                                            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
                                                        </div>
                                                        </div>
                                                <p>Vintage Skinny Jeans<br><b class="w3-text-red">$14.99</b></p>
                                            </div>
                                        </div>
                                        
                                        <div class="w3-col l3 s6">
                                            <div class="w3-container">
                                                <div class="w3-display-container">
                                                    <img src="/w3images/jeans2.jpg" style="width:100%">
                                                        <div class="w3-display-middle w3-display-hover">
                                                            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
                                                        </div>
                                                        </div>
                                                <p>Mega Ripped Jeans<br><b>$19.99</b></p>
                                            </div>
                                            <div class="w3-container">
                                                <div class="w3-display-container">
                                                    <img src="/w3images/jeans2.jpg" style="width:100%">
                                                        <div class="w3-display-middle w3-display-hover">
                                                            <button class="w3-button w3-black">Buy now <i class="fa fa-shopping-cart"></i></button>
                                                        </div>
                                                        </div>
                                                <p>Mega Ripped Jeans<br><b>$19.99</b></p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    
                                    
                                    
                                    <!-- End page content -->
                                </div>
                                
                                <!-- 회원정보 수정 -->
                                <div id="private" class="w3-modal">
                                    <div class="w3-modal-content w3-animate-zoom" style="padding:32px">
                                        <div class="w3-container w3-white w3-center">
                                            <i onclick="document.getElementById('newsletter').style.display='none'" class="fa fa-remove w3-right w3-button w3-transparent w3-xxlarge"></i>
                                            <h2 class="w3-wide">회원정보 수정</h2>
                                            <p>비밀번호를 입력하세요.</p>
                                            <p><input class="w3-input w3-border" type="text" placeholder="Enter password"></p>
                                                <button type="button" class="w3-button w3-padding-large w3-red w3-margin-bottom" onclick="document.getElementById('private').style.display='none'">제출</button>
                                                </div>
                                    </div>
                                </div>
                                
                                
                                <!-- 비밀번호 수정 -->
                                <div id="password" class="w3-modal">
                                    <div class="w3-modal-content w3-animate-zoom" style="padding:32px">
                                        <div class="w3-container w3-white w3-center">
                                            <i onclick="document.getElementById('newsletter').style.display='none'" class="fa fa-remove w3-right w3-button w3-transparent w3-xxlarge"></i>
                                            <h2 class="w3-wide">비밀번호 수정</h2>
                                            <p>새로운 비밀번호를 입력하세요.</p>
                                            <p><input class="w3-input w3-border" type="text" placeholder="Enter password"></p>
                                                <button type="button" class="w3-button w3-padding-large w3-red w3-margin-bottom" onclick="document.getElementById('password').style.display='none'">제출</button>
                                                </div>
                                    </div>
                                </div>
                                
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
                                
                                // Click on the "과일" link on page load to open the accordion for demo purposes
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
                                
                                // Click on the "채소" link on page load to open the accordion for demo purposes
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
                                
                                // Click on the "수산물" link on page load to open the accordion for demo purposes
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