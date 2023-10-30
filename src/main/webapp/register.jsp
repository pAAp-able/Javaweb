<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.bean.Users" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="./static/css/reset.css">
<link rel="stylesheet" href="./static/css/normalize.css">
<link rel="stylesheet" href="./static/css/register.css">
<title>注册页面</title>
</head>
<body>
	<div></div>
	<h1>用户注册页面</h1>
	<form method="post">
		<p><span>用户名</span><input type ="text" name="username"></p>
		<p><span>电话号码</span><input type ="text" name="phone"></p>
		<p><span>密码</span><input type ="text" name="password"></p>
		<p><span>确认密码</span><input type="password" name="confirmPassword"></p>
		<input type ="submit" name="注册"><br>
	</form>
	
	<% 
	    Connection conn = DBUtil.getConnectDb();	    // 处理表单提交
	    if (request.getMethod().equalsIgnoreCase("post")) {
	        String username = request.getParameter("username");
	        String phone = request.getParameter("phone");
	        String password = request.getParameter("password");
	        String confirmPassword = request.getParameter("confirmPassword");
	        if (!password.equals(confirmPassword)) {
	            // 密码验证不通过
	            out.println("密码不匹配，请重新输入");
	            return; // 停止继续处理注册逻辑
	        }else{
				Users users = new Users(username, password, null,phone,null);
				DBUtil.addUser(conn,users);
				response.sendRedirect("login.jsp"); // 注册成功后重定向到 index.jsp 页面
				return; // 结束当前页面的执行
	        }
	    }
	    
 	 %>
</body>
</html>