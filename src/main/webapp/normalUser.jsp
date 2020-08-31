<%@page import="com.learn.ecommerce.model.User"%>
<%
	// To prevent going back after Logout
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");

User user = (User) session.getAttribute("currentUser");
if (user == null) {
	session.setAttribute("message", "Your are not logged in! Login first");
	response.sendRedirect("login.jsp");
	return;
} else if (user.getUserType().equals("admin")) {
	session.setAttribute("message", "Your are not a normal user!!");
	response.sendRedirect("login.jsp");

	return;
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>

	<!-- getting current logged in user details -->
	<%
		User userDetails = (User)session.getAttribute("currentUser");
	%>

		<div class="row mt-5">

				<div class="card mx-auto">
	
						<div class="card-header text-center">
							<h4>Profile</h4>
						</div>	
						
						<div class="card-body">
						
							<table class="table m-2">
						
							<tr>
								<th>Name</th>
								<td><%=userDetails.getUserName() %></td>
							</tr>
							<tr>
								<th>Email</th>
								<td><%=userDetails.getUserEmail() %></td>
							</tr>
							<tr>
								<th>Mobile Number</th>
								<td><%=userDetails.getUserPhone() %></td>
							</tr>
							<tr>
								<th>Address</th>
								<td><%=userDetails.getUserAddress() %></td>
							</tr>
						
						</table>
							
						</div>
						
				</div>

			
		</div>
</body>
</html>