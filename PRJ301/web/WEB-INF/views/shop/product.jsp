<%-- 
    Document   : productedit
    Created on : 23-03-2023, 13:44:04
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<a href="<c:url value="/product/create.do" />"><i class="bi bi-pencil-square"></i> Create</a>
<c:if test="${current_user== null || current_user.role=='us'}">
    <div class="container" style = "margin-bottom: 10px">
        <div class="row">
            <div class="col-4">
                <div class="container w-100" style="width: 50rem;">  
                    <div class="card-container-pro"><img class="card-img-top" src="<c:url value="/images/${product.image}" />" /></div>
                </div>
            </div>
            <div class="col-4 card-body">
                <h2 style="color: blue" class="card-title">${product.name}</h2>
                <h3 style="margin-top:5px" class="id">Brand: ${product.proBrand}</h3>
                <h3 style="margin-top:5px" class="id">Type: ${product.proType}</h3>            
                <h3 style="margin-top:5px" class="id">Age Group: ${product.ageGroup}</h3>                                               
            </div>
            <div class="col-4 card-body">
                <c:if test="${product.size.trim()!=''}"><h3 style="margin-top:5px" class="id">Size: ${product.size}</h3></c:if>
                <c:if test="${product.color.trim()!=''}">
                    <h3 style="margin-top:5px; border: ${product.color}; border-style:solid; border-width: 7px" class="id">Color: ${product.color}</h3>             
                </c:if>        
                <h4 style="margin-top:5px" class="id">Stock: ${product.stock}</h4>
                <h4 style="margin-top:5px" class="id">Price: ${product.price}</h4>  
                <div class="mt-3 d-flex justify-content-between">   
                    <a href='<c:url value='/shop/product.do?id=${product.proID}'/>' class='btn btn-outline-success'>Add to cart</a>
                </div>
            </div>
        </div>      
    </div>
</c:if>




