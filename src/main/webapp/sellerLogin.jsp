<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.bean.Sellers" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>商家登录页面</title>
</head>
<body>
	<div class="box">
		<h1>商家登陆页面</h1>
    	<form method="post" action="sellerLogin.jsp">
			<p><span>商家名称</span><input type ="text" name="sellername"></p>
			<p><span>密码</span><input type ="text" name="password"></p>
	        <input type="submit" value="登录">
	    </form>
	    <button onclick="ToUserLogin()">用户登录</button>
	    <p>还没有账号？请先<a href="sellerRegister.jsp">注册</a></p>
	</div>
	
    <% 
    request.setCharacterEncoding("UTF-8");
    // 获取表单提交的用户名和密码
    String sellername = request.getParameter("sellername");
    String password = request.getParameter("password");
    
    // 检查用户名和密码是否匹配
    boolean isValid = false;
    if (sellername != null && password != null) {
    	Connection conn = DBUtil.getConnectDb();
        Sellers seller = DBUtil.getSellersBySellername(conn, sellername);
        if (seller != null && seller.getSellerpassword().equals(password)) {
            // 登录验证成功
            isValid = true;
            String newSellername = seller.getSellername();
            session.setAttribute("sellername", newSellername);
        }
        DBUtil.CloseDB(null, null, conn);
    }
    %>
    
    <%-- 显示登录结果信息 --%>
    <% if (isValid) { %>
        <p>登录成功！</p>
        <%-- 跳转到 index.jsp 页面 --%>
        <% response.sendRedirect("sellerIndex.jsp"); %>
    <% } else if (sellername != null && password != null) { %>
        <p>账号或密码错误，请重新登录。</p>
    <% } %>
	
    <script>
		function ToUserLogin() {
		  // 替换下面的 URL 为你想要跳转的页面的实际 URL
		  window.location.href = "login.jsp";
		}
	</script>
</body>
</html>