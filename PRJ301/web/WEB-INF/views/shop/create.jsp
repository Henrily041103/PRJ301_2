<%-- 
    Document   : create
    Created on : Mar 26, 2023, 3:46:26 PM
    Author     : ACER NITRO FPT
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
    <div class="col">
        <form action="<c:url value="/product/create.do" />">
            <div class="mb-3 mt-3">
                <label for="id" class="form-label">Id:</label>
                <input type="text" class="form-control" id="id" placeholder="Product id" name="id" value="${product.proID}">
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">Name:</label>
                <input type="text" class="form-control" id="name" placeholder="Toy name" name="name" value="${product.name}">
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Price:</label>
                <input type="number" step="0.1" class="form-control" id="price" placeholder="Toy price" name="price" value="${toy.price}">
            </div>
            <div class="mb-3">
                <label for="expDate" class="form-label">Expired date:</label>
                <input type="date" class="form-control" id="expDate" placeholder="Toy expired date" name="expDate" 
                       value="<fmt:formatDate value="${toy.expDate}" pattern="yyyy-MM-dd" />">
            </div>
            <div class="mb-3">
                <label for="brandId" class="form-label">Brand id:</label>
                <%--<input type="text" class="form-control" id="brandId" placeholder="Toy brand id" name="brandId" value="${toy.brandId}">--%>
                <select name="brandId" class="form-control">
                    <c:forEach var="brand" items="${list}">
                        <option value="${brand.id}" ${brand.id==toy.brandId?"selected":""}>${brand.name}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-outline-success" name="op" value="create"><i class="bi bi-check-lg"></i> Create</button>
            <button type="submit" class="btn btn-outline-danger" name="op" value="cancel"><i class="bi bi-x-lg"></i> Cancel</button>
        </form>
        <i style="color:red;">${message}</i>
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