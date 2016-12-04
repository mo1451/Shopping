<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>

<%@ include file="logincheck.jsp" %>

<%
	List<Category> categories = new ArrayList<Category>();
	categories = new Category().getCategories();
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

	<link rel="stylesheet" href="tree/jquery.treeview.css" />

	
	<script src="tree/demo/jquery.cookie.js"></script>
	<script src="tree/jquery.treeview.js" type="text/javascript"></script>

	<script type="text/javascript">
	    $(document).ready(function(){
			$("#tree").treeview({
				toggle: function() {
					console.log("%s was toggled.", $(this).find(">span").text());
				}
			});
		});
	 </script>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head" id="add"><strong><span class="icon-folder-open"></span>产品列表--树状</strong></div>
 	<br>
	<table align="center">
		<tr>
			<td>
				<ul id="tree" class="filetree">
				      <%
				      	out.print(Category.getTree(categories, 0));
				       %>
				</ul>
			</td>
		</tr>
	</table>
</div>
</body>
</html>