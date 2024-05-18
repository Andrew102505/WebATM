package com.andrew;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			  
			PrintWriter out = response.getWriter();
			response.setContentType("text/html");
			String name  = request.getParameter("name");
			String password = request.getParameter("password");
			String bank = request.getParameter("bank");
			HttpSession session = request.getSession();
			try {
				if(DatabaseLogger.validateLogin(name, password, bank, session)) {//if the login info is correct
					RequestDispatcher rd = request.getRequestDispatcher("Home.jsp");
					rd.forward(request, response);
				}else{
					out.println("<font color = red size=18>Login Failed!!<br>");
					out.println("<a href=Login.jsp>Try Again!!</a>");
				}
			} catch (ClassNotFoundException | SQLException | ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
					
			
			
	}
}