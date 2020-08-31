<%@page import="java.util.List"%>
<%@page import="com.learn.ecommerce.helper.FactoryProvider"%>
<%@page import="com.learn.ecommerce.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders</title>
<%@include file="components/common_css_js.jsp"%>
<%
	//To prevent going back after Logout
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	
	if ( session.getAttribute("currentUser") == null) {
		session.setAttribute("message", "Your are not logged in! Login first");
		response.sendRedirect("login.jsp");
		return;
	}
%>
</head>
<body>	

	<%
		OrderDao orderDao = new OrderDao(FactoryProvider.getSessionFactory());
		ArrayList<Order> orderList =(ArrayList<Order>)orderDao.listAllOrders();
	%>
	
	<div class="container">
	
		<div class="row">
		
			<div class="col-md-2"></div>
			
			<div class="col-md-7">
			
				<div class="card m-3">
				
					<div class="card-header text-center">
							<h4>List of all orders</h4>
					</div>
					
					<!-- Showing orders -->
					<div class="card-body">
					
					<%
						if (orderList!=null && orderList.size()!=0) 
						{
						%>
						
							<table class="table">
									<thead class="thead-light">
										<tr>
											<th>Order Id</th>
											<th>Customer Name</th>
											<th>Customer Email</th>
										</tr>
									</thead>
							<tr>
							
						<%
							for (int i = 0; i < orderList.size(); i++) 
							{
								Order order = orderList.get(i);
								
						%>
						
							<td><%=order.getOrderId() %></td>
							<td><%=order.getCustomerName() %></td>
							<td><%=order.getCustomerEmail() %></td>
							
						</tr>
					
						<%
							}
						%>
						
						</table>
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