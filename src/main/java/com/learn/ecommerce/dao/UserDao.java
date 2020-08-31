package com.learn.ecommerce.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.learn.ecommerce.helper.FactoryProvider;
import com.learn.ecommerce.model.User;

public class UserDao {

	SessionFactory sessionFactory;

	public UserDao(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public User getUserByEmailPassword(String email,String password) {
		User user = null;
		try {
		
			Session session = FactoryProvider.getSessionFactory().openSession();
			String query = "from User where userEmail =:e and userPassword =:p"; // HQL
			Query q = session.createQuery(query);
			q.setParameter("e", email);
			q.setParameter("p", password);
			
			user = (User) q.uniqueResult();
			
			session.close();
		} 
		
		catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return user;
	}
	
	// List of all users
	public List<User> listUsers() {
		
		Session s = FactoryProvider.getSessionFactory().openSession();
		Query q1 = s.createQuery("from User");
		List<User> users = q1.getResultList();
		return users;
	}
	

}
