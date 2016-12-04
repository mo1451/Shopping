<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.*" %>

<%@ include file="logincheck.jsp" %>

<%
	String action = request.getParameter("action");
	String categoryid = request.getParameter("categoryid");
	
	String id = "";
	if(request.getParameter("id") != null) {
		id = request.getParameter("id");
	}
	String err = "";
	String title = "添加产品";
	String succ = "";
	String name = "";
	String descr = "";
	double normalPrice = -100;
	double memberPrice = -100;
	int categoryId = -1;
	Product p = new Product();
	if(categoryid != null && !categoryid.equals("")) {
		categoryId = Integer.parseInt(categoryid);
	}
	if(id != null && !id.trim().equals("")) {
		title = "修改产品";
		p = ProductMgr.getInstance().getProductById(Integer.parseInt(id));		
		name = p.getName();
		descr = p.getDescr();
		normalPrice = p.getNormalPrice();
		memberPrice = p.getMemberPrice();
		categoryId = p.getCategoryId();
	}
	if (action != null && action.equals("add")) {
		name = request.getParameter("name");
		descr = request.getParameter("descr");
		normalPrice = Double.parseDouble(request.getParameter("normalprice"));
		memberPrice = Double.parseDouble(request.getParameter("memberprice"));
		if(request.getParameter("categoryid") != null) {
			categoryId = Integer.parseInt(request.getParameter("categoryid"));
		}
		//categoryId = Integer.parseInt(request.getParameter("categoryid"));
		p.setId(-1);
		p.setName(name);
		p.setDescr(descr);
		p.setNormalPrice(normalPrice);
		p.setMemberPrice(memberPrice);
		p.setCategoryId(categoryId);
		p.setPdate(new Timestamp(System.currentTimeMillis()));
		if(!( ProductMgr.getInstance().add(p) )) {
			err = "产品已存在";
		} else {
			succ = "添加成功";
		}
	}
	
	if (action != null && action.equals("modify")) {
		p = ProductMgr.getInstance().getProductById(Integer.parseInt(id));
		if(request.getParameter("name") != null && !request.getParameter("name").trim().equals("")) {
			name = request.getParameter("name");
			p.setName(name);
		}
		if(request.getParameter("descr") != null && !request.getParameter("descr").trim().equals("")) {
			descr = request.getParameter("descr");
			p.setDescr(descr);
		}
		if(request.getParameter("normalprice") != null && !request.getParameter("normalprice").trim().equals("")) {
			normalPrice = Double.parseDouble(request.getParameter("normalprice"));
			p.setNormalPrice(normalPrice);
		}
		if(request.getParameter("memberprice") != null && !request.getParameter("memberprice").trim().equals("")) {
			memberPrice = Double.parseDouble(request.getParameter("memberprice"));
			p.setMemberPrice(memberPrice);
		}
		if(request.getParameter("categoryid") != null && !request.getParameter("categoryid").trim().equals("")) {
			categoryId = Integer.parseInt(request.getParameter("categoryid"));
			p.setCategoryId(categoryId);
		}		
		ProductMgr.getInstance().updateProduct(p);
		succ = "修改成功";
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
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span><%=title %></strong></div>
  <div class="body-content">
    <form method="get" class="form-x" action="">  
    <input type="hidden" name="id" value="<%=title == "修改产品" ? p.getId():"" %>">
      <div class="form-group">
        <div class="label">
          <label>产品名称：</label>
        </div>
        <div class="field">
          <input type="text" class="input w50" value="<%=name %>" name="name" data-validate="required:请输入产品名" />
          <div class="tips"><font color="red"><%=err %></font></div>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>描述：</label>
        </div>
        <div class="field">
          <textarea class="input" name="descr" value="" style=" height:90px;"><%=descr %></textarea>
          <div class="tips"></div>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>市场价格：</label>
        </div>
        <div class="field">
          <input type="text" class="input w50" value="<%=normalPrice==-100?"":normalPrice %>" name="normalprice" data-validate="required:请输入普通价格,double:请输入数字" />
          <div class="tips"></div>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>会员价格：</label>
        </div>
        <div class="field">
          <input type="text" class="input w50" value="<%=memberPrice==-100?"":memberPrice %>" name="memberprice" data-validate="required:请输入会员价格,double:请输入数字" />
          <div class="tips"></div>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>类别：</label>
        </div>
        <div class="field">
          <select name="categoryid" class="input w50" data-validate="required:请选择类别">
          <option name="null" value="" selected></option>
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
          <option value="<%=c.getId() %>" <%= c.getId()==categoryId?"selected":"" %>><%=str + c.getName() %></option>
          	<%
          			} else {
          	%>
          	<optgroup label=<%=str + c.getName() %>></optgroup>
          			<%
          		  	}
          		}
          	 %>
          </select>
          <div class="tips"></div>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label></label>
        </div>
        <div class="field">
          <button class="button bg-main icon-check-square-o" type="submit" name="action" value="<%=id == "" ? "add" : "modify"  %>"> 提交</button>
          <label class="text-dot"><%= succ==""?"":"<span class='icon-check'></span>" + succ %></label>
        </div>
      </div>
    </form>
  </div>
</div>

</body></html>