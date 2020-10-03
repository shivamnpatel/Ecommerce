<%@page import="com.learn.ecommerce.dao.OrderDao"%>
<%@page import="com.learn.ecommerce.dao.ProductDao"%>
<%@page import="com.learn.ecommerce.dao.UserDao"%>
<%@page import="com.learn.ecommerce.model.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.ecommerce.helper.FactoryProvider"%>
<%@page import="com.learn.ecommerce.dao.CategoryDao"%>
<%@page import="com.learn.ecommerce.model.User"%>

<%
	User user = (User) session.getAttribute("currentUser");

	if (user==null || !user.getUserType().equals("admin")) {
	session.setAttribute("message", "You don't have access to this page");
	response.sendRedirect("login.jsp");
	return;
}
	UserDao uDao = new UserDao(FactoryProvider.getSessionFactory());
	ProductDao pDao = new ProductDao(FactoryProvider.getSessionFactory());
	CategoryDao cDao = new CategoryDao(FactoryProvider.getSessionFactory());
	OrderDao orderDao = new OrderDao(FactoryProvider.getSessionFactory());
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
<%@include file="/components/common_css_js.jsp"%>
</head>
<body>

	<div style="width: 800px" class="container admin">

		<%@include file="/components/message.jsp"%>

		<div class="row mt-3">
			<!-- First row -->

			<!-- First column -->
			<div class="col-md-4">

				<div class="card">
					<!-- First card -->

					<div class="card-body text-center"
						onclick='window.location.href="admin?page=users"'>

						<img style="width: 120px" class="container-fluid rounded-circle"
							src="images/users.png" alt="users">

						<h3><%=uDao.listUsers().size()%></h3>
						<h3>Users</h3>

					</div>

				</div>

			</div>

			<!-- Second column -->
			<div class="col-md-4">

				<div class="card">
					<!-- Second card -->

					<div class="card-body text-center"
						onclick='window.location.href="admin?page=categories"'>

						<input type="hidden" name="categoryServlet" value="listCategory">

						<img style="width: 120px" class="container-fluid rounded-circle"
							src="images/category.png" alt="category">
						<h3><%=cDao.listCategories().size()%></h3>
						<h3>Categories</h3>

					</div>

				</div>

			</div>

			<!-- Third column -->
			<div class="col-md-4">

				<div class="card">
					<!-- Third card -->

					<div class="card-body text-center"
						onclick='window.location.href="admin?page=products"'>

						<img style="width: 120px" class="container-fluid rounded-circle"
							src="images/product.png" alt="product">
						<h3><%=pDao.listAllProducts().size()%></h3>
						<h3>Products</h3>

					</div>

				</div>

			</div>

		</div>

		<div class="row mt-3">
			<!-- Second row -->

			<!-- 2nd row First column -->
			<div class="col-md-4">

				<div class="card">
					<!-- First card -->

					<div class="card-body text-center"
						onclick='window.location.href="admin?page=orders"'>

						<img style="width: 120px" class="container-fluid rounded-circle"
							src="images/purchases.png" alt="orders">


						<!-- display order total here -->
						<h3 class="mt-2">
							Orders (<%=orderDao.listAllOrders().size()%>)
						</h3>

					</div>

				</div>

			</div>

			<!-- 2nd row Second column -->
			<div class="col-md-4">

				<div class="card" data-toggle="modal"
					data-target="#add-new-category">
					<!-- First card -->

					<div class="card-body text-center">

						<img style="width: 120px" class="container-fluid rounded-circle"
							src="images/add_category.png" alt="Add Category">
						<!-- <p class="mt-2">Click here to add new Category</p> -->
						<h3 class="mt-2">Add Category</h3>

					</div>

				</div>

			</div>

			<!--2nd row Third column -->
			<div class="col-md-4">

				<div class="card" data-toggle="modal" data-target="#add-new-product">
					<!-- Second card -->

					<div class="card-body text-center">

						<img style="width: 120px" class="container-fluid rounded-circle"
							src="images/add_product.png" alt="Add Product">
						<!-- <p class="mt-2">Click here to add new Product</p> -->
						<h3 class="mt-2">Add Product</h3>

					</div>

				</div>

			</div>

		</div>

	</div>


	<!-- Add category Modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-new-category" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Enter Category
						details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form action="Category" method="post">

						<input type="hidden" name="categoryServlet" value="addCategory">
						<div class="form-group">
							<input type="text" name="catTitle" placeholder="Enter title here"
								class="form-control required" />

						</div>

						<div class="form-group">
							<textarea rows="5" placeholder="Enter description here"
								class="form-control" name="catDesc" required></textarea>
						</div>

						<div class="container text-center">
							<button type="submit" class="btn btn-outline-success">Add
								Category</button>
						</div>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>

				</div>
			</div>
		</div>
	</div>

	<!-- End of Add category Modal -->

	<!-- Add Product Modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-new-product" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Enter Product
						details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form action="Product" method="post" enctype="multipart/form-data">

						<input type="hidden" name="productServlet" value="addProduct">

						<div class="form-group">
							<input type="text" name="pName" placeholder="Enter name here"
								class="form-control" required />

						</div>

						<div class="form-group">
							<textarea rows="5" placeholder="Enter description here"
								class="form-control" name="pDesc" required></textarea>
						</div>

						<div class="form-group">
							<label for="photo">Photo of Product</label><br> <input
								type="file" name="pPhoto" id="photo" class="form-control"
								required />
						</div>

						<div class="form-group">
							<input type="number" name="pPrice" class="form-control"
								placeholder="Enter price here" required />
						</div>

						<div class="form-group">
							<input type="number" name="pDiscount" class="form-control"
								placeholder="Enter discount here" required />
						</div>

						<div class="form-group">
							<input type="number" name="pQuantity" class="form-control"
								placeholder="Enter quantity here" required />
						</div>

						<div class="form-group">
							<label for="photo">Select Category of Product</label><br> <select
								name="catId" class="form-control" required>

								<!-- getting list of categories from database -->
								<%
									CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
								List<Category> list = categoryDao.listCategories();
								for (Category c : list) {
								%>
								<option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>

								<%
									}
								%>

							</select>
						</div>


						<div class="container text-center">
							<button type="submit" class="btn btn-outline-success">Add
								Product</button>
						</div>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- End of Add Product Modal -->


</body>
</html>