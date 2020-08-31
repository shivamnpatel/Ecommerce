package com.learn.ecommerce.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.learn.ecommerce.dao.OrderDao;
import com.learn.ecommerce.helper.FactoryProvider;
import com.learn.ecommerce.model.Cart;
import com.learn.ecommerce.model.Order;

public class OrderServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String name = request.getParameter("cust_name");
		String email = request.getParameter("cust_email");
		String mobile = request.getParameter("cust_mobile");
		String state = request.getParameter("cust_state");
		String city = request.getParameter("cust_city");
		int pincode = Integer.parseInt(request.getParameter("cust_pincode"));
		String address = request.getParameter("cust_address");
		
		// Validations
		if(name.isEmpty() || email.isEmpty() || mobile.isEmpty() || state.isEmpty() ||
				city.isEmpty() || address.isEmpty())
		{
			PrintWriter out = response.getWriter();
			out.println("Please enter all details!!");
			return;
		}
		
		// fetching cart/checkout items
		HttpSession session = request.getSession();
		ArrayList<Cart> cartItemsList = new ArrayList<>();
		cartItemsList = (ArrayList<Cart>) session.getAttribute("cartItems");
		int finalPrice = 0;
		
/*		for (Cart cart : cartItemsList) {
			System.out.println("Item name: "+cart.getItemName());
			System.out.println("Item price: "+cart.getItemPrice());
			System.out.println("Item quantity: "+cart.getItemQuantity());
			System.out.println("Item total price: "+(cart.getItemPriceAfterDiscount()*(cart.getItemQuantity())));
			finalPrice+=(cart.getItemPriceAfterDiscount()*(cart.getItemQuantity()));
			System.out.println();
		}	
		System.out.println("FINAL PRICE: "+finalPrice);
*/	
		// now set the above items to Order.jsp Entity class using setters & save to DB.
		// then show summary of purchase to user in order.jsp page.
			
		Order orderItems = new Order(cartItemsList,name,email,mobile,state,city,pincode,address);
		System.out.println(orderItems);
		
		OrderDao orderDao = new OrderDao(FactoryProvider.getSessionFactory());
		orderDao.saveOrderDetails(orderItems,cartItemsList);
		HttpSession sess = request.getSession();
		sess.setAttribute("orderId", orderItems.getOrderId());
		
		response.sendRedirect("order.jsp");
	}

}
