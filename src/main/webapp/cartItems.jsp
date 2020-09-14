<%@page import="com.learn.ecommerce.model.Cart"%>
<%@page import="com.learn.ecommerce.model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Cart</title>
	<%@include file="components/common_css_js.jsp" %>
</head>
<body>


	<div class="container mt-5">
	
		<div class="row">
		
		<div class="col-md-2"></div>
			<div class="col-md-8">
			
				<div class="card">
				
					<div class="card-title text-center mt-3">
						<h3>Your Shopping Cart</h3>
					</div>
					
					<div class="card-body">
					
						<!-- 	display cart items from session -->
						<%
							int totalPrice=0;
							int finalPrice=0;
							ArrayList<Cart> cartListItems = new ArrayList<Cart>();
							cartListItems = (ArrayList<Cart>) session.getAttribute("cartItems");
							if (cartListItems!=null && cartListItems.size()!=0) 
							{
						%>
						
							<table class="table table-responsive">
								<thead class="thead-light">
										<tr>
											<th>Item Name</th>
											<th>Price</th>
											<th>Quantity</th>
											<th>Total Price</th>
											<th>Action</th>
										</tr>
								</thead>
							<tr>
							
						<%
							for (int i = 0; i < cartListItems.size(); i++) 
							{
								Cart cart = cartListItems.get(i);
								totalPrice = (cart.getItemPriceAfterDiscount()*(cart.getItemQuantity()));
								cart.setTotalPrice(totalPrice);
								finalPrice += (cart.getItemPriceAfterDiscount()*(cart.getItemQuantity()));
								
						%>
						
							<td><%=cart.getItemName() %></td>
							<td><%=cart.getItemPriceAfterDiscount() %></td>
							<td><%=cart.getItemQuantity() %></td>
							<td><%=cart.getTotalPrice() %></td>
							
							<td>
							<form action="Cart" method="post">
								<input type="hidden" name="cartServlet" value="removeFromCart">
								<button class="btn btn-danger btn-sm" name="removeFromCartBtn" value="<%=cart.getItemId() %>">Remove</button>
							</form>
							
							</td>
						</tr>
					
					<%
							}
						
							
					%>
						<tr><th colspan='5' class="text-right">Final Price:- &#8377; <%=finalPrice %></th></tr>
						</table>
					<%
						} 
							
					else 
					{
					%>
						<h4 class="mt-5" align="center" style="color:red;">Cart is Empty!!!</h4>
	
					<%
						}
					%>
					
					</div>
										
						<%
			
						if(cartListItems!=null && cartListItems.size()!=0)
						{
						%>
							<div class="card-footer text-right">
							<button type="button" class="btn btn-primary" id="checkout-btn"
								onclick="window.location.href='checkout.jsp'">Proceed to Checkout</button>
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