<%-- 
    Document   : products
    Created on : Jun 15, 2022, 10:56:23 AM
    Author     : ACER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bookshelf</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css"/></noscript>
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

                    <li><a href="Login?origin=./Book?id=0"><i class="fa fa-sign-in"></i>Login</a></li>
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
                    <h1>Bookshelf</h1>
                    <div class="image main">
                        <img
                            src="images/banner-image-6-1920x500.jpg"
                            class="img-fluid"
                            alt=""
                            />
                    </div>
                    <form action="Book" method="get">
                        <input type="hidden" name="cate" value="${cate!=null?cate:"0"}"> 
                    <div class="md-form active-pink active-pink-2 mb-3 mt-0 col-md-10" style="margin:0 auto;">
                        <input name="search" class="form-control" type="text" placeholder="Search by Title" aria-label="Search">
                    </div>
                    
                    <div class="grid_column-10">
                        <div class="home-filter">
                            <h2>Category</h2>
                        </div>
                        <div class="home-filter">
                            <button name="type"  type="submit" class="primary" value="0" style="overflow:initial;">All</button>
                            <c:forEach items="${types}" var="type">
                                <button name="type" type="submit" class="primary" value="${type.getId()}">${type.getName()}</button>
                            </c:forEach>
                        </div>
                    </div>
                    </form>
                    <style>
                        .home-filter{
                            text-align: center;
                            display: flex;
                            margin: 0 50px;
                        }
                        button{
                            margin: 0 10px;
                        }
                    </style>

                    <!-- Products -->
                    <section class="tiles">
                        <c:forEach items="${books}" var="book">
                            <article class="style1">
                                <span class="image">
                                    <img src="${book.getImage()}" alt="" style="height: 391px;"/>
                                </span>
                                <a href="Book?id=${book.getId()}">
                                    <h2>${book.getTitle()}</h2>
                                    <h3 style="font-size: 0.85em;"><i>${book.getAuthor()}</i></h3>
                                            <c:if test="${book.issale()}">
                                        <p>
                                            <del>$${book.getPrice()}</del> 
                                            <strong>$${Math.round(book.getPrice()*(100-book.getDiscount()))/100}</strong>
                                        </p>
                                    </c:if>
                                    <c:if test="${!book.issale()}">
                                        <p><strong>$${book.getPrice()}</strong></p>
                                    </c:if>
                                    <!--button href="Cart?service=addToCart&bookID=${book.getId()}">Add to Cart</button-->
                                </a>
                            </article>
                        </c:forEach>
                    </section>

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
                        <li>HLV</li>
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

