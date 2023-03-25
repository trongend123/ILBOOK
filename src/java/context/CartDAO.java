/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Book;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/* @author ACER */
public class CartDAO {

    public CartDAO() {
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

    public void addToCart(int userid, int bookid, int quantity) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String check = "select * from [Cart] where bookid=" + bookid
                    + "AND userid =" + userid;
            rs = stm.executeQuery(check);
            if (!rs.next()) {
                String sql = "insert [Cart] ([userid],[bookid],[quantity]) values"
                        + "(" + userid + ", " + bookid + ", " + quantity + ")";
                stm.executeUpdate(sql);
            }else{
                String sql = "update [Cart] "
                        + "set quantity = quantity + " + quantity
                        + "where bookid = " + bookid + "AND userid ="+userid;
                stm.executeUpdate(sql);
            }
        } catch (Exception e) {
            System.out.println("addtoCart Error:" + e.getMessage());
        }
    }

    public void addToCart(int bookid, int quantity) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String check = "select * from [Cart] where bookid=" + bookid
                    + "AND userid is NULL";
            rs = stm.executeQuery(check);
            if (!rs.next()) {
                String sql = "insert [Cart] ([bookid],[quantity]) values"
                        + "(" + bookid + ", " + quantity + ")";
                stm.executeUpdate(sql);
            } else {
                String sql = "update [Cart] "
                        + "set quantity = quantity + " + quantity
                        + "where bookid = " + bookid + "AND userid is Null";
                stm.executeUpdate(sql);
            }
        } catch (Exception e) {
            System.out.println("addtoCart Error:" + e.getMessage());
        }
    }

    public ArrayList<Book> getCart(int userid) {
        ArrayList<Book> list = new ArrayList<>();
        try{
            stm= cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            String sql="select b.[id], b.[title], b.[author], c.[quantity], b.[price], b.[is_sale], b.[discount], b.[image] from [Book] b, [Cart] c where c.[userid]="+userid+""
                    + "AND b.[id] = c.[bookid]";
            rs = stm.executeQuery(sql);
            while(rs.next()){
                int id = rs.getInt(1);
                String title = rs.getString(2);
                String author = rs.getString(3);
                int quantity = rs.getInt(4);
                float price = rs.getFloat(5);
                boolean issale = rs.getBoolean(6);
                int discount = rs.getInt(7);
                String image = rs.getString(8);
                list.add(new Book(id, title, author, 0, quantity, price, issale, discount, image, null));
            }
        }catch(Exception e){
            System.out.println("getCart Error:"+e.getMessage());
        }
        return list;
    }

}
