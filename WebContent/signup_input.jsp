<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>SYD sign-up</title>
<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<body>

<form action="signup.jsp" class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin" method = "post">
<h2 class="w3-center">Sign Up</h2>
 
<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Id" type="text" placeholder="Id">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Password" type="password" placeholder="Password">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope-o"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Zipcode" type="text" placeholder="Zipcode">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Name" type="text" placeholder="Name">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-phone"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Phone" type="text" placeholder="Phone">
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
       <option value="Choongchugn">Choongchugn</option>
       <option value="Daegu">Daegu</option>
       <option value="Ulsan">Ulsan</option>
       <option value="Gyeongsang">Gyeongsang</option>
       <option value="Busan">Busan</option>
       <option value="Jeolla">Jeolla</option>
       <option value="Sejong">Sejong</option>
       <option value="Daejun">Daejun</option>
       <option value="Gwangju">Gwangju</option>
       <option value="Jeju">Jeju</option>       
</select>   
</div>
</div>



<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope-o"></i></div>
    <div class="w3-rest">
<select name = "Gender">
       <option value="F">F</option>
       <option value="M">M</option>
</select>   
</div>
</div>


<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-pencil"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Age" type="text" placeholder="Age">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-pencil"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="Job" type="text" placeholder="Job">
    </div>
</div>

<p class="w3-center">
<button class="w3-button w3-section w3-blue w3-ripple"> Send </button>
</p>
</form>

</body>
</html> 