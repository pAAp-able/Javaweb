package com.bean;

public class Users {
	private String username;
	private String password;
	private String address;
	private String phone;
	private String orders;
	private int id;

	
	public Users(String username, String password, String address, String phone, String orders) {
	    this.username = username;
	    this.password = password;
	    this.phone = phone;
	    this.orders = orders;
	    this.address = address;
	}
	 public String getUsername() {
		 return username;
	 }
	 public String getPassword() {
		 return password;
	 }
	 public int getId() {
		 return id;
	 }
	 public String getPhone() {
		 return phone;
	 }
	 public String getOrders() {
		 return orders;
	 }
	 public String getAddress() {
		 return address;
	 }
	 public void setUsername(String username) {
		 this.username=username;
	 }
	 public void setPassword(String password) {
		 this.password=password;
	 }
	 public void setPhone(String phone) {
		 this.phone=phone;
	 }
	 public void setOrders(String orders) {
		 this.orders=orders;
	 }
	 public void setAddress(String address) {
		 this.address=address;
	 }
}
