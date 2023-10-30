<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%
    request.setCharacterEncoding("UTF-8");
	System.out.print(request.getParameter("goodsId"));
	int id = Integer.parseInt(request.getParameter("goodsId"));
	String goodname = request.getParameter("goodsname");
    float price = Float.parseFloat(request.getParameter("price"));
    int account = Integer.parseInt(request.getParameter("account"));
    String description = request.getParameter("describe");
    System.out.print(description+":"+id);

    Connection conn = DBUtil.getConnectDb();
    DBUtil.updateGoodsById(conn, id, goodname, price, account, description);
    DBUtil.CloseDB(null,null,conn);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>更新商品信息</title>
    <script>
        // 在页面加载完成后弹出提示框并返回店铺管理页面
        window.onload = function() {
            alert("商品信息已成功更新");
            window.location.href = "sellerIndex.jsp";
        }
    </script>
</head>
<body>
    <h1>商品信息更新中...</h1>
    <p>请稍等，正在更新商品信息...</p>
</body>
</html>
