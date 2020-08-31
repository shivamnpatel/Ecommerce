package com.learn.ecommerce.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.learn.ecommerce.helper.FactoryProvider;
import com.learn.ecommerce.model.User;

public class RegisterServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		HttpSession httpSession;
		
		try {
			
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userPhone = request.getParameter("user_phone");
			String userAddress = request.getParameter("user_address");
			
			if(userName.isEmpty() || userEmail.isEmpty() || userPassword.isEmpty()
					|| userPhone.isEmpty() || userAddress.isEmpty())
			{
				httpSession = request.getSession();
				httpSession.setAttribute("message", "Please enter all details!!");
				response.sendRedirect("register.jsp");
				return;
			}
			
			Session hibernateSession = FactoryProvider.getSessionFactory().openSession();
			
			Transaction transaction = hibernateSession.beginTransaction();
			
			User user = new User(userName, userEmail, userPassword, userPhone, "default.png", userAddress,"normal");
			
			
			hibernateSession.save(user);
		
			transaction.commit();
			hibernateSession.close();
//			out.println("Registeration success!");
//			out.println("User id is: "+user.getUserId());
			httpSession = request.getSession();
			
			httpSession.setAttribute("message", "Registration Succesfull!!");
			
			response.sendRedirect("register.jsp");
			return;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

}
