<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.learn.ecommerce.model.User"%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout</title>
<%@include file="components/common_css_js.jsp"%>

<script type="text/javascript" src="js/validations.js"></script>

</head>
<body>

	<%
		response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
		User user = (User) session.getAttribute("currentUser");
	%>
	<c:if test="${sessionScope.currentUser == null }">
		<c:set var="message" value="Please Login to complete checkout" scope="session"></c:set>
		<c:redirect url="login.jsp"/>
	</c:if>
	
	<c:if test="${sessionScope.cartItems == null }">
		<c:redirect url="index.jsp"/>
	</c:if>


	<div class="container">

		<div class="row mt-5">

			<!-- cart items -->
			<div class="col-md-6">

				<div class="card">

					<div class="card-title mt-3">
						<h3 align="center">Your Shopping List</h3>
					</div>

					<div class="card-body">
					
						<!-- 	display cart items from session -->
						<%
							int totalPrice=0;
							int finalPrice=0;
							ArrayList<Cart> cartListItems = new ArrayList<Cart>();
							cartListItems = (ArrayList<Cart>) session.getAttribute("cartItems");
							if (cartListItems!=null && cartListItems.size()!=0 ) 
							{
						%>
						
							<table class="table table-responsive">
									
										<tr class="thead-light">
											<th>Item Name</th>
											<th>Price</th>
											<th>Quantity</th>
											<th>Total Price</th>
									
										</tr>
									
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
							</tr>
					
					<%
							}
							
					%>
						</table>
							<div class="card-footer text-right" style="color:#673ab7;">
								<b>Final Price:- &#8377; <%=finalPrice %></b>
							
							</div>
													
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

				</div>

			</div>

			<!-- User details for Order -->
			<div class="col-md-6">

				<div class="card">

					<div class="card-title text-center mt-3">
						<h3>Your Details</h3>
					</div>

					<div class="card-body">

						<form name="checkout" method="post" action="Order"
							onsubmit="return validateCheckoutDetails()">

							
							<div class="form-group">
								<label for="name">Your Name</label> 
								<input type="text" name="cust_name" class="form-control" id="name"
									value="<%=user.getUserName()%>" placeholder="Enter name here">
							</div>
							<div class="form-group">
								<label for="email">Your Email address</label>
								<input type="email" name="cust_email" class="form-control" id="email"
									value="<%=user.getUserEmail()%>" placeholder="Enter email here">
							</div>
							<div class="form-group">
								<label for="phone">Your Mobile number</label>
								<input type="text" name="cust_mobile" class="form-control"
									id="phone" value="<%=user.getUserPhone()%>"
									placeholder="Enter phone number here">
							</div>
							<div class="form-group">
								<label for="state">State</label>
								<input type="text" name="cust_state" class="form-control" id="state"
									placeholder="Enter state here">
							</div>
							<div class="form-group">
								<label for="city">City</label>
								<input type="text" name="cust_city" class="form-control" id="city"
									placeholder="Enter city here">
							</div>
							<div class="form-group">
								<label for="pincode">Pincode</label> 
								<input type="number" name="cust_pincode" class="form-control"
									id="pincode" placeholder="Enter pincode here">
							</div>
							<div class="form-group">
								<label for="address">Shipping Address</label>
								<textarea class="form-control" name="cust_address" id="address"
									rows="3" placeholder="Enter address here"><%=user.getUserAddress()%></textarea>
							</div>

							<div class="container text-center mt-5">
								<button type="submit" class="btn btn-outline-success">Order Now</button>
							</div>

						</form>

					</div>

				</div>

			</div>

		</div>

	</div>


</body>
</html>