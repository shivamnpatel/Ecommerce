<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<%@include file="components/common_css_js.jsp" %>
<script type="text/javascript" src="js/validations.js"></script>
</head>
<body>

	<%
		//To prevent going back after Logout
		response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	
		// check if already logged in
		if (session.getAttribute("currentUser") != null) {
			response.sendRedirect(request.getContextPath());
			return;
		}
	%>

	<div class="container-fluid">
		<div class="row mt-4">
			<div class="col-md-4 offset-md-4">
				
				<div class="card">
				
					<div class="card-header custom-bg text-center text-white">
						<img style="width: 80px" class="container-fluid rounded-circle" src="images/user.png" alt="Login">
						<h3>Login here</h3>
					</div>
					
					<%@include file="components/message.jsp"%>	
						
					<div class="card-body px-4">
					
						<form name="loginForm" action="Login" method="post" onsubmit="return validateLogin()">
						
							  <div class="form-group">
							    <label for="email">Email address</label>
							    <input type="email" name="user_email" class="form-control" id="email" placeholder="Enter email">
							  </div>
							  
							  <div class="form-group">
							    <label for="password">Password</label>
							    <input type="password" name="user_password" class="form-control" id="password" placeholder="Password">
							  </div>
							  
							  <a href="register.jsp">New User? Register here</a>
							  <a class="text-muted mx-4" href="#">Forgot Password?</a> 
							  <div class="container text-center mt-3">
							  	<button type="submit" class="btn btn-success">Login</button>
							  	
							  </div>
						  
						</form>
				</div>
				
				</div>
				
				
				
			</div>
		</div>
	</div>	
</body>
</html>