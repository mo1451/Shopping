<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.mo1451.shopping.*" %>
<%@ page import="com.mo1451.shopping.Chart.*" %>
<%@ page import="java.sql.*" %>

<%@ include file="logincheck.jsp" %>

<%
	new ProductChart().createProductCategoryChart(request);
	new ProductChart().createProductPieChart(request);
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
  <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>产品销量</strong></div>
  <div class="body-content">
    <form method="get" class="form-x" action="">  
    <table class="table table-hover text-center">
        <tr>
          <td ><img src="../images/chart/productsales_category.jpg"></img></td>
          <td ><img src="../images/chart/productsales_pie.jpg"></img></td>
        </tr>
    </table>
    </form>
  </div>
</div>

</body></html>