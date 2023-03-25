<%-- 
    Document   : product-details
    Created on : Jun 15, 2022, 10:59:59 AM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Book</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
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
            
        <li><a href="Login?origin=./Book?id=${book.getId()}"><i class="fa fa-sign-in"></i>Login</a></li>
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
                    <h1 style="margin: 0 0 0 0;">${book.getTitle()}
                        <c:if test="${book.issale()}">
                            <span class="pull-right">
                                <del>$${book.getPrice()}</del> 
                                $${Math.round(book.getPrice()*(100-book.getDiscount()))/100}
                            </span>
                        </c:if> 
                        <c:if test="${!book.issale()}">
                            <span class="pull-right">$${book.getPrice()}</span>
                        </c:if>
                    </h1>
                    <h2> ${book.getAuthor()} </h2>

                    <div class="container-fluid">
                        <div class="row" style="width: 1200px; text-align: justify;">
                            <div class="col-md-3">
                                <img src="${book.getImage()}" class="img-fluid" alt="${book.getImage()}">
                                <div style="text-align: center;">
                                    <span class="fa fa-eye"></span>
                                    <span class="title">${book.getViews()}</span>
                                </div>
                            </div>

                            <div class="col-md-7">
                                <h2 style="margin: 0 0 0.8em 0;"><i>Category: ${book.getCategory()}</i></h2>
                                <p>
                                    ${book.getDescription()}
                                </p>
                                <div class="row">        
                                    <form action="Book" method="POST">
                                        <div class="col-sm-8">
                                            <label class="control-label" >Quantity</label>

                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <input type="number" name="quantity" min="1" max="${book.getQuantity()}" class="bg-transparent form-control" value="1" pattern="[0-9]+" required>
                                                    </div>
                                                </div>

                                                <div class="col-sm-6">
                                                    <c:if test="${book.getQuantity()>0}">
                                                        <input type="submit" name="addtocart" class="primary" value="Add to Cart">
                                                    </c:if>
                                                    <c:if test="${book.getQuantity()==0}">
                                                        <input type="submit" class="primary" value="Out of Stock" disabled>
                                                    </c:if>
                                                </div>
                                                <input type="hidden" name="id" value="${book.getId()}">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <br>
                    <br>

                    <div class="container-fluid">
                        <h2 class="h2">Similar Products</h2>

                        <!-- Products -->
                        <section class="tiles">
                            <c:forEach items="${likes}" var="like">
                                <article class="style1">
                                    <span class="image">
                                        <img src="${like.getImage()}" alt="${like.getImage()}" style="height: 391px;" />
                                    </span>
                                    <a href="Book?id=${like.getId()}">
                                        <h2>${like.getTitle()}</h2>

                                        <c:if test="${like.issale()}">
                                            <p>
                                                <del>$${like.getPrice()}</del> 
                                                <strong>$${Math.round(like.getPrice()*(100-like.getDiscount()))/100}</strong>
                                            </p>
                                        </c:if>
                                        <c:if test="${!like.issale()}">
                                            <p><strong>$${like.getPrice()}</strong></p>
                                        </c:if>
                                    </a>
                                </article>
                            </c:forEach>
                        </section>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer id="footer">
                <div class="inner">
                    <section>
                        <h2>Contact Info</h2>
                        <ul class="alt">
                            <li><span class="fa fa-github"></span> <a href="https://github.com/nekon0/IIBOOK">Our Project</a></li>
                            <li><span class="fa fa-map-pin"></span> <a href="https://goo.gl/maps/ojwCjTqRteiA4B9U7"> DE336, FBT University</a></li>
                        </ul>
                    </section>

                    <ul class="copyright">
                        <li> HLV </li>
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
