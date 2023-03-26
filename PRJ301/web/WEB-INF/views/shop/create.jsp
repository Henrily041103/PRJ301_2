<%-- 
    Document   : create
    Created on : Mar 26, 2023, 3:46:26 PM
    Author     : ACER NITRO FPT
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
    <div class="col">
        <form action="<c:url value="/shop/create.do" />">
            <div class="mb-3 mt-3">
                <label for="id" class="form-label">Id:</label>
                <input type="text" class="form-control" id="id" placeholder="Product id" name="id" value="${product.proID}">
            </div>
            <div class="mb-3 mt-3">
                <label for="id" class="form-label">BRand:</label>
                <input type="text" class="form-control" id="brand" placeholder="Product brand" name="brand" value="${product.proBrand}">
            </div>
            <div class="mb-3">
                <label for="brand" class="form-label">Name:</label>
                <input type="text" class="form-control" id="name" placeholder="Product name" name="name" value="${product.name}">
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Price:</label>
                <input type="number" step="0.1" class="form-control" id="price" placeholder="Prodcut price" name="price" value="${product.price}">
            </div>
            <div class="mb-3">
                <label for="sale" class="form-label">Sale:</label>
                <input type="double" step="0.1" class="form-control" id="sale" placeholder="Product sale" name="sale" value="${product.sale}">
            </div>
            <div class="mb-3">
                <label for="stock" class="form-label">Stock:</label>
                <input type="number" step="1" class="form-control" id="stock" placeholder="Product stock" name="stock" value="${product.stock}">
            </div>
            <div class="mb-3">
                <label for="ageGroup" class="form-label">Age group</label>
                <input type="number" step="1" class="form-control" id="stock" placeholder="Product age group" name="ageGroup" value="${product.ageGroup}">
            </div>
            <div class="mb-3">
                <label for="size" class="form-label">Size:</label>
                <input type="text" class="form-control" id="Size:" placeholder="Product name" name="size" value="${product.size}">
            </div>
            <div class="mb-3">
                <label for="color" class="form-label">Color:</label>
                <input type="text" class="form-control" id="color" placeholder="Product color" name="color" value="${product.color}">
            </div>
            <button type="submit" class="btn btn-outline-success" name="op" value="create"><i class="bi bi-check-lg"></i> Create</button>
            <button type="submit" class="btn btn-outline-danger" name="op" value="cancel"><i class="bi bi-x-lg"></i> Cancel</button>
        </form>
    </div>
    <div class="col">
        <img src="<c:url value="/images/mickey.gif" />" alt=""/>
    </div>
</div>
    
        private String name;
    private String proID;
    private String proBrand;
    private String proType;
    private double price;
    private double sale;
    private int stock;
    private String ageGroup;
    private String size;
    private String color;