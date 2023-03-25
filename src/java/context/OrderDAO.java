/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Customer;
import Model.Order;
import Model.OrderItem;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/* @author ACER */
public class OrderDAO {

    public OrderDAO() {
        connectDB();
    }

    Connection cnn; // ket noi db
    Statement stm; // thuc thi cac cau lenh sql
    ResultSet rs; // luu tru va xu ly du lieu

    private void connectDB() {
        try {
            cnn = (new DBContext().getConnection());
            System.out.println("Connect successfully!");
        } catch (Exception e) {
            System.out.println("Connect error:" + e.getMessage());
        }
    }

    public ResultSet getData(String sql) {
        rs = null;
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = stm.executeQuery(sql);
        } catch (SQLException e) {
            System.out.println("getData error:" + e.getMessage());
        }
        return rs;
    }

    public int addOrderGetId(int id, String sorderdate, String shipper) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "insert [Order] ([userid],[orderdate],[shipper],[status]) values"
                    + "(" + id + ", '" + sorderdate + "','" + (shipper.equals("fast") ? "Fast Delivery" : "Free Delivery") + "', 'Wait')";
            stm.executeUpdate(sql);
            rs = stm.executeQuery("select top 1 * from [Order] where userid =" + id + " order by [id] desc");
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("addOrder error:" + e.getMessage());
        }
        return -1;
    }

    public int addOrderItem(OrderItem item) {
        int n = 0;
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "insert [OrderItem] ([orderid],[bookid],[itemname],[quantity],[price]) values"
                    + "(" + item.getOrderid() + ", " + item.getBookid() + ", N'" + item.getItemname() + "', " + item.getQuantity() + ", " + item.getPrice() + ")";
            n = stm.executeUpdate(sql);
        } catch (SQLException e) {
            System.out.println("addOrderItem error:" + e.getMessage());
        }
        return n;
    }

    public ArrayList<Order> getUserOrders(int userid) {
        ArrayList<Order> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [Order] where [userid] = " + userid;
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                SimpleDateFormat f = new SimpleDateFormat("dd/MM/yyyy");
                int id = rs.getInt(1);
                String orderdate = f.format(rs.getDate(3));
                float subtotal = rs.getFloat(4);
                String shipper = rs.getString(5);
                float total = rs.getFloat(6);
                String status = rs.getString(7);
                list.add(new Order(id, userid, orderdate, subtotal, shipper, total, status));
            }
        } catch (Exception e) {
            System.out.println("getSimilar Error:" + e.getMessage());
        }
        return list;
    }

    public int addCustomer(int orderid, int userid, String name, String email, String phone, String address) {
        int n = 0;
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "insert [Customer] ([orderid], [userid], [name], [email], [phone], [address]) "
                    + "values (" + orderid + ", " + userid + ", N'" + name + "', N'" + email + "', N'" + phone + "', N'" + address + "')";
            n = stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("getSimilar Error:" + e.getMessage());
        }
        return n;
    }

    public int getNumberOrder() {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select count([id]) from [Order]";
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("getNumberOrder Error");
        }
        return -1;
    }

    public float getEarning() {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select sum(total) from [Order] where [status] = 'Done'";
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return rs.getFloat(1);
            }
        } catch (Exception e) {
            System.out.println("getNumberOrder Error");
        }
        return -1;
    }

    public ArrayList<OrderItem> getItems(String orderid) {
        ArrayList<OrderItem> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [OrderItem] where [orderid]=" + orderid;
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int bid = rs.getInt(2);
                String itemname = rs.getString(3);
                int quantity = rs.getInt(4);
                float price = rs.getFloat(5);
                list.add(new OrderItem(Integer.parseInt(orderid), bid, itemname, quantity, price));
            }
        } catch (Exception e) {
            System.out.println("getNumberOrder Error");
        }
        return list;
    }

    public Order getOrderById(String oid) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [Order] where [id]=" + oid;
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                int uid = rs.getInt(2);
                SimpleDateFormat f = new SimpleDateFormat("dd/MM/yyyy");
                String orderdate = f.format(rs.getDate(3));
                float subtotal = rs.getFloat(4);
                String shipper = rs.getString(5);
                float total = rs.getFloat(6);
                String status = rs.getString(7);
                return new Order(Integer.parseInt(oid), uid, orderdate, subtotal, shipper, total, status);
            }
        } catch (Exception e) {
            System.out.println("getNumberOrder Error");
        }
        return null;
    }

    public Customer getCustomerByOrder(int oid) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [Customer] where [orderid]=" + oid;
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                String name = rs.getString(4);
                String email = rs.getString(5);
                String phone = rs.getString(6);
                String address = rs.getString(7);
                return new Customer(name, email, phone, address);
            }
        } catch (Exception e) {
            System.out.println("getNumberOrder Error");
        }
        return null;
    }

    public ArrayList<Order> getAllOrder() {
        ArrayList<Order> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [Order]";
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                SimpleDateFormat f = new SimpleDateFormat("dd/MM/yyyy");
                int id = rs.getInt(1);
                int userid = rs.getInt(2);
                String orderdate = f.format(rs.getDate(3));
                float subtotal = rs.getFloat(4);
                String shipper = rs.getString(5);
                float total = rs.getFloat(6);
                String status = rs.getString(7);
                list.add(new Order(id, userid, orderdate, subtotal, shipper, total, status));
            }
        } catch (Exception e) {
            System.out.println("getSimilar Error:" + e.getMessage());
        }
        return list;
    }

    public void updateOrder(int id, String status) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "update [Order] set  [status] = '"+status+"' "
                    + "where [id]="+id;
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("getSimilar Error:" + e.getMessage());
        }
    }
}
