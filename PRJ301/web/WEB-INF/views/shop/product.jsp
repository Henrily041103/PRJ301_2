<%-- 
    Document   : productedit
    Created on : 23-03-2023, 13:44:04
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<a href="<c:url value="/product/create.do" />"><i class="bi bi-pencil-square"></i> Create</a>
<c:if test="${current_user!= null && current_user.role=='ad'}">
    <div class="row">
        <div class="col">
            <div class="mb-3 mt-3">
                <label for="id" class="form-label">Product ID</label>
                <input disabled type="text" class="form-control" placeholder="Product ID" name="proID" value="${product.proID}">
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" placeholder="Product name" name="name" value="${product.name}">
            </div>
            <div class="mb-3">
                <label for="brand" class="form-label">Brand</label>
                <input type="text" class="form-control" placeholder="Product brand" name="proBrand" value="${product.proBrand}">
            </div>
            <div class="mb-3">
                <label for="type" class="form-label">Type</label>
                <input type="text" class="form-control" placeholder="Product type" name="proType" value="${product.proType}">
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Price</label>
                <input type="number" step="1" class="form-control" placeholder="Product type" name="price" value="${product.price}">
            </div>   
            <div class="mb-3">
                <label for="sale" class="form-label">Sale</label>
                <input type="number" step="0.1" class="form-control" placeholder="Product sale" name="sale" value="${product.sale}%">
            </div>
            <div class="mb-3">
                <label for="stock" class="form-label">Stock</label>
                <input type="number" step="1" class="form-control" placeholder="Product stock" name="stock" value="${product.stock}">
            </div>
            <div class="mb-3">
                <label for="ageGroup" class="form-label">Age group</label>
                <input type="number" step="1" class="form-control" placeholder="Product age group" name="ageGroup" value="${product.ageGroup}">
            </div>
            <div class="mb-3">
                <label for="size" class="form-label">Size</label>
                <input type="text" class="form-control" placeholder="Product size" name="size" value="${product.size}">
            </div>
            <div class="mb-3">
                <label for="size" class="form-label">Color</label>
                <input type="text" class="form-control" placeholder="Product color" name="color" value="${product.color}">
            </div>
            <button type="submit" class="btn btn-outline-success" name="op" value="update"><i class="bi bi-check-lg"></i> Update</button>
            <button type="submit" class="btn btn-outline-danger" name="op" value="cancel"><i class="bi bi-x-lg"></i> Cancel</button>
        </div>
        <div class="col">
            <img src="https://arc-anglerfish-arc2-prod-bostonglobe.s3.amazonaws.com/public/OHGTW7AZXYI6THMOPZS6ZC3G2A.jpg" class="img-fluid">
        </div>
    </div>
</c:if>

<c:if test="${current_user== null || current_user.role=='us'}">
    <div class="row">
        <div class="col">
            <div class="mb-3 mt-3">
                <label for="id" class="form-label">Product ID</label>
                <input disabled type="text" class="form-control" placeholder="Product ID" name="proID" value="${product.proID}">
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input disabled type="text" class="form-control" placeholder="Product name" name="name" value="${product.name}">
            </div>
            <div class="mb-3">
                <label for="brand" class="form-label">Brand</label>
                <input disabled type="text" class="form-control" placeholder="Product brand" name="proBrand" value="${product.proBrand}">
            </div>
            <div class="mb-3">
                <label for="type" class="form-label">Type</label>
                <input disabled type="text" class="form-control" placeholder="Product type" name="proType" value="${product.proType}">
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Price</label>
                <input disabled type="number" step="1" class="form-control" placeholder="Product type" name="price" value="${product.price}">
            </div>   
            <div class="mb-3">
                <label for="sale" class="form-label">Sale</label>
                <input disabled type="number" step="0.1" class="form-control" placeholder="Product sale" name="sale" value="${product.sale}%">
            </div>
            <div class="mb-3">
                <label for="stock" class="form-label">Stock</label>
                <input disabled type="number" step="1" class="form-control" placeholder="Product stock" name="stock" value="${product.stock}">
            </div>
            <div class="mb-3">
                <label for="ageGroup" class="form-label">Age group</label>
                <input disabled type="number" step="1" class="form-control" placeholder="Product age group" name="ageGroup" value="${product.ageGroup}">
            </div>
            <div class="mb-3">
                <label for="size" class="form-label">Size</label>
                <input disabled type="text" class="form-control" placeholder="Product size" name="size" value="${product.size}">
            </div>
            <div class="mb-3">
                <label for="size" class="form-label">Color</label>
                <input disabled type="text" class="form-control" placeholder="Product color" name="color" value="${product.color}">
            </div>
            <a class="btn btn-outline-danger" href="<c:url value="/shop/shop.do"/>">Return</a>
        </div>
        <div class="col">
            <img src="https://arc-anglerfish-arc2-prod-bostonglobe.s3.amazonaws.com/public/OHGTW7AZXYI6THMOPZS6ZC3G2A.jpg" class="img-fluid">
        </div>
    </div>
</c:if>




