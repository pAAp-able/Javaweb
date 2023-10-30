/**
 * 
 */
function confirmOrder(event) {
	event.preventDefault(); // 阻止表单的默认提交行为
	var confirmed = confirm("请确认您的个人信息是否正确？");
	if (confirmed) {
		// 执行订单提交操作
		window.location.href = "index.jsp"; // 替换成订单提交成功页面的URL
		sessionStorage.setItem("goodsname", "<%= goodsname %>");
  		sessionStorage.setItem("quantity", "<%= quantity %>");
	} 
}