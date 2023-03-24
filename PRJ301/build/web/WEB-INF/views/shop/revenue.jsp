<%-- 
    Document   : revenue
    Created on : 23-03-2023, 13:45:04
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form class="form-control" action="<c:url value='/shop/revenue-handler.do'/>">
    <select name="brand" class="btn btn-secondary dropdown-toggle" style="background-color:white; color: black" type="button" id="brand" data-bs-toggle="dropdown">
        <c:forEach var="brand" items="${brand_list}" varStatus="loop">
            <option class="dropdown-item" value="${brand}">${brand}</option>
        </c:forEach>
    </select>
    
    <select name="year" class="btn btn-secondary dropdown-toggle" style="background-color:white; color: black" type="button" id="year" data-bs-toggle="dropdown">
        <c:forEach var="year" items="${year_list}" varStatus="loop">
            <option class="dropdown-item" value="${year}">${year}</option>
        </c:forEach>
    </select>
    
    <button class="btn btn-primary btn-block">Get revenue</button>
</form>

<c:if test="${handle==true}">
    <div>${q1}</div>
    <div>${q2}</div>
    <div>${q3}</div>
</c:if>

