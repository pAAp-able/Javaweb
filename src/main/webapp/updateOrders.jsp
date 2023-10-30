<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.bean.Orders" %>
<%
    request.setCharacterEncoding("UTF-8");
	System.out.print(request.getParameter("orderId"));
	int id = Integer.parseInt(request.getParameter("orderId"));
	Connection conn = DBUtil.getConnectDb();
	Orders order = DBUtil.getOrderById(conn, id);
	int number = order.getNumber();
	String producer = order.getProducer();
	String goodsname = order.getGoodsname();
	String username = order.getUsername();
	String payment = order.getPayment();
	String status = "已发货";
	DBUtil.updateOrdersById(conn, id, producer, number, goodsname, username, status, payment);
    DBUtil.CloseDB(null,null,conn);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>更新订单信息</title>
    <script>
        // 在页面加载完成后弹出提示框并返回店铺管理页面
        window.onload = function() {
            alert("订单信息已成功更新");
            window.location.href = "sellerIndex.jsp";
        }
    </script>
</head>
<body>
    <h1>订单信息更新中...</h1>
    <p>请稍等，正在更新订单信息...</p>
</body>
</html>