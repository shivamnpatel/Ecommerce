package com.learn.ecommerce.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.learn.ecommerce.model.Cart;
import com.learn.ecommerce.model.Order;

public class OrderDao {

	private SessionFactory sessionFactory;

	public OrderDao(SessionFactory sessionFactory) {

		this.sessionFactory = sessionFactory;
	}
	
	
	// saving order details of users in DB
	public void saveOrderDetails(Order order,ArrayList<Cart> cartList) {
		
		Session session = this.sessionFactory.openSession();
		try 
		{

			int finalPrice = 0;
			session.beginTransaction();
			
			session.save(order);
			
			// saving ArrayList<Cart> cartListItems using enhanced for loop 
			for(Cart cart1:cartList)
			{
				System.out.println("Item name: "+cart1.getItemName());
				System.out.println("Item price: "+cart1.getItemPriceAfterDiscount());
				System.out.println("Item quantity: "+cart1.getItemQuantity());
				System.out.println("Item total price: "+(cart1.getItemPriceAfterDiscount()*(cart1.getItemQuantity())));
				System.out.println();
				
//				Cart cartItem = new Cart();
				cart1.setOrders(order); // to set Foreign key orderId in Cart table
				finalPrice+=(cart1.getItemPriceAfterDiscount()*(cart1.getItemQuantity()));
				cart1.setFinalPrice(finalPrice);
				session.save(cart1);
				
			}		
			session.getTransaction().commit();
			session.close();
			
		} 
		
		catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	// getting list of all orders
	public List<Order> listAllOrders() {
		
		Session s = this.sessionFactory.openSession();
		Query query = s.createQuery("from Order");

		List<Order> ordersList = query.getResultList();
		getOrderByCustomerEmail("raj123@gmail.com");
		return ordersList;
	}

	// get order by orderId
	public List<Cart> getOrderById(int orderId) {
		
		Session s = this.sessionFactory.openSession();
		Query query = s.createQuery("from Order");
		Order o = s.get(Order.class,orderId);
		List<Order> orders = query.getResultList();
		//System.out.println("List of orders:"+o.getCartItems());
		List<Cart> cartItems = o.getCartItems();
		for (Cart cart : cartItems) {
			System.out.println(cart.getItemName());
		}
		
		return cartItems;
	}
	
	// get order by Customer email
	public List<Cart> getOrderByCustomerEmail(String email) {
		
		Session s = this.sessionFactory.openSession();
		// get all the orders of particular Customer using their email id
		Query query = s.createQuery("from Cart as c where c.orders.customerEmail=:e");
		query.setParameter("e", email);
		
		List<Cart> myCart = query.getResultList();	
		
		return myCart;
	}


}
