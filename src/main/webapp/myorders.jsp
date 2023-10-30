<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.bean.Users" %>
<%@ page import="com.bean.Goods" %>
<%@ page import="com.bean.Orders" %>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="./static/css/myorders.css">

<title>我的订单</title>
</head>
<body>
	<%
		  // 自定义EL函数：将字节数组转换为Base64编码
		  pageContext.setAttribute("toBase64", new com.util.DBUtil());
	%>
	<h1 style="margin-top:30px;margin-left:45%;">我的订单</h1>
	<%	
		request.setCharacterEncoding("UTF-8");
		String username = (String) session.getAttribute("username");
		Connection conn = DBUtil.getConnectDb();
		String payment = "已付款";
		List<Orders> ordersList = DBUtil.getOrderByName(conn,username,payment);
		for (Orders order : ordersList) {
			int id = order.getId();
		    String goodsname = order.getGoodsname();
		    int number = order.getNumber();
		    String status = order.getStatus();
		    List<Goods> goodsList = DBUtil.getGoodsBygoodsname(conn, goodsname);
		    for (Goods goods : goodsList) {
		    	float price = goods.getPrice();
		    	float money =price * number;
		        byte[] imgBytes = goods.getImg();
		        String imgBase64 = com.util.DBUtil.ImageToBase64(imgBytes);
		        pageContext.setAttribute("imgBase64", imgBase64);
		        
		        %>
		            <div class="order">
				        <img class="product-image" src="data:image/jpg;base64, <%= imgBase64 %>"  alt="Product Image">
				
				        <h2 class="product-name"><%= goodsname %></h2>
				
				        <p class="product-quantity"><%= number %></p>
				
				        <p class="product-amount"><%= money %></p>
				
				        <p class="shipping-status"><%= status %></p>
		       
			            <form action="updateStatus.jsp" method="POST">
			                <input type="hidden" name="orderId" value="<%= id %>">
			                <% if (status.equals("已发货")) { %>
			                <button class="confirm-button" style="background-color: #337ab7" type="submit">确认收货</button>
			                <% } else { %>
               			            <button class="confirm-button" style="background-color: gray" disabled>确认收货</button>
			        		<% } %>
			            </form>

				    </div>

		        <%

		    }
		}
	%>


</body>
</html>