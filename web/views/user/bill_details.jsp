<%-- 
    Document   : bill_details
    Created on : Jul 12, 2022, 2:49:38 PM
    Author     : FPT SHOP KM4
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice</title>
        <style>
            body{
                background-color: #F6F6F6;
                margin: 0;
                padding: 0;
            }
            h1,h2,h3,h4,h5,h6{
                margin: 0;
                padding: 0;
            }
            p{
                margin: 0;
                padding: 0;
            }
            .container{
                width: 80%;
                margin-right: auto;
                margin-left: auto;
            }
            .brand-section{
                background-color: #363335;
                padding: 10px 40px;
            }
            .logo{
                width: 50%;
            }

            .row{
                display: flex;
                flex-wrap: wrap;
            }
            .col-4{
                width: 33%;
                flex: 0 0 auto;
            }
            .text-white{
                color: #fff;
            }
            .company-details{
                float: right;
                text-align: right;
            }
            .body-section{
                padding: 16px;
                border: 1px solid gray;
            }
            .heading{
                font-size: 20px;
                margin-bottom: 08px;
            }
            .sub-heading{
                color: #262626;
                margin-bottom: 05px;
            }
            table{
                background-color: #fff;
                width: 100%;
                border-collapse: collapse;
            }
            table thead tr{
                border: 1px solid #111;
                background-color: #f2f2f2;
            }
            table td {
                vertical-align: middle !important;
                text-align: center;
            }
            table th, table td {
                padding-top: 08px;
                padding-bottom: 08px;
            }
            .table-bordered{
                box-shadow: 0px 0px 5px 0.5px gray;
            }
            .table-bordered td, .table-bordered th {
                border: 1px solid #dee2e6;
            }
            .text-right{
                text-align: end;
            }
            .w-20{
                width: 20%;
            }
            .float-right{
                float: right;
            }
        </style>
        <% 
                if(session.getAttribute("user")==null){ 
                    response.sendRedirect("./Home");
                }
            %>
    </head>
    <body>

        <div class="container">
            <div class="brand-section">
                <div class="row">
                    <div class="col-6">
                        <h1 class="text-white">INVOICE</h1>
                    </div>
                    <div class="col-6">
                        <div class="company-details">
                            <p class="text-white"></p>
                            <p class="text-white"></p>
                            <p class="text-white"></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="body-section">
                <div class="row">
                    <div class="col-4">
                        <h2 class="heading">Invoice No.: 00${order.getId()}</h2>

                        <p class="sub-heading">Order Date: ${order.getOrderdate()} </p>
                        <p class="sub-heading">Email: ${customer.getEmail()} </p>
                    </div>
                    <div class="col-4">
                        <p class="sub-heading">Customer Name: ${customer.getName()} </p>
                        <p class="sub-heading">Phone Number:  ${customer.getPhone()}</p>
                        <p class="sub-heading">Address:  ${customer.getAddress()}</p>
                    </div>
                  <div class="col-4">
                        <p class="sub-heading">Cash On Delivery</p>
                        <p class="sub-heading">${order.getShipper()}</p>
                    </div>
                </div>
            </div>

            <div class="body-section">
                <h3 class="heading">Purchase Order</h3>
                <br>
                <table class="table-bordered">
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
                            <th colspan="3" class="text-right">Subtotal</th>
                            <td> $${order.getSubtotal()}</td>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">Shipping</th>
                            <td> ${order.getShipper()=="Fast Delivery"?"$1.5":"$0"}</td>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-right">ORDER TOTAL</th>
                            <th> $${order.getTotal()}</th>
                        </tr>
                    </tbody>
                </table>
                <br>
            </div>
        </div>      
    </body>
</html>
