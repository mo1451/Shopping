<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.FileUpload" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.commons.fileupload.*"%> 
<%@page import="org.apache.commons.fileupload.util.Streams"%> 
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%> 

<%@ page import="java.io.*" %>

<%
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
					%> 
					<!-- read a FileItemStream's content into a string. --> 
					<h1><%=fieldName%> --> <%=Streams.asString(is)%></h1> 
					<% 
				} else { //file upload 
					String fileName = item.getName(); 
					File uploadedFile = new File(getServletContext().getRealPath("/") + 
					"fileupload" + File.separator + fieldName + "_" + fileName);
					 uploadedFile.getParentFile().mkdirs();
                        uploadedFile.createNewFile();
					OutputStream os = new FileOutputStream(uploadedFile); 
					// write file to disk and close outputstream. 
					Streams.copy(is, os, true); 
					%> 
					<h1>upload file <%=uploadedFile.getName()%> done!</h1> 
					<% 
				} 
			} 
		} 
	
 %>