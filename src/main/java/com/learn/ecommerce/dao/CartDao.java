package com.learn.ecommerce.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.learn.ecommerce.model.Cart;

public class CartDao {

	private SessionFactory sessionFactory;

	public CartDao(SessionFactory sessionFactory) {

		this.sessionFactory = sessionFactory;
	}

	
	// getting Cart items by orderId
	public Cart getCartItemById(int orderId){
		
		Session session = this.sessionFactory.openSession();
		Cart cartOrder = session.get(Cart.class, orderId);
		session.close();
		
		return cartOrder;
	}
	
	// getting all cart items
	public List<Cart> getAllCartItems(){
		
		Session sess = this.sessionFactory.openSession();
		Query query = sess.createQuery("from Cart");
		List<Cart> cartItem = query.getResultList();
		
		return cartItem;
	}
}
