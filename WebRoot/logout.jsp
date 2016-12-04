<%
	session.removeAttribute("user");
	response.sendRedirect("main.jsp");
 %>