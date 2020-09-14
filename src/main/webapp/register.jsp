<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New User</title>
<%@include file="components/common_css_js.jsp"%>
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
		<div class="row mt-4" >
			<div class="col-md-4 offset-md-4">
			
				<div class="card">
					<div class="card-header custom-bg text-center text-white">
					<img style="width: 80px" class="container-fluid rounded-circle" src="images/add-user.png" alt="Register">
					<h3>Register here</h3>
					</div>
					<%@include file="components/message.jsp" %>
					
					<div class="card-body px-4">
					
					<form action="Register" name="f1" method="post" onsubmit="return validateRegister()">
					
						<div class="form-group">
					    <label for="name">User Name</label>
					    <input type="text" name = "user_name" class="form-control" id="name" placeholder="Enter name here">
						</div>
						<div class="form-group">
					    <label for="email">User Email</label>
					    <input type="email" name = "user_email" class="form-control" id="email" placeholder="Enter email here">
					  	</div>
						<div class="form-group">
					    <label for="password">User Password</label>
					    <input type="password" name = "user_password" class="form-control" id="password" placeholder="Enter password here">
					  	</div>
						<div class="form-group">
					    <label for="phone">User Phone</label>
					    <input type="number" name = "user_phone" class="form-control" id="phone" placeholder="Enter phone number here">
					  	</div>
						<div class="form-group">
					    <label for="address">User Address</label>
					    <textarea class="form-control" name = "user_address" id="address" rows="3" placeholder="Enter address here"></textarea>
					  	</div>
						
						<a href="login.jsp">Already registered? Login here</a>
						
						<div class="container text-center mt-3">
							<button type="submit" class="btn btn-success">Register</button>
							<button type="reset" class="btn btn-warning">Reset</button>
						</div>
						
					</form>
					</div>
				</div>
				
			</div>
		</div>
	</div>

</body>
</html>