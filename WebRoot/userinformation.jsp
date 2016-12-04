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
	}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userinformation.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <br>
  <br>
    <table align="center" border="2">
    		<tr>
    			<td>用户名</td>
    			<td><%=u.getUserName() %></td>
    		</tr>
    		<tr>
    			<td>电话</td>
    			<td><%=u.getPhone() %></td>
    		</tr>
    		<tr>
    			<td>地址</td>
    			<td><%=u.getAddr() %></td>
    		</tr>
    		<tr>
    			<td>注册日期</td>
    			<td><%=u.getrDate() %></td>
    		</tr>
    	</table>
  </body>
</html>
