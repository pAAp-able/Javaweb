<%@ page language="java" contentType="text/html; utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.bean.Sellers" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>商家注册页面</title>
</head>
<body>
	<div class="box">
	<h1>商家注册页面</h1>
		<form method="post" accept-charset="UTF-8">
			<p><span>店铺名称</span><input type ="text" name="sellername"></p>
			<p><span>电话号码</span><input type ="text" name="sellerphone"></p>
			<p><span>密码</span><input type ="text" name="sellerpassword"></p>
			<p><span>确认密码</span><input type="password" name="confirmPassword"></p>
			<input type ="submit" name="注册"><br>
		</form>
		
		<% 
			request.setCharacterEncoding("UTF-8");
		    Connection conn = DBUtil.getConnectDb();	    // 处理表单提交
		    conn.prepareStatement("SET NAMES 'utf8'").executeUpdate();

		    if (request.getMethod().equalsIgnoreCase("post")) {
		        String sellername = request.getParameter("sellername");
		        String sellerphone = request.getParameter("sellerphone");
		        String sellerpassword = request.getParameter("sellerpassword");
		        String confirmPassword = request.getParameter("confirmPassword");
		        if (!sellerpassword.equals(confirmPassword)) {
		            // 密码验证不通过
		            out.println("密码不匹配，请重新输入");
		            return; // 停止继续处理注册逻辑
		        }else{
		        	Sellers sellers = new Sellers(sellername, sellerphone, sellerpassword);
					DBUtil.addSeller(conn,sellers);
					response.sendRedirect("sellerLogin.jsp"); // 注册成功后重定向到 index.jsp 页面
					return; // 结束当前页面的执行
		        }
		    }
		    
	 	 %>
	</div>
</body>
</html>