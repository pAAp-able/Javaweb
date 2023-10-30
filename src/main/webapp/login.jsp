<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.bean.Users" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>登录页面</title>
</head>
<body>
	<h1>用户登陆页面</h1>
    <form method="post" action="login.jsp">
		<p><span>电话号码</span><input type ="text" name="phone"></p>
		<p><span>密码</span><input type ="text" name="password"></p>
        <input type="submit" value="登录">
    </form>
 	<p>还没有账号？请先<a href="register.jsp">注册</a></p>
 	<button onclick="redirectToPage()">商家登录</button>
    <%-- 检查登录结果 --%>
    <% 
    // 获取表单提交的用户名和密码
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    
    // 检查用户名和密码是否匹配
    boolean isValid = false;
    if (phone != null && password != null) {
    	Connection conn = DBUtil.getConnectDb();
        Users user = DBUtil.getUserByPhone(conn, phone);
        if (user != null && user.getPassword().equals(password)) {
            // 登录验证成功
            isValid = true;
            String username = user.getUsername();
            session.setAttribute("username", username);
        }
        DBUtil.CloseDB(null, null, conn);
    }
    %>
    
    <%-- 显示登录结果信息 --%>
    <% if (isValid) { %>
        <p>登录成功！</p>
        <%-- 跳转到 index.jsp 页面 --%>
        <% response.sendRedirect("index.jsp"); %>
    <% } else if (phone != null && password != null) { %>
        <p>账号或密码错误，请重新登录。</p>
    <% } %>
    
    <script>
		function redirectToPage() {
		  // 替换下面的 URL 为你想要跳转的页面的实际 URL
		  window.location.href = "sellerLogin.jsp";
		}
	</script>
</body>
</html>