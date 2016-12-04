<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.*" %>

<%
	Cart cart = (Cart)session.getAttribute("cart");
	if(cart == null) {
		cart = new Cart();
		session.setAttribute("cart", cart);
	}
	String id = request.getParameter("id");
	Product p = null;
	if(id != null && !id.trim().equals("")) {
		cart.delete(Integer.parseInt(id));
	}
	String url = request.getParameter("url");
	if(url.equals("cart")) {
		response.sendRedirect("cart.jsp");
	} else if(url.equals("confirm")) {
		response.sendRedirect("confirm.jsp");
	}
	
 %>