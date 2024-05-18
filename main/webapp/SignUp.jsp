<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- no need for plain html files any more, just make a plain html jsp file instead because jsp files are rendered as html pages to the browser and their are issues with redirecting from jsp to html page. -->
<body bgcolor = "blue">


	<!-- when you click submit, the form will be submitted to the server(tomcat)-->
	<!-- when submitted the url will have /signup as declared in action parameter-->
	<!--the tomcat server will then look at the web.xml file to see which servlet the "/signup" request
	is mapped to - we will map it to the SignUpServlet class, which will handle the form data--> 
	<!-- because this is a post it will just have /signup in the url when submitted, if it was a get method then the url would have /signup and input values from the user -->
	<form action = "SignUpProcessor.jsp" method = "post"> <!-- http error method will tell you that the method specified in the form tag does not have a proper method to send the url data to, somtimes you will have to restart the server multiple times until it realizes you have made fixes to the error  -->
	<!-- the type of method that you declare is the type of response that it is expecting so if you declare a post method then the response should be from a doPost method because that will return a post response and viceversa for a get request -->
	<!-- default method is get request-->
	<!-- post will not show input in url parameters like a get request for security -->
		<h1 >Sign Up</h1>
	<table >
	
	
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
	
	<tr>
		<td>Balance: </td>
		<td><input type="text" name="balance"></td>
	</tr>
	
	
	 <!-- for incorrect password ideally you could insert a dynamic string that is empty initially, 
	 but we do a sendRedirect back to this html page with a string inside this table row tag that says
	 "invalid password try again - but I think that this is what jsp is for" -->
	 <tr >
	 	<td><input type = "submit" value = "Register"></td>
	 </tr>
	 
	 
	</table>
	
	</form>

<!-- now im confused on where we signal to send information to from a form
from the signup page how do I send the form data to a jsp -->


</body>
</html>