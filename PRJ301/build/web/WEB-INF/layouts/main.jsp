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

<!--<link href="<c:url value="/css/site.css" />" rel="stylesheet" type="text/css"/>-->
    </head>
    <body>
        <div class="container">
            <!--header-->
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
                        <div id="col-2 logo-alone">
                            Baby Shop
                        </div>
                        <span id="col-8 account-login">
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
