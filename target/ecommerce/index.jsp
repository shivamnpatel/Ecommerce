<%@page import="java.util.ArrayList"%>
<%@page import="com.learn.ecommerce.helper.DescriptionHelper"%>
<%@page import="com.learn.ecommerce.model.Product"%>
<%@page import="com.learn.ecommerce.dao.ProductDao"%>
<%@page import="com.learn.ecommerce.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.ecommerce.dao.CategoryDao"%>
<%@page import="com.learn.ecommerce.helper.FactoryProvider"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
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
			request.setAttribute("prodList", prodList);
			
			CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
			ArrayList<Category> catList =(ArrayList<Category>) categoryDao.listCategories();
			
			request.setAttribute("catList", catList);
		%>

		<!-- Column for categories -->
		<div class="col-md-2">

			<div class="list-group" id="list-tab" role="tablist">
				<a href="index.jsp?category=all"
					class="list-group-item list-group-item-action active">All
					Products</a>

	
				<!-- iterating over the product categories -->
				<c:forEach items="${catList}" var="category">
				
					<a id="highlight" class="list-group-item list-group-item-action"
						href="index.jsp?category=${category.getCategoryTitle()}">
						${category.getCategoryTitle() }</a>

				</c:forEach>
			</div>

		</div>

		<!-- Column for showing products -->
		<div class="col-md-10">
		
			<div class="row">
			
				<!-- Iterating over products -->
						<c:if test="${prodList.size()!=0}">
							
							<c:forEach var="product" items="${prodList}">
							
								<div class="col-md-4">
		
									<div class="card mt-2">
		
										<div class="text-center">
											<img src="ProductImage?pId=${product.getpId()}"
												alt="image of product" class="product-photo">
										</div>
		
										<div class="card-body">
											<h6 class="card-title">${product.getpName()}</h6>
											<p class="card-text">
												<jsp:useBean id="desc" class="com.learn.ecommerce.helper.DescriptionHelper"/>
													${desc.longDescToShort(pageContext.getAttribute("product").getpDesc())}
											</p>
										</div>
		
										<div class="card-footer text-center">
		
											<!-- Add to Cart Button -->
		
											<form action="Cart" name="cart" method="post">
												<input type="hidden" name="cartServlet" value="addToCart">
												<%
													ArrayList cartItems = new ArrayList();
													cartItems.add(pageContext.getAttribute("product"));
												%>
		
												<button class="btn btn-primary" name="addToCartBtn"
													onclick="addToCartMsg()" value="${product.getpId()}">Add
													to Cart</button>
		
												<!-- Showing Product Price  -->
												<span class="btn btn-success"> &#8377; ${product.getProductPriceAfterDiscount()}
													<span class="text-secondary product-price">&#8377; ${product.getpPrice()}</span>
													<span class="font-italic product-disc">${product.getpDiscount()}%
														off</span>
												</span>
		
											</form>
		
		
										</div>
		
									</div>
		
								</div>

							</c:forEach>
							
						</c:if>
			</div>
			
		</div>

	</div>
	

</body>
</html>
