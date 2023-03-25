<%-- 
    Document   : about
    Created on : Jun 17, 2022, 11:03:08 AM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Our Team</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
    </head>
    <body class="is-preload">
        <!-- Wrapper -->
        <div id="wrapper">

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
            
        <li><a href="Login?origin=./about.jsp"><i class="fa fa-sign-in"></i>Login</a></li>
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
                    <h1>About Us</h1>

                    <div class="image main">
                        <img src="images/banner-image-1-1920x500.jpg" class="img-fluid" alt="" />
                    </div>

                    <p>"I AM THE LINK OF MY SERVER"<br>
                        "IMVU IS MY BODY, AND <span style="text-decoration: line-through">RIGHTING</span> WRITING IS MY BLOOD"<br>
                        "I HAVE CREATED OVER A THOUSAND ADS"<br>
                        "UNKNOWN TO WIN, NOR KNOWN TO LOSE"<br>
                        "HAVE WITHSTOOD FEMALE NARUTO TO CREATE MANY QUIZNO'S SUBS"<br>
                        "YET THOSE DOUBLE-CLICKS WILL NEVER HOLD ANYTHING"<br>
                        "SO, AS I PAY BILLS"<br>
                        <strong>"UNLIMITED AD WORKS"</strong><br>
                        "AS YOU CAN SEE, WHAT STANDS BEFORE YOU ARE UNLIMITED ADS, THE PINNACLE OF GETTING WEBSITES MONEY"<br>
                        "WELL WHAT ARE YOU WAITING FOR?"</p>
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
