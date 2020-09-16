package com.learn.ecommerce.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.learn.ecommerce.dao.ProductDao;
import com.learn.ecommerce.helper.FactoryProvider;
import com.learn.ecommerce.model.Product;

public class ProductImageServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int productId = Integer.parseInt(request.getParameter("pId"));
		
		ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
		Product product = productDao.getProductById(productId);

		try 
		{
			byte[] photo = product.getpPhoto();

			OutputStream output = response.getOutputStream();
			output.write(photo);
			output.flush();
			output.close();
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		
		response.setContentType("image/gif");
	}

}
