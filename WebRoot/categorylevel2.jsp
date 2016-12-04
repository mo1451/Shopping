<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control", "no-store");//HTTP1.1
response.setHeader("Pragma", "no-cache");//HTTP1.0
response.setDateHeader("Expires", 0);

StringBuffer str = new StringBuffer();
int id = Integer.parseInt(request.getParameter("id"));
List<Category> categories = new Category().getCategories(id);


//字符串格式
for(int i=0;i<categories.size();i++) {
	Category c = categories.get(i);
	str.append(c.getId() + "," + c.getName() + "-");
}
//str.append("sdaf");
if(categories.size() == 0) {
	str.append("false");
} else {
	str.deleteCharAt(str.length()-1);
}


/*
//XML格式
for(int i=0;i<categories.size();i++) {
	Category c = categories.get(i);
	str.append("<category><name>" + c.getName() + "</name><id>" + c.getId() + "</id></category>");
}
if(categories.size() == 0) {
	str.append("false");
} else {
	str.insert(0, "<categories>");
	str.append("</categories>");
}
*/

response.getWriter().write(str.toString());
%>