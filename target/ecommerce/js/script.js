/*function addToCart(pId, pName, pPrice) {
	let cart = localStorage.getItem("cart");  // in string format
	// cart is empty
	if (cart == null) {

		let products = [];
		let product = { productId: pId, productName: pName, productPrice: pPrice, productQuantity: 1 };
		products.push(product);
		localStorage.setItem("cart", JSON.stringify(products));
		console.log("Product is added first time");
	}

	// item is already present in cart
	else {

		let pCart = JSON.parse(cart);   // Convert the cart string into
		// Javascript object array

		// now find that the new product which is added is the same old product
		// which was previously added or not..

		let oldProduct = pCart.find((item) => item.productId == pId);

		// if it is old product, then only increase the product quantity
		if (oldProduct) {
			oldProduct.productQuantity = oldProduct.productQuantity + 1;
			// now update the quantity to original object
			pCart.map((item) => {
				if (item.productId == oldProduct.productId)
					item.productQuantity = oldProduct.productQuantity;
			});

			localStorage.setItem("cart", JSON.stringify(pCart));
			console.log("Product quantity increased...");
		}

		// if new product, add the product
		else {
			let product = { productId: pId, productName: pName, productPrice: pPrice, productQuantity: 1 };
			pCart.push(product);
			localStorage.setItem("cart", JSON.stringify(pCart));
			console.log("New product is added to cart");
		}
	}
	updateCart();
	return true;
}

function updateCart() {
	console.log("Inside update cart function...");

	let cartString = localStorage.getItem("cart");
	let cart = JSON.parse(cartString);

	// cart is empty or no product is added into the cart
	if (cart == null || cart.length == 0) {
		document.getElementById("cart-items").innerHTML = " ( 0 )";
		document.getElementById("cart-body").innerHTML = "<h5>Cart does not have any items!</h5>";
		document.getElementById("checkout-btn").disabled = true;
	}
	// items are present into cart
	else {
		document.getElementById("cart-items").innerHTML = " ( " + cart.length + " )";
		//		$(".cart-items").html(` ( ${cart.length} )`);
		console.log(cart.length);
		//document.getElementById("cart-body").innerHTML = "<h3>Cart have items!</h3>";
		//document.getElementById("checkout-btn").disabled= false;
		$('#checkout-btn').prop('disabled', false);
		let table = `
				<table class="table table-responsive">
					<thead class="thead-light">
						<tr>
							<th>Item Name</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Total Price</th>
							<th>Action</th>
						</tr>
					</thead>
				
		`;

		let finalTotalPrice = 0;
		cart.map((item) => {

			table = table + `
			
				<tr>
					<td>${(item.productName)}</td>
					<td>${(item.productPrice)}</td>
					<td>${(item.productQuantity)}</td>
					<td>${(item.productPrice * item.productQuantity)}</td>
					<td><button class="btn btn-danger btn-sm" onclick="removeItemFromCart(${item.productId})">Remove</button></td>
				</tr>
			
			`;

			finalTotalPrice += item.productPrice * item.productQuantity;
		});


		table = table + `
			<tr><th colspan='5' class="text-right">Final Price:- &#8377; ${finalTotalPrice}</th></tr>
		</table>`;
		document.getElementById("cart-body").innerHTML = table;

	}

}

function removeItemFromCart(prodId) {
	let cart = JSON.parse(localStorage.getItem("cart"));

	// filter the cart so that the new cart is update one with removed items...
	let updatedCart = cart.filter((item) => item.productId != prodId);

	localStorage.setItem("cart", JSON.stringify(updatedCart));

	updateCart();
}


//$(document).ready(function(){
//	updateCart();
//});

// JS alternative of above jquery 
document.addEventListener("DOMContentLoaded", function(event) {
	updateCart();
});

/*	
$.get('${pageContext.request.contextPath}/RemoveFromCartServlet', function(data) {
        alert(data);
    });

*/

function addToCartMsg()
{
	alert("Product added to cart successfully!");
	document.cart.submit();
}

function removeItem()
{
	if(confirm("Confirm remove?") == true)
	{
		document.f1.submit();
		return true;
	}
	else
	{
		return false;
	}
}