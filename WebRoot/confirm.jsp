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
%>


<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>确认下单</title>
<link rel="stylesheet" href="admin/css/pintuer.css">
<link rel="stylesheet" href="admin/css/admin.css">
<script src="admin/js/jquery.js"></script>
<script src="admin/js/pintuer.js"></script>
</head>
<body>
<div align="center">
    <div class="panel-head text-center"><strong class="icon-reorder"> 购物车</strong></div>
    <br>
	<form action="order.jsp" method="get" class="form-x">
	<input type="hidden" name="login" value="<%=u != null?true:false %>">
    <table class="table table-hover text-center" style="width: 800px;text-align: center;">
      <tr>
        <th>已买商品ID</th>
        <th>已买商品名称</th>
        <th>已买商品价格</th>
        <th>已买商品数量</th>
        <th>操作</th>
      </tr>
      
      <%
      	for(int i=0;i<cart.getItems().size();i++) {
      		CartItem ci = cart.getItems().get(i);
       %>
      
        <tr>
          <td><%= ci.getProductId() %></td>
          <td><a><%=ci.getProductName() %></a></td>
          <td><%=u == null ?ci.getProductNormalPrice() : ci.getProductMemberPrice() %></td>
          <td><%=ci.getProductNo() %></td>
          <td><div class="button-group"> 
          		<a class="button border-red" href="javascript:void(0)" onclick="return del(<%=ci.getProductId() %>)"><span class="icon-trash-o"></span> 删除</a> 
          </div></td>
        </tr>
        <%
        }
         %>
         <tr align="left" class="form-group">
         	<td colspan="4">
         		<strong><% 
         			if(u == null) {
         				out.print("您现在未登录，将按市场价计算价格，您确定吗？");
						out.print("&nbsp<a href='login.jsp'><font color='red'>登录</font></a>");
         			} else {
         				out.print("欢迎您，" + u.getUserName() + "。请确认您的送货信息");
         			}
         		 %></strong>
         	</td>
         	<td colspan="1">
         		<strong>共<span class="text-red"><%=Math.round(cart.getTotalPrice(u == null ?false:true)*100)/100.0 %></span>元</strong>
         	</td>
         	
         </tr>
         <tr class="form-group">
         	<td colspan="1" class="form-button text-left">
         		<button class="border-main"><a href="main.jsp" target="_top"><span class="icon-arrow-left"></span>返回首页</a></button>
         	</td>
         	<td align="right" colspan="1">
         		<strong>送货地址：</strong>
         	</td>
         	<td colspan="1" class="field">
         		<input type="text" name="addr" value="<%=u==null?"":u.getAddr() %>" placeholder="送货地址" data-validate="required:请输入送货地址">
         		<div class="tips"></div>
         	</td>
         	<td colspan="2" class="form-button text-right">
         		<button class="submit border-main"><span class="icon-check"></span>下单</button>
         	</td>
         </tr>
    </table>
    </form>
    </div>
</body>
<script type="text/javascript">
	function del(id) {
		if(confirm("您确定要删除吗？")) {
			window.top.location.href="cartdelete.jsp?id=" + id + "&url=confirm";
		}
	}
</script>
</html>