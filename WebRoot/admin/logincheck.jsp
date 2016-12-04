<%
	String loginbg = (String)session.getAttribute("loginbg");
	if(loginbg == null || !loginbg.equals("true")) {
		//response.sendRedirect("/Shopping/admin/login.jsp");
		response.getWriter().write("<script>window.top.location='login.jsp'</script>");
	}
 %>