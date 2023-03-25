/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package context;

import Model.Category;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/* @author ACER */
public class CategoryDAO {

    public CategoryDAO() {
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

    public int addCategory(String name) {
        int n = 0;
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "insert [Category] ([name]) values (N'" + name + "')";
            n = stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("add Error:" + e.getMessage());
        }
        return n;
    }

    public void editCategory(int id, String editName) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "update [Category] set [name]=N'"+editName+"' where [id]="+id;
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("edit Error:" + e.getMessage());
        }
    }

    public void delCategory(int id) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "update [Book] set [categoryid] = NULL where [categoryid]=" + id;
            stm.executeUpdate(sql);
            sql = "delete from [Category] where [id] = " + id;
            stm.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("del Error:" + e.getMessage());
        }
    }

    public ArrayList<Category> getCategories() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select * from [Category]";
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                list.add(new Category(id, name));
            }
        } catch (Exception e) {
            System.out.println("getCategories Error:" + e.getMessage());
        }
        return list;
    }

    public String getCategory(int id) {
        try {
            stm = cnn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String sql = "select [name] from [Category] where [id] ="+id;
            rs = stm.executeQuery(sql);
            if(rs.next()){
            return rs.getString(1);}
        } catch (Exception e) {
            System.out.println("getCategories Error:" + e.getMessage());
            return null;
        }
        return null;
    }

}
