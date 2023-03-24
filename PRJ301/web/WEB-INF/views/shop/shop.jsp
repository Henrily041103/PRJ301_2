<%-- 
    Document   : shop
    Created on : 23-03-2023, 13:43:06
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table table-striped">
    <tr>
        <th>Name</th>
        <th>Price</th>
        <th>Sale</th>
        <th>Stock</th>
        <th>Age Group</th>
        <th>Size</th>
        <th>Color</th>
        <th>Operation</th>
    </tr>
    <c:forEach var="product" items="${list}">
        <tr>
            <td>${product.name}</td>
            <td>${product.price}</td>
            <td>${product.sale}</td>
            <td>${product.stock}</td>
            <td>${product.ageGroup}</td>
            <td>${product.size}</td>
            <td>${product.color}</td>
            <td>
                <c:if test="${current_user!= null && current_user.role=='ad'}">
                    <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-primary btn-block'>Edit</a>
                </c:if>
                <c:if test="${current_user== null || current_user.role!='ad'}">
                    <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-primary btn-block'>View more</a>
                </c:if>
            </td>
            
        </tr>
    </c:forEach>
</table>
