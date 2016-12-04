<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.*" %>

<%
	String orderId = request.getParameter("id");
	int id = -1;
	if(orderId != null && !orderId.trim().equals("")) {
		id = Integer.parseInt(orderId);
	}
	List<SalesItem> items = OrderMgr.getInstance().getItems(id);
	String userName = request.getParameter("username");
	int pageNumber = Integer.parseInt(request.getParameter("pagenumber"));
 %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="css/pintuer.css">
<link rel="stylesheet" href="css/admin.css">
<script src="js/jquery.js"></script>
<script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>订单明细</strong></div>
  <div class="body-content">
    <form method="get" class="form-x" action="">  
    <table class="table table-hover text-center">
      <tr>
        <th>商品名称</th>
        <th>商品价格</th>
        <th>购买数量</th>
      </tr>
      
      <%
      	double totalPrice = 0.0;
      	for(int i=0;i<items.size();i++) {
      		SalesItem si = items.get(i);
      		totalPrice += si.getUnitPrice()*si.getPcount();
       %>
      
        <tr>
          <td><%= si.getProductName() %></td>
          <td ><a><%=si.getUnitPrice() %></a></td>
          <td><%=si.getPcount() %></td>
        </tr>
        <%
        }
         %>
        <tr>
        	
          <td>下单人：<%= userName %></td>
          <td>总价：<%=totalPrice %></td>
          <td><div class="button-group"> 
          		<a class="button border-main" href="orderlist.jsp?pageno=<%=pageNumber%>"><span class="icon-edit"></span> 返回</a>
          </div></td>
        </tr>   
    </table>
    </form>
  </div>
</div>

</body></html>