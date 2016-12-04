<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	String id = request.getParameter("id");
	String pid = request.getParameter("pid");
	String ids[] = request.getParameterValues("id[]");
	if(id != null && pid != null) {
		Category.delete(Integer.parseInt(id),Integer.parseInt(pid));
		out.print("delete successfully");
	}
	response.sendRedirect("categorylist.jsp");
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'categorydelete.jsp' starting page</title>
    
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
				window.parent.right.document.location.href=url;
			}
		    setTimeout("delayURL('" + url + "')", 1000);
		}
	</script>
  </head>
  
  <body>
        删除成功，<span id="time" style="background:red">4</span>秒后跳转至用户列表，如未跳转，请点击下面链接
	<a href="/Shopping/admin/categorylist.jsp">用户列表</a>
	<script type="text/javascript">
		delayURL("/Shopping/admin/categorylist.jsp");
	</script>
  </body>
</html>
