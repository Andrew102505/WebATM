<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page  import = "java.io.PrintWriter, java.sql.Connection, java.sql.DriverManager, java.sql.SQLException, jakarta.servlet.RequestDispatcher, jakarta.servlet.ServletException, jakarta.servlet.annotation.WebServlet, jakarta.servlet.http.HttpServlet, jakarta.servlet.http.HttpServletRequest, jakarta.servlet.http.HttpServletResponse, jakarta.servlet.http.HttpSession" %>
	<%@ page import = "com.andrew.DatabaseLogger" %>
	
	
	<%
		//only code that would be part of a doPost or doGet (service method) can be placed in here
		String transactionType = (String)request.getParameter("transaction_type");
		System.out.println(transactionType);
		int amount = Integer.parseInt(request.getParameter("transaction_amount"));
		System.out.println(amount);
		if(transactionType.equals("DEPOSIT")){
			System.out.println((String)session.getAttribute("customer_id"));
			
			DatabaseLogger.createTransaction((String)session.getAttribute("customer_id"), (String)session.getAttribute("name"), (String)session.getAttribute("bank"), amount, transactionType, session);
			//the balance attribute of the session is updated in the call of createTransaction
			
		}else{
			DatabaseLogger.createTransaction((String)session.getAttribute("customer_id"), (String)session.getAttribute("name"), (String)session.getAttribute("bank"), (-1)*amount, transactionType, session);
		}
		
	%>
	
	
	<h1>Your transaction was successfully processed!</h1>
	
	<form action = "PageRedirect.jsp" method = "get"><!-- get request because we are asking for a page(the page where we can change our account balance) -->
		
  		<h3>Click continue to return home.</h3>
			<br>
  		<button name="page" type="submit" value="Home">Home</button><!-- value should be the name of the page you want to be redirected to -->
  		<button name="page" type="submit" value="Initial">SignOut</button>
  		
	</form>
	
</body>
</html>