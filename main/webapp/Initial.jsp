<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action = "PageRedirect.jsp" method = "get"><!-- get request because we are asking for a page(the page where we can change our account balance) -->
			
  		<button name="page" type="submit" value="SignUp">Sign up</button><!-- value should be the name of the page you want to be redirected to -->
  		<button name="page" type="submit" value="Login">Sign in</button>
	
	</form> 

</body>
</html>  