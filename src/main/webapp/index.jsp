<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="com.bean.Users" %>
<%@ page import="com.bean.Goods" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="-utf-8">
<link rel="stylesheet" href="./static/css/reset.css">
<link rel="stylesheet" href="./static/css/normalize.css">
<link rel="stylesheet" href="./static/css/index.css">
<title>购物系统首页</title>
</head>
<body>
	<%
	  // 自定义EL函数：将字节数组转换为Base64编码
	  pageContext.setAttribute("toBase64", new com.util.DBUtil());
	%>
	<h1>欢迎来到叮叮当当购物系统</h1>
	<div class="nav">
		<span>
			    <% 
			    String username = (String) session.getAttribute("username");
			    if (username != null && !username.isEmpty()) {
			    %>
			        你好 <%= username %>
			    <% } else { %>
			        你好，请先<a href="login.jsp">登录</a>
			    <% } %>
		</span>
		<a href="login.jsp">退出登录</a>
		<span class=right><a href="myself.jsp">个人信息</a></span>
		<span class=right><a href="myorders.jsp">我的订单</a></span>
		<span class=right><a href="ShoppingCart.jsp">我的购物车</a></span>
	</div>	
    <% 
    	Connection conn = DBUtil.getConnectDb();
	    List<Goods> goodsList = DBUtil.getAllGoods(conn); // 获取数据并保存到List中
	    request.setAttribute("data", goodsList); // 设置data属性为List对象
    %>
	<ul class="clearfix">
	    <c:forEach var="row" items="${data}">
	        <li>
	            <div class="shops">
	                <c:set var="imgBytes" value="${row.img}" />
	                <c:set var="imgBase64" value="${toBase64.ImageToBase64(imgBytes)}" />
	                <img src="data:image/jpg;base64,${imgBase64}" />
	                <p>商品名称：${row.goodsname}</p>
	                <p>商品价格：${row.price}</p>
	                <p>店铺：${row.producer}</p>
	                <p>商品描述：${row.describe}</p>
   	                <p>商品数量：
	                </p>
	                
					<form class="buyNow" action="purchase.jsp" method="post" onsubmit="setQuantity(this)">
					    <!-- 表单内容 -->
					    <input type="hidden" name="goodsname" value="${row.goodsname}" />
					    <input type="hidden" name="imgBase64" value="${imgBase64}" />
					    <input type="number" class="number" name="quantity" value="1" min="1" />
					    <input type="hidden" name="price" value="${row.price}" />
					    <input type="hidden" id="quantityValue" name="quantityValue" value="" /> <!-- 添加隐藏字段 -->
					    <button type="submit">立即购买</button>
					</form>
					
					<form action="addToCart.jsp"  method="post" id="cartForm">
					    <!-- 表单内容 -->
					    <input type="hidden" name="goodsname" value="${row.goodsname}" />
					    <input type="hidden" name="imgBase64" value="${imgBase64}" />
					    <input type="hidden" class="number" name="quantity" value="1" min="1" />
					    <input type="hidden" name="price" value="${row.price}" />
					    <input type="hidden" name="quantityValue" value="" /> <!-- 添加隐藏字段 -->
					    <button type="submit" onclick="addToCart(event,this)">加入购物车</button>
					</form>
	            </div>
	        </li>
	    </c:forEach>
	</ul>
	
	<!-- <script src="./static/javascript/index.js"></script> -->
		
	<script>
	    function setQuantity(form) {
	        var quantityInput = form.querySelector('.number');
	        var quantityValue = quantityInput.value;
	        form.quantityValue.value = quantityValue; // 设置隐藏字段的值
	    }
	    
	    function addToCart(event, button) {
	        event.preventDefault(); // 取消表单的默认提交行为
	        var form = button.closest('form');
	        var previousForm = form.previousElementSibling;
	        var quantityInput = previousForm.querySelector('.number'); // 获取数量输入框元素
	        var quantityValue = quantityInput.value; // 获取数量值
	        form.querySelector('input[name="quantityValue"]').value = quantityValue; // 设置隐藏字段的值
	        form.submit();
	    }
	</script>


</body>
</html>