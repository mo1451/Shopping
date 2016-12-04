<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page contentType="text/html; charset=gbk"%>
<%@ page import="com.mo1451.shopping.*"%>

<%
	User u = (User)session.getAttribute("user");
	Cart cart = (Cart)session.getAttribute("cart");
	if(cart == null) {
		cart = new Cart();
		session.setAttribute("cart", cart);
	}
	
	
	List<Product> products = new ArrayList<Product>();
	ProductMgr.getInstance().getLatestProducts(products, 10);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0024)http://www.dangdang.com/ -->
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:v="urn:schemas-microsoft-com:vml" class="cye-disabled cye-nm">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK"></meta>
<title>网上商城首页</title>
<link rel="Stylesheet" type="text/css" href="./images/homemin.css"></link>
<link type="text/css" rel="stylesheet" href="./images/main.css"></link>
<script src="./images/cpc_new.php"></script>
<script src="./images/logurl.htm"></script>
</head>
<div id="cyeBlackMaskLayer" style="background-color: rgb(19, 19, 19); position: fixed; width: 1980px; height: 1080px; z-index: -2147483648;"></div>
<body>
	<div id="hd">
		<div id="tools">
			<div class="tools">
				<div class="ddnewhead_operate" dd_name="顶链接">
					<ul class="ddnewhead_operate_nav">
					<%
						if(u != null) {
					 %>
						<li class="ddnewhead_cart">
							<a href="cart.jsp" ><i class="icon_card"></i>购物车<b id="cart_items_count_head"><%=cart.getItems().size() %></b></a>
						</li>
						<li class="ddnewhead_cart">
							<a href="historyorder.jsp?id=<%=u.getId() %>" ><i class="icon_card"></i>我的订单</a>
						</li>
						<%
						}
						 %>
					</ul>
				
					<div class="new_head_znx" id="znx_content" style="display:none;"></div>
					<div class="ddnewhead_welcome" display="none;">
					<span>
					<%
						if(u == null) {
					 %>
					 	欢迎光临，请<a href="login.jsp" class="login_link">登录</a>
					 	<a href="register.jsp" target="_self" rel="nofollw">注册</a>
					 <%
					 	}else {
					  %>
						欢迎光临，<a href="selfservice.jsp" class="login_link"><%=u.getUserName() %></a>
						<a href="logout.jsp">退出</a>
					 <%
					 	}
					  %>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div id="header_end"></div>
		<!--CreateDate  2016-11-07 13:00:01-->
		<div class="logo_line_out">
			<div class="logo_line" dd_name="搜索框">
				<script type="text/javascript">
					function categoryChange() {
						var id = document.forms["formcategory"].category1.options[document.forms["formcategory"].category1.selectedIndex].value;
						var url = "categorylevel2.jsp?id=" + escape(id);
				
						if (window.XMLHttpRequest) {
							req = new XMLHttpRequest();
						} else {
							req = new ActiveXObject("Microsoft.XMLHTTP");
						}
						req.open("get", url, true);
						req.onreadystatechange = callback;
						req.send(null);
					}
				
					function callback() {
						if (req.readyState == 4) {
							if (req.status == 200) {
								var msg = req.responseText;
								parse(msg);
							//	var msg = req.responseXML;
							//	parseXML(msg);
							}
						}
					}
				
					//XML格式
					function parseXML(msg) {
						var category = msg.getElementsByTagName("category")[0];
						alert(category.childNodes[0].nodeValue);
					}
				
					//字符串格式
					function parse(msg) {
						msg = msg.replace(/(^\s*)|(\s*$)/g, "");
						if (msg.toString() == "false") {
							document.forms["formcategory"].categoryids.length = 1;
							document.forms["formcategory"].categoryids.selectedIndex = 0;
							document.forms["formcategory"].categoryids.options[0].text = "全部分类";
							document.forms["formcategory"].categoryids.options[0].value = "";
						} else {
							var categories = msg.split("-")
							document.forms["formcategory"].categoryids.length = categories.length + 1;
							document.forms["formcategory"].categoryids.selectedIndex = 0;
							document.forms["formcategory"].categoryids.options[0].text = "请选择二级分类";
							document.forms["formcategory"].categoryids.options[0].value = "-1";
							for (var i = 0; i < categories.length; i++) {
								var categorieslevel2 = categories[i].split(",");
								var id = categorieslevel2[0];
								var name = categorieslevel2[1];
								document.forms["formcategory"].categoryids.options[i + 1].text = name;
								document.forms["formcategory"].categoryids.options[i + 1].value = id;
							}
						}
				
					}
				</script>
				<div class="search">
					<form action="mainsearch.jsp" name="formcategory" method="get">
						<input type="hidden" name="action" value="complex"/>
						<table style="border: 1px solid red;width:560px; height: 35px;">
							<tr>
								<td style="border: 1px solid red;width:300px; height: 35px;">
									<input type="text" placeholder="搜索产品" name="keyword" style="width:300px; height: 35px;">
								</td>
								<td style="border: 1px solid red;width:80px; height: 35px;">
									<select name="category1" onchange="categoryChange()"
									style="width:80px; height: 35px;">
										<option value="-1" selected>全部分类</option>
										<%
											List<Category> categories = new Category().getCategories(0);
											for (int i = 0; i < categories.size(); i++) {
												Category c = categories.get(i);
										%>
										<option value="<%=c.getId()%>"><%=c.getName()%></option>	
										<%
												}
											%>
									</select>
								</td>
								<td style="border: 1px solid red;width:120px; height: 35px;">
									<select name="categoryids" style="width:120px; height: 35px;">
										<option value="">全部分类</option>							
									</select>
								</td>
								<td style="border: 1px solid red;width:60px; height: 35px;">
									<input type="submit" id="search_btn" name="搜索" value="搜索" style="width:60px; height: 35px;" /> 
								</td>
							</tr>
						</table>	
								
					</form>
				</div>
				<div class="search_bottom">
					<a href="" class="search_advs" target="_blank">高级搜索</a>
				</div>
			</div>
		</div>
		
	</div>
	<script type="text/javascript" src="./images/pagetop.js.下载"></script>
	<div id="bd" name="15639" cvid="16424">
		<div class="con bd_body" name="15640">
			<div class="dd_brand ">
				<div class="con ">
					<div class="best_seller">
						<div class="head"><h3><span> 最新商品</span></h3></div>
						<div class="tab_c">
							<div type="item" style="display: block;">
								<ul class="clearfix">		
									<%
