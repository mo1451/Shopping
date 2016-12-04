<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>

<% 
	User u = (User)session.getAttribute("user");
	if(u == null) {
		response.getWriter().write("<script>window.top.location='login.jsp'</script>");
		return;
	}
 %>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户中心</title>
<link type="text/css" rel="stylesheet" href="main/css/style.css" />
<script type="text/javascript" src="main/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="main/js/menu.js"></script>
</head>

<body>
<div class="top"></div>
<div id="header">
	<div class="logo">用户中心</div>
	<div class="navigation">
		<ul>
		 	<li>欢迎您！</li>
			<li><a href=""><%=u.getUserName() %></a></li>
			<li><a href="main.jsp" target="_top">回到首页</a></li>
			<li><a href="logout.jsp">退出</a></li>
		</ul>
	</div>
</div>
<div id="content">
	<div class="left_menu">
	 <ul id="nav_dot">
      <li>
          <h4 class="M1"><span></span>用户管理</h4>
          <div class="list-item">
            <a href='userinformation.jsp' target="right">用户信息</a>
            <a href='usermodify.jsp' target="right">修改信息</a>
            <a href='userpasswordmodify.jsp' target="right">修改密码</a>
            <a href='cart.jsp' target="right">购物车</a>
            <a href='historyorder.jsp?id=<%=u.getId() %>' target="right">历史订单</a>
          </div>
        </li>
  </ul>
		</div>
		<div class="m-right">
			<div class="right-nav">
					<ul>
							
								<li style="margin-left:25px;">您当前的位置：</li>
								<li><a href="#" id="a_leader_txt1">用户管理</a></li>
								<li>></li>
								<li><a href="#" id="a_leader_txt2">用户信息</a></li>
						</ul>
			</div>
			<div class="main">
				<iframe scrolling="auto" rameborder="0" src="userinformation.jsp" name="right" width="100%" height="100%"></iframe>
			</div>
		</div>
</div>
<div class="bottom"></div>
<div id="footer"><p>Copyright©  2015 版权所有 京ICP备05019125号-10 </p></div>
<script>navList(12);</script>
<script type="text/javascript">
$(function(){
  $(".list-item a").click(function(){
 // alert();
	    $("#a_leader_txt2").text($(this).text());
  		$(".list-item a").removeClass("on");
		$(this).addClass("on");
  })
});
</script>
</body>
</html>
