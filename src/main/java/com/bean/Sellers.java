package com.bean;

public class Sellers {
	private int id;
	private String sellername;
	private String sellerphone;
	private String sellerpassword;
	private float turnover;
	
	public Sellers(String sellername, String sellerphone, String sellerpassword, float turnover) {
	    this.sellername = sellername;
	    this.sellerphone = sellerphone;
	    this.sellerpassword = sellerpassword;
	    this.turnover = turnover; 
	}
	//商家注册页面给商家添加信息
	public Sellers(String sellername, String sellerphone, String sellerpassword) {
	    this.sellername = sellername;
	    this.sellerphone = sellerphone;
	    this.sellerpassword = sellerpassword;
	}
	 public String getSellername() {
		 return sellername;
	 }
	 public String getSellerphone() {
		 return sellerphone;
	 }
	 public String getSellerpassword() {
		 return sellerpassword;
	 }	 
	 public float getTurnover() {
		 return turnover;
	 }
	 public int getId() {
		 return id;
	 }
	 public void setSellername(String sellername) {
		 this.sellername=sellername;
	 }
	 public void setSellerphone(String sellerphone) {
		 this.sellerphone=sellerphone;
	 }
	 public void setSellerpassword(String sellerpassword) {
		 this.sellerpassword=sellerpassword;
	 }
	 public void setTurnover(float turnover) {
		 this.turnover=turnover;
	 }
	 
}
