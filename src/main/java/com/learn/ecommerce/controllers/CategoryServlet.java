package com.learn.ecommerce.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.learn.ecommerce.dao.CategoryDao;
import com.learn.ecommerce.helper.FactoryProvider;
import com.learn.ecommerce.model.Category;

public class CategoryServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		String requestType = request.getParameter("categoryServlet");
		
		if(requestType.equals("addCategory"))
		{
			String categoryTitle = request.getParameter("catTitle");
			String categoryDescription = request.getParameter("catDesc");
			
			//Server side validations 
			
			Category category = new Category();
			category.setCategoryTitle(categoryTitle);
			category.setCategoryDescription(categoryDescription);
				
			// saving the category in database.. CategoryDao access the database & perform operations
			CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
			categoryDao.addCategory(category);
			
			// Providing message on page that category is added successfully...
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("message", "Category added successfully");
			response.sendRedirect("admin.jsp");
			return;
		}
		
		else if(requestType.equals("removeCategory"))
		{
			int catId = Integer.parseInt(request.getParameter("removeCategoryBtn"));
			CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
			categoryDao.removeCategory(catId);
			response.sendRedirect("list-categories.jsp");
			return;
		}
		
		else if(requestType.equals("updateCategory"))
		{
			int catId = Integer.parseInt(request.getParameter("updateCategoryBtn"));
			CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
			String catTitle = request.getParameter("mydata");
			System.out.println("Category title to be changed is: "+catTitle);
			categoryDao.updateCategory(catId,catTitle);
			response.sendRedirect("list-categories.jsp");
			return;
		}
	}

}
