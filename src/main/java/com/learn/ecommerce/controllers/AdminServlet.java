package com.learn.ecommerce.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String requestPage = request.getParameter("page");
		
		if(requestPage.equals("users"))
		{
			String nextPage = "/WEB-INF/views/list-users.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
			dispatcher.forward(request, response);
		}
		else if(requestPage.equals("categories"))
		{
			String nextPage = "/WEB-INF/views/list-categories.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
			dispatcher.forward(request, response);
		}
		else if(requestPage.equals("products"))
		{
			String nextPage = "/WEB-INF/views/list-products.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
			dispatcher.forward(request, response);
		}
		else if(requestPage.equals("orders"))
		{
			String nextPage = "/WEB-INF/views/list-orders.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
			dispatcher.forward(request, response);
		}
		
	}

}
