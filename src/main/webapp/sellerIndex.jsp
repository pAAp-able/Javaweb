<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="com.bean.Users" %>
<%@ page import="com.bean.Goods" %>
<%@ page import="com.bean.Orders" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="./static/css/sellerIndex.css">
<title>店铺管理</title>
</head>
<body>
	<h1>店铺管理页面</h1>
    <% 	
    	Connection conn = DBUtil.getConnectDb();
    	request.setCharacterEncoding("UTF-8");
	    String sellername = (String) session.getAttribute("sellername");
    %>
    <p> 你好 <%= sellername %></p>   
    <a href="login.jsp">退出登录</a>
	<h3>商品管理</h3>
	
    <table>
        <tr>
            <th>图片</th>
            <th>名称</th>
            <th>价格</th>
            <th>库存</th>
            <th>商品描述</th>
        </tr>
	<%	
		List<Goods> goodsList = DBUtil.getGoodsBysellersname(conn, sellername);
		for (Goods goods : goodsList) {
			int id = goods.getId();
		    String goodsname = goods.getGoodsname();
		    String producer = goods.getProducer();
		    float price = goods.getPrice();
		    int account = goods.getAccount();
		    String describe = goods.getDescribe();
	        byte[] imgBytes = goods.getImg();
	        String imgBase64 = com.util.DBUtil.ImageToBase64(imgBytes);
	        pageContext.setAttribute("imgBase64", imgBase64);		        
    		 %>
	         <tr>
	            <td><img class="product-image" src="data:image/jpg;base64, <%= imgBase64 %>"  alt="Product Image"></td>
	            <td><%= goodsname %></td>
	            <td><%= price %></td>
	            <td><%= account %></td>
	            <td><%= describe %></td>
				<td>
		            <form action="sellerIndex.jsp" method="post">
		                <input type="hidden" name="updateGoods" value="<%= id %>">
		                <button type="submit">修改</button>
		            </form>
		        </td>
   				<td>
		            <form action="sellerIndex.jsp" method="post">
		                <input type="hidden" name="deleteGoods" value="<%= id %>">
		                <button type="submit">删除</button>
		            </form>
		        </td>
	        </tr>
	        
		     <%
		   	}
	%>
	</table>
	<%	//修改信息
		if (request.getParameter("updateGoods") != null) {
		    int goodsIdToUpdate = Integer.parseInt(request.getParameter("updateGoods"));
		    System.out.print(goodsIdToUpdate);
		    Goods goodsToUpdate = DBUtil.getGoodsById(conn, goodsIdToUpdate);
		    if (goodsToUpdate != null) {
		%>
		    <h1>修改商品信息</h1> 
			<form method="post" action="updateGoods.jsp">
			    <input type="hidden" name="goodsId" value="<%= goodsToUpdate.getId() %>">
			    商品名称：<input type="text" name="goodsname" value="<%= goodsToUpdate.getGoodsname() %>"><br>
			    价格：<input type="text" name="price" value="<%= goodsToUpdate.getPrice() %>"><br>
			    库存：<input type="text" name="account" value="<%= goodsToUpdate.getAccount() %>"><br>
			    描述：<input type="text" name="describe" value="<%= goodsToUpdate.getDescribe() %>"><br>
			    <input type="submit" value="确认修改">
			</form>
		<%
		    } else {
		        out.println("找不到要修改的商品");
		    }
		}
	%>
	
	<%
		//删除信息
		if (request.getParameter("deleteGoods") != null){
			int goodsIdToDelete = Integer.parseInt(request.getParameter("deleteGoods"));
			DBUtil.deleteGoodsById(conn, goodsIdToDelete);
			response.sendRedirect("sellerIndex.jsp");
		}
	%>
	<h3>订单管理</h3>
	<%	
		List<Orders> ordersList = DBUtil.getOrdersBysellersname(conn, sellername);
		for (Orders orders : ordersList) {	
			int id = orders.getId();
		    String goodsname = orders.getGoodsname();
		    int number = orders.getNumber();
		    String payment = orders.getPayment();
		    String status = orders.getStatus();
		    String username = orders.getUsername();
		    
		    Users user = DBUtil.getUserByUsername(conn, username);
		    String userphone = user.getPhone();
		    String useraddress = user.getAddress();
		    
		    Goods good = DBUtil.getGoodsByGoodsname(conn,goodsname);
		    float price1 = good.getPrice();
	        byte[] imgBytes1 = good.getImg();
	        String imgBase641 = com.util.DBUtil.ImageToBase64(imgBytes1);
	        pageContext.setAttribute("imgBase641", imgBase641);
	        float money = price1 * number;
	        
    		 %>	
 		            <div class="order">
				        <img class="order-product-image" src="data:image/jpg;base64, <%= imgBase641 %>"  alt="Product Image">
				        <p><%= goodsname %></p>			
				        <p><%= number %></p>
				        <p><%= money %></p>
				        <div>
				        	<p><span><%= username %></span> <span><%= userphone %></span></p>
				        	<p><%= useraddress %></p>
				        </div>				
				        <p><%= payment %></p>
				        <p><%= status %></p>
	                    <% if (payment.equals("已付款") && status.equals("未发货") ) { %>
			                <form action="updateOrders.jsp" method="POST">
			                    <input type="hidden" name="orderId" value="<%= id %>">
			                    <button style="background-color:#4CAF50" type="submit">发货</button>
			                </form>
			                
			            <% } else { %>
			                <button  style="background-color:gray" disabled>发货</button>
			            <% } %>
				    </div>        
		     <%
		   	}
	%>
</body>
</html>