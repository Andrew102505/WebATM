<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- this page can be used in circumstances where we do not need to be redirected to a servlet, like from the signup processor to home page -->
<%
	String pageName = (String)request.getParameter("page");

	if(pageName.equals("Initial")){//specifically if the user wants to logout of their session
			session.invalidate();
	}
		response.sendRedirect(pageName + ".jsp");
	
	
%>
</body>
</html>