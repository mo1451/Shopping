<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.Timestamp" %>

<%
	User u = (User)session.getAttribute("user");
	Cart cart = (Cart)session.getAttribute("cart");
	if(cart == null) {
		cart = new Cart();
		session.setAttribute("cart", cart);
	}
	String login = request.getParameter("login");
	if(login.equals("true")) {
		cart.setLogin(true);
	} else if(login.equals("false")) {
		cart.setLogin(false);
	}
	String addr = request.getParameter("addr");
	SalesOrder so = new SalesOrder();
	so.setCart(cart);
	so.setUserid(u==null?-1:u.getId());
	so.setAddr(addr);
	so.setOdate(new Timestamp(System.currentTimeMillis()));
	so.setStatus(0);
	if(cart.getItems()==null) {
		out.print("您未下单，请下单");
	} else {
		OrderMgr.getInstance().addToDatabase(so);
	}
	session.removeAttribute("cart");
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
<script language="JavaScript1.2" type="text/javascript">
		function delayURL(url) {
			var delay=document.getElementById("time").innerHTML;
			if(delay>0) {
				delay--;
				document.getElementById("time").innerHTML=delay;
			}else {
				//window.top.location.href=url;
			//	window.parent.right.document.loaction.reload();
				window.top.location.href=url;
			}
		    setTimeout("delayURL('" + url + "')", 1000);
		}
	</script>
</head>
<body>
	<div align="center">
		<br>
	    <div class="panel-head text-center"><strong> 谢谢您在本网站购物，下单成功。</strong></div>
	    <br>
	    <span id="time" style="background:red">3</span>秒后跳转至商城主页，如未跳转，请点击下面链接
		<a class="text-green" href="main.jsp">商城主页</a>
	</div>
	<script type="text/javascript">
		delayURL("main.jsp");
	</script>
</html>