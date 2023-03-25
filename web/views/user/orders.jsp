<%-- 
    Document   : products
    Created on : Jun 15, 2022, 10:56:23 AM
    Author     : ACER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Customer" %>
<%@page import="Model.Order" %>
<%@page import="context.OrderDAO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order History</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css"/></noscript>
        <% 
            if(session.getAttribute("user")==null){ 
                response.sendRedirect("./Home");
            }
        %>
    </head>
    <body class="is-preload">
        <!-- Wrapper -->
        <div id="wrapper">
            <!-- Header -->
            <header id="header">
                <div class="inner">
                    <!-- Logo -->
                    <a href="./Home" class="logo">
                        <span class="fa fa-book"></span>
                        <span class="title">IIBOOK</span>
                    </a>


                    <!-- Nav -->
                    <nav>
                        <ul>
                            <li><a href="#menu">Menu</a></li>
                        </ul>
                    </nav>
                </div>
            </header>

            <!-- Menu -->
            <nav id="menu">
                <h2><a href="./User" >${sessionScope.user==null? "Menu": ("Welcome ")}${sessionScope.user.getName()}</a></h2>
                <ul>
                    <li><a href="./Home">Home</a></li>

                    <li><a href="./Book?id=0">Bookshelf</a></li>

                    <li><a href="./Cart">Cart</a></li>


                    <li><a href="./Order">Order History</a></li>

                    <li><a href="about.jsp">About</a></li>

                    <li><a href="Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
                </ul>
            </nav>

            <!-- Main -->
            <div id="main">
                <div class="inner">
                    <h1>List My Orders</h1>

                    <div class="image main">
                        <img
                            src="images/banner-image-6-1920x500.jpg"
                            class="img-fluid"
                            alt=""
                            />
                    </div>

                    <table>
                        <tr>
                            <th>No.</th>
                            <th>Customer</th>
                            <th>Email</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Expected Delivery Time</th>
                            <th>Created Time</th>
                            <th>Details</th>
                        </tr>
                        <%  
                            int No = 1 ;
                            ArrayList<Order> orders = (ArrayList<Order>)request.getAttribute("orders");
                            OrderDAO od = new OrderDAO();
                            for(int i=0;i<orders.size();i++){
                                Order order = orders.get(i);
                                Customer customer= od.getCustomerByOrder(order.getId());
                        %>
                        <tr>
                            <td><%=No++%></td>
                            <td><%=customer.getName()%></td>
                            <td><%=customer.getEmail()%></td>
                            <td>$<%=order.getTotal()%></td>
                            <td><%=order.getStatus()%></td>
                            <td></td>
                            <td><%=order.getOrderdate()%></td>
                            <td><a href="Order?service=details&oid=<%=order.getId()%>" class="btn btn-outline-dark"><i class="fa fa-caret-right"></i></a></td>
                        </tr>
                        <%}%>
                    </table>
                </div>
            </div>

            <!-- Footer -->
            <footer id="footer">
                <div class="inner">
                    <section>
                        <h2>Contact Info</h2>
                        <ul class="alt">
                            <li>
                                <span class="fa fa-github"></span>
                                <a href="https://github.com/nekon0/IIBOOK">Our Project</a>
                            </li>
                            <li>
                                <span class="fa fa-map-pin"></span>
                                <a href="https://goo.gl/maps/ojwCjTqRteiA4B9U7">
                                    DE336, FBT University</a
                                >
                            </li>
                        </ul>
                    </section>
                    <ul class="copyright">
                        <li>@HLV</li>
                    </ul>
                </div>
            </footer>
        </div>

        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/jquery.scrollex.min.js"></script>
        <script src="assets/js/main.js"></script>
    </body>
</html>

