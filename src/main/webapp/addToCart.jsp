<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.bean.Users" %>
<%@ page import="com.bean.Goods" %>
<%@ page import="com.bean.Orders" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
    // 获取提交的表单数据
   	request.setCharacterEncoding("UTF-8");
	String goodsname = request.getParameter("goodsname");
    int quantity = Integer.parseInt(request.getParameter("quantityValue"));
	System.out.println("quantity: " + quantity);
    String username = (String) session.getAttribute("username");
    
    float price = Float.parseFloat(request.getParameter("price"));

    // 插入订单数据到orders表中
	Connection conn = DBUtil.getConnectDb();
    Users users = DBUtil.getUserByUsername(conn, username);
    Goods goods = DBUtil.getGoodsByGoodsname(conn, goodsname);
    String newUsername = users.getUsername();
    String newProducer = goods.getProducer();
    DBUtil.addOrder(conn, newUsername, goodsname, newProducer, quantity);
    
%>

<script>
    var goodsname = "<%= goodsname %>";
    var quantity = <%= quantity %>;

    var message = "成功添加到购物车: " + goodsname + ": " + quantity;

    function confirmAndRedirect() {
        var confirmation = confirm(message);
        if (confirmation) {
            window.location.href = "index.jsp";
        }
    }
    confirmAndRedirect();
</script>

<p>成功添加到购物车！</p>
</body>
</html>