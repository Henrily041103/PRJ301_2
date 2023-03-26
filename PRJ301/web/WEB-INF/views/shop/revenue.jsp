<%-- 
    Document   : revenue
    Created on : 23-03-2023, 13:45:04
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form class="form-control" action="<c:url value='/shop/revenue-handler.do'/>">
    <select name="brand" class="btn btn-secondary dropdown-toggle" style="background-color:white; color: black" type="button" id="brand" data-bs-toggle="dropdown">
        <p>Brand</p>
        <c:forEach var="brand" items="${brand_list}" varStatus="loop">
            <option class="dropdown-item" value="${brand}">${brand}</option>
        </c:forEach>
    </select>

    <select name="year" class="btn btn-secondary dropdown-toggle" style="background-color:white; color: black" type="button" id="year" data-bs-toggle="dropdown">
        <c:forEach var="year" items="${year_list}" varStatus="loop">
            <option class="dropdown-item" value="${year}">${year}</option>
        </c:forEach>
    </select>

    <button class="btn btn-outline-success btn-block">Get revenue</button>
</form>

<c:if test="${handle==true}">

    <h3 style="color:cyan; margin-top: 10px">Q1: $${q1}</h3>
    <div class="progress" style="height:40px; margin-top: 5px">
        <div class="progress-bar bg-info" role="progressbar" style="width: ${q1/(q1+q2+q3)*100}%" aria-valuenow="${q2/(q1+q2+q3)*100}" aria-valuemin="0" aria-valuemax="${(q1+q2+q3)}">$${q1}</div>
    </div>

    <br>

    <h3 style="color: green">Q2: $${q2}</h3>
    <div class="progress" style="height:40px; margin-top: 5px">
        <div class="progress-bar bg-success" role="progressbar" style="width: ${q2/(q1+q2+q3)*100}%" aria-valuenow="${q2/(q1+q2+q3)*100}" aria-valuemin="0" aria-valuemax="${(q1+q2+q3)}">$${q2}</div>
    </div>

    <br>

    <h3 style="color:orange">Q3: $${q3}</h3>
    <div class="progress" style="height:40px; margin-top: 5px">
        <div class="progress-bar bg-warning" role="progressbar"  style="width: ${q3/(q1+q2+q3)*100}%" aria-valuemin="${q3/(q1+q2+q3)*100}" aria-valuemax="${(q1+q2+q3)}">$${q3}</div>
    </div>

    <br>
    
    <h3 style="color:black">TOTAL: $${q1+q2+q3}</h3>
    <div class="progress" style="height:50px; margin-top: 5px">
        <div class="progress-bar progress-bar-striped bg-info progress-bar-animated" role="progressbar" style="width: ${q1/(q1+q2+q3)*100}%" aria-valuenow="${q2/(q1+q2+q3)*100}" aria-valuemin="0" aria-valuemax="${(q1+q2+q3)}">${q1}</div>
        <div class="progress-bar progress-bar-striped bg-success progress-bar-animated" role="progressbar" style="width: ${q2/(q1+q2+q3)*100}%" aria-valuenow="${q2/(q1+q2+q3)*100}" aria-valuemin="0" aria-valuemax="${(q1+q2+q3)}">${q2}</div>
        <div class="progress-bar progress-bar-striped bg-warning progress-bar-animated" role="progressbar"  style="width: ${q3/(q1+q2+q3)*100}%" aria-valuemin="${q3/(q1+q2+q3)*100}" aria-valuemax="${(q1+q2+q3)}">${q3}</div>
    </div>
</c:if>

