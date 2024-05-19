<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Account Info</h1>
	<br>
	<br>
	<%
		out.print("<h3>Name:  </h3>");
		out.println((String)session.getAttribute("name"));
		out.println("<br>");
		out.print("<h3>Bank:  </h3>");
		out.println((String)session.getAttribute("bank"));
		out.println("<br>");
		out.print("<h3>Balance:  </h3>");
		out.println((int)session.getAttribute("balance"));
		out.println("<br>");
		
	%>
	
	<form action = "PageRedirect.jsp" method = "get"><!-- get request because we are asking for a page(the page where we can change our account balance) -->
		
  		<h3>Click continue to return home.</h3>
			<br>
  		<button name="page" type="submit" value="Home">Home</button><!-- value should be the name of the page you want to be redirected to -->
  		<button name="page" type="submit" value="Initial">SignOut</button>
  		
	</form>
	
</body>
</html>