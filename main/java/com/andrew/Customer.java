package com.andrew;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.*;
public class Customer {
	private String customerId;
	private String name;
	private String password;
	private int bankBalance;
	private Bank bank;
	  
	public Customer(String name, String password, int bankBalance, String bank, Connection con) throws SQLException {
		
		this.name = name;
		System.out.println(this.name);
		this.password = password;
		this.bankBalance = bankBalance;
		this.bank = new Bank(bank);
		
		this.customerId = this.generateCustomerId(con);
		
		String bankName = bank.toLowerCase().replace(" ", "_");
		
		String query = "INSERT INTO " + bankName + "_customers values (?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, this.customerId);
		ps.setString(2, this.name);
		ps.setString(3, this.bank.getName());
		ps.setInt(4, this.bankBalance);
		ps.setString(5, this.password);
		ps.executeUpdate();
		
	}
	
	public String generateCustomerId(Connection con) throws SQLException {
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
		String bankName = this.bank.getName().toLowerCase().replace(" ", "_");//the name of the table is all lowercase in mysql and has _ to connect words together
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
	
	
}
