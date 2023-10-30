package com.bean;

public class Orders {
	private String username;
	private String producer;
	private String goodsname;
	private String status;
	private String payment;
	private int number;
	private int id;
	
	//用户点击添加购物车页面（默认未发货 未付款）
	public Orders(String username, String producer, String goodsname, int number) {
	    this.username = username;
	    this.goodsname = goodsname;
	    this.producer = producer;
	    this.status = "未发货"; // 默认值为"未发货"
	    this.payment = "未付款";
	    this.number = number;
	}
	
	//用户点击立即购买(会将付款状态修改为已付款)
	public Orders(String username, String producer, String goodsname, int number,String payment) {
	    this.username = username;
	    this.goodsname = goodsname;
	    this.producer = producer;
	    this.status = "未发货"; // 默认值为"未发货"
	    this.number = number;
	    this.payment = payment;
	}
	
	//商家获取到的订单信息，包括付款状态和物流
	public Orders(String username, String producer, String goodsname, String status, String payment,int number) {
	    this.username = username;
	    this.goodsname = goodsname;
	    this.producer = producer;
	    this.status = status;
	    this.number = number;
	    this.payment = payment;
	}
	public Orders(int id,String username, String producer, String goodsname, String status, String payment,int number) {
		this.id = id;
	    this.username = username;
	    this.goodsname = goodsname;
	    this.producer = producer;
	    this.status = status;
	    this.number = number;
	    this.payment = payment;
	}
	 public String getUsername() {
		 return username;
	 }
	 public String getProducer() {
		 return producer;
	 }
	 public String getPayment() {
		 return payment;
	 }
	 public String getGoodsname() {
		 return goodsname;
	 }
	 public String getStatus() {
		 return status;
	 }
	 public int getId() {
		 return id;
	 }
	 public int getNumber() {
		 return number;
	 }
	 public void setPayment(String payment) {
		 this.payment=payment;
	 }
	 public void setUsername(String username) {
		 this.username=username;
	 }
	 public void setProducer(String producer) {
		 this.producer=producer;
	 }
	 public void setGoodsname(String goodsname) {
		 this.goodsname=goodsname;
	 }
	 public void setStatus(String status) {
		 this.status=status;
	 }
	 public void setNumber(int number) {
		 this.number=number;
	 }
	 public void setId(int id) {
		 this.id=id;
	 }
}
