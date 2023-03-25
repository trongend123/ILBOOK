<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Model.User" %>
<%
            User user = (User)session.getAttribute("user");
            if(user==null || !user.is_super()){
                response.sendRedirect("./Home");
            }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Detail</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- bootstrap 3.0.2 -->
        <link href="./admin/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="./admin/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="./admin/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="./admin/css/morris/morris.css" rel="stylesheet" type="text/css" />
        <link href="./admin/css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <link href="./admin/css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
        <link href="./admin/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <link href="./admin/css/iCheck/all.css" rel="stylesheet" type="text/css" />
        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <!-- Theme style -->
        <link href="./admin/css/style.css" rel="stylesheet" type="text/css" />

        <style type="text/css">
            .left-aside{
                height: 1550px;
            }
            h3{
                margin-top:150px;
                text-align: center;
                }
                .control-label
                {
                    font-size: 15px;
                    }
        </style>
    </head>
    <body class="skin-black">
        <c:if test="${param['index']==null }">   
            <c:set var = "index" scope = "page" value = "1"/>
        </c:if>
        <c:if test="${param['index']!=null}">
            <c:set var = "index" scope = "page" value = "${param['index']}"/>
        </c:if>
        <!-- header logo: style can be found in header.less -->
        <jsp:include page="./header.jsp"/>
        <div class="wrapper row-offcanvas row-offcanvas-left" style="height: 100%;">
            <!-- Left side column. contains the logo and sidebar -->
            <jsp:include page="./aside.jsp"/>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">

                <!-- Main content -->
                <section class="content">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="panel">
                                <header class="panel-heading">
                                    Order Detail
                                </header>
                                <div class="panel-body table-responsive">
                                    <div class="sliderList">
                                        <div class="form-group col-md-6">
                                            <label class="control-label">ID:</label>${order.getId()}
                                            <br><label for="exampleSelect1" class="control-label">Customer: </label>${customer.getName()}
                                            <br><label for="exampleSelect1" class="control-label">Email: </label>${customer.getEmail()}
                                            <br><label class="control-label">Phone: </label>${customer.getPhone()}
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="control-label">Order Date: </label>${order.getOrderdate()}
                                            <br><label class="control-label">Address: </label>${customer.getAddress()}
                                            <br><label class="control-label">Cash On Delivery</label>
                                            <br><label class="control-label">${order.getShipper()}</label>
                                        </div>
                                        <div class="body-section">
                                            <h3 class="heading">Purchase Order</h3>
                                            <br>
                                            <table class="table-bordered" width="1500px">
                                                <thead>
                                                    <tr>
                                                        <th>Item Description</th>
                                                        <th class="w-20">Price</th>
                                                        <th class="w-20">Quantity</th>
                                                        <th class="w-20">Total</th>
                                                    </tr>
                                                </thead>
                                                <% float subtotal = 0;%>
                                                <tbody>
                                                    <c:forEach var="item" items="${items}">
                                                        <tr>
                                                            <td>${item.getItemname()}</td>
                                                            <td>$${item.getPrice()}</td>
                                                            <td>${item.getQuantity()}</td>
                                                            <td>$${Math.round(item.getPrice()*item.getQuantity()*100)/100}</td>
                                                        </tr>
                                                    </c:forEach>
                                                    <tr>
                                                        <th colspan="3" class="text-left">Subtotal:</th>
                                                        <td> $${order.getSubtotal()}</td>
                                                    </tr>
                                                    <tr>
                                                        <th colspan="3" class="text-left">Shipping:</th>
                                                        <td> ${order.getShipper()=="Fast Delivery"?"$1.5":"$0"}</td>
                                                    </tr>
                                                    <tr>
                                                        <th colspan="3" class="text-left">ORDER TOTAL:</th>
                                                        <th> $${order.getTotal()}</th>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div></div></div>
                            </section><!-- /.content -->
                            <div class="footer-main">
                                Copyright &copy Director, 2014
                            </div>
                            </aside><!-- /.right-side -->


                        </div><!-- ./wrapper -->



                        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
                        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
                        <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
                        <script>
                            $(document).ready(function () {
                                $("#tablepro").DataTable({bFilter: false, bInfo: false, paging: false});
                            });
                        </script>
                        <!-- Bootstrap -->
                        <script src="./admin/js/bootstrap.min.js" type="text/javascript"></script>
                        <!-- Director App -->
                        <script src="./admin/js/Director/app.js" type="text/javascript"></script>
                        </body>
                        </html>