<%@ page language="java" import="java.util.*,com.mo1451.shopping.*"
	pageEncoding="utf-8"%>

<%
	String reg = request.getParameter("register");
	String err = "";
	User user = new User();
	if (reg != null && reg.equals("true")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");
		user.setUserName(username);
		user.setPassWord(password);
		user.setPhone(phone);
		user.setAddr(addr);
		if(user.checkUser(username)) {
			err = "用户名已存在";			
		} else {
			user.addToDatabase();
			response.sendRedirect("login.jsp");
		}		
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<title>注册</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link type="text/css" rel="stylesheet" href="main/css/login.css">
<script type="text/javascript" src="main/js/jquery.min.js"></script>
<script src="main/jquery-validation-1.14.0/lib/jquery.js" charset="UTF-8"></script>
<script src="main/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
<script src="main/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>

<script>
	$().ready(function() {
		$("#register").validate({
			rules : {
				username : {
					required : true,
					minlength : 2,
					maxlength : 10
				},
				password : {
					required : true,
					minlength : 3,
					maxlength : 20
				},
				password2 : {
					required : true,
					minlength : 3,
					maxlength : 20,
					equalTo : "#password"
				},
				phone : {
					required : true,
					minlength : 3,
					digits : true
				},
				addr : {
					required : true,
					minlength : 3
				},
				agree : "required"
			},
			messages : {
				username : {
					required : "请输入用户名",
					minlength : "少于两个字符",
					maxlength : "超过五个字符"
				},
				password : {
					required : "请输入密码",
					minlength : "少于三个字符",
					maxlength : "大于20个字符"
				},
				password2 : {
					required : "请确认密码",
					minlength : "少于三个字符",
					maxlength : "大于20个字符",
					equalTo : "密码不一致"
				},
				phone : {
					required : "请输入电话",
					minlength : "少于三个数字",
					digits : "请输入数字"
				},
				addr : {
					required : "请输入地址",
					minlength : "少于三个字符"
				},
				agree : "请接受声明"
			},
			errorPlacement: function(error, element) { //错误信息位置设置方法
				error.appendTo( element.next() ); //这里的element是录入数据的对象
			}
		});
	});
	var req;
	function usernamevalidate() {
		var nameField = document.getElementById("username");
		var url = "usernamevalidate.jsp?username=" + escape(nameField.value);
		if(window.XMLHttpRequest) {
			req = new XMLHttpRequest();
		} else {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		req.open("get", url, true);
		req.onreadystatechange = callback;
		req.send(null);
	}
	
	function callback() {
		if(req.readyState == 4) {
			if(req.status == 200) {
				var msg = req.responseXML.getElementsByTagName("msg")[0];
				//alert(msg.childNodes[0].nodeValue);
				setMsg(msg.childNodes[0].nodeValue);
				//alert(req.responseText);
			}
		}
	}
	
	function setMsg(msg) {
		if(msg == "invalid") {
			document.getElementById("err").innerHTML = "用户已存在";
		} else {
			document.getElementById("err").innerHTML = "";
		}
	}
</script>
<style>
.error {
	color: red;
}
</style>
</head>

<body class="login_bj">

	<div class="zhuce_body">
		<div class="zhuce_kong">
			<div class="zc">
				<div class="bj_bai">
					<h3>欢迎注册</h3>
					<form action="register.jsp" id="register" method="get">
						<input type="hidden" name="register" value="true">
						<input id="username" name="username" type="text" class="kuang_txt phone" onblur="usernamevalidate()" placeholder="用户名" value="<%= user.getUserName()!=null?user.getUserName():"" %>">
						<label class="err"><font color="red" id="err"><%= err %></font></label> 
						<label id="qwer"></label> 
						<input id="password" name="password" type="password" class="kuang_txt possword" placeholder="密码">
						<label class="err"></label> 
						<input id="password2" name="password2" type="password" class="kuang_txt possword" placeholder="确认密码">
						<label class="err"></label>  
						<input id="phone" name="phone" type="text" class="kuang_txt possword" placeholder="电话" value="<%= user.getPhone()!=null?user.getPhone():"" %>"> 
						<label class="err"></label> 
						<input id="addr" name="addr" type="text" class="kuang_txt yanzm" placeholder="送货地址" value="<%= user.getAddr()!=null?user.getAddr():"" %>">
						<label class="err"></label> 
						<div>
							<input name="agree" id="agree" type="checkbox" value=""><span>已阅读并同意<a
								href="agreement.jsp" target="_blank"><span class="lan">《XXXXX使用协议》</span></a></span>
						</div>
						<input name="注册" type="submit" class="btn_zhuce" value="注册">
						<p>
							已有账号？<a href="login.jsp">立即登录</a>
						</p>
					</form>
				</div>

			</div>
		</div>

	</div>

	<div style="text-align:center;"></div>
</body>
<!--  
<body>
	<form action="register.jsp" id="register">
		<input type="hidden" name="register" value="true">
		<table width="750" align="center" border="2">
			<tr>
				<td colspan="2" align="center">用户注册</td>
			</tr>
			<tr>
				<td width="5">用户名:&nbsp<input type="text" id="username"
					name="username" size="30" maxlength="10"></td>
			</tr>
			<tr>
				<td>密码:&nbsp&nbsp<input type="password" id="password"
					name="password" size="30" maxlength="12"></td>
			</tr>
			<tr>
				<td>密码确认:<input type="password" id="password2" name="password2"
					size="30" maxlength="12"></td>
			</tr>
			<tr>
				<td>电话:&nbsp&nbsp<input type="text" id="phone" name="phone"
					size="30" maxlength="12"></td>
			</tr>
			<tr>
				<td>收货地址:<input type="text" id="addr" name="addr" size="50"></td>
			</tr>
			<tr>
				<td><input type="submit" value="提交"> <input
					type="reset" value="重置"> <input type="button" value="ok"></td>
			</tr>
		</table>
	</form>
</body>

-->

</html>
