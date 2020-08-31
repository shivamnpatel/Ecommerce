<%@page import="java.util.List"%>
<%@page import="com.learn.ecommerce.helper.FactoryProvider"%>
<%@page import="com.learn.ecommerce.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Orders</title>
</head>
<%@include file="components/common_css_js.jsp"%>
<%
	//To prevent going back after Logout
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	
	if (session.getAttribute("currentUser") == null) {
		session.setAttribute("message", "Your are not logged in! Login first");
		response.sendRedirect("login.jsp");
		return;
	}
%>
<body>

	<%
		User user = (User)session.getAttribute("currentUser");
		OrderDao orderDao = new OrderDao(FactoryProvider.getSessionFactory());
		List<Cart> myOrderList =(List<Cart>)orderDao.getOrderByCustomerEmail(user.getUserEmail());
	%>
	
	<div class="container">
	
		<div class="row">
		
			<div class="col-md-2"></div>
			
			<div class="col-md-8">
			
				<div class="card m-5">
				
					<div class="card-header text-center">
							<h4>Your Orders</h4>
					</div>
					
					<!-- Showing orders -->
					<div class="card-body">
					
							<%
								if(myOrderList!=null && myOrderList.size()!=0)
								{	
							%>
								<table class="table">
									<thead class="thead-light text-center">
										<tr>
											<th>Order Id</th>
											<th>Item Name</th>
											<th>Quantity</th>
										</tr>
									</thead>
										<tr>
							
							<%
									for(Cart cart:myOrderList)
									{
							%>
										<td><%=cart.getOrders().getOrderId()%></td>
										<td><%=cart.getItemName() %></td>
										<td><%=cart.getItemQuantity()%></td>
									</tr>
							<%
									}
							%>
								</table>
							<%
								}
								else
								{	
							%>
								<h5 class="text-center">You have not made any purchase yet</h5>
							<%
								}
							
							%>
					
							
					
					</div>
					
				</div>
			
			</div>
			
		</div>
		
	</div>

</body>
</html>