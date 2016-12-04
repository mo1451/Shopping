<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.*" %>

<%
	String id = request.getParameter("id");
	Product p = null;
	if(id != null && !id.trim().equals("")) {
		p = ProductMgr.getInstance().getProductById(Integer.parseInt(id));
	}
	
 %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="admin/css/pintuer.css">
<link rel="stylesheet" href="admin/css/admin.css">
<script src="admin/js/jquery.js"></script>
<script src="admin/js/pintuer.js"></script>
</head>
<body>
<div align="center">
  <div class="panel-head text-center" id="add"><strong><span class="icon-bars"></span>产品展示</strong></div>
  <br>
  <br>
  <div class="panel padding" style="width: 450px;text-align: center;">
  <br>
	<table class="table table-hover table-bordered text-center">
		<tr>
			<td>产品名称</td>
			<td><%=p.getName() %></td>
			<td rowspan="5" title="<%=p.getDescr()%>"><img src="./images/product/product<%=p.getId()%>.jpg" width="200" height="250" alt="<%=p.getName()%>" style="display: block;"></td>
		</tr>
		<tr>
			<td>产品描述</td>
			<td><%=p.getDescr() %></td>
		</tr>
		<tr>
			<td>市场价格</td>
			<td><%=p.getNormalPrice() %></td>
		</tr>
		<tr>
			<td>优惠价格</td>
			<td><%=p.getMemberPrice() %></td>
		</tr>
		<tr>	
			<td colspan="2">
				<button type="button" class="button icon-star-o text-green"><a href="buy.jsp?id=<%=p.getId() %>">购买商品</a></button></td>
		</tr>
	</table>
</div>
</div>



</body></html>