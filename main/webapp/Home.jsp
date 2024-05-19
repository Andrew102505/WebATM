<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>
	  <!--  out.println((String)session.getAttribute("name")); 
			//write now you need to figure out how you print general info from java outside of the doPost and doGet methods-->
		
	</h3>
	
	<br>
	<br>
	
	<h1>Total Balance: </h1>
	
	<!-- out.println((int)session.getAttribute("balance") + " dollars"); -->
	
	<!-- write now you have an error, you need to figure out how to do print general info from java outside doPost and doGet methods
	and you need to update the mysql database when the user makes transactions such as withdrawing or depositing
	**to log data base information create a transaction class where a transaction has attributes and you can log the information
	of that transaction into the database there and update the persons balance within the bank customers table - do this like you
	did for when you created a customer and logged it into the database from that class - create a class anytime you need to log 
	something into a database --> -->
	
	<br>
	
	<form action = "UpdateBalance.jsp" method = "post"> <!-- post request because we are asking for the program to update something, we will redirect this form info to the update balance method and that method will then do the same thing were we click a button to return us back to home which will be a get method-->
		
		<h3>What transaction type are you seeking: </h3>
		<input type="radio" id="deposit" name="transaction_type" value="DEPOSIT">
		<label for="deposit">Deposit</label><br>
		<input type="radio" id="withdraw" name="transaction_type" value="WITHDRAW">
		<label for="withdraw">Withdraw</label><br>
		
		<table>
			<tr>
				<td>Amount to deposit or withdraw: </td>
				<td><input type="text" name="transaction_amount"></td>
			</tr>
		</table>
		
		<input type = "submit" value = "Complete Transaction"><!-- this form data is going directly to a post method in UpdateBalance.jsp -->
		
	</form>
	
	<form action = "PageRedirect.jsp" method = "get"><!-- get request because we are asking for a page(the page where we can change our account balance) -->
			
  		
  		<button name="page" type="submit" value="Initial">SignOut</button>
  		<button name="page" type="submit" value = "AccountInfo">View Account Info</button>

</form> 
</body>
</html>