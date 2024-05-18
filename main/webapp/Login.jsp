<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%@ page import = "com.andrew.LoginServlet" %>
	<form action = login method = post> <!-- when calling a servlet from jsp you need to make sure you made updated the webxml file -->
	<table>
	<tr>
		<td>Select a Bank: </td>
		<td>
	  		<select name="bank" id="bank">
  			<option value="Bank of America">Bank of America</option><!-- change value down the line as needed -->
  			<option value="Chase">Chase</option>
	  		</select>
		</td>
	</tr>	
	
		<tr>
			<td>Name: </td>
			<td><input type="text" name="name"></td>
		</tr>
		
		 <tr>
			<td>8 digit password with at least one letter, number, and special character(@,!, #): </td>
			<td><input type="text" name="password"></td>
		</tr>
		
	<tr >
	 	<td><input type = "submit" value = "Login"></td><!-- the value parameter is just what the button will say on the user interface -->
	 </tr>
	 
	 </table>
	</form>
	
	<!-- really you should've had a username(best to use email) field for this part because two users can have the same first and last name -->
	<!-- after the user enters their login information, search the database using a SELECT statement and return the entries in the 
	result set that contain the users first and last name, most likely only one entry unless two users have the same name,
	then, then check that the password they entered matches with the returned entries password, use the next statement if their happens to be two,
	if you get to the end of the result set and there is no matches then return something saying that the users information was incorrect
	or else log them in by setting their session attributes and directing them to the home page.  -->
</body>
</html>