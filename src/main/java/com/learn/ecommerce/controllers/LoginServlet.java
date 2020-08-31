package com.learn.ecommerce.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.learn.ecommerce.dao.UserDao;
import com.learn.ecommerce.helper.FactoryProvider;
import com.learn.ecommerce.model.User;

public class LoginServlet extends HttpServlet {

       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession httpSession = request.getSession();
		try {
		
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			
			// validations
			if(userEmail.isEmpty() || userPassword.isEmpty())
			{
				httpSession.setAttribute("message", "Please enter all details!!");
				response.sendRedirect("login.jsp");
				return;
			}
			
			// authenticating user
			UserDao userDao = new UserDao(FactoryProvider.getSessionFactory());
			User user = userDao.getUserByEmailPassword(userEmail, userPassword);
			System.out.println(user);
			
			if(user!=null)
			{
				httpSession.setAttribute("currentUser",user);
				// admin 
				if(user.getUserType().equals("admin")) {
					response.sendRedirect("admin.jsp");
				}
				// normal user
				else if(user.getUserType().equals("normal")) {
					response.sendRedirect("index.jsp");
				}
				else {
					out.println("Sorry we couldn't verify your user type");
				}
				
			}
			else
			{
				httpSession = request.getSession();
				httpSession.setAttribute("message", "Invalid email or password!!");
				response.sendRedirect("login.jsp");
				return;
			}
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
