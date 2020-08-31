package com.learn.ecommerce.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.learn.ecommerce.model.Category;
import com.learn.ecommerce.model.Product;

public class ProductDao {

	private SessionFactory sessionFactory;

	public ProductDao(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public boolean addProduct(Product product) {
		boolean result = false;
		Session session;
		try {

			session = this.sessionFactory.openSession();
			session.save(product);
			session.close();
			result = true;
		} 
		
		catch (Exception e) {

			e.printStackTrace();
			result = false;
		}

		return result;

	}
	
	// getting all products
	public List<Product> listAllProducts() {
		Session s = this.sessionFactory.openSession();
		Query query = s.createQuery("from Product");

		List<Product> productsList = query.getResultList();

		return productsList;
	}

	// getting all products with category Name
	public List<Product> getProductByCatName(String catName) {
		Session s = this.sessionFactory.openSession();
		Query query = s.createQuery("from Product as p where p.category.categoryTitle=:c");
		query.setParameter("c", catName);

		List<Product> productsListById = query.getResultList();

		return productsListById;
	}

	// getting object of Product by productId
	public Product getProductById(int pId) {

		Session ss = this.sessionFactory.openSession();
		Product product = ss.get(Product.class, pId);

		ss.close();

		return product;
	}
	//removing Product by productId
	public void removeProduct(int pId) {
		
		Session ss = this.sessionFactory.openSession();
		Product product = ss.get(Product.class, pId);
		Transaction transaction = ss.beginTransaction();
		
		ss.delete(product);
		transaction.commit();
		ss.close();
	
	}

}
