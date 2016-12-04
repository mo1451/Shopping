<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>产品高级搜索</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="css/pintuer.css">
	<link rel="stylesheet" href="css/admin.css">
	<script src="js/jquery.js"></script>
	<script src="js/pintuer.js"></script>
  </head>
  
  <body>
  <div class="panel admin-panel">
  <div class="panel-head" id="add"><strong><span class="icon-search"></span>高级搜索</strong></div>
  <div class="body-content">
  <form action="/Shopping/admin/productlist.jsp" method="get" class="form-x">
  	<input type="hidden" name="action" value="complex">
  	<div class="form-group">
		<div class="field">
			<div class="label">
				<label for="username">
					类别选择：</label>
			</div>
			<div class="button-group checkbox">
				<%
          		List<Category> categories = new Category().getCategories();
          		for(int i=0;i<categories.size();i++) {
          			Category c = categories.get(i);
          			String str = "";
          			for(int j=c.getGrade();j>1;j--) {
          				str += "--";
          			}
          			if(c.isIsleaf()) {
          	%>
          		<label class="button border-blue">
					<input name="categoryids" value="<%=c.getId() %>" type="checkbox"><span class="icon icon-star"></span> <%=c.getName() %>
				</label>
          	<%
          			} else {
          	%>
          		<label class="button bg-green" disabled="disabled">
					<input name="categoryids" value="<%=c.getId() %>" type="checkbox"><span class="icon icon-star"></span> <%=c.getName() %>
				</label>
          	<%
          			}
          		}
          	 %>
			</div>
		</div>
	</div>
	<div class="form-group">
		<div class="label">
			<label for="username">
				关键字：</label>
		</div>
		<div class="field">
			<input type="text" class="input w50" id="keyword" name="keyword" size="30" placeholder="关键字" />
			<div class="tips"></div>
		</div>
	</div>
	<div class="form-group">
		<div class="label">
			<label>
				市场价格：</label>
		</div>
		<div class="field">
			<input type="text" class="input w50" id="highnormalprice" name="highnormalprice" size="30" placeholder="高市场价    请输入数字" data-validate="integer:请输入数字" /><div class="tips"></div>
		</div>
	</div>
	<div class="form-group">
		<div class="label">
			<label>
				</label>
		</div>
		<div class="field">
			<input type="text" class="input w50" id="highnormalprice" name="highnormalprice" size="30" placeholder="高市场价    请输入数字" data-validate="integer:请输入数字" /><div class="tips"></div>
		</div>
	</div>
	<div class="form-group">
		<div class="label">
			<label>
				会员价格：</label>
		</div>
		<div class="field">
			<input type="text" class="input w50" id="lowmemberprice" name="lowmemberprice" size="30" placeholder="低会员价    请输入数字" data-validate="integer:请输入数字" /><div class="tips"></div>
		</div>
	</div>
	<div class="form-group">
		<div class="label">
			<label>
				</label>
		</div>
		<div class="field">
			<input type="text" class="input w50" id="highmemberprice" name="highmemberprice" size="30" placeholder="高会员价    请输入数字" data-validate="integer:请输入数字" /><div class="tips"></div>
		</div>
	</div>
	<div class="form-group">
		<div class="label">
			<label>
				日期范围：</label>
		</div>
		<div class="field">
			<input type="text" class="input w50" id="startdate" name="startdate" size="30" placeholder="开始日期     请输入日期"/>
		</div>
	</div>
	<div class="form-group">
		<div class="label">
			<label>
				</label>
		</div>
		<div class="field">
			<input type="text" class="input w50" id="enddate" name="enddate" size="30" placeholder="结束日期    请输入日期" />
		</div>
	</div>
	<div class="form-button">
		<button class="button bg-main icon-check-square-o" type="submit">
			<span class="icon-search"></span>搜索</button>
	</div>
  </form>  
  </div>
  </div>
  </body>
</html>
