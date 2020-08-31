package com.learn.ecommerce.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.learn.ecommerce.dao.ProductDao;
import com.learn.ecommerce.helper.FactoryProvider;
import com.learn.ecommerce.model.Cart;
import com.learn.ecommerce.model.Product;

public class CartServlet extends HttpServlet {

	
	//Cart cart = null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
		
		String requestType = request.getParameter("cartServlet");
		
		// Add To Cart Action
		if(requestType.equals("addToCart"))
		{
			try 
			{
				ArrayList<Cart> cartList;
				Cart cart = new Cart();
				// get the id of the product of which addToCart btn is clicked
				int prodId = Integer.parseInt(request.getParameter("addToCartBtn"));
				System.out.println("Product id is "+prodId);
				int flag=0;
				
				HttpSession session = request.getSession();
				Product product = productDao.getProductById(prodId);			
			
				cartList = (ArrayList<Cart>) session.getAttribute("cartItems");
				
				// if cart is empty and product is added first time
				if(cartList==null)
				{
					cart = new Cart();
					cart.setItemId(prodId);
					cart.setItemName(product.getpName());
					cart.setItemPrice(product.getProductPriceAfterDiscount());
					cart.setItemQuantity(1);
					cart.setItemDiscount(product.getpDiscount());
					
					cartList = new ArrayList<Cart>();
					cartList.add(cart);
					flag=1;
				}
				
				// item is of same product id which was added before. So increase quantity
				if(flag!=1 && cartList!=null)
				{
					
						for(Cart c:cartList)
						{
							if(c.getItemId()==prodId)
							{
								int quan = c.getItemQuantity();
								quan++;
								c.setItemQuantity(quan);
								flag=1;
								break;
								
							}
						}
						
				}
								
				
				// cart is having item and the new item is also new item
				if(flag==0 && cartList!=null) 
				{
					// cart = new Cart();
					cart.setItemId(prodId);
					cart.setItemName(product.getpName());
					cart.setItemPrice(product.getProductPriceAfterDiscount());
					cart.setItemQuantity(1);
					cart.setItemDiscount(product.getpDiscount());
					
					// cartList = new ArrayList<Cart>();
					cartList.add(cart);
					//flag=1;
				}
				
				
				session.setAttribute("cartItems", cartList);
					
				response.sendRedirect("index.jsp");
			} 
			
			catch (Exception e) {
				e.printStackTrace();
				
			}
		}
		
		// Remove From Cart Action
		else if(requestType.equals("removeFromCart"))
		{
			int prodId = Integer.parseInt(request.getParameter("removeFromCartBtn"));
			
			ArrayList<Cart> cartList = new ArrayList<Cart>();
			HttpSession session = request.getSession();
			Product product = productDao.getProductById(prodId);
	
			cartList = (ArrayList<Cart>) session.getAttribute("cartItems");

			// to remove items from ArrayList, advanced for-loop is not used.
			if(cartList!=null)
			{
				for (int i = 0; i < cartList.size(); i++) 
				{
					
					int id = cartList.get(i).getItemId();
					if(id==prodId)
					{
						cartList.remove(i);
						
					}
				}
			}
			
			response.sendRedirect("cartItems.jsp");
			return;
			
		}
	}

}
