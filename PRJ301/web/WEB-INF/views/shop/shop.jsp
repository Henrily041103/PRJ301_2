<%-- 
    Document   : shop
    Created on : 23-03-2023, 13:43:06
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${current_user.role=='us' || current_user==null}">
    <div class="container">
        <div class="row">
            <c:forEach var="product" items="${list}" varStatus="loop">
                <div class="col-md-3 my-3">
                    <div class="container w-100" style="width: 50rem;">  
                        <div class="card-container"><img class="card-img-top" src="<c:url value="/images/${product.image}"/>" /></div>
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <h6 style="margin-top:5px" class="id">Id: ${product.proID}</h6>
                            <h6 style="margin-top:5px" class="id">Price: $${product.price}</h6>
                            <div class="mt-3 d-flex justify-content-between">    
                                <c:if test="${current_user== null || current_user.role!='ad'}">
                                    <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-primary'>View more</a>
                                </c:if>
                                <c:if test="${current_user== null || current_user.role!='ad'}">
                                    <a href='<c:url value='/cart/add.do?proId=${product.proID}'/>' class='btn btn-outline-success'>Add to cart</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<c:if test="${current_user.role=='ad'}">
    <a href="<c:url value="/product/create.do" />" class='btn btn-outline-success'><i class="bi bi-pencil-square"></i> Create</a>
    <div class="row">
        <c:forEach var="product" items="${list}" varStatus="loop">
            <div class="col-md-3 my-3">
                <div class="container w-100" style="width: 50rem;">  
                    <div class="card-body">
                        <form action="<c:url value="/"/>">
                            <input disabled type="text" class="form-control" placeholder="Product id" name="id" id="id" value="Product id: ${product.proID}"/>
                            <input name="id" hidden id="id" type="text" value="${product.id}">
                            Name: <input name="name" style="margin-top:5px" id="name" type="text" value="${product.name}"></br>   
                            Brand: <input name="brand" style="margin-top:5px" id="brand" type="text" value="${product.proBrand}"></br>
                            Type: <input name="type" style="margin-top:5px" id="type" type="text" value="${product.proType}"></br>
                            Age Group: <input name="age-group" style="margin-top:5px" id="ageGroup" type="number" step = "1" value="${product.ageGroup}"></br>       
                            Stock: <input name="stock" style="margin-top:5px" id="stock" type="number" value="${product.stock}"></br>

                        <c:if test="${product.color.trim()!=''}">Color: <input style="margin-top:5px" id="color" type="text" value="${product.color}"></br></c:if>   
                        <c:if test="${product.size.trim()!=''}">Size: <input style="margin-top:5px" id="size" type="text" value="${product.size}"></br></c:if>   
                        Price: <input style="margin-top:5px" id="price" type="float" value="${product.price}"></br>       
                        <div class="mt-3 d-flex justify-content-between">    
                            <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-warning'>Update</a>
                            <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-danger'>Delete</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>

<nav aria-label="pageNav" >
    <ul class="pagination" style="">
        <c:if test="${pageNum != 1}">
            <li class="page-item"><a class="page-link" style="font-weight: 600; color: black" href="shop.do?page=${pageNum - 1}${search_term}">Previous</a></li>
            </c:if>
            <c:forEach begin="1" end="${numOfPage}" var="i">
                <c:choose>  
                    <c:when test="${pageNum eq i}">
                    <li class="page-item"><a class="page-link" style="color: white; background-color:black; font-weight: bolder" href="shop.do?page=${i}${search_term}">${i}</a></li>
                    </c:when>
                    <c:otherwise>
                    <li class="page-item"><a class="page-link" style="color: black" href="shop.do?page=${i}${search_term}">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pageNum lt numOfPage}">
            <li class="page-item"><a class="page-link" style="font-weight: 600; color: black" href="shop.do?page=${pageNum + 1}${search_term}">Next</a></li>
            </c:if>
    </ul>
</nav>
