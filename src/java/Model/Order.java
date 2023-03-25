/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Model;

import context.UserDAO;

/* @author ACER */
public class Order {
    private int id;
    private int userid;
    private String orderdate;
    private float subtotal;
    private float total;
    private String shipper;
    private String status;

    public Order(int id, int userid, String orderdate, float subtotal, String shipper, float total, String status) {
        this.id = id;
        this.userid = userid;
        this.orderdate = orderdate;
        this.subtotal = subtotal;
        this.total = total;
        this.shipper = shipper;
        this.status = status;
    }

    public Order(int userid, String orderdate) {
        this.userid = userid;
        this.orderdate = orderdate;
        this.status = "Wait";
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getOrderdate() {
        return orderdate;
    }

    public void setOrderdate(String orderdate) {
        this.orderdate = orderdate;
    }

    public float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getShipper() {
        return shipper;
    }

    public void setShipper(String shipper) {
        this.shipper = shipper;
    }
    
    public String getUsername(){
        UserDAO dao = new UserDAO();
        return dao.getUsername(this.userid);
    }
}
