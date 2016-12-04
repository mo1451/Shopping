<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>


<% 
	String err = "";
	User u = (User)session.getAttribute("user");
	if(u == null) {
		response.getWriter().write("<script>window.top.location='login.jsp'</script>");
		return;
	} else {
		String action = request.getParameter("action");
		if(action != null && action.equals("change")) {
			String password1 = request.getParameter("password1");
			int key = u.checkUser(u.getUserName(), password1);
			if(key == -1) {
				err = "密码错误";
			} else if(key == 1) {
				String password2 = request.getParameter("password2");
				u.changPassword(password2);
				response.getWriter().write("<script>window.top.location='login.jsp'</script>");
			}
		}
	}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>修改密码</title>
    
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
    <form action="userpasswordmodify.jsp" method="get" class="form-x">
    <input type="hidden" name="action" value="change">
    <br>
    	<div class="form-group">
			<div class="label">
				<label for="password1">
					原密码：</label>
			</div>
			<div class="field">
				<input type="password" class="input input-auto" name="password1" size="30" placeholder="原密码" data-validate="required:请输入原密码"/>
				<div class="tips text-red"><%=err %></div>
			</div>
		</div>
		
		<div class="form-group">
			<div class="label">
				<label for="password2">
					修改密码：</label>
			</div>
			<div class="field">
				<input type="password" class="input input-auto" name="password2" size="30" placeholder="修改密码" data-validate="required:请输入原密码"/>
				<div class="tips"></div>
			</div>
		</div>
		
		<div class="form-group">
			<div class="label">
				<label for="password2">
					确认修改密码：</label>
			</div>
			<div class="field">
				<input type="password" class="input input-auto" name="password2" size="30" placeholder="确认修改密码" data-validate="required:请输入原密码,repeat#password2:密码不一致"/>
				<div class="tips"></div>
			</div>
		</div>
		<div class="form-button">
		<button class="button bg-main icon-check-square-o" type="submit">确认</button>
	</div>
    </form>
  </body>
</html>
