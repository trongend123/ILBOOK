<%-- 
    Document   : user_profile
    Created on : Jul 12, 2022, 3:41:46 AM
    Author     : FPT SHOP KM4
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Book"%>
<%@page import="java.util.ArrayList"%>
<% 
            if(session.getAttribute("user")==null){ 
                response.sendRedirect("./Home");
            }
%>
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

    <style>
        .sidebar{
            background-color: rgb(222, 188, 211);
            color: white;
            height: 100%
        }
        .sidebar a {
            margin-left: 10px;
            display: block;
            color: white;
            padding-bottom: 10px;
            font-size: 30px;
            text-decoration: none;
        }
        .card{
            position: relative;
            display: flex;
            flex-direction: column;

        }
        .content{
            background-color: whitesmoke;
        }
    </style>
    <body class="is-preload">
        <div id ="wrapper">
            <!--Header-->
            <header id="header">
                <div class="inner">

                    <!-- Logo -->
                    <a href="./Home" class="logo">
                        <span class="fa fa-book"></span> <span class="title">IIBOOK</span>
                    </a>

                    <!-- Nav -->
                    <nav>
                        <ul>
                            <li><a href="#menu">Menu</a></li>
                        </ul>
                    </nav>

                </div>
            </header>

            <!--Menu-->
            <nav id="menu">
                <h2><a href="./User" >${user==null? "Menu": ("Welcome ")}${user.getName()}</a></h2>
                <ul>
                    <li></li>
                    <li><a href="./Home" class="active">Home</a></li>
                    <li><a href="./Book?id=0">Bookshelf</a></li>
                    <li><a href="./Cart">Cart</a></li>

                    <li><a href="./Order">Order History</a></li>
                    <li><a href="about.jsp">About</a></li>

                    <li><a href="Logout">Logout</a></li>
                </ul>
            </nav>

            <body class="is-preload">
                <div class="profile" id="profile ">
                    <div class="row">
                        <div class="col-md-3 mt-1">
                            <div class="card text-center sidebar">
                                <div class="card-body">
                                    <div class="mt-3">

                                        <a href="./Home">Home</a>
                                        <a href="#profile">Edit Profile</a>
                                        <a href="#change_password">Change password</a>

                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="col-md-8 mt-1">
                            <div class="card mb-3 content">
                                <h1 class="m-3 pt-3">About</h1>
                                <div class="card-body">
                                    <form action="User" method="get">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Full Name</label>
                                            </div>
                                            <div class="col-md-9">
                                                <div class="input-group">
                                                    <div class="input-group-name">

                                                    </div>
                                                    <input class="" id="name" name="name" value="${user.getName()}"
                                                           placeholder="Enter your name" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <hr>

                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Email</label>
                                            </div>
                                            <div class="col-md-9">
                                                <div class="input-group">
                                                    <div class="input-group-name">

                                                    </div>
                                                    <input class="" id="email" value="${user.getEmail()}"
                                                           disabled type="text">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Phone</label>
                                            </div>
                                            <div class="col-md-9">
                                                <div class="input-group">
                                                    <div class="input-group-name">

                                                    </div>
                                                    <input class="" id="phone" name="phone" value="${user.getPhone()}"
                                                           placeholder="Enter your phone" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Address</label>
                                            </div>
                                            <div class="col-md-9">
                                                <div class="input-group">
                                                    <div class="input-group-name">

                                                    </div>
                                                    <input class="" id="address" name="address" value="${user.getAddress()}"
                                                           placeholder="Enter your address" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="button_profile">
                                            <button type="submit" name="submit" value="Submit">Save</button>
                                            <button type="reset" name="submit" value="Reset">Clear</button>
                                            <p>${mes}</p>
                                        </div>
                                    </form>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>

                <style>
                    .button_profile{
                        padding: 30px 0px;
                    }
                    .button_changepass{
                        margin: 0 0;
                        padding: 20px 0px;
                    }
                </style>

                <div class="change password" id="change_password">
                    <form action="User" method="post">
                        <div class="box box-primary">
                            <div class="box-header">
                                <h2 class="page-header"><i class="fa fa-lock"></i> Change Password</h2>

                            </div>
                            <!-- /.box-header -->

                            <div class="box-body">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-3 col-md-3">
                                        <label>Old Password</label>
                                    </div>
                                    <div class="col-xs-12 col-sm-3 col-md-3">
                                        <div class="input-group">
                                            <div class="input-group-addon">

                                            </div>
                                            <input class="text" id="oldPassword" name="oldpass" value=""
                                                   placeholder="Enter the Old Password" type="password" required>
                                        </div>
                                    </div>
                                        <div class="col-xs-12 col-sm-3 col-md-3">${errold}</div>
                                    <!-- /.input group -->
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-xs-12 col-sm-3 col-md-3">
                                        <label>New Password</label>
                                    </div>
                                    <div class="col-xs-12 col-sm-3 col-md-3">
                                        <div class="input-group">
                                            <div class="input-group-addon">

                                            </div>
                                            <input class="form-control" id="password" name="newpass" value=""
                                                   placeholder="Enter the New Password" type="password" required>
                                        </div>
                                    </div>
                                    <!-- /.input group -->
                                </div>
                                <br />
<!--                                <div class="row">
                                    <div class="col-xs-12 col-sm-3 col-md-3">
                                        <label>Confirm Password</label>
                                    </div>
                                    <div class="col-xs-12 col-sm-3 col-md-3">
                                        <div class="input-group">
                                            <div class="input-group-addon">

                                            </div>
                                            <input class="form-control" id="confirm_password" value=""
                                                   placeholder="Re-enter the New Password" type="password" required>
                                        </div>
                                    </div>
                                     /.input group 
                                </div>-->

                                <div class="button_changepass">
                                    <button type="submit" name="submit" value="Submit">Save</button>
                                    <button type="reset" name="submit" value="Reset">Clear</button>
                                    <p>${message}</p>
                                </div>
                            </div>
                        </div>
                    </form>
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
                                            DE336, FBT University</a>
                                    </li>
                                </ul>
                                <ul class="copyright">
                                    <li>HLV</li>
                                </ul>
                            </section>

                        </div>
                    </footer>
                </div>
        </div>
                <!-- Scripts -->
                <script src="assets/js/jquery.min.js"></script>
                <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="assets/js/jquery.scrolly.min.js"></script>
                <script src="assets/js/jquery.scrollex.min.js"></script>
                <script src="assets/js/main.js"></script>
                <script>
            $('#password, #confirm_password').on('keyup', function () {
                if ($('#password').val() == $('#confirm_password').val()) {
                    $('#confirm_password').setCustomValidity("Passwords Don't Match");
                    ;
                } else
                    $('#confirm_password').setCustomValidity('');
                ;
            });
        </script>
            </body>


            <style>
                .body {
                    margin-top: 20px;
                }

                .main {
                    padding: 15px;
                    font-family: Arial, Helvetica, sans-serif;
                }

                .sidebar {
                    background-color: rgb(222, 188, 211);
                    color: white;
                    height: 100%;
                    margin-left: 50px;
                }

                .sidebar a {
                    margin-left: 10px;
                    display: block;
                    color: white;
                    padding-bottom: 10px;
                    font-size: 30px;
                    text-decoration: none;
                }

                .card {
                    position: relative;
                    display: flex;
                    flex-direction: column;

                }

                .content {
                    background-color: whitesmoke;
                }
            </style>

