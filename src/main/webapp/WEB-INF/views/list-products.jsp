<%@page import="com.learn.ecommerce.helper.FactoryProvider"%>
<%@page import="com.learn.ecommerce.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products</title>
<%@include file="/components/common_css_js.jsp" %>

</head>
<body>

	<%
		ProductDao pDao = new ProductDao(FactoryProvider.getSessionFactory());
		ArrayList<Product> prodList =(ArrayList<Product>)pDao.listAllProducts();
	%>
	
	<div class="container">
	
		<div class="row">
		
			<div class="col-md-2"></div>
			
			<div class="col-md-11">
			
				<div class="card m-3">
				
					<div class="card-header text-center">
							<h4>List of all Products</h4>
					</div>
					
					<!-- Showing products -->
					<div class="card-body">
					
					<%
						if (prodList!=null && prodList.size()!=0) 
						{
						%>
						
							<table class="table table-responsive">
									<thead class="thead-light text-center">
										<tr>
											<th>Item Name</th>
											<th>Price</th>
											<th>Quantity</th>
											<th>Discount</th>
											<th>Action</th>
										</tr>
									</thead>
							<tr>
							
						<%
							for (int i = 0; i < prodList.size(); i++) 
							{
								Product product = prodList.get(i);
						%>
						
							<td><%=product.getpName() %></td>
							<td><%=product.getpPrice() %></td>
							<td><%=product.getpQuantity()%></td>
							<td><%=product.getpDiscount()%></td>
							
							<td>
								<form action="Product" name="f1" method="post" onsubmit="return removeItem()">
								<input type="hidden" name="productServlet" value="removeProduct">
									<button class="btn btn-danger btn-sm" name="removeProductBtn" value="<%=product.getpId() %>">Remove</button>
								</form>
							</td>
							
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