<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.bean.Users" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="./static/css/myself.css">
	<script src="./static/javascript/myself.js"></script>
    <title>个人信息</title>
</head>
<body>
    <%  
    	request.setCharacterEncoding("UTF-8");
        String username = (String) session.getAttribute("username");
        Connection conn = DBUtil.getConnectDb();
        Users users = DBUtil.getUserByUsername(conn, username);
        
        String orders = users.getOrders();
        
        if (request.getParameter("updateUser") != null) {
            String updateUser = request.getParameter("updateUser");
            String newUsername = request.getParameter("username");
            String newPassword = request.getParameter("password");
            String newAddress = request.getParameter("address");
            String newPhone = request.getParameter("phone");
            
            // 更新用户信息
            DBUtil.updateUser(conn, updateUser, newUsername, newPassword, newAddress, newPhone);
             
            // 重新获取更新后的用户信息
            Users updatedUser = DBUtil.getUserByUsername(conn, newUsername);
            session.setAttribute("users", updatedUser);
            users = updatedUser; // 更新 users 变量的值
            
            //设置订单内容
            if (orders == null) {
                orders = "暂无订单";
            }
        }
    %>
    <h1>个人信息</h1>
    <p>用户名： <%= users.getUsername() %> </p>
    <p>密码： <%= users.getPassword() %> </p>
    <p>地址： <%= users.getAddress() %> </p>
    <p>电话： <%= users.getPhone() %> </p>
	<p>订单： <%= orders %> </p>
    
    <button id="modifyButton" onclick="showForm()">修改信息</button>
    
    <form id="userInfoForm" method="post" style="display: none;">
        <input type="hidden" name="updateUser" value="${users.getUsername()}">
        <label for="username">用户名：</label>
        <input type="text" id="username" name="username" value="<%= users.getUsername() %>" required><br>
        <label for="password">密码：</label>
        <input type="password" id="password" name="password" value="<%= users.getPassword() %>" required><br>
        <label for="address">地址：</label>
        <input type="text" id="address" name="address" value="<%= users.getAddress() %>" required><br>
        <label for="phone">电话：</label>
        <input type="text" id="phone" name="phone" value="<%= users.getPhone() %>" required><br>
        <button type="submit">确认修改</button>
    </form>
</body>
</html>