//最新商品从这开始
									for (Iterator<Product> it = products.iterator(); it.hasNext();) {
										Product p = it.next();
									%>
									<li>
										<a href="productdetailshow.jsp?id=<%=p.getId()%>" title="<%=p.getDescr() %>" class="pic">
											<img src="./images/product/product<%=p.getId()%>.jpg" width="150" height="150" alt="产品图片未上传" style="display: block;">
										</a>
										<p class="name">
											<a href="productdetailshow.jsp?id=<%=p.getId()%>" title="<%=p.getName()%>"> <span><%=p.getName()%></span><span
												class="color"><%=p.getDescr()%></span>
											</a>
										</p>
										<p class="price">
											<span class="price_r">￥<span><%=p.getNormalPrice()%></span></span>
											<span class="price_n">￥<span><%=p.getMemberPrice()%></span></span>
										</p>
									</li>
									<%
										}
									%>
								</ul>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
			
		</div>
		
		<script type="text/javascript" src="./images/jquery.js.下载"></script>

		<script type="text/javascript" src="./images/lazyloadDiv0615.js.下载"></script>
		<script type="text/javascript" src="./images/getJS.php"></script>
		<script type="text/javascript" charset="gbk"
			src="./images/adall.min.js.下载"></script>
		<script type="text/javascript" src="./images/js_tracker.js.下载"></script>
		<script type="text/javascript" src="./images/ddclick.js.下载"></script>
		<script language="javascript" src="./images/smart.js.下载"></script>
		<script type="text/javascript" src="./images/mix.js.下载"></script>
		<script type="text/javascript" src="./images/LoginWindow.js.下载"></script>
		<link href="./images/win_login20150728.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="./images/jquery.underscore.min.js.下载"></script>			
		<script type="text/javascript" src="./images/ld.js.下载" async="true"></script>
		<script type="text/javascript">
			window.criteo_q = window.criteo_q || [];
			window.criteo_q.push({
				event : "setAccount",
				account : "25268"
			}, {
				event : "setHashedEmail",
				email : [ "" ]
			}, {
				event : "setSiteType",
				type : "d"
			}, {
				event : "viewHome"
			});
		</script>
	</div>
	<script type="text/javascript" src="./images/suggest_new.php"></script>
	<div id="criteo-tags-div" style="display: none;">
		<iframe height="0" width="0" src="./images/dis.html"
			style="display: none;"></iframe>
	</div>
</body>
<div id="cye-workaround-body"
	style="position: absolute; left: 0px; top: 0px; z-index: -2147483646; background: none 0% 0% / auto repeat scroll padding-box border-box white; height: 6404px; width: 1347px;"></div>

</html>