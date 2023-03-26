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

                            <!--                            IF NOT LOGGED IN-->
                            <c:if test="${current_user==null}"> 
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <c:if test="${action=='shop' || action==null}">
                                        <li class="search">
                                            <form class="d-flex" action="<c:url value="/shop/shop.do"/>" >
                                                <button class="btn btn-outline" type="submit" style="margin-right: 1px"><i class="bi bi-search"></i></button>
                                                <input class="form-control me-2" type="text" name="search" id="search" placeholder="Search a product" value="${param.search}" style="width:500px">
                                                <select class="form-control" style="margin-left:10px" name="sort" id="sort">
                                                    <option value="none">Sort options</option>
                                                    <option value="az" ${sort=="az"?"selected":""}>Name: A - Z</option>
                                                    <option value="za" ${sort=="za"?"selected":""}>Name: Z - A</option>
                                                    <option value="inc" ${sort=="inc"?"selected":""}>Increasing Price</option>
                                                    <option value="dec" ${sort=="dec"?"selected":""}>Decreasing Price</option>
                                                </select>                    
                                            </form>
                                        </li>
                                    </c:if>

                                    <c:if test="${action=='shop' || action==null}">
                                        <c:if test="${cart==null || cart.size==0}">
                                            <li class="cart" style="margin-left:50px">
                                                <a class="nav-link active" href="<c:url value="/cart/cart.do"/>"><i class="bi bi-cart3"></i>Cart</a>
                                            </li>
                                        </c:if >
                                        <c:if test="${cart!=null && cart.size!=0}" >
                                            <li class="cart" style="margin-left:50px">
                                                <a class="nav-link active" href="<c:url value="/cart/cart.do"/>"><i class="bi bi-cart-fill"></i>Cart</a>
                                            </li>
                                        </c:if >
                                    </c:if >
                                    <c:if test="${action!='login'}">
                                        <li class="login" style="margin-left: 50px">
                                            <a class="nav-link active" style="color:blue" href="<c:url value="/login/login.do"/>">Login</a>
                                        </li>  
                                    </c:if>
                                </ul>
                            </c:if >

                            <!--                           IF USER IS A USER-->
                            <c:if test="${current_user!=null && current_user.role=='us'}">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="font-size: 20px">

                                    <c:if test="${action=='shop' || action==null}">
                                        <li class="search">
                                            <form class="d-flex" action="<c:url value="/shop/shop.do"/>" >
                                                <button class="btn btn-outline" type="submit" style="margin-right: 1px"><i class="bi bi-search"></i></button>
                                                <input class="form-control me-2" type="text" name="search" id="search" placeholder="Search a product" value="${param.search}" style="width:500px">
                                                <select class="form-control" style="margin-left:10px" name="sort" id="sort">
                                                    <option value="none">Sort options</option>
                                                    <option value="az" ${sort=="az"?"selected":""}>Name: A - Z</option>
                                                    <option value="za" ${sort=="za"?"selected":""}>Name: Z - A</option>
                                                    <option value="inc" ${sort=="inc"?"selected":""}>Increasing Price</option>
                                                    <option value="dec" ${sort=="dec"?"selected":""}>Decreasing Price</option>
                                                </select>                    
                                            </form>
                                        </li>
                                    </c:if>
                                    <c:if test="${action=='shop' || action==null}">
                                        <c:if test="${cart==null || cart.size==0}">
                                            <li class="cart" style="margin-left:50px">
                                                <a class="nav-link active" href="<c:url value="/cart/cart.do"/>"><i class="bi bi-cart3"></i>Cart</a>
                                            </li>
                                        </c:if >
                                        <c:if test="${cart!=null && cart.size!=0}">
                                            <li class="cart">
                                                <a class="nav-link active" href="<c:url value="/cart/cart.do"/>"><i class="bi bi-cart-fill"></i>Cart</a>
                                            </li>
                                        </c:if >
                                    </c:if >
                                </ul>
                                <div class="btn-group">
                                    <button style="font-weight:bold; color:black" type="button" class="btn btn-outline-info dropdown-toggle" data-bs-toggle="dropdown">
                                        ${current_user.username}
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="<c:url value="/shop/user.do?id=${current_user.userID}"/>">Change info</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="<c:url value="/login/logout.do"/>">Logout</a></li>
                                    </ul>
                                </div>
                            </c:if >

                            <!--                            IF USER IS AN ADMIN-->
                            <c:if test="${current_user!= null && current_user.role=='ad'}">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                                    <c:if test="${action=='shop' || action==null}">
                                        <li class="search">
                                            <form class="d-flex" action="<c:url value="/shop/shop.do"/>" >
                                                <button class="btn btn-outline" type="submit" style="margin-right: 1px"><i class="bi bi-search"></i></button>
                                                <input class="form-control me-2" type="text" name="search" id="search" placeholder="Search a product" value="${param.search}" style="width:500px">
                                                <select class="form-control" style="margin-left:10px" name="sort" id="sort">
                                                    <option value="none">Sort options</option>
                                                    <option value="az" ${sort=="az"?"selected":""}>Name: A - Z</option>
                                                    <option value="za" ${sort=="za"?"selected":""}>Name: Z - A</option>
                                                    <option value="inc" ${sort=="inc"?"selected":""}>Increasing Price</option>
                                                    <option value="dec" ${sort=="dec"?"selected":""}>Decreasing Price</option>
                                                </select>                    
                                            </form>
                                        </li>
                                    </c:if>

                                </ul>
                                <div class="btn-group">
                                    <button style="font-weight:bold; color:black" type="button" class="btn btn-outline-info dropdown-toggle" data-bs-toggle="dropdown">
                                        ${current_user.username}
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="<c:url value="/shop/user.do?id=${current_user.userID}"/>">Change info</a></li>
                                        <li><a class="dropdown-item" href="<c:url value="/shop/revenue.do"/>"/>See revenue</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="<c:url value="/login/logout.do"/>">Logout</a></li>
                                    </ul>
                                </div>
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
                    Copyright &copy; by Nhóm 三人だけだ
                </div>
            </div>            
        </div>
    </body>
</html>
