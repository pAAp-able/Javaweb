package com.util;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import com.bean.Users;
import com.bean.Goods;
import com.bean.Orders;
import com.bean.Sellers;
import java.sql.Blob;
import java.util.Base64;
import java.util.Base64.Decoder;



import java.util.ArrayList;

public class DBUtil {
	public Connection conn;
    public PreparedStatement statement;
    
	public static String username = "root";
	public static String password = "123456";
	public static String database = "text5";
	
	public static String url = "jdbc:mysql://localhost:3306/"+database+"?user=root&characterEncoding=UTF-8";
	
    static{
        try {
            // 加载驱动
        	Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnectDb() {
    	Connection conn = null;
    	try{
    		conn = DriverManager.getConnection(url,username,password);
    		System.out.print("数据库连接成功");
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    	return conn;
    }
    //关闭数据库
    public static void CloseDB(ResultSet rs, PreparedStatement stm,Connection conn) {
    	if(rs!=null) {
    		try {
    			rs.close();
    		} catch(SQLException e) {
        		e.printStackTrace();
        	}
    	}
    	if(stm!=null) {
    		try {
    			stm.close();
    		} catch(SQLException e) {
        		e.printStackTrace();
        	}
    	}	
    	if(conn!=null) {
    		try {
    			conn.close();
    		} catch(SQLException e) {
        		e.printStackTrace();
        	}
    	}
    }
    //将字节数组转换为Base64编码
    public static String ImageToBase64(byte[] imageBytes) {
        return Base64.getEncoder().encodeToString(imageBytes);
    }
    //添加用户数据
    public static void addUser(Connection conn, Users user) {
        String sql = "INSERT INTO users (username, password, address,phone,orders) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getAddress());
            statement.setString(4, user.getPhone());
            statement.setString(5, user.getOrders());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //添加商家数据数据
    public static void addSeller(Connection conn, Sellers sellers) {
        String sql = "INSERT INTO sellers (sellername, sellerpassword,sellerphone) VALUES (?, ?, ?)";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, sellers.getSellername());
            statement.setString(2, sellers.getSellerpassword());
            statement.setString(3, sellers.getSellerphone());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //通过商品id获取商品信息
    public static Goods getGoodsById(Connection conn, int id) {
        Goods goods = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM goods WHERE id = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            rs = statement.executeQuery();
            if (rs.next()) {
            	int newid = rs.getInt("id");
            	String goodsname = rs.getString("goodsname");
                float price = rs.getFloat("price");
                int account = rs.getInt("account");
                String producer = rs.getString("producer");
                String describe = rs.getString("describe");
                Blob imgBlob = rs.getBlob("img");
                byte[] imgBytes = imgBlob.getBytes(1, (int) imgBlob.length());
                goods = new Goods(newid,goodsname, price,account,producer,describe,imgBytes);
            }
            else {
                System.out.println("找不到要修改的商品，ID：" + id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseDB(rs, statement, null);
        }
        return goods;
    }
    //通过店铺名称获取到商家信息
    public static Sellers getSellersBySellername(Connection conn, String sellername) {
        Sellers seller = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM sellers WHERE sellername = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, sellername);
            rs = statement.executeQuery();
            if (rs.next()) {
                String foundSellername = rs.getString("sellername");
                String sellerpassword = rs.getString("sellerpassword");
                String sellerphone = rs.getString("sellerphone");
                float turnover = rs.getFloat("turnover");
                seller = new Sellers(foundSellername, sellerphone, sellerpassword,turnover);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseDB(rs, statement, null);
        }
        return seller;
    }
    //通过手机号码获取用户信息
    public static Users getUserByPhone(Connection conn, String phone) {
        Users user = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE phone = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, phone);
            rs = statement.executeQuery();
            if (rs.next()) {
                String foundUserphone = rs.getString("phone");
                String address = rs.getString("address");
                String password = rs.getString("password");
                String username = rs.getString("username");
                String orders = rs.getString("orders");
                user = new Users(username, password, address,foundUserphone,orders);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseDB(rs, statement, null);
        }
        return user;
    }
    //根据订单id获取订单信息
    public static Orders getOrderById(Connection conn, int id) {
        Orders order = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM orders WHERE id = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            rs = statement.executeQuery();
            if (rs.next()) {
                String producer = rs.getString("producer");
                String goodsname = rs.getString("goodsname");
                String status = rs.getString("status");
                String username = rs.getString("username");
                String payment = rs.getString("payment");
                int number = rs.getInt("number");
                order = new Orders(username,producer, goodsname, status, payment,number);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseDB(rs, statement, null);
        }
        return order;
    }
    //通过用户名获取用户信息
    public static Users getUserByUsername(Connection conn, String username) {
        Users user = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            rs = statement.executeQuery();
            if (rs.next()) {
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String password = rs.getString("password");
                String foundusername = rs.getString("username");
                String orders = rs.getString("orders");
                user = new Users(foundusername, password, address,phone,orders);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseDB(rs, statement, null);
        }
        return user;
    }
    //通过商品名称获取商品信息(1个)
    public static Goods getGoodsByGoodsname(Connection conn, String goodsname) {
        Goods goods = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM goods WHERE goodsname = ?";
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, goodsname);
            rs = statement.executeQuery();
            if (rs.next()) {
            	String foundgoodsname = rs.getString("goodsname");
                float price = rs.getFloat("price");
                int account = rs.getInt("account");
                String producer = rs.getString("producer");
                String describe = rs.getString("describe");
                Blob imgBlob = rs.getBlob("img");
                byte[] imgBytes = imgBlob.getBytes(1, (int) imgBlob.length());
                goods = new Goods(foundgoodsname, price,account,producer,describe,imgBytes);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            CloseDB(rs, statement, null);
        }
        return goods;
    }
    //获取所有商品信息
    public static List<Goods> getAllGoods(Connection conn) {
    	List<Goods> goodsList = new ArrayList<>();
        Statement stat = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM goods";
        try {
            stat = conn.createStatement();
            rs = stat.executeQuery(sql);
            while (rs.next()) {
            	int account = rs.getInt("account");
                String goodsname = rs.getString("goodsname");
                String producer = rs.getString("producer");
                String describe = rs.getString("describe");
                float price = rs.getFloat("price");
                
                Blob imgBlob = rs.getBlob("img");
                byte[] imgBytes = imgBlob.getBytes(1, (int) imgBlob.length());
                String imgBase64 = ImageToBase64(imgBytes);
                Decoder decoder = Base64.getDecoder();
                byte[] imgData = decoder.decode(imgBase64);
                
                Goods goods = new Goods(goodsname, price,account,producer,describe,imgData); // 根据实际情况创建 User 对象
                goodsList.add(goods);
                }
                
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return goodsList;
    }
    //更新修改个人信息
    public static void updateUser(Connection conn, String username, String newUsername, String newPassword, String newAddress, String newPhone) {
        String sql = "UPDATE users SET username = ?, password = ?, address = ?, phone = ? WHERE username = ?";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, newUsername);
            statement.setString(2, newPassword);
            statement.setString(3, newAddress);
            statement.setString(4, newPhone);
            statement.setString(5, username);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //更新个人订单信息
    public static void updateUserOrder(Connection conn,String username,String info) {
    	 String sql = "UPDATE users SET orders = CONCAT(orders, ',', ?) WHERE username = ?";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1,info );
            statement.setString(2, username);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //更新修改商品信息根据id
    public static void updateGoodsById(Connection conn, int id, String goodsname, float price, int account, String describe) {
        String sql = "UPDATE goods SET goodsname = ?, price = ?, account = ?, `describe` = ? WHERE id = ?";
       	 
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, goodsname);
            statement.setFloat(2, price);
            statement.setInt(3, account);
            statement.setString(4, describe);
            statement.setInt(5, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //根据订单ID来更新修改订单信息
    public static void updateOrdersById(Connection conn, int id, String producer, int number, String goodsname, String username,String status,String payment) {
        String sql = "UPDATE orders SET producer = ?, number = ?, goodsname = ?, username = ?,status = ?,payment = ? WHERE id = ?"; 
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, producer);
            statement.setInt(2, number);
            statement.setString(3, goodsname);
            statement.setString(4, username);
            statement.setString(5, status);
            statement.setString(6, payment);
            statement.setInt(7, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //从付款页面给Orders表添加信息
    public static void addOrders(Connection conn, String username, String goodsname, String producer,String payment, int number) {
        String sql = "INSERT INTO `orders` (username, goodsname, producer,payment, number) VALUES (?, ?, ?, ?,?)";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, goodsname);
            statement.setString(3, producer);
            statement.setString(4, payment);
            statement.setInt(5, number);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //从首页点击添加购物车给Orders添加信息
    public static void addOrder(Connection conn, String username, String goodsname, String producer, int number) {
        String sql = "INSERT INTO `orders` (username, goodsname, producer, number) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, goodsname);
            statement.setString(3, producer);
            statement.setInt(4, number);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //根据用户名与付款信息从Orders中获取商品名称和数量(所有信息)--(用户端)
    public static List<Orders> getOrderByName(Connection conn,String username,String payment) {
        List<Orders> ordersList = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM orders WHERE username = ? and payment = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, payment);
            rs = ps.executeQuery();
            while (rs.next()) {
            	int id = rs.getInt("id");
            	String newusername = rs.getString("username");
                String goodsname = rs.getString("goodsname");
                String producer = rs.getString("producer");
                String status = rs.getString("status");
                int number = rs.getInt("number");
                String newpayment = rs.getNString("payment");
                Orders order = new Orders(id,newusername, producer, goodsname, status, newpayment, number);
                ordersList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ordersList;
    }
    //根据商品名称从goods中获取商品信息（多个）
    public static List<Goods> getGoodsBygoodsname(Connection conn,String goodsname) {
    	List<Goods> goodsList = new ArrayList<>();
    	PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM goods where goodsname = ? ";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, goodsname);
            rs = ps.executeQuery();
            while (rs.next()) {
            	int account = rs.getInt("account");
                String newGoodsname = rs.getString("goodsname");
                String producer = rs.getString("producer");
                String describe = rs.getString("describe");
                float price = rs.getFloat("price");
                
                Blob imgBlob = rs.getBlob("img");
                byte[] imgBytes = imgBlob.getBytes(1, (int) imgBlob.length());
                String imgBase64 = ImageToBase64(imgBytes);
                Decoder decoder = Base64.getDecoder();
                byte[] imgData = decoder.decode(imgBase64);
                
                Goods goods = new Goods(newGoodsname, price,account,producer,describe,imgData); // 根据实际情况创建 User 对象
                goodsList.add(goods);
                }
                
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return goodsList;
    }
    //根据店铺名称从goods获取表中商品信息
    public static List<Goods> getGoodsBysellersname(Connection conn,String producer) {
    	List<Goods> goodsList = new ArrayList<>();
    	PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM goods where producer = ? ";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, producer);
            rs = ps.executeQuery();
            while (rs.next()) {
            	int id = rs.getInt("id");
            	int account = rs.getInt("account");
                String goodsname = rs.getString("goodsname");
                String newProducer = rs.getString("producer");
                String describe = rs.getString("describe");
                float price = rs.getFloat("price");
                
                Blob imgBlob = rs.getBlob("img");
                byte[] imgBytes = imgBlob.getBytes(1, (int) imgBlob.length());
                String imgBase64 = ImageToBase64(imgBytes);
                Decoder decoder = Base64.getDecoder();
                byte[] imgData = decoder.decode(imgBase64);
                
                Goods goods = new Goods(id,goodsname, price,account,newProducer,describe,imgData); // 根据实际情况创建 User 对象
                goodsList.add(goods);
                }
                
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return goodsList;
    }
    //根据店铺名称从orders表中获取订单信息
    public static List<Orders> getOrdersBysellersname(Connection conn,String producer) {
    	List<Orders> ordersList = new ArrayList<>();
    	PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM orders where producer = ? ";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, producer);
            rs = ps.executeQuery();
            while (rs.next()) {
            	int id = rs.getInt("id");
            	String newProducer = rs.getString("producer");
            	int number = rs.getInt("number");
            	String goodsname = rs.getString("goodsname");
            	String username = rs.getString("username");
            	String status = rs.getString("status");
            	String payment = rs.getString("payment");
     
                Orders orders = new Orders(id,username, newProducer,goodsname,status,payment,number); // 根据实际情况创建 User 对象
                ordersList.add(orders);
                }
                
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ordersList;
    }
    //根据商品名称和店铺名称从goods中获取信息------------------
    public static List<Goods> getGoodsBysellersAndGoods(Connection conn,String producer,String goodsname) {
    	List<Goods> goodsList = new ArrayList<>();
    	PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM goods where producer = ? and goodsname = ? ";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, producer);
            ps.setString(2, goodsname);
            rs = ps.executeQuery();
            while (rs.next()) {
            	int account = rs.getInt("account");
                String newgoodsname = rs.getString("goodsname");
                String newProducer = rs.getString("producer");
                String describe = rs.getString("describe");
                float price = rs.getFloat("price");
                
                Blob imgBlob = rs.getBlob("img");
                byte[] imgBytes = imgBlob.getBytes(1, (int) imgBlob.length());
                String imgBase64 = ImageToBase64(imgBytes);
                Decoder decoder = Base64.getDecoder();
                byte[] imgData = decoder.decode(imgBase64);
                
                Goods goods = new Goods(newgoodsname, price,account,newProducer,describe,imgData); // 根据实际情况创建 User 对象
                goodsList.add(goods);
                }
                
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return goodsList;
    }
    //根据商品ID删除商品信息
    public static void deleteGoodsById(Connection conn,int id) {
        String sql = "DELETE FROM goods WHERE id = ?";

        try {
        	PreparedStatement statement = conn.prepareStatement(sql);
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
