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
	for(int i=0;i<cart.getItems().size();i++) {
		CartItem ci = cart.getItems().get(i);
		String count = request.getParameter("p" + ci.getProductId());
		if(count != null && !count.trim().equals("")) {
			ci.setProductNo(Integer.parseInt(count));
		}
	}
 %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>购物车</title>
<link rel="stylesheet" href="admin/css/pintuer.css">
<link rel="stylesheet" href="admin/css/admin.css">
<script src="admin/js/jquery.js"></script>
<script src="admin/js/pintuer.js"></script>
</head>
<body>
<div align="center">
    <div class="panel-head text-center"><strong class="icon-reorder"> 购物车</strong></div>
    <br>
	<form action="cart.jsp" method="get">
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
          <td><%=(u == null ?ci.getProductNormalPrice() : ci.getProductMemberPrice()) %></td>
          <td><input name="p<%=ci.getProductId() %>" value=<%=ci.getProductNo() %> size="10"></td>
          <td><div class="button-group"> 
          		<a class="button border-red" href="javascript:void(0)" onclick="return del(<%=ci.getProductId() %>)"><span class="icon-trash-o"></span> 删除</a> 
          </div></td>
        </tr>
        <%
        }
         %>
         <tr>
         	<td colspan="5">
         		<strong>共<span class="text-red"><%=Math.round(cart.getTotalPrice(u == null ?false:true)*100)/100.0 %></span>元</strong>
         	</td>
         </tr>
         <tr>
         	<td colspan="5">
         		<button class="border-main"><a href="main.jsp" target="_top"><span class="icon-arrow-left"></span>返回首页</a></button>
         		<button class=" sbumit border-main"><span class="icon-check"></span>修改订单数量</button>
         		<button class="border-main"><a href="confirm.jsp"><span class="icon-check"></span>提交订单</a></button>
         	</td>
         </tr>
    </table>
    </form>
    </div>
</body>
</html>
<script type="text/javascript">
	function del(id) {
		if(confirm("您确定要删除吗？")) {
			window.top.location.href="cartdelete.jsp?id=" + id + "&url=cart";
		}
	}
</script>