<%@page import="java.util.ArrayList"%>
<%@page import="com.learn.ecommerce.helper.DescriptionHelper"%>
<%@page import="com.learn.ecommerce.model.Product"%>
<%@page import="com.learn.ecommerce.dao.ProductDao"%>
<%@page import="com.learn.ecommerce.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.ecommerce.dao.CategoryDao"%>
<%@page import="com.learn.ecommerce.helper.FactoryProvider"%>
<html>
<head>

<title>Ecommerce - Home</title>
<%@include file="components/common_css_js.jsp"%>

</head>
<body>

	<div class="row m-3">

		<!-- getting list of categories and products -->
		<%
			String catName = request.getParameter("category");

			ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
			List<Product> prodList = null;
	
			if (catName == null || catName.trim().equals("all")) {
				prodList = productDao.listAllProducts();
			} else {
				//int cId = Integer.parseInt(catId.trim());
				prodList = productDao.getProductByCatName(catName);
			}
	
			CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
			List<Category> catList = categoryDao.listCategories();
		%>

		<!-- Column for categories -->
		<div class="col-md-2">

			<div class="list-group" id="list-tab" role="tablist">
				<a href="index.jsp?category=all"
					class="list-group-item list-group-item-action active">All
					Products</a>

				<!-- iterating over the product categories -->
				<%
					for (Category c : catList) {
				%>
				<a id="highlight" class="list-group-item list-group-item-action"
					href="index.jsp?category=<%=c.getCategoryTitle()%>"><%=c.getCategoryTitle()%></a>
				<%
					}
				%>

			</div>

		</div>

		<!-- Column for showing products -->
		<div class="col-md-10">
		
			<div class="row">
			
				<!-- Iterating over products -->
						<%
							if (prodList.size() != 0) {
							for (Product p : prodList) {
						%>
						
						<div class="col-md-4">
						
							<div class="card mt-2">

								<div class="text-center ">
									<img src="images/products/<%=p.getpPhoto()%>"
										alt="image of product" class="product-photo">
								</div>

								<div class="card-body">
											<h6 class="card-title"><%=p.getpName()%></h6>
											<p class="card-text"><%=DescriptionHelper.longDescToShort(p.getpDesc())%></p>
								</div>
								
								<div class="card-footer text-center">

									<!-- Add to Cart Button -->
									<!-- Cart details first saved to localStorage & then to session  -->
									
	
									<form action="Cart" name="cart" method="post">
										<input type="hidden" name="cartServlet" value="addToCart">
										<%
											ArrayList cartItems = new ArrayList();
											cartItems.add(p);
										%>			
															
										<button class="btn btn-primary" name="addToCartBtn" onclick="addToCartMsg()"
											value="<%=p.getpId()%>">Add to Cart</button>
	
										<!-- Showing Product Price  -->
										<span class="btn btn-success"> &#8377;
											<%=p.getProductPriceAfterDiscount()%>
											<span class="text-secondary product-price">&#8377; <%=p.getpPrice()%></span>
											<span class="font-italic product-disc"><%=p.getpDiscount()%>% off</span>
										</span>
										
									</form>
									

							</div>
								
							</div>
						
						</div>
						
						<%
								}
							}
							else
							{
							
							%>
								<h4>There are no products in this category!</h4>
							
							<%
							}
						%>
			
			</div>
			
		</div>

	</div>
	

</body>
</html>
