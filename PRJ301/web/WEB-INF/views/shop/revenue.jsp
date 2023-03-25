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
    <div class="progress" style="height:40px; margin-top: 25px">
        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${q1/(q1+q2+q3)*100}%" aria-valuenow="${q2/(q1+q2+q3)*100}" aria-valuemin="0" aria-valuemax="${(q1+q2+q3)}">Q1</div>
    </div>
    
    <br>
    
    <div class="progress" style="height:40px; margin-top: 25px">
        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${q2/(q1+q2+q3)*100}%" aria-valuenow="${q2/(q1+q2+q3)*100}" aria-valuemin="0" aria-valuemax="${(q1+q2+q3)}">Q2</div>
    </div>
    
    <br>
    
    <div class="progress" style="height:40px; margin-top: 25px">
        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar"  style="width: ${q3/(q1+q2+q3)*100}%" aria-valuemin="${q3/(q1+q2+q3)*100}" aria-valuemax="${(q1+q2+q3)}">Q3</div>
    </div>
</c:if>

