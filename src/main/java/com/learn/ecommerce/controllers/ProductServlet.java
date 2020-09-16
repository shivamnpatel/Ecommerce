package com.learn.ecommerce.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.learn.ecommerce.dao.CategoryDao;
import com.learn.ecommerce.dao.ProductDao;
import com.learn.ecommerce.helper.FactoryProvider;
import com.learn.ecommerce.model.Category;
import com.learn.ecommerce.model.Product;

@MultipartConfig
public class ProductServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String requestType = request.getParameter("productServlet");
		
		if(requestType.equals("addProduct"))
		{
			String productName = request.getParameter("pName");
			String productDescription = request.getParameter("pDesc");
			int productPrice = Integer.parseInt(request.getParameter("pPrice"));
			int productDiscount = Integer.parseInt(request.getParameter("pDiscount"));
			int productQuantity = Integer.parseInt(request.getParameter("pQuantity"));
			int categoryId = Integer.parseInt(request.getParameter("catId"));

			//////////////////////////////// Image upload
			
			Part filePart = request.getPart("pPhoto"); // Retrieves <input type="file" name="pPhoto">
			String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
			InputStream fileContent = filePart.getInputStream();
			byte[] bFile = new byte[fileContent.available()];
			fileContent.read(bFile);
			
			System.out.println("File name: "+fileName);
			
			///////////////////////////////
			
			
			Product product = new Product();
			product.setpName(productName);
			product.setpDesc(productDescription);
			
			product.setpPhoto(bFile); // gets the filename of photo
			product.setpPrice(productPrice);
			product.setpDiscount(productDiscount);
			product.setpQuantity(productQuantity);

			// getting object of Category by categoryId

			CategoryDao categoryDao = new CategoryDao(FactoryProvider.getSessionFactory());
			Category categoryById = categoryDao.getCategoryById(categoryId);
			// setting category of the product by using categoryId
			product.setCategory(categoryById);

			// ProductDao access the database & perform operations
			ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
			boolean result = productDao.addProduct(product);
			if (!result) {
				request.getSession().setAttribute("message", "Error adding product");
				response.sendRedirect("admin.jsp");
				return;
			}

			// Providing message on page that product is added successfully...
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("message", "Product added successfully");
			response.sendRedirect("admin.jsp");
			return;
		}
		
		else if(requestType.equals("removeProduct"))
		{
			int prodId = Integer.parseInt(request.getParameter("removeProductBtn"));
			ProductDao productDao = new ProductDao(FactoryProvider.getSessionFactory());
			productDao.removeProduct(prodId);
			response.sendRedirect("list-products.jsp");
			return;
		}

	}

}
