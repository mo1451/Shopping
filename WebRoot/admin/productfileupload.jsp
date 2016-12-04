<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="org.apache.commons.*" %>
<%@ page import="org.apache.commons.fileupload.FileUpload" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.commons.fileupload.*"%> 
<%@page import="org.apache.commons.fileupload.util.Streams"%> 
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%> 

<%@ page import="java.io.*" %>

<%
	String strId = request.getParameter("id");
	String strPageNo = request.getParameter("pageno");
	int pageNo = 1;
	if(strPageNo != null && !strPageNo.equals("")) {
		pageNo = Integer.parseInt(strPageNo);
	}
	int id = -1;
	String str = "";
	if(strId != null && !strId.equals("")) {
		id = Integer.parseInt(strId);
	}
	String action = request.getParameter("action");
	String pattern = "(.+)(\\.)jpg$";
	Pattern p = Pattern.compile(pattern);
	
	if(strId == null) {
		request.setCharacterEncoding("UTF-8"); 
		// Check that we have a file upload request 
		if(ServletFileUpload.isMultipartContent(request)) 
		{ 
			// Create a new file upload handler 
			ServletFileUpload upload = new ServletFileUpload(); 
			
			// Parse the request 
			FileItemIterator iter = upload.getItemIterator(request); 
			while(iter.hasNext()) 
			{ 
				FileItemStream item = iter.next(); 
				String fieldName = item.getFieldName(); 
				InputStream is = item.openStream(); 
				if(item.isFormField()) //regular form field 
				{ 
					if(fieldName.equals("id")) {
						id = Integer.parseInt(Streams.asString(is));
					}
					if(fieldName.equals("pageno")) {
						pageNo = Integer.parseInt(Streams.asString(is));
					}
				} 
				else 
				{ //file upload 
					String fileName = item.getName(); 
					if(fileName == "") {
						str = "文件为空";
						break;
					}
					Matcher m = p.matcher(fileName);
					if(!m.find()) {
						str = "请上传jpg格式的图片";
						break;
					} else {
						//out.print(m.group(1));
					}
					File uploadedFile = new File(getServletContext().getRealPath("/") + 
					"images/product" + File.separator + "product" + id + ".jpg"); 
					OutputStream os = new FileOutputStream(uploadedFile); 
					// write file to disk and close outputstream. 
					Streams.copy(is, os, true); 
					str = "图片上传成功";					
				} 
			} 
		} 
	}
	
 %>
 <html>
 <head>
 <link rel="stylesheet" href="css/pintuer.css">
<link rel="stylesheet" href="css/admin.css">
<script src="js/jquery.js"></script>
<script src="js/pintuer.js"></script>
</head>
 <body>
 <div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-file-photo-o"></span>图片上传</strong>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <a href="productlist.jsp?pageno=<%=pageNo %>&action=list" style="text-align:left;"><button class="button submit bg-main">返回上一页</button></a></div>
  <div class="body-content" align="center">
 	<form action="productfileupload.jsp" enctype="multipart/form-data" method="post">
 	<input type="hidden" name="pageno" value="<%=pageNo %>">
 		<table class="table text-center" style="width:600px;">
 			<tr>
 				<td class="text-right">
					<input type="hidden" name="id" value="<%=id %>" >		
					产品图片：<input type="file" name="file1">
				</td>
				<td>
				</td>
				<td class="text-left">
					<button class="button submit bg-main">上传/更换</button>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="text-center text-red"><%=str %></div>
				</td>
			</tr>
			
		</table>
	</form>
  </div>
 </div>
 </body>
 </html>