<%-- 
    Document   : checkout
    Created on : Jun 15, 2022, 11:01:33 AM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Book"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
        <style>
            table th{
                font-size: 1em;
                padding: 0.75em;
                text-align: left;
            }
            table td{
                vertical-align: middle;
            }
            img{
                border: 1px solid black;
                border-radius: 1px;
            }
        </style>
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

            <% 
                if(session.getAttribute("user")==null){ 
            %>
            <li><a href="about.jsp">About</a></li>
            
        <li><a href="Login?origin=./Cart"><i class="fa fa-sign-in"></i>Login</a></li>
            <% } else{ %>
        <li><a href="./Order">Order History</a></li>
        
        <li><a href="about.jsp">About</a></li>
        
        <li><a href="Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
            <% }%>
    </ul>
</nav>

            <!-- Main -->
            <div id="main">
                <div class="inner">
                    <h1>Checkout</h1>
                    <h2><i>${error}</i></h2>
                    <table>
                        <tr>
                            <th style="width: 100px;">Image</th>
                            <th style="width: 400px;">Title</th>
                            <th style="width: 200px;">Author</th>
                            <th style="width: 150px;">Price</th>
                            <th style="width: 100px;">Quantity</th>
                            <th style="width: 150px;">Total Price</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <% 
                            float totalOrder = 0; 
                            ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("books");
                            for(int i=0; i<books.size();i++){
                                totalOrder += books.get(i).getRealPrice()*books.get(i).getQuantity();
                            }
                        %>

                        <c:forEach items="${books}" var="book">
                            <form method="post" action="Cart">
                                <input type="hidden" name="bookID" value="${book.getId()}">
                                <tr>
                                    <th><img src="${book.getImage()}" alt="alt" style="width: 75px;"/></th>
                                    <td>${book.getTitle()}</td>
                                    <td>${book.getAuthor()}</td>
                                    <td>$${Math.round(book.getRealPrice()*100)/100}</td>
                                    <td><input type="number" name="quantity" min="1" value="${book.getQuantity()}" class="bg-transparent form-control"></td>
                                    <td>$${Math.round(book.getRealPrice()*book.getQuantity()*100)/100}</td>
                                    <td><button type="submit" name="service" value="update"><i class="fa fa-refresh"></i></button></td>
                                    <td><button type="submit" name="service" value="remove"><i class="fa fa-remove"></i></button></td>
                                </tr>
                            </form>
                        </c:forEach>
                        <tr>
                            <th colspan="5" style="text-align: center;">Total order</th>
                            <th colspan="3">$<%=Math.round(totalOrder*100)/(float)100%></th>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Footer -->
            <footer id="footer">
                <div class="inner">
                    <section>
                        <form method="post" action="Cart">
                            <div class="fields">
                                <div class="field">
                                    <input type="text" name="fullname" id="field-2" placeholder="Name" value="${sessionScope.user.getName()}" ${user==null?"":"required"}>
                                </div>

                                <div class="field">
                                    <input type="text" name="email" id="field-3" placeholder="Email" value="${sessionScope.user.getEmail()}" ${user==null?"":"required"}>
                                </div>

                                <div class="field">
                                    <input type="text" name="phone" id="field-4" placeholder="Phone" value="${sessionScope.user.getPhone()}" ${user==null?"":"required"}>
                                </div>

                                <div class="field">
                                    <input type="text" name="address" id="field-5" placeholder="Address" value="${sessionScope.user.getAddress()}" ${user==null?"":"required"}>
                                </div>

                                <div class="field half">

                                    <select name="shipper" ${user==null?"":"required"}>
                                        <option value="">-- Choose Delivery Method--</option>
                                        <option value="fast"> Fast Delivery - $1.5</option>
                                        <option value="free"> Free Delivery</option>
                                    </select>
                                </div>
                                <div class="field half text-right">
                                    <ul class="actions">
                                        <li><input type="submit" name="service" value="Checkout" class="primary"></li>
                                    </ul>
                                </div>
                            </div>
                        </form>
                    </section>
                    <section>
                        <h2>Contact Info</h2>
                        <ul class="alt">
                            <li><span class="fa fa-github"></span> <a href="https://github.com/nekon0/IIBOOK">Our Project</a></li>
                            <li><span class="fa fa-map-pin"></span> <a href="https://goo.gl/maps/ojwCjTqRteiA4B9U7"> DE336, FBT University</a></li>
                        </ul>
                    </section>

                    <ul class="copyright">
                        <li>@HLV </li>
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
