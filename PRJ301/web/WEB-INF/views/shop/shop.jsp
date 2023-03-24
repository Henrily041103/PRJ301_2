<%-- 
    Document   : shop
    Created on : 23-03-2023, 13:43:06
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <div class="row">
        <c:forEach var="product" items="${list}" varStatus="loop">
            <div class="col-md-3 my-3">
                <div class="container w-100" style="width: 50rem;">  
                    <img class="card-img-top" src="<c:url value="https://www.cultofpedagogy.com/wp-content/uploads/2020/03/IDK-Featured.png" />" />
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        <h6 style="margin-top:5px" class="id">Id: ${product.proID}</h6>
                        <h6 style="margin-top:5px" class="id">Price: $${product.price}</h6>
                        <c:if test="${product.size!=' '}"><h6 style="margin-top:5px" class="id">Size: ${product.size}</h6></c:if>
                        <c:if test="${product.size==' '}"></br></c:if>
                        <c:if test="${product.color!=' '}"><h6 style="margin-top:5px" class="id">Color ${product.color}</h6></c:if>
                        <c:if test="${product.color==' '}"></br></c:if>
                        <h6 style="margin-top:5px" class="id">Size: ${product.size}</h6>
                        <h6 style="margin-top:5px" class="price">Color ${product.color}</h6>
                        <div class="mt-3 d-flex justify-content-between">    
                            <c:if test="${current_user!= null && current_user.role=='ad'}">
                                <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-dark'>Edit</a>
                            </c:if>
                            <c:if test="${current_user== null || current_user.role!='ad'}">
                                <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-primary'>View more</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%--For displaying Previous link except for the 1st page --%>
<c:if test="${pageNum != 1}">
    <td><a href="shop.do?page=${pageNum - 1}">Previous</a></td>
</c:if>

<%--For displaying Page numbers. 
The when condition does not display a link for the current page--%>
<table border="1" cellpadding="5" cellspacing="5">
    <tr>
        <c:forEach begin="1" end="${numOfPage}" var="i">
            <c:choose>  
                <c:when test="${pageNum eq i}">
                    <td>${i}</td>
                </c:when>
                <c:otherwise>
                    <td><a href="shop.do?page=${i}">${i}</a></td>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
    </tr>
</table>

<%--For displaying Next link --%>
<c:if test="${pageNum lt numOfPage}">
    <td><a href="shop.do?page=${pageNum + 1}">Next</a></td>
</c:if>
