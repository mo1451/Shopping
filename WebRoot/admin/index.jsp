<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="logincheck.jsp" %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>后台管理中心</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>   
</head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
  <div class="logo margin-big-left fadein-top">
    <h1><img src="images/y.jpg" class="radius-circle rotate-hover" height="50" alt="" />后台管理中心</h1>
  </div>
  <div class="head-l"><a class="button button-little bg-green" href="/Shopping/main.jsp" target="_blank"><span class="icon-home"></span> 前台首页</a> &nbsp;&nbsp;<a class="button button-little bg-red" href="login.jsp"><span class="icon-power-off"></span> 退出登录</a> </div>
</div>
<div class="leftnav">
  <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
  <h2><span class="icon-pencil-square-o"></span>用户管理</h2>
  <ul style="display:block">
  	<li><a href="userlist.jsp" target="right"><span class="icon-caret-right"></span>用户列表</a></li>  
  </ul>   
  <h2><span class="icon-pencil-square-o"></span>种类管理</h2>
  <ul>
    <li><a href="categorylist.jsp" target="right"><span class="icon-caret-right"></span>种类列表</a></li>
    <li><a href="categorylistjs.jsp" target="right"><span class="icon-caret-right"></span>种类列表--树状</a></li>
    <li><a href="categoryadd.jsp" target="right"><span class="icon-caret-right"></span>添加根种类</a></li>     
  </ul>  
  <h2><span class="icon-pencil-square-o"></span>产品管理</h2>
  <ul>
    <li><a href="productlist.jsp?action=list" target="right"><span class="icon-caret-right"></span>产品列表</a></li>
    <li><a href="productadd.jsp" target="right"><span class="icon-caret-right"></span>产品添加</a></li>
    <li><a href="productsearch.jsp" target="right"><span class="icon-caret-right"></span>高级搜索</a></li>       
  </ul> 
  <h2><span class="icon-pencil-square-o"></span>订单管理</h2>
  <ul>
    <li><a href="orderlist.jsp" target="right"><span class="icon-caret-right"></span>订单列表</a></li>  
    <li><a href="productsales.jsp" target="right"><span class="icon-caret-right"></span>产品销量</a></li>     
  </ul> 
</div>
<script type="text/javascript">
$(function(){
  $(".leftnav h2").click(function(){
	  $(this).next().slideToggle(200);	
	  $(this).toggleClass("on"); 
  })
  $(".leftnav ul li a").click(function(){
	    $("#a_leader_txt").text($(this).text());
  		$(".leftnav ul li a").removeClass("on");
		$(this).addClass("on");
  })
});
</script>
<ul class="bread">
  <li><a href="{:U('Index/info')}" target="right" class="icon-home"> 首页</a></li>
  <li><a href="##" id="a_leader_txt">网站信息</a></li>
</ul>
<div class="admin">
  <iframe scrolling="auto" rameborder="0" src="info.html" name="right" width="100%" height="100%"></iframe>
</div>
<div style="text-align:center;">
</div>
</body>
</html>