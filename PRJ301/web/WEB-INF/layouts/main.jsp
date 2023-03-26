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
            <div class="row header">
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="<c:url value="/shop/shop.do"/>">
                            <img src="<c:url value="/images/logo.png"/>"/></a>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <c:if test="${current_user==null}"> 
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="font-size: 25px; margin-left: 5px">
                                    <li class="home">
                                        <a class="nav-link active" href="<c:url value="/shop/shop.do"/>">Home</a>
                                    </li>
                                    <c:if test="${action!='login'}">
                                        <li class="login">
                                            <a class="nav-link active" style="color:blue" href="<c:url value="/login/login.do"/>">Login</a>
                                        </li>  
                                    </c:if>
                                    <c:if test="${action=='shop' || action==null}">
                                        <c:if test="${cart==null || cart.size==0}">

                                            <li class="cart">
                                                <a class="nav-link active" href="<c:url value="/cart/show.do"/>">Cart</a>
                                            </li>

                                        </c:if >
                                        <c:if test="${cart!=null && cart.size>0}">
                                            <li class="cart">
                                                <a class="nav-link active" style="color:red" href="<c:url value="/cart/show.do"/>">Cart</a>
                                            </li>
                                        </c:if >

                                    </ul>
                                </c:if>
                            </c:if >

                            <c:if test="${current_user!=null && current_user.role=='us'}">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="font-size: 20px">
                                    <li class="home">
                                        <a class="nav-link active" href="<c:url value="/shop/shop.do"/>">Home</a>
                                    </li>
                                    <li class="logout">
                                        <a class="nav-link active" style="color:red" href="<c:url value="/login/logout.do"/>">Logout</a>
                                    </li>
                                    <c:if test="${action=='shop' || action==null}">
                                        <c:if test="${cart==null || cart.size==0}">
                                            <li class="cart">
                                                <a class="nav-link active" href="<c:url value="/cart/show.do"/>">Cart</a>
                                            </li>
                                        </c:if >
                                        <c:if test="${cart!=null && cart.size>0}">
                                            <li class="cart">
                                                <a class="nav-link active" style="color:red" href="<c:url value="/cart/show.do"/>">Cart</a>
                                            </li>
                                        </c:if >

                                    </ul>

                                    <form class="d-flex" action="<c:url value="/shop/shop.do"/>">
                                        <input class="form-control me-2" type="text" name="search" id="search" placeholder="Search a product" value="${param.search}">
                                        <button class="btn btn-outline-success" type="submit">Search</button>
                                        <select style="margin-left:10px" name="search_op" id="search_op">
                                            <option value="name">Name</option>
                                            <option value="brand">Brand</option>
                                            <option value="type">Type</option>
                                            <option value="az">Name: A - Z</option>
                                            <option value="asc">Asc Price</option>
                                            <option value="desc">Desc Price</option>
                                        </select>
                                        <button class="btn btn-outline-warning" style="margin-left: 10px" type="option">More</button>
                                    </form>
                                </c:if>
                            </c:if >

                            <c:if test="${current_user!= null && current_user.role=='ad'}">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="font-size: 20px">
                                    <li class="home">
                                        <a class="nav-link active" href="<c:url value="/shop/shop.do"/>">Home</a>
                                    </li>
                                    <li class="revenue">
                                        <a class="nav-link active" href="<c:url value="/shop/revenue.do"/>">Revenue</a>
                                    </li>
                                    <li class="logout">
                                        <a class="nav-link active" style="color:red" href="<c:url value="/login/logout.do"/>">Logout</a>
                                    </li>                                    
                                </ul>
                            </c:if >

                        </div>
                    </div>
                </nav>
            </div>
            <!--view-->
            <div class="row content">
                <div class="col">
                    <jsp:include page="/WEB-INF/views/${controller}/${action}.jsp" />
                </div>
            </div>

            <!--footer-->
            <div class="row footer">
                <div class="col">
                    Copyright &copy; by Nhóm 三人だけ
                </div>
            </div>            
        </div>
    </body>
</html>
