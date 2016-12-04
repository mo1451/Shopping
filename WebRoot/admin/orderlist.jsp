<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.Timestamp" %>

<%@ include file="logincheck.jsp" %>

<%
	List<SalesOrder> orders = new ArrayList<SalesOrder>();
	int pageNumber = 1;
	String pageNo = request.getParameter("pageno");
	int pageSize = 5;
	int pageCount = 1;
	if(pageNo != null) {
		pageNumber = Integer.parseInt(pageNo);
		if(pageNumber < 1) {
			pageNumber = 1;
		}
	}
	pageCount = OrderMgr.getInstance().getOrders(orders,pageNumber, pageSize);
	String action = request.getParameter("action");
	if(action != null) {
		for(int i=0;i<orders.size();i++) {
			SalesOrder so = orders.get(i);
			int status = Integer.parseInt(request.getParameter("status" + so.getId()));
			so.setStatus(status);
			OrderMgr.getInstance().updateStatus(so);
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
<title></title>
<link rel="stylesheet" href="css/pintuer.css">
<link rel="stylesheet" href="css/admin.css">
<script src="js/jquery.js"></script>
<script src="js/pintuer.js"></script>
<script type="text/javascript">
	function dosomething() {
		document.form1.submit();
	}
</script>
</head>
<body>
<form method="get" action="orderlist.jsp" id="listform" name="form1">
	<input type="hidden" name="action" value="modify">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 内容列表</strong> <a href="" style="float:right; display:none;">添加字段</a></div>

    <table class="table table-hover text-center">
      <tr>
        <th>订单ID</th>
        <th>下单用户</th>
        <th>送货地址</th>
        <th>下单时间</th>
        <th>订单状态</th>
        <th>操作</th>
      </tr>
      
      <%
      	for(int i=0;i<orders.size();i++) {
      		SalesOrder so = orders.get(i);
      		User u = new User().getUserById(so.getUserid());
       %>
      
        <tr>
          <td><%= so.getId() %></td>
          <td title="<%=u.getPhone() == null ? "电         话：无\n地         址：无\n注册日期：无" : "电         话：" + u.getPhone() + "\n地         址：" + u.getAddr() + "\n注册日期：" + u.getrDate() %>"><a><%=so.getUsername() %></a></td>
          <td><%=so.getAddr() %></td>
          <td><%=so.getOdate() %></td>
          <td>
          	<select name="status<%=so.getId() %>">
          		<option value="0" <%=so.getStatus() == 0 ?"selected" : "" %>>未处理</option>
          		<option value="1" <%=so.getStatus() == 1 ?"selected" : "" %>>已处理</option>
          		<option value="2" <%=so.getStatus() == 2 ?"selected" : "" %>>废单</option>
          	</select>
		</td>
          <td><div class="button-group"> 
          <button class="button border-main" onclick="dosomething"><span class="icon-edit"></span> 订单处理</button>
          		<a class="button border-main" href="orderdetail.jsp?id=<%=so.getId() %>&username=<%=so.getUsername() %>&pagenumber=<%=pageNumber %>"><span class="icon-edit"></span> 明细</a>
          </div></td>
        </tr>
        <%
        }
         %>
        
        
      <tr>
        <td colspan="8"><div class="pagelist">
        		<a href="orderlist.jsp?pageno=1">首页</a>  
        		<a href="orderlist.jsp?pageno=<%=pageNumber-1 == 0 ? 1 : pageNumber-1 %>">上一页</a>
        		<span class="current"><%=pageNumber %></span>
        		
        		<a href="orderlist.jsp?pageno=<%=pageNumber+1>pageCount ? pageNumber : pageNumber+1 %>">下一页</a>
        		<span>共<%=pageCount %>页</span>
        		<a href="orderlist.jsp?pageno=<%=pageCount %>">尾页</a> 
        		
        		</div></td>
        		
      </tr>
    </table>
  </div>
</form>
</body>
</html>