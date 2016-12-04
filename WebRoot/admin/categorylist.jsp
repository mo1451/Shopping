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

</head>
<body>
<form method="post" action="categorydelete.jsp" id="listform">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 内容列表</strong> <a href="" style="float:right; display:none;">添加字段</a></div>
    <table class="table table-hover text-center" style="width:100%;">
      <tr>
        <th  style="text-align:left; padding-left:20px;">ID</th>
        <th>种类名称</th>
        <th>父类ID</th>        
        <th>分类等级</th>
        <th>操作</th>
        <th>是否为叶子节点</th>
        <th>操作</th>
      </tr>
      
      <%
      	for(int i=0;i<categories.size();i++) {
      		Category c = categories.get(i);
      		String preStr = "";
      		for(int j=1;j<c.getGrade();j++) {
      			preStr += "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
      		}
       %>
      
        <tr>
          <td style="text-align:left; padding-left:20px;"><input type="checkbox" name="id[]" value="<%=c.getId() %>" /><%= c.getId() %></td>
          <td style="text-align:left; hover:background-color:yellow;" class="<%=c.getName() %>" title="<%=c.getDescr() %>"><a><%=preStr + c.getName() %></a></td>
          <td><%=c.getPid() %></td>          
          <td><%=c.getGrade() %></td>
          <td><div class="button-group"> 
          		<a class="button border-main" href="categoryadd.jsp?id=<%=c.getId() %>"><span class="icon-edit"></span> 修改</a>
          		<a class="button border-main" href="categoryadd.jsp?pid=<%=c.getId() %>"><span class="icon-edit"></span> 添加子类</a> 	
          		 
          </div></td>
          <td><%=c.isIsleaf() %></td>
          <td><div class="button-group"> 
          		<%
          			if(c.isIsleaf()) {
          		 %>
          		 <a class="button border-red" href="javascript:void(0)" onclick="return del(<%=c.getId() %>,<%=c.getPid() %>)"><span class="icon-trash-o"></span> 删除</a>
          		 <a class="button border-main" href="productadd.jsp?categoryid=<%=c.getId() %>"><span class="icon-edit"></span> 添加产品</a> 
          		 <%
          		 	}
          		  %>
          </div></td>
        </tr>
        
        <script type="text/javascript">
        	$(function(){
			  $(".<%=c.getName() %>").click(function(){
			  	<%
			  		String str = "";	
			  		int n = 0;	  		
			  		for(int j=i+1;j<categories.size();j++) {
			  			Category c2 = categories.get(j);				  					  						  			
			  			if(c2.getGrade()>c.getGrade()) {
			  				n++;
			  			}
			  			str +="next().next().";
			  			if(c2.getGrade()<=c.getGrade()) {
							break;
						}
			  			//if(c2.getGrade()>c.getGrade() && n>1) {
  				%>
	  			//	if($(this).parent().<%=str %>is(":hidden")){
				//  		$(this).parent().<%=str %>slideToggle(200);
				//	} else {
						
				//	}
  				<%
			  			//}
			  			
			  			if(n>0) {
			  			
			  	%>
			  	
				  $(this).parent().<%=str %>slideToggle(200);	
				  
				  
				<%
						}
						
					}
				%>
			  })
			});
        </script>
        
        <%
        }
         %>
        
    </table>
  </div>
</form>

<script type="text/javascript">

//单个删除
function del(id,pid){
	if(confirm("您确定要删除吗?\n该类别下的产品也将删除。")){
		window.location.href="categorydelete.jsp?id=" + id + "&pid=" + pid;
	}
}

//全选
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

//批量删除
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
		$("#listform").submit();		
	}
	else{
		alert("请选择您要删除的内容!");
		return false;
	}
}

</script>
</body>
</html>