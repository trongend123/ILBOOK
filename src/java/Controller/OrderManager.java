/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Customer;
import Model.Order;
import Model.OrderItem;
import Model.User;
import context.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/* @author ACER */
public class OrderManager extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String service = request.getParameter("service");
        OrderDAO od = new OrderDAO();
        if (service == null) {
            service = "Order Manager";
        }
        switch (service) {
            default:
                ArrayList<Order> orders = od.getAllOrder();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("/admin/ordermanager.jsp").forward(request, response);
                break;
            case "details":
                String oid = request.getParameter("oid");
                ArrayList<OrderItem> items = od.getItems(oid);
                Order order = od.getOrderById(oid);
                Customer customer = od.getCustomerByOrder(Integer.parseInt(oid));
                request.setAttribute("customer", customer);
                request.setAttribute("items", items);
                request.setAttribute("order", order);
                request.getRequestDispatcher("/admin/orderdetail.jsp").forward(request, response);
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("oid"));
                int istatus = Integer.parseInt(request.getParameter("status"));
                String status[] = {"Reject","Wait","Process","Done"};
                od.updateOrder(id, status[istatus]);
                response.sendRedirect("OrderManager");
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
