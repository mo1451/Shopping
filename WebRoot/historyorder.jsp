<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.Timestamp" %>


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
	int userId = Integer.parseInt(request.getParameter("id"));
	pageCount = new User().getHistoryOrders(orders, userId, pageNumber, pageSize);
	
 %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="admin/css/pintuer.css">
<link rel="stylesheet" href="admin/css/admin.css">
<script src="admin/js/jquery.js"></script>
<script src="admin/js/pintuer.js"></script>
<script type="text/javascript">
	function dosomething() {
		document.form1.submit();
	}
</script>
</head>
<body>
<form method="get" action="orderlist.jsp" id="listform" name="form1">
	<input type="hidden" name="id" value="<%=userId %>">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 订单列表</strong></div>

    <table class="table table-hover text-center">
      <tr>
        <th>订单ID</th>
        <th>下单用户</th>
        <th>送货地址</th>
        <th>下单时间</th>
        <th>订单状态</th>
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
          	  <%
          	  	switch(so.getStatus()) {
          	  		case 0:
          	  			out.print("未处理");
          	  		break;
          	  		case 1:
          	  			out.print("已处理");
          	  		break;
          	  		case 2:
          	  			out.print("交易完成");
          	  		break;          	  			
          	  	}
          	   %>
		</td>
        </tr>
        <%
        }
         %>
        
        
      <tr>
        <td colspan="8"><div class="pagelist">
        		<a href="main.jsp" target="_top">返回首页</a>  
        		<a href="historyorder.jsp?pageno=1&id=<%=userId %>">第一页</a>  
        		<a href="historyorder.jsp?pageno=<%=pageNumber-1 == 0 ? 1 : pageNumber-1 %>&id=<%=userId %>">上一页</a>
        		<span class="current"><%=pageNumber %></span>
        		
        		<a href="historyorder.jsp?pageno=<%=pageNumber+1>pageCount ? pageNumber : pageNumber+1 %>&id=<%=userId %>">下一页</a>
        		<span>共<%=pageCount %>页</span>
        		<a href="historyorder.jsp?pageno=<%=pageCount %>&id=<%=userId %>">尾页</a> 
        		
        		</div></td>
        		
      </tr>
    </table>
  </div>
</form>
</body>
</html>