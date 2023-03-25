/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Book;
import Model.OrderItem;
import Model.User;
import context.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Enumeration;

/* @author ACER */
public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            String bookID = request.getParameter("bookID");
            if (service == null) { // call controller direct
                service = "showCart";
            }
            ArrayList<Book> books= new ArrayList<>();
            OrderDAO dao = new OrderDAO();
            HttpSession session = request.getSession();
            Enumeration em = session.getAttributeNames();
            switch (service) {
                default:
                    while (em.hasMoreElements()) {
                        try {
                            String key = em.nextElement().toString();
                            books.add((Book) session.getAttribute(key));
                        } catch (Exception e) {
                        }
                    }
                    request.setAttribute("books", books);
                    dispath(request, response, "/views/cart/cart.jsp");
                    break;
                case "addToCart":
                    Book book = (Book) session.getAttribute(bookID);
                    if (book == null) {
                        ResultSet rs = dao.getData("Select * from [Book] where [id]='" + bookID + "'");
                        if (rs.next()) {
                            String title = rs.getString(2);
                            String author = rs.getString(3);
                            float price = rs.getFloat(6);
                            boolean issale = rs.getBoolean(7);
                            int discount = rs.getInt(8);
                            String image = rs.getString(9);
                            book = new Book(Integer.parseInt(bookID), title, author, 1, price, issale, discount, image);
                        }
                    } else {
                        book.setQuantity(book.getQuantity() + 1);
                    }
                    session.setAttribute(bookID, book);
                    dispath(request, response, "index.jsp");
                    break;
                case "update":
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    book = (Book) session.getAttribute(bookID);
                    book.setQuantity(quantity);
                    while (em.hasMoreElements()) {
                        String key = em.nextElement().toString();
                        if (key.equals("user")) {
                            continue;
                        }
                        books.add((Book) session.getAttribute(key));
                    }
                    request.setAttribute("books", books);
                    dispath(request, response, "/views/cart/cart.jsp");
                    break;
                case "remove":
                    session.removeAttribute(bookID);
                    em = session.getAttributeNames();
                    while (em.hasMoreElements()) {
                        try {
                            String key = em.nextElement().toString();
                            books.add((Book) session.getAttribute(key));
                        } catch (Exception e) {
                        }
                    }
                    request.setAttribute("books", books);
                    dispath(request, response, "/views/cart/cart.jsp");
                    break;
//            case "removeAll":
//                while (em.hasMoreElements()) {
//                    try {
//                        String key = em.nextElement().toString();
//                        Titles get = (Titles) session.getAttribute(key);
//                        if (get != null) {
//                            session.removeAttribute(key);
//                        }
//                    } catch (Exception e) {
//                        continue;
//                    }
//                }
//                dispath(request, response, "./JSP/User/ShowCart.jsp");
//                break;
                case "Checkout":
                    User user = (User) session.getAttribute("user");
//                    if ("null".equals(user) || user == null || user.isEmpty()) {
                    if (user == null) {
                        response.sendRedirect("Login?origin=./Cart");
                    } else {
                        if (user.is_super()) {
                            request.setAttribute("error", "You are admin so you are not allow to buy anything! This is just for check");
                            response.sendRedirect("./Home");
                        } else {
                            String name = request.getParameter("fullname");
                            String email = request.getParameter("email");
                            String phone = request.getParameter("phone");
                            String address = request.getParameter("address");
                            String shipper = request.getParameter("shipper");
                            boolean checkcart=false;
                            while(em.hasMoreElements()){
                                try {
                                    String key = em.nextElement().toString();
                                    Book get = (Book) session.getAttribute(key);
                                    checkcart=true;
                                    break;
                                } catch (Exception e) {
                                    continue;
                                }
                            }
                            if(!checkcart){
                                request.setAttribute("error", "Please add book to cart first!");
                                request.setAttribute("books", books);
                                dispath(request, response, "/views/cart/cart.jsp");
                                return;
                            }
                            em = session.getAttributeNames();
                            int orderid = dao.addOrderGetId(user.getId(), LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME), shipper);
                            dao.addCustomer(orderid, user.getId(), name, email, phone, address);
                            while (em.hasMoreElements()) {
                                try {
                                    String key = em.nextElement().toString();
                                    Book get = (Book) session.getAttribute(key);
                                    OrderItem item = new OrderItem(orderid, Integer.parseInt(key), get.getTitle(), get.getQuantity(), get.getRealPrice());
                                    if (dao.addOrderItem(item) > 0) {
                                        session.removeAttribute(key);
                                    }
                                } catch (Exception e) {
                                    continue;
                                }
                            }
                            response.sendRedirect("./Order");
                        }
                    }
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void dispath(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher dispath = request.getRequestDispatcher(path);
        dispath.forward(request, response);
    }

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

    private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(path);
        rd.forward(request, response);
    }
}
