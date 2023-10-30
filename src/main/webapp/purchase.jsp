<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.util.DBUtil" %>
<%@ page import="com.bean.Users" %>
<%@ page import="com.bean.Goods" %>
<%@ page import="com.bean.Orders" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="./static/css/purchase.css">		
<title>购物页面</title>
</head>
<body>
		<%
		  // 自定义EL函数：将字节数组转换为Base64编码
		  pageContext.setAttribute("toBase64", new com.util.DBUtil());
		%>
		
	    <%  
	    	request.setCharacterEncoding("UTF-8");
	    	String goodsname = request.getParameter("goodsname");
	    	String quantity = request.getParameter("quantityValue");
	    	int newquantity = Integer.parseInt(quantity);
	    	System.out.println("quantity: " + quantity);
	    	String orderInfo = goodsname + ": " + quantity;
	        String username = (String) session.getAttribute("username");
	        Connection conn = DBUtil.getConnectDb();
	        Users users = DBUtil.getUserByUsername(conn, username);
	        Goods goods = DBUtil.getGoodsByGoodsname(conn, goodsname);
	        
	        DBUtil.updateUserOrder(conn, username, orderInfo);
	        String newUsername = users.getUsername();
	        String newProducer = goods.getProducer();
	        String payment = "已付款";
	        DBUtil.addOrders(conn, newUsername, goodsname, newProducer,payment, newquantity);

	        
	        byte[] imgBytes = goods.getImg();
	        String imgBase64 = com.util.DBUtil.ImageToBase64(imgBytes);
	        pageContext.setAttribute("imgBase64", imgBase64);
        %>
		<div class="content">
	        <div class="usercontent"> 
	        	<h1 class="address">收货地址</h1>
	        	<div class="userinfo">
				    <span><%= users.getUsername() %></span>
				    <span><%= users.getPhone() %></span>
				</div>
	        	<p><%= users.getAddress() %></p>
	        </div>
	         <div class="goodscontent">
	        	<h3 class="shopname"><%= goods.getProducer() %></h3>
	        	<div class="goodsinfo">
					<img class="goodsimage" src="data:image/jpg;base64,${imgBase64}" />
					<div class="nameandprice">
						<p><%= goods.getGoodsname() %></p>
						<p><%= goods.getPrice() %></p>
					</div>
               		<div class="number">
	                    ×<%=quantity %>
	                </div>
	        	</div>
	        </div>
	        <div class='money'>
	        	<h1 id="totalAmount">总金额：0</h1>
	        </div>
			<form action="myorders.jsp" method="post">
				<input type="hidden" name="goodsname" value="<%= goodsname %>" />
				<input type="hidden" name="quantity" value="<%= quantity %>" />
				<button class='confirm' onclick="confirmOrder(event)">提交订单</button>

			</form>
		</div>
		
		<script>
			window.addEventListener('load', function() {
				var quantity = <%= quantity %>;
				var price = <%= goods.getPrice() %>;
				var totalAmount = quantity * price;
				var totalAmountElement = document.getElementById('totalAmount');
				totalAmountElement.innerText = '总金额：' + totalAmount.toFixed(2);
			});
			function confirmOrder(event) {
				  event.preventDefault(); // 阻止表单的默认提交行为
				  var confirmed = confirm("请确认您的个人信息是否正确？");
				  if (confirmed) {
				    sessionStorage.setItem("goodsname", "<%= goodsname %>");
				    sessionStorage.setItem("quantity", "<%= quantity %>");
				    // 执行订单提交操作
				    window.location.href = "index.jsp"; // 替换成订单提交成功页面的URL
				  } 
			}
	</script>

</body>
</html>