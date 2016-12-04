<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.util.*" %>

<%@ include file="logincheck.jsp" %>

<%
	List<User> users = new ArrayList<User>();
	//users = new User().getUsers();
	int pageNumber = 1;
	String pageNo = request.getParameter("pageno");
	int pageSize = 5;
	int pageCount = 1;
	if(pageNo != null) {
		pageNumber = Integer.parseInt(pageNo);
	}	
	pageCount = new User().getUsers(users,pageNumber, pageSize);
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
<form method="get" action="userdelete.jsp" onsubmit="return DelSelect()">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 用户列表</strong></div>
    <div class="padding border-bottom">
      <ul class="search">
        <li>
          <button type="button"  class="button border-green" id="checkall"><span class="icon-check"></span> 全选</button>
          <button type="submit" class="button border-red"><span class="icon-trash-o"></span> 批量删除</button>
        </li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th width="120">ID</th>
        <th>用户</th>       
        <th>电话</th>
        <th width="25%">地址</th>
         <th width="120">注册时间</th>
        <th>操作</th>       
      </tr>      
      <%
      	for(int i=0;i <users.size();i++) {
      		User u = users.get(i);
       %>
       <tr>
         <td><input type="checkbox" name="id[]" value="<%= u.getId() %>" /><%= u.getId() %></td>
         <td><%= u.getUserName() %></td>
         <td><%= u.getPhone() %></td>
          <td><%= u.getAddr() %></td>         
         <td><%= u.getrDate() %></td>
         <td><div class="button-group"> 
         <a class="button border-red" href="javascript:void(0)" onclick="return del(<%= u.getId() %>)"><span class="icon-trash-o"></span> 删除</a> </div></td>
       </tr>
       <%
       	}
        %>
      <tr>
        <td colspan="8">
        	<div class="pagelist"> 
        		<a href="userlist.jsp?pageno=1">首页</a> 
        		<a href="userlist.jsp?pageno=<%=pageNumber-1 == 0 ? 1 : pageNumber-1 %>">上一页</a> 
        		<span class="current"><%=pageNumber %></span>
        		<a href="userlist.jsp?pageno=<%=pageNumber+1>pageCount ? pageNumber : pageNumber+1 %>">下一页</a>
        		<span class="bg-main">共<%=pageCount %>页</span>
        		<a href="userlist.jsp?pageno=<%=pageCount %>">尾页</a> 
        	</div>
        </td>
      </tr>
    </table>
  </div>
</form>
<script type="text/javascript">

function del(id){
	if(confirm("您确定要删除吗?")){
		window.location.href="userdelete.jsp?id=" + id;
	}
}

$("#checkall").click(function(){ 
  $("input[name='id[]']").each(function(){
	  if (this.checked) {
		  this.checked = false;
	  }
	  else {
		  this.checked = true;
	  }
  });
})

function DelSelect(){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		var t=confirm("您确认要删除选中的内容吗？");
		if (t==false) return false; 		
	}
	else{
		alert("请选择您要删除的内容!");
		return false;
	}
}

</script>
</body></html>