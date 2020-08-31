package com.learn.ecommerce.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.learn.ecommerce.model.Category;

public class CategoryDao {

	private SessionFactory sessionFactory;

	public CategoryDao(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public int addCategory(Category category) {

		Session session = this.sessionFactory.openSession();
		Transaction transaction = session.beginTransaction();
		int categoryId = (int) session.save(category);

		transaction.commit();
		session.close();

		return categoryId;
	}

	// returns all categories from DB
	public List<Category> listCategories() {
		Session s = this.sessionFactory.openSession();
		Query query = s.createQuery("from Category");
		List<Category> list = query.getResultList();

		// s.close();
		return list;
	}

	// getting object of Category by categoryId
	public Category getCategoryById(int cId) {

		Session ss = this.sessionFactory.openSession();
		Category category = ss.get(Category.class, cId);

		ss.close();

		return category;
	}
	
	// deleting category by categoryId
	public void removeCategory(int catId) {

		Session sess = this.sessionFactory.openSession();
		Transaction transaction = sess.beginTransaction();
		Category category = sess.get(Category.class, catId);
		//Category cat = getCategoryById(catId);
		//sess.createQuery("delete from Category where categoryId="+catId).executeUpdate();
		
		sess.delete(category);
		transaction.commit();
		sess.close();
		
	} 
	
	// updating category by categoryId
	public void updateCategory(int catId,String catTitle) {
		
		Session sess = this.sessionFactory.openSession();
		Transaction transaction = sess.beginTransaction();
		Category category = sess.get(Category.class, catId);
		
		category.setCategoryTitle(catTitle);  // updating category
		System.out.println("Updated category is: "+catTitle);
		sess.update(category);
		transaction.commit();
		sess.close();
		
	} 

}
