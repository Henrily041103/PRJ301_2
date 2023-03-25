<%-- 
    Document   : revenue
    Created on : 23-03-2023, 13:45:04
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" style="background-color:white; color: black" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown">
        Choose brand
    </button>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
        <c:forEach var="brand" items="${list}" varStatus="loop">

            <li><a class="dropdown-item" href="revenue.do?brand=${product.brand}">${product.brand}</a></li>

        </c:forEach>

    </ul>
</div>

<div class="progress" style="height:40px; margin-top: 25px">
    <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${this-total}%" aria-valuenow="${this-total}" aria-valuemin="0" aria-valuemax="${total}">Q1</div>
</div>

<br>

<div class="progress" style="height:40px; margin-top: 25px">
    <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${this-total}%" aria-valuenow="${this-total}" aria-valuemin="0" aria-valuemax="${total}">Q2</div>
</div>

<br>

<div class="progress" style="height:40px; margin-top: 25px">
    <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar"  style="width: ${this-total}%" aria-valuemin="${this-total}" aria-valuemax="${total}">Q3</div>
</div>

<br>

<div class="progress" style="height:40px; margin-top: 25px">
    <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar"  style="width: ${this-total}%" aria-valuemin="${this-total}" aria-valuemax="${total}">Q4</div>
</div>

<br>

