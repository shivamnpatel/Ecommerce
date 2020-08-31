<%@page import="com.learn.ecommerce.model.*"%>
<%@page import="java.util.ArrayList"%>

<%
	ArrayList<Cart> cartList = (ArrayList<Cart>)session.getAttribute("cartItems");
	int cartQuantity = 0;
	// checking for NullPointerException 
	if(cartList!=null)
		cartQuantity = cartList.size();

%>

<nav class="navbar navbar-expand-lg navbar-dark navbar-bg">
  <div class="container">
  	<a class="navbar-brand" href="index.jsp">Ecommerce</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
      
      <!-- <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Categories
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Mobiles</a>
          <a class="dropdown-item" href="#">Laptops</a>
        </div>
      </li>  -->
    </ul>
    
   	<%
   		User userReg =(User) session.getAttribute("currentUser");
   		if(userReg!=null)
   		{
   	%>
   			<ul class="navbar-nav ml-auto">
	   			<li class="nav-item active">
						<a class="nav-link" href="cartItems.jsp">
							<i class="fa fa-cart-plus"><span id="cart-items"> ( <%=cartQuantity %> )</span></i></a> 
			    </li>
	   			<li class="nav-item active">
	   				<a class="nav-link" href="<%=userReg.getUserType().equals("admin")?"admin.jsp":"normalUser.jsp" %>"><%=userReg.getUserName()%></a> 
	   		    </li>
	  		   	<li class="nav-item active">
	   		        <a class="nav-link" href="my-orders.jsp">My Orders</a> 
	   		    </li>
	  		   	<li class="nav-item active">
	   		        <a class="nav-link" href="LogoutServlet">Logout</a> 
	   		    </li>
   		   
   	    	</ul>	
  	 <%
   		}
   		
   		else
   		{
 	%>
	   		<ul class="navbar-nav ml-auto">
	   		
				<li class="nav-item active">
					<a class="nav-link" href="cartItems.jsp">
						<i class="fa fa-cart-plus"><span id="cart-items"> ( <%=cartQuantity %> )</span></i></a> 
			    </li>
				<li class="nav-item active">
					<a class="nav-link" href="login.jsp">Login</a> 
			    </li>
			   	<li class="nav-item active">
			        <a class="nav-link" href="register.jsp">Register</a> 
			    </li>
			    
	    	</ul>
    <%	
   		}
   	%>
   
  </div>
  </div>
</nav>