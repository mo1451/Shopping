<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>

<%@ include file="logincheck.jsp" %>

<%
request.setCharacterEncoding("utf-8");
//System.out.println(request.getCharacterEncoding());
	String pid = request.getParameter("pid");
	String action = request.getParameter("action");
	String id = request.getParameter("id");
	String err = "";
	String title = "";
	String str = "";
	Category c = new Category();
	if(pid == null) {
		pid = "0";
		title = "添加根类";
		if(id != null) {
			title = "修改类别";
		}
	} else {
		title = "添加子类";
	}
	if (action != null && action.equals("add")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
//out.print(name);
//System.out.println(name);
		c.setName(name);
		c.setDescr(descr);
		c.setPid(Integer.parseInt(pid));
		if(c.checkCategory(name)) {
			err = "该种类已存在";			
		} else {
			c.addRootCategory();
			str = "添加成功";
		}		
	}
	
	if (action != null && action.equals("modify")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		

		c.setName(name);
		c.setDescr(descr);
		c.setId(Integer.parseInt(id));
		c.updateCategory();	
		
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
function load() 
{
	//alert();
	document.getElementById("name").focus();
}

</script>
</head>
<body onLoad="load()">
<div class="panel admin-panel">
  <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span><%=title %></strong></div>
  <div class="body-content">
    <form method="post" class="form-x" action="">  
      <div class="form-group">
        <div class="label">
          <label>类别：</label>
        </div>
        <div class="field">
          <input type="text" class="input w50" value="" name="name" id="name" data-validate="required:请输入类别" value="<%=action !=null && action.equals("modify")?c.getName():"" %>"/>
          <div class="tips"><font color="red"><%=err %></font></div>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>描述：</label>
        </div>
        <div class="field">
          <textarea class="input" name="descr" style=" height:90px;"></textarea>
          <div class="tips"></div>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label></label>
        </div>
        <div class="field">
          <button class="button bg-main icon-check-square-o" type="submit" name="action" value="<%=id == null ? "add" : "modify"  %>"> 提交</button>
          <%=str %>
        </div>
      </div>
    </form>
  </div>
</div>

</body></html>