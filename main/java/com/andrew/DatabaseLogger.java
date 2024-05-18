package com.andrew;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;

//you must put all jar files like msql connector into your server library, it will not work if you have it on your desktop
//you will need to move it back to desktop to run non web servlet applications like atmjdbc project

public class DatabaseLogger {//this class is responsible for logging information to the database
	
	//this method creates the database connection that the methods below will need to use
	static Connection createDBConnection() throws ClassNotFoundException, SQLException {
		String url = "jdbc:mysql://localhost:3306/webatm";
		String uname = "root";
		String pass = "Andrew@05";
		
		Class.forName("com.mysql.cj.jdbc.Driver"); //this will load the driver for us
		Connection con = DriverManager.getConnection(url, uname, pass);
		
		
		return con;
		}
	
	//this method is public because it will be called from the jsp file, and the jsp file can only call public methods from other classes
	public static void createCustomer(String name, String password, int bankBalance, String bank, HttpSession session) throws ClassNotFoundException, SQLException {
		Connection con = DatabaseLogger.createDBConnection();
		
		String customerId = generateCustomerId(con, bank);
		
		String bankName = bank.toLowerCase().replace(" ", "_");
		
		//this updates the bank_customers table with all of the info about the customer signing up
		String query = "INSERT INTO " + bankName + "_customers values (?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, customerId);
		ps.setString(2, name);
		ps.setString(3, bank);
		ps.setInt(4, bankBalance);
		ps.setString(5, password);
		ps.executeUpdate();
		
		//updates the customerId of the users session
		session.setAttribute("customer_id", customerId);                        
		
		
	}
	
	private static String generateCustomerId(Connection con, String bank) throws SQLException {
		//we have to make sure that it is not equal to any of the other customers in that bank
		//we'll make it nonstatic so then we can call it on an object and access some of that objects
		//properties, if we made it static we would have to pass the objects properties as parameters which
		//it messier, doesn't make that much of a difference in this case though
		//first generate the id then check it
		
		String id = "";
		boolean unique = false;
		boolean redo = false;
		while(unique==false) {
		for(int i = 0; i<5; i++) {
			String character = String.valueOf(((int)(Math.random()*10)));
			id += character;
			
		}	
		String bankName = bank.toLowerCase().replace(" ", "_");//the name of the table is all lowercase in mysql and has _ to connect words together
		String query = "SELECT customer_id FROM " + bankName + "_customers";//will return all the customers id from the specified bank of the user
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		System.out.println("passed");
		
		redo = false;
		while(rs.next()) {
			if(rs.getString("customer_id").equals(id)) {//indexing starts at 1 in mysql
				redo = true;
				break;
			}
			
			//so if its equal to something then we need to run this method again, if it's not then we need to return the id
		}
		if(redo==false) {
			unique=true;
		}
		
		//now we check it against all other in customer id's in the customers bank table of customers
		}
		
			return id;
		
	}
	
	public static void createTransaction(String customerId, String name, String bank, int amount, String transactionType, HttpSession session) throws ClassNotFoundException, SQLException {
		//we pass the users session because we need to update the balance of the users session, we have to create a session object because in a generic java class file a HttpSession variable is not created by default like in JSP, since servlet provides jsp already with the objects
		Connection con = DatabaseLogger.createDBConnection();
		System.out.println("Made it");
		String bankName = bank.toLowerCase().replace(" ", "_");
		   
		//this updates the transaction table with all of the info about the transaction made
		String query = "INSERT INTO " + bankName + "_transactions values (?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, customerId);
		ps.setString(2, name);
		ps.setString(3, bank);
		ps.setInt(4, amount);
		ps.setString(5, transactionType);
		ps.executeUpdate();
		//the part above works.
		
		//this updates the users balance in the customers table based on the amount they deposit/withdraw
		Statement st = con.createStatement();
		//query = "SELECT bank_balance FROM " + bankName + "_customers WHERE customer_id = '" + customerId + "'";
		//query = "UPDATE " + bankName + "_customers bank_balance = "
		//ResultSet rs = st.executeQuery(query);
		//rs.next();
		//int currentBalance = (int)rs.getInt("bank_balance");
		//int newBalance = currentBalance + amount;
		//query = "UPDATE " + bankName + "_customers SET bank_balance = bank_balance + " + Integer.toString(amount) + " WHERE customer_id = '" + customerId + "'";
		//System.out.println(query);
		query = "UPDATE " + bankName + "_customers SET bank_balance = bank_balance + " + amount + " WHERE customer_id = '" + customerId + "'";
		st.executeUpdate(query);//we were getting error because you cannot use executeQuery on an update, insert, or delete statement because they will not return items to a result set, they only return the number of rows affected.
		
		int newBalance = (int)session.getAttribute("balance") + amount;
		session.setAttribute("balance", newBalance);//update the session balance since it is changed after the transaction.
		//ResultSet rs = st.executeQuery(query);//returns all rows affected by the execution of this query(only one value returned in the resultSet because we filtered by customer_id)
		//rs.next();
		//int updatedBalance = rs.getInt("bank_balance"); 
		
		//this updates the users balance for their session
		//session.setAttribute("balance", updatedBalance);
	}
	//could create a jsp page with now html code that the program is directed to after the user enters their login info
	//in the servlet section is will have a condition that calls the method in the database logger class which will set the session
	//within the method if the name and password are valid and then the 
	public static boolean validateLogin(String name, String password, String bank, HttpSession session) throws ClassNotFoundException, SQLException {
		Connection con = DatabaseLogger.createDBConnection();
		String bankName = bank.toLowerCase().replace(" ", "_");
		String query = "SELECT customer_id, customer_name, customer_bank, bank_balance, customer_password FROM " + bankName + "_customers WHERE customer_name=? and customer_password=? and customer_bank=?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, name);
		ps.setString(2, password);
		ps.setString(3, bank);
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()) {//there was an item returned in the result set - user provided valid login information
			session.setAttribute("customer_id", rs.getString("customer_id"));//we are specifying the name of the column of the data
			session.setAttribute("name", rs.getString("customer_name"));//first argument is what we want the attribute to be called and the second argument is what the actually value is
			session.setAttribute("password", rs.getString("customer_password"));
			session.setAttribute("balance", rs.getInt("bank_balance"));
			session.setAttribute("bank", rs.getString("customer_bank"));
			return true;
		}else{
			return false;
		}
		
	}
	
}
	

