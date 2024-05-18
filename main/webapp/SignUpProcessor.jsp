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
	<%@ page import = "com.andrew.DatabaseLogger, com.andrew.Customer" %>
	<!-- you cannot just import a package as a whole, you must declare the class within the package too. -->
	
	<%!
	//dont create a separate class for this method because we can only access public methods from other classes and we don't want to pass a password into a public method
	private static boolean validPassword(String password) {
		String[] letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
		String[] nums = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
		String[] special = {"@", "!", "#"};
		boolean hasLength;
		if(password.length()==8) {
			hasLength = true;
		}else {
			hasLength = false;
		}
		boolean hasLetter = false;
		for(int i=0; i<letters.length; i++) {
			if(password.toLowerCase().contains(letters[i])){	
				hasLetter = true;
				break;
			}
		}
			boolean hasNum = false;
			for(int k=0; k<nums.length; k++) {
			if(password.toLowerCase().contains(nums[k])){	
				hasNum = true;
				break;
			}
		}
			boolean hasSpecial = false;
			for(int j=0; j<special.length; j++) {
				if(password.toLowerCase().contains(special[j])){
					hasSpecial = true;
					break;
				}
			}
		if(hasLength==true&&hasLetter==true&&hasNum==true&&hasSpecial==true) {
			return true;
		}else {
			return false;
		}
		
		}
	%> 
	
	<% 
	
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	int balance = Integer.parseInt(request.getParameter("balance"));
	String bank = request.getParameter("bank");
	
	//we don't need to make a print writer object because it's given by the servlet
	out.println("Hello " + name + ". Thank you for choosing " + bank);
	//this print line can go here even though we are declaring this a post method because the main function of the method was to add the user to the database which is what you would have a post method do, adding a println there is just for claraification that the users info was correctly processed
		
	
	
		
		
		if(validPassword(password)) {
			
			//this statement allows us to get access to the customerId and log all the other users information in the database
			DatabaseLogger.createCustomer(name, password, balance, bank, session);
				
			//we don't create a HttpSession object, when we want to capture a users session just start capturing their attributes like we did below
			//the customersId is added to the session in the createCustomer method
			session.setAttribute("name", name);//first argument is what we want the attribute to be called and the second argument is what the actually value is
			session.setAttribute("password", password);
			session.setAttribute("balance", balance);
			session.setAttribute("bank", bank);
			//need to get the users id, so we can access information from their database.
			
			
			//out.println("Thank you " + name + ". You are now a member of " + bank + ".");
			
		}else {
			out.println("Invalid password please try again.");
			response.sendRedirect("SignUp.html");//with send redirect, we direct the response to another servlet and also pass the client request to that servlet to be handle there, we could also direct the respose to an external source/website
		}
		
	
	
	%>
	
	<h1>You are now registered.</h1>
	
	<br>
	
	<form action = "PageRedirect.jsp" method = "get"><!-- get request because we are asking for a page(the page where we can change our account balance) -->
		
  		<h3>Click continue to return home.</h3>
			<br>
  		<button name="page" type="submit" value="Home">Continue</button><!-- value should be the name of the page you want to be redirected to -->
  		<button name="page" type="submit" value="Initial">SignOut</button>
</form>
	
	<!-- I could have  redirect servlet that just uses response.send redirect and the final response is the jsp file they want to go to and you can have a dictionary type thing -->
	<!-- could have them select options of things they want to do and that value is passed to the redirect servlet -->
	<!-- html code for next steps, write a message with their info using more java code, then an
	html form below with a button asking them if they would like to continue onto the main and redirect
	them to a new jsp page-->
	
</body>
</html>