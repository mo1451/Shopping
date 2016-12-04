<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.Timestamp" %>


<%
	String action = request.getParameter("action");
	List<Product> products = new ArrayList<Product>();
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
	int id = -1;
	String keyword = "";
	double lowNormalPrice = -100;
	double highNormalPrice = -100;
	double lowMemberPrice = -100;
	double highMemberPrice = -100;
	Timestamp startDate = null;
	Timestamp endDate = null;
	String[] strCategoryids = null;
	String strCategoryidsQuery = "";
	int[] ids = null;
	if(action != null && action.equals("complex")) {		
		keyword =request.getParameter("keyword");
		strCategoryids = request.getParameterValues("categoryids");		
		if(strCategoryids != null && !strCategoryids[0].trim().equals("")) {
			ids = new int[strCategoryids.length];
			for(int i=0;i<strCategoryids.length;i++) {
				ids[i] = Integer.parseInt(strCategoryids[i]);
				strCategoryidsQuery += "&categoryids=" + ids[i];
			}
		}
		if(request.getParameter("categoryid") != null && !request.getParameter("categoryid").trim().equals("")) {
			id = Integer.parseInt(request.getParameter("categoryid"));
		}
		if(request.getParameter("lownormalprice") != null && !request.getParameter("lownormalprice").trim().equals("")) {
			lowNormalPrice = Double.parseDouble(request.getParameter("lownormalprice"));
		}
		if(request.getParameter("highnormalprice") != null && !request.getParameter("highnormalprice").trim().equals("")) {
			highNormalPrice = Double.parseDouble(request.getParameter("highnormalprice"));
		}
		if(request.getParameter("lowmemberprice") != null && !request.getParameter("lowmemberprice").trim().equals("")) {
			lowMemberPrice = Double.parseDouble(request.getParameter("lowmemberprice"));
		}
		if(request.getParameter("highmemberprice") != null && !request.getParameter("highmemberprice").trim().equals("")) {
			highMemberPrice = Double.parseDouble(request.getParameter("highmemberprice"));
		}
		if(request.getParameter("startdate") != null && !request.getParameter("startdate").trim().equals("")) {
			startDate = Timestamp.valueOf(request.getParameter("startdate"));
		}
		if(request.getParameter("enddate") != null && !request.getParameter("enddate").trim().equals("")) {
			endDate =Timestamp.valueOf(request.getParameter("enddate"));
		}
		pageCount = ProductMgr.getInstance().searchProductBy(products, ids, keyword, lowNormalPrice, highNormalPrice, 
																lowMemberPrice, highMemberPrice, startDate, endDate, pageNumber, pageSize,false);
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
<link rel="stylesheet" href="admin/css/pintuer.css">
<link rel="stylesheet" href="admin/css/admin.css">
<script src="admin/js/jquery.js"></script>
<script src="admin/js/pintuer.js"></script>
</head>
<body>
<form method="get" action="mainsearch.jsp" id="listform">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 产品列表</strong> <a href="" style="float:right; display:none;">添加字段</a></div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <li>
        <input type="hidden" name="action" value="complex">
          <input type="text" placeholder="请输入搜索关键字" name="keyword" class="input" style="width:250px; line-height:17px;display:inline-block" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>产品名称</th>
        <th width="10%">产品描述</th>
        <th>产品图片</th>
        <th>市场价格</th>
        <th>会员价格</th>
        <th>产品类别</th>
        <th width="310">操作</th>
      </tr>
      <volist name="list" id="vo">
      
      <%
      	for(int i=0;i<products.size();i++) {
      		Product p = products.get(i);
       %>
      
        <tr>
          <td align="center" style="hover:background-color:yellow;" class="<%=p.getName() %>"><a><%=p.getName() %></a></td>
          <td width="10%"><%=p.getDescr() %></td>
          <td><img alt="未上传图片" src="./images/product/product<%=p.getId()%>.jpg" width="150" height="150" /></td>
          <td><%=p.getNormalPrice() %></td>
          <td><%=p.getMemberPrice() %></td>
          <td><%=p.getCategory().getName() %></td>
          <td><div class="button-group"> 
          		<a class="button border-main" href="productdetailshow.jsp?id=<%=p.getId()%>"><span class="icon-edit"></span> 购买</a>
          </div></td>
        </tr>
        <%
        }
         %>
        
      <tr>
        <td colspan="8"><div class="pagelist">
        		<a href="main.jsp">返回首页</a>
        		<a href="mainsearch.jsp?pageno=1&action=<%=action %><%=strCategoryidsQuery %>&keyword=<%=keyword %>&lownormalprice=<%=lowNormalPrice %>&highnormalprice=<%=highNormalPrice %>&lowmemberprice=<%=lowMemberPrice %>&highmemberprice=<%=highMemberPrice %>&startdate=<%=startDate==null?"":startDate %>&enddate=<%=endDate==null?"":endDate %>">第一页</a>  
        		<a href="mainsearch.jsp?pageno=<%=pageNumber-1 == 0 ? 1 : pageNumber-1 %>&action=<%=action %><%=strCategoryidsQuery %>&keyword=<%=keyword %>&lownormalprice=<%=lowNormalPrice %>&highnormalprice=<%=highNormalPrice %>&lowmemberprice=<%=lowMemberPrice %>&highmemberprice=<%=highMemberPrice %>&startdate=<%=startDate==null?"":startDate %>&enddate=<%=endDate==null?"":endDate %>">上一页</a>
        		<span class="current"><%=pageNumber %></span>
        		
        		<a href="mainsearch.jsp?pageno=<%=pageNumber+1>pageCount ? pageNumber : pageNumber+1 %>&action=<%=action %><%=strCategoryidsQuery %>&keyword=<%=keyword %>&lownormalprice=<%=lowNormalPrice %>&highnormalprice=<%=highNormalPrice %>&lowmemberprice=<%=lowMemberPrice %>&highmemberprice=<%=highMemberPrice %>&startdate=<%=startDate==null?"":startDate %>&enddate=<%=endDate==null?"":endDate %>">下一页</a>
        		<span>共<%=pageCount %>页</span>
        		<a href="mainsearch.jsp?pageno=<%=pageCount %>&action=<%=action %><%=strCategoryidsQuery %>&keyword=<%=keyword %>&lownormalprice=<%=lowNormalPrice %>&highnormalprice=<%=highNormalPrice %>&lowmemberprice=<%=lowMemberPrice %>&highmemberprice=<%=highMemberPrice %>&startdate=<%=startDate==null?"":startDate %>&enddate=<%=endDate==null?"":endDate %>">尾页</a> 
        		
        		</div></td>
        		
      </tr>
    </table>
  </div>
</form>
<script type="text/javascript">

//搜索
function changesearch(){	
		$("#listform").submit();
}

</script>
</body>
</html>