<%-- 
    Document   : index
    Created on : Jun 7, 2022, 9:18:12 PM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.User"%>
<%@page import="context.BookDAO"%>
<%@page import="java.util.ArrayList"%>
<% 
    if (request.getAttribute("books")==null){
    response.sendRedirect("./Home");
    }
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>IIBook</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <link rel="stylesheet" href="assets/css/main_1.css" />
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

                    <li><a href="Login?origin=./Home"><i class="fa fa-sign-in"></i>Login</a></li>
                        <% } else{ %>
                    <li><a href="./Order">Order History</a></li>

                    <li><a href="about.jsp">About</a></li>

                    <li><a href="Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
                        <% }%>
                </ul>
            </nav>
            <!-- Main -->
            <div id="main">
                <div
                    id="carouselExampleIndicators"
                    class="carousel slide"
                    data-ride="carousel"
                    >
                    <ol class="carousel-indicators">
                        <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="0"
                            class="active"
                            ></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img
                                class="d-block w-100"
                                src="images/slider-image-1-1920x700.jpg"
                                alt="First slide"
                                />
                        </div>
                        <div class="carousel-item">
                            <img
                                class="d-block w-100"
                                src="images/slider-image-2-1920x700.jpg"
                                alt="Second slide"
                                />
                        </div>
                        <div class="carousel-item">
                            <img
                                class="d-block w-100"
                                src="images/slider-image-3-1920x700.jpg"
                                alt="Third slide"
                                />
                        </div>
                    </div>
                    <a
                        class="carousel-control-prev"
                        href="#carouselExampleIndicators"
                        role="button"
                        data-slide="prev"
                        >
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a
                        class="carousel-control-next"
                        href="#carouselExampleIndicators"
                        role="button"
                        data-slide="next"
                        >
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>

                <br />
                <br />

                <div class="inner">
                    <!-- About Us -->
                    <header id="inner">
                        <h1>Tell us what book you love</h1>
                        <blockquote>
                            <p>
                                <i
                                    >"Books are the quietest and most constant of friends; they
                                    are the most accessible and wisest of counselors, and the most
                                    patient of teachers."</i
                                >
                            </p>
                            <cite>Charles W. Eliot</cite>
                        </blockquote>
                    </header>

                    <br />

                    <h2 class="h2">Featured Products</h2>
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
                                    <!--button class="btn-danger" href="Cart?service=addToCart&bookID=${book.getId()}">Add to Cart</button-->
                                </a>
                            </article>
                        </c:forEach>
                    </section>

                    <p class="text-center">
                        <a href="./Book?id=0"
                           >More Books &nbsp;<i class="fa fa-long-arrow-right"></i
                            ></a>
                    </p>

                    <br />

                    <h2 class="h2">Blog</h2>

                    <div class="row">
                        <div class="col-sm-4 text-center">
                            <img src="images/blog-1-720x480.jpg" class="img-fluid" alt="" />

                            <h2 class="m-n">
                                <a href="#"
                                   >LEARN HOW TO HEAL YOURSELF</a
                                >
                            </h2>

                            <p>Nekon &nbsp;|&nbsp; 08/06/2022</p>
                        </div>

                        <div class="col-sm-4 text-center">
                            <img src="images/blog-4-720x480.jpg" class="img-fluid" alt="" />

                            <h2 class="m-n">
                                <a href="#"
                                   >WHAT I READ IN THE FIRST 4 MONTHS OF THE YEAR</a
                                >
                            </h2>

                            <p>mucmocmeo &nbsp;|&nbsp; 10/05/2022</p>
                        </div>

                        <div class="col-sm-4 text-center">
                            <img src="images/blog-6-720x480.jpg" class="img-fluid" alt="" />

                            <h2 class="m-n">
                                <a href="#"
                                   >\Novel Recommended/: Classroom of the Elite</a
                                >
                            </h2>

                            <p>Nekon &nbsp;|&nbsp; 12/06/2020</p>
                        </div>
                    </div>

                    <p class="text-center">
                        <a href="#"
                           >Read More &nbsp;<i class="fa fa-long-arrow-right"></i
                            ></a>
                    </p>
                </div>
            </div>

            <!-- Footer -->
            <footer id="footer">
                <div class="inner">
                    <section>
                        <h2>Contact Us</h2>
                        <form method="get" action="#">
                            <div class="fields">
                                <div class="field half">
                                    <input type="text" name="name" id="name" placeholder="Name" />
                                </div>

                                <div class="field half">
                                    <input
                                        type="text"
                                        name="email"
                                        id="email"
                                        placeholder="Email"
                                        />
                                </div>

                                <div class="field">
                                    <input
                                        type="text"
                                        name="subject"
                                        id="subject"
                                        placeholder="Subject"
                                        />
                                </div>

                                <div class="field">
                                    <textarea
                                        name="message"
                                        id="message"
                                        rows="3"
                                        placeholder="Notes"
                                        ></textarea>
                                </div>

                                <div class="field half text-right">
                                    <label>&nbsp;</label>

                                    <ul class="actions">
                                        <li>
                                            <input
                                                type="submit"
                                                value="Send Message"
                                                class="primary"
                                                />
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </form>
                    </section>
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
