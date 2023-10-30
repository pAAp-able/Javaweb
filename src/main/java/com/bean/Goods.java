package com.bean;

public class Goods {
	private byte[] img;
	private String goodsname;
	private String describe;
	private String producer;
	private int id;
	private float price;
	private int account;
	
	public Goods(String goodsname, float price, int account, String producer, String describe,byte[] img) {
	    this.goodsname = goodsname;
	    this.price = price;
	    this.account = account;
	    this.producer = producer;
	    this.describe = describe;
	    this.img = img;
	}
	public Goods(int id,String goodsname, float price, int account, String producer, String describe,byte[] img) {
		this.id = id;
	    this.goodsname = goodsname;
	    this.price = price;
	    this.account = account;
	    this.producer = producer;
	    this.describe = describe;
	    this.img = img;
	}
	 public String getGoodsname() {
		 return goodsname;
	 }
	 public String getProducer() {
		 return producer;
	 }
	 public String getDescribe() {
		 return describe;
	 }
	 public float getPrice() {
		 return price;
	 }
	 public int getAccount() {
		 return account;
	 }
	 public byte[] getImg() {
		 return img;
	 }
	 public int getId() {
		 return id;
	 }
	 public void setGoodsname(String goodsname) {
		 this.goodsname=goodsname;
	 }
	 public void setProducer(String producer) {
		 this.producer=producer;
	 }
	 public void setDescribe(String describe) {
		 this.describe=describe;
	 }
	 public void setPrice(float price) {
		 this.price=price;
	 }
	 public void setAccount(int account) {
		 this.account=account;
	 }
	 public void setImg(byte[] img) {
		 this.img=img;
	 }
	 public void setId(int id) {
		 this.id=id;
	 }

	 
	
}
