<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>《XXXXX使用协议》</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
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
  <center>
	   这里什么也没有。<br><span id="time" style="background:red">5</span>秒后跳转至注册页面，如未跳转，请点击下面链接
	<a href="register.jsp">注册</a>
	</center>
	<script type="text/javascript">
		delayURL("register.jsp");
	</script>
  </body>
</html>
