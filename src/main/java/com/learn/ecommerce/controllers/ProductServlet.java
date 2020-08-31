package com.learn.ecommerce.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletContext;
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
			Part partPhoto = request.getPart("pPhoto");
			int productPrice = Integer.parseInt(request.getParameter("pPrice"));
			int productDiscount = Integer.parseInt(request.getParameter("pDiscount"));
			int productQuantity = Integer.parseInt(request.getParameter("pQuantity"));
			int categoryId = Integer.parseInt(request.getParameter("catId"));

//			productPhoto.getSubmittedFileName();

			Product product = new Product();
			product.setpName(productName);
			product.setpDesc(productDescription);
			product.setpPhoto(partPhoto.getSubmittedFileName()); // gets the filename of photo
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

			// uploading photo to directory

			// path to upload photo
			String pathOfPhoto = request.getServletContext().getRealPath("images") + File.separator + "products"
					+ File.separator + partPhoto.getSubmittedFileName();
			System.out.println(pathOfPhoto);

			// writing code to upload photo in that path (folder)
			FileOutputStream fos = new FileOutputStream(pathOfPhoto);
			InputStream is = partPhoto.getInputStream();

			// reading data
			byte data[] = new byte[is.available()]; // is.available() gives the size of byte needed for Photo
			is.read(data);
			fos.write(data);
			fos.close();

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
