<%@ page import="com.mo1451.shopping.*" %>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control", "no-store");//HTTP1.1
response.setHeader("Pragma", "no-cache");//HTTP1.0
response.setDateHeader("Expires", 0);
String str = "valid";
if(new User().checkUser(request.getParameter("username"))) {
	str = "invalid";
}
response.getWriter().write("<msg>" + str + "</msg>");
%>