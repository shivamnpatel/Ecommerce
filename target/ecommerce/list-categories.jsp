<%@page import="com.learn.ecommerce.helper.FactoryProvider"%>
<%@page import="com.learn.ecommerce.dao.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Categories</title>
<%@include file="components/common_css_js.jsp" %>
<%
	//To prevent going back after Logout
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	
	if (session.getAttribute("currentUser") == null) {
		session.setAttribute("message", "Your are not logged in! Login first");
		response.sendRedirect("login.jsp");
		return;
	}
%>
</head>
<body>
	<%
		CategoryDao cDao = new CategoryDao(FactoryProvider.getSessionFactory());
		ArrayList<Category> catList =(ArrayList<Category>)cDao.listCategories();
	%>
	<div class="container">
	
		<div class="row">
		
			<div class="col-md-3"></div>
			
			<div class="col-md-7">
			
				<div class="card m-3">
				
					<div class="card-header text-center">
							<h4>List of all Categories</h4>
					</div>
					
					<!-- Showing categories -->
					<div class="card-body">
					
						<table class="table table-responsive" style="margin:0px auto;float: none; width: 80%">
									<thead class="thead-light text-center">
										<tr>
											<th>Category Name</th>
											<th>Action</th>
										</tr>
									</thead>
							<tr>
						
							<%
								if(catList!=null && catList.size()!=0)
								{
									for(Category category:catList)
									{	
							%>
						

								<td>
									<input type="text" name="category" value="<%=category.getCategoryTitle()%>" style="width:100%; height:100%;">
								</td>
								<td>
									<form action="Category" name="f1" method="post" onsubmit="return removeItem()">
									<input type="hidden" name="categoryServlet" value="removeCategory">
										<button class="btn btn-danger btn-sm" name="removeCategoryBtn"
											value="<%=category.getCategoryId() %>">Remove</button>
									</form>	
								</td>
								
							
							</tr>
						
							<%
									}
								}
							%>
							
						
						</table>
											
					</div>
					
				</div>
			
			</div>
			
		</div>
		
	</div>

</body>
</html>