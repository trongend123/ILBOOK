<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>Book Manager</title>
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

        <style>
            .left-aside{
                height: 100%;
            }
            img{
                border: 1px solid black;
                border-radius: 2px;
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
                                    Book Manager
                                </header>
                                <!-- <div class="box-header"> -->
                                <!-- <h3 class="box-title">Responsive Hover Table</h3> -->

                                <!-- </div> -->
                                <div class="panel-body table-responsive">
                                    <div class="sliderList">
                                        <div class="input-group" style="margin-bottom: 10px;width: 100%; ">
                                            <form class="search-slider"
                                                  style="width: 100%; display: flex; justify-content: space-between; position: relative;"
                                                  method="get" action="BookManager">
                                                <div class="left-filter">
                                                    <a class="btn btn-primary" href="BookManager?service=add">Add Book</a>
                                                </div>

                                                <div class="right-search">
                                                    <label class="form-control"
                                                           style="border:none;display: inline;">Category</label>
                                                    <select class="form-control" name="cid" style="display: inline; width: 100px;">
                                                        <option value="">All</option>
                                                        <c:forEach var="cate" items="${cates}">
                                                            <option value="${cate.getId()}" ${cate.getId()==param['cid']?"selected":""}>${cate.getName()}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <input type="text" name="search" class="form-control" value="${param['search']} "
                                                           style="width: 250px;" placeholder="Search" />
                                                    <select class="form-control input-sm" name="type-search"
                                                            style="display: inline; width: 90px; border:none; position:absolute; right:50px;top:2px;">
                                                        <option value="0" ${param['type-search']==0?'selected':''}>Title</option>
                                                        <option value="1" ${param['type-search']==1?'selected':''}>Author</option>
                                                    </select>
                                                    <button class="btn btn-default" name="service" value="search">Go</button>
                                                </div>
                                            </form>
                                        </div>
                                        <table class="table table-hover " id="tablepro">
                                            <thead>
                                                <tr style="cursor: pointer; font-size: 15px;  text-align: center;">
                                                    <th>ID</th>
                                                    <th>Title</th>
                                                    <th>Author</th>
                                                    <th style="width: 150px;">Image</th>
                                                    <th>Category</th>
                                                    <th>Stock</th>
                                                    <th>Price</th>
                                                    <th>Sale</th>
                                                    <th>Discount</th>
                                                    <th  width="20px">Edit</th>
                                                    <th  width="20px">Del</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <c:forEach var="s" items="${books}">
                                                    <tr>
                                                        <td >${s.getId()}</td>
                                                        <td data-toggle="modal" data-target="#Show${s.getId()}" style="cursor: pointer;">${s.getTitle()}</td>
                                                        <td>${s.getAuthor()}</td>
                                                        <td style="width: 150px;"><img  src="${s.getImage()}" width="100px"></td>
                                                        <td>${s.getCategory()}</td>
                                                        <td>${s.getQuantity()}</td>
                                                        <td>$${s.getPrice()}</td>
                                                        <td><input class="checkbox-inline" type="checkbox" ${s.issale()?"checked":""} disabled></td>
                                                        <td>${s.getDiscount()}%</td>
                                                        <td><a class="btn btn-primary" href="BookManager?service=edit&bid=${s.getId()}"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a></td>
                                                        <td><a class="btn btn-danger" href="BookManager?service=del&bid=${s.getId()}"><i class="fa fa-trash-o" aria-hidden="true"></i></a></td>
                                                    </tr>
                                                    <!-- Show detail modal -->
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="pagination-arena " style="margin-left: 40%">
                                            <ul class="pagination">
                                                <li class="page-item" >
                                                    <a href="BookManager?xpage=${xpage-1}" class="page-link" style="${xpage<3?"display:none":""}">
                                                        <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                                    </a>
                                                </li>
                                                <c:forEach begin="${1}" end="${numPage}" var="item">
                                                    <li class="page-item ${item==xpage?"active":""}">
                                                        <a href="BookManager?xpage=${item}" 
                                                           class="page-link " style="${(xpage-1>item || xpage+1<item ) ?"display:none;":""}"
                                                           >${item}</a></li>
                                                    </c:forEach>
                                                <li >
                                                    <a href="BookManager?xpage=${xpage+1}" class="page-link" style="${xpage+2>numPage?"display:none":""}">
                                                        <i class="fa fa-angle-right" aria-hidden="true"  ></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div> 
                                    </div><!-- /.box-body -->
                                </div><!-- /.box -->
                            </div>
                        </div>
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