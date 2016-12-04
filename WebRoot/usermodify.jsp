<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<% 
	User u = (User)session.getAttribute("user");
	if(u == null) {
		response.getWriter().write("<script>window.top.location='login.jsp'</script>");
		return;
	} else {
		String modify = request.getParameter("modify");
		if(modify != null && modify.equals("修改")) {
			String phone = request.getParameter("phone");
			String addr = request.getParameter("addr");
			u.setPhone(phone);
			u.setAddr(addr);
			u.update();
			response.sendRedirect("userinformation.jsp");
		}
	}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'usermodfiy.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="admin/css/pintuer.css">
	<link rel="stylesheet" href="admin/css/admin.css">
	<script src="admin/js/jquery.js"></script>
	<script src="admin/js/pintuer.js"></script>

  </head>
  
  <body>
    <form action="usermodify.jsp" method="get">
    	<table align="center" class="table text-center">
    		<tr>
    			<td>电话</td>
    			<td class="text-left"><input type="text" name="phone" value="<%=u.getPhone() %>"></td>
    		</tr>
    		<tr>
    			<td>地址</td>
    			<td class="text-left"><input type="text" name="addr" value="<%=u.getAddr() %>" size="50"></td>
    		</tr>
    		<tr>
    		<td>
    		<input class="button bg-main" type="submit" name="modify" value="修改">
    		</td>
    		</tr>
    	</table>
    </form>
  </body>
</html>
