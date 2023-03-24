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
