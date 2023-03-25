/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Book;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Random;

/* @author ACER */
public class BookDAO {

    public BookDAO() {
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

    public ArrayList<Book> getBooks() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [Book]";
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int quantity = rs.getInt(5);
                float price = rs.getFloat(6);
                boolean issale = rs.getBoolean(7);
                int discount = rs.getInt(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                list.add(new Book(id, title, author, type, quantity, price, issale, discount, image, description));
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return list;
    }

    public void editBook(int id, String title, String author, int categoryid, int quantity, float price, boolean issale, int discount, String image, String description) {
        String sql = "update [Book] set [title]= ?"
                + ", [author] = ? "
                + ", [categoryid] = ?"
                + ", [quantity] = ?"
                + ", [price] = ?"
                + ", [is_sale] = ?"
                + ", [discount] = ?"
                + ", [image] = ?"
                + ", [description] = ?"
                + " where [id] = ? ";
        try {
            PreparedStatement pre = cnn.prepareStatement(sql);
            pre.setString(1, title);
            pre.setString(2, author);
            pre.setString(3, (categoryid == 0 ? "NULL" : categoryid + ""));
            pre.setInt(4, quantity);
            pre.setFloat(5, price);
            pre.setBoolean(6, issale);
            pre.setInt(7, discount);
            pre.setString(8, image);
            pre.setString(9, description);
            pre.setInt(10, id);
            pre.executeUpdate();
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
    }

    public int addBook(String title, String author, int categoryid, int quantity, float price, boolean issale, int discount, String image, String description) {
        int n = 0;
//        try {
//            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String sql = "insert [Book] ( [title], [author], [categoryid], [quantity], [price], [is_sale], [discount], [image], [description])"
                + " values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
//            n = stm.executeUpdate(sql);
        try {
            PreparedStatement pre = cnn.prepareStatement(sql);
            pre.setString(1, title);
            pre.setString(2, author);
            pre.setString(3, (categoryid == 0 ? "NULL" : categoryid + ""));
            pre.setInt(4, quantity);
            pre.setFloat(5, price);
            pre.setBoolean(6, issale);
            pre.setInt(7, discount);
            pre.setString(8, image);
            pre.setString(9, description);
            n = pre.executeUpdate();
            return n;
        } catch (Exception e) {
            System.out.println("add Error:" + e.getMessage());
        }
        return n;
    }

    public Book getBookById(int bookid) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "update [Book] set [views] = [views]+1 where [id]=" + bookid;
            stm.executeUpdate(sql);
            sql = "select * from [Book] where [id] = " + bookid;
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int quantity = rs.getInt(5);
                float price = rs.getFloat(6);
                boolean issale = rs.getBoolean(7);
                int discount = rs.getInt(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                int views = rs.getInt(11);
                return new Book(id, title, author, type, quantity, price, issale, discount, image, description, views);
            }
        } catch (Exception e) {
            System.out.println("getBookbyID Error:" + e.getMessage());
        }
        return null;
    }

    public ArrayList<Book> getSimilarBooks(int bookid, int categoryid) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select top 3 * from [Book] where [categoryid] = " + categoryid + " AND [id] != " + bookid;
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int quantity = rs.getInt(5);
                float price = rs.getFloat(6);
                boolean issale = rs.getBoolean(7);
                int discount = rs.getInt(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                list.add(new Book(id, title, author, type, quantity, price, issale, discount, image, description));
            }
        } catch (Exception e) {
            System.out.println("getSimilar Error:" + e.getMessage());
        }
        return list;
    }

    public int getNumberBook() {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select count([id]) from [Book]";
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("getNumberBook Error");
        }
        return -1;
    }

    public ArrayList<Book> getFeaturedBooks() {
        ArrayList<Book> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [Book] where [is_sale] = 1";
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int quantity = rs.getInt(5);
                float price = rs.getFloat(6);
                boolean issale = rs.getBoolean(7);
                int discount = rs.getInt(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                list.add(new Book(id, title, author, type, quantity, price, issale, discount, image, description));
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        ArrayList<Book> lists = new ArrayList<>();
        Random r = new Random();
        int index[] = new int[3];
        int i = 0, temp;

        while (i < 3) {
            boolean is = true;
            temp = r.nextInt(list.size());
            for (int j = 0; j < i; j++) {
                if (index[j] == temp) {
                    is = false;
                }
            }
            if (is) {
                index[i] = temp;
                lists.add(list.get(temp));
                i++;
            }
        }
        return lists;
    }

    public ArrayList<Book> getByPage(ArrayList<Book> list, int start, int end) {
        ArrayList<Book> listpage = new ArrayList<>();

        for (int i = start; i < end; i++) {
            listpage.add(list.get(i));
        }
        return listpage;
    }

    public void deleteBook(int id) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "update [OrderItem] set [bookid] = NULL where [bookid]=" + id;
            stm.executeUpdate(sql);
            sql = "delete from [Book] where [id] = " + id;
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("del Error:" + e.getMessage());
        }
    }

    public ArrayList<Book> getBooksByCid(String cid) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [Book] where [categoryid] = " + cid;
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int quantity = rs.getInt(5);
                float price = rs.getFloat(6);
                boolean issale = rs.getBoolean(7);
                int discount = rs.getInt(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                list.add(new Book(id, title, author, type, quantity, price, issale, discount, image, description));
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return list;
    }

    public ArrayList<Book> searchBook(String search, int cid) {
        ArrayList<Book> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql;
            if (cid != 0) {
                sql = "select * from [Book] where [categoryid] = " + cid + " AND [title] like '%" + search + "%'";
            } else {
                sql = "select * from [Book] where [title] like '%" + search + "%'";
            }
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int type = rs.getInt(4);
                int quantity = rs.getInt(5);
                float price = rs.getFloat(6);
                boolean issale = rs.getBoolean(7);
                int discount = rs.getInt(8);
                String image = rs.getString(9);
                String description = rs.getString(10);
                list.add(new Book(id, title, author, type, quantity, price, issale, discount, image, description));
            }
        } catch (Exception e) {
            System.out.println("getlist Error:" + e.getMessage());
        }
        return list;
    }
}
