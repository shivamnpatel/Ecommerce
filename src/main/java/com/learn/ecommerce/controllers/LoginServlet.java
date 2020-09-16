package com.learn.ecommerce.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
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
		
		try {
		
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			HttpSession oldSession = request.getSession(false);
			 
            if (oldSession != null) {
                oldSession.invalidate();
            }
	            
            HttpSession newSession = request.getSession(true);
			// validations
			if(userEmail.isEmpty() || userPassword.isEmpty())
			{
				newSession.setAttribute("message", "Please enter all details!!");
				response.sendRedirect("login.jsp");
				return;
			}
			
			// authenticating user
			UserDao userDao = new UserDao(FactoryProvider.getSessionFactory());
			User user = userDao.getUserByEmailPassword(userEmail, userPassword);
			System.out.println(user);
			
			if(user!=null)
			{
				newSession.setAttribute("currentUser",user);
				// admin 
				if(user.getUserType().equals("admin")) 
				{
					String adminPage = "/WEB-INF/views/admin.jsp";
					RequestDispatcher dispatcher = request.getRequestDispatcher(adminPage);
					dispatcher.forward(request, response);
				}
				// normal user
				else if(user.getUserType().equals("normal")) 
				{
					response.sendRedirect("index.jsp");
				}
				else 
				{
					out.println("Sorry we couldn't verify your user type");
				}
				
			}
			else
			{
				newSession = request.getSession();
				newSession.setAttribute("message", "Invalid email or password!!");
				response.sendRedirect("login.jsp");
				return;
			}
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
