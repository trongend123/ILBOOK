<%-- 
    Document   : signup
    Created on : Jun 30, 2022, 5:15:57 PM
    Author     : ACER
--%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Join us · IIBOOK </title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="assets/css/style.css">

    </head>
    <body>
        <section class="ftco-section">
            <div class="row justify-content-center">
                <div class="col-md-6 text-center mb-5">
                    <h2 class="heading-section"><span class="fa fa-book"></span>IIBOOK</h2>
                </div>
            </div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="img" style="background-image: url(images/slider-image-2-1920x700.jpg);"></div>
                            <div class="login-wrap p-4 p-md-5">
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h3 class="mb-4">Sign Up</h3>
                                    </div>
                                </div>
                                <form action="Signup" method="POST" class="signin-form">
                                    <input type="hidden" name="origin" value="${origin}">
                                    <div class="form-group mt-3">
                                        <input type="email" name="email" class="form-control" value="${in4.getEmail()}" required>
                                        <label class="form-control-placeholder" for="email">Email</label>
                                    </div>
                                    <div class="form-group mt-3">
                                        <input type="text" name="username" class="form-control" value="${in4.getUsername()}" required>
                                        <label class="form-control-placeholder" for="username">Username</label>
                                    </div>
                                    <div class="form-group">
                                        <input id="password-field" id="password" name="password" type="password" class="form-control" required>
                                        <label class="form-control-placeholder" for="password">Password</label>
                                        <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                    </div>
                                    <!--                                    <div class="form-group">
                                                                            <input id="password-field" id="confirm_password" type="password" class="form-control" required>
                                                                            <label class="form-control-placeholder" for="re_password">Confirm Password</label>
                                                                        </div>-->
                                    <div class="form-group">
                                        <input type="text" name="phone" class="form-control" value="${in4.getPhone()}" required>
                                        <label class="form-control-placeholder" for="phone">Phone</label>
                                    </div>
                                    <div class="form-group mt-3">
                                        <input type="text" name="name" class="form-control" value="${in4.getName()}" required>
                                        <label class="form-control-placeholder" for="name">Full Name</label>
                                    </div>
                                    <div class="form-group d-md-flex " style="margin-left: 16px;">
                                        <div class="w-25">
                                            <input id="male" type="radio" name="gender" value="Male" class="" aria-labelledby="country-option-1" aria-describedby="country-option-1" checked>
                                            <label for="male" class="block ml-2 text-sm font-medium text-gray-900">
                                                Male
                                            </label>
                                        </div>
                                        <div class="w-50 text-left">
                                            <input id="female" type="radio" name="gender" value="Female" class="w-4 h-4 border-gray-300 focus:ring-2 focus:ring-blue-300" aria-labelledby="country-option-2" aria-describedby="country-option-2">
                                            <label for="female" class="block ml-2 text-sm font-medium text-gray-900">
                                                Female
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group" style="margin-left: 16px;">
                                        <label for="birthday" class="text-left">Birthday</label>
                                        <input type="date" name="birthday" class="text-right" style="
                                               border: 1px solid gray;
                                               border-radius: 6px;
                                               width: 130px;
                                               margin: 0 1em;
                                               " required>
                                    </div>
                                    <% if (request.getAttribute("error") != null) {%>
                                    <div class="w-100">
                                        <%=request.getAttribute("error")%>
                                    </div>
                                    <%}%>
                                    <div class="form-group">
                                        <button type="submit" class="form-control btn btn-primary rounded submit px-3">Sign Up</button>
                                    </div>
                                </form>
                                <p class="text-center">Already a member? <a href="Login?origin=${origin}">Log In</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="assets/js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
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
</html>


