function validateRegister()
{

	let uName = document.f1.user_name.value;
	let uEmail = document.f1.user_email.value;
	let uPassword = document.f1.user_password.value;
	let uPhone = document.f1.user_phone.value;
	let uAddress = document.f1.user_address.value;
	let atpos = uEmail.indexOf('@');
	let dotpos = uEmail.lastIndexOf('.');	
	
	if(uName.length<1 || uEmail.length<1 || uPassword.length<1 || uPhone.length<1 || uAddress.length<1)
	{
		alert("Please Enter all details!!");
		return false;
	}
	
	else if (atpos<1 || dotpos-atpos<=2 || dotpos+2>=uEmail.length)
	{
		alert("Enter valid Email id!");
		return false;
	}
	
	else if(uPhone.length!=10 || isNaN(uPhone))
	{
		alert("Enter valid mobile number!");
		return false;
	}
	
	else if(uPassword.length<4 || uPassword.length>15)
	{
		alert("Please enter password length 4-12 char");
		return false;
	}
	
	else if(uAddress.length<10)
	{
		alert("Please enter full Address!");
		return false;
	}

}

function validateLogin()
{
	let email = document.loginForm.email.value;
	let password = document.loginForm.password.value;
	let atpos = email.indexOf('@');
	let dotpos = email.lastIndexOf('.');	
	
	if(email.length<1 || password.length<1)	
	{
		alert("Please Enter all details!!");
		return false;
	}
	
	else if(atpos<1 || dotpos-atpos<=2 || dotpos+2>=email.length)
	{
		alert("Enter valid email id!!");
		return false;
	}
	
}
function validateCheckoutDetails()
{
	let name = document.checkout.order_name.value;
	let email = document.checkout.order_email.value;
	let mobile = document.checkout.order_phone.value;
	let address = document.checkout.order_address.value;
	let atpos = email.indexOf('@');
	let dotpos = email.lastIndexOf('.');	
	
	if(name.length<1 || email.length<1 || mobile.length<1 || address.length<1)
	{
		alert("Please Enter all details!!");
		return false;
	}
	
	else if (atpos<1 || dotpos-atpos<=2 || dotpos+2>=email.length)
	{
		alert("Enter valid Email id!");
		return false;
	}
	
	else if(mobile.length!=10 || isNaN(mobile))
	{
		alert("Enter valid mobile number!");
		return false;
	}
	
	else if(address.length<10)
	{
		alert("Please enter full Address!");
		return false;
	}
	
}
