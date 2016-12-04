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
		p = ProductMgr.getInstance().getProductById(Integer.parseInt(id));
	}
	CartItem ci = new CartItem();
	ci.setProductId(p.getId());
	ci.setProductName(p.getName());
	ci.setProductNormalPrice(p.getNormalPrice());
	ci.setProductMemberPrice(p.getMemberPrice());
	ci.setProductNo(1);
	cart.add(ci);
	response.sendRedirect("cart.jsp");
 %>