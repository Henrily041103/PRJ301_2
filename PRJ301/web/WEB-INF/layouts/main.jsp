<%-- 
    Document   : main
    Created on : Feb 2, 2023, 12:51:25 PM
    Author     : PHT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JDBC Demo</title>
        <!-- Latest compiled and minified CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Latest compiled JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

        <!--<link href="<c:url value="/WEB-INF/css/style.css" />" rel="stylesheet" type="text/css"/>-->
        <style> <%@ include file="/WEB-INF/css/style.css"%> </style>
    </head>
    <body>
        <div class="container">
            <!--header-->

            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <a class="navbar-brand" href="shop/shop.do">Baby shop</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="#">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Link</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Dropdown
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <li><a class="dropdown-item" href="#">Action</a></li>
                                    <li><a class="dropdown-item" href="#">Another action</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                                </ul>
                            </li>
                        </ul>
                        <form class="d-flex">
                            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                            <button class="btn btn-outline-success" type="submit">Search</button>
                        </form>
                    </div>
                </div>
            </nav>

            <div class="row header">
                <c:if test="${current_user!=null}">
                    <div class="row">
                        <div class="col-2" id="logo">
                            Baby Shop
                        </div>
                        <div class="col-6" id="search-bar">
                            <form action="<c:url value="/shop/search.do"/>">
                                <input type="text" name="search" id="search" placeholder="Search a product">
                                <button type="submit" id="search-icon">
                                    <i class="bi bi-search"></i>

                                    </i>
                                </button>
                            </form>
                        </div>
                        <div class="col-2" id="cart">
                            <c:choose>
                                <c:when test="${cart==null || cart.size==0}">
                                    <a href="<c:url value="/cart/show.do"/>">
                                        <i class="bi bi-cart"></i>
                                    </a>
                                </c:when>
                                <c:when test="${cart!=null && cart.size>0}">
                                    <a href="<c:url value="/cart/show.do"/>">
                                        <i class="bi bi-cart-fill"></i>
                                        <div id="cart-size">${cart.size}</div>
                                    </a>

                                </c:when>
                            </c:choose>
                        </div>
                        <div class="col-2" id="account-info">
                            <div id="account-name">Current user: ${current_user.username}</div>

                            <div id="account-logout">
                                <a class="btn btn-danger" href="<c:url value="/login/logout.do"/>" id="logout">Log out</a>
                            </div>
                        </div>
                    </div>
                </c:if >

                <c:if test="${current_user==null}">
                    <div class="row">
                        <div id="logo-alone">
                            Baby Shop
                        </div>
                        <span id="account-login">
                            <a href="<c:url value="/login/login.do"/>" class="btn btn-primary btn-block"> <i class="fas fa-user-plus"></i>Login</a>
                        </span>
                    </div>
                </c:if>
            </div>
            <!--view-->
            <div class="row content">
                <div class="col">
                    <jsp:include page="/WEB-INF/views/${controller}/${action}.jsp" />
                </div>
            </div>
            <c:if test="${error_message!=null}"><div class="alert alert-warning">${error_message}</div></c:if>
            <!--footer-->
            <div class="row footer">
                <div class="col">
                    Copyright &copy; by FPT Students
                </div>
            </div>            
        </div>
    </body>
</html>
