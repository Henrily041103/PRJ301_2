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
                    <div class="card-container"><img class="card-img-top" src="<c:url value="/images/${product.image}" />" /></div>
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        <h6 style="margin-top:5px" class="id">Id: ${product.proID}</h6>
                        <h6 style="margin-top:5px" class="id">Price: $${product.price}</h6>
                            <div class="mt-3 d-flex justify-content-between">    
                            <c:if test="${current_user!= null && current_user.role=='ad'}">
                                <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-dark'>Edit</a>
                            </c:if>
                            <c:if test="${current_user== null || current_user.role!='ad'}">
                                <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-primary'>View more</a>
                            </c:if>
                            <c:if test="${current_user== null || current_user.role!='ad'}">
                                <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-success'>Add to cart</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<nav aria-label="pageNav" >
    <ul class="pagination" style="">
        <c:if test="${pageNum != 1}">
            <li class="page-item"><a class="page-link" style="font-weight: 600; color: black" href="shop.do?page=${pageNum - 1}${search}">Previous</a></li>
            </c:if>
            <c:forEach begin="1" end="${numOfPage}" var="i">
                <c:choose>  
                    <c:when test="${pageNum eq i}">
                    <li class="page-item"><a class="page-link" style="color: white; background-color:black; font-weight: bolder" href="shop.do?page=${i}${search}">${i}</a></li>
                    </c:when>
                    <c:otherwise>
                    <li class="page-item"><a class="page-link" style="color: black" href="shop.do?page=${i}${search}">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pageNum lt numOfPage}">
            <li class="page-item"><a class="page-link" style="font-weight: 600; color: black" href="shop.do?page=${pageNum + 1}${search}">Next</a></li>
            </c:if>
    </ul>
</nav>
