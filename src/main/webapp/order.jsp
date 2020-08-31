<%@page import="com.learn.ecommerce.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Order Success</title>
	<%
		response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	
		User user = (User) session.getAttribute("currentUser");
		if (user == null) {
			session.setAttribute("message", "Please Login first!!");
			response.sendRedirect("login.jsp");
			return;
		}
	%>
	
<%@include file="components/common_css_js.jsp"%>
</head>

<body>

	<div class="container">
	
		<div class="row">
		
			<div class="col-md-2"></div>
			
			<div class="col-md-8">
			
				<div class="card mt-3">
				
					<div class="card-title text-center text-primary mt-3">
						<h5>Order Successful</h5>
					</div>
				
					<div class="card-body">
					
						<!-- Show Order details -->
						<%
							
							int orderId = (int) session.getAttribute("orderId");
						%>
						
						<b>Your order id is: <%=orderId %></b>
						<br><br>
						<p class="text-center">Thank you for shopping!</p>
						
						<%
							// making cart empty
							session.removeAttribute("cartItems");
						%>
					</div>
					
				</div>
			
			</div>
		
		</div>
	
	</div>

</body>
</html>