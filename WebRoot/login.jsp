<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	String forelogin = request.getParameter("登录");
	String err = "";
	if(forelogin != null && forelogin.equals("登录")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User u = new User();
		switch(u.checkUser(username, password)) {
			case 0: err = "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户不存在";
			break;
			case 1:
				session.setMaxInactiveInterval(60*30);
				session.setAttribute("user", u); 
				response.sendRedirect("main.jsp");
			break;
			case -1: err = "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户名或密码错误";
			break;
		}
	}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link type="text/css" rel="stylesheet" href="main/css/login.css">
    <script type="text/javascript" src="main/js/jquery-1.8.0.min.js"></script>

  </head>
  
<body class="login_bj" >
	<div class="zhuce_body">
		<div class="logo"></div>
	    <div class="zhuce_kong login_kuang">
	    	<div class="zc">
	        	<div class="bj_bai">
	            <h3>登录<font color="red"><%= err %></font></h3>
	       	  	  <form action="login.jsp" method="get">
	                <input name="username" type="text" class="kuang_txt" placeholder="用户名">
	                <input name="password" type="password" class="kuang_txt" placeholder="密码">
	                <div>
	               		<a href="forgetpassword.jsp">忘记用户名或密码？</a><input name="" type="checkbox" value="" checked><span>记住我</span> 
	                </div>
	                <input name="登录" type="submit" class="btn_zhuce" value="登录">
	                
	                </form>
	            </div>
	    	</div>
	    </div>
	
	</div>
</body>
</html>
