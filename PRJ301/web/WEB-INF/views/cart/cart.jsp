<%-- 
    Document   : cart
    Created on : 23-03-2023, 13:43:28
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="table-responsive">
    <table class="table">
        <thead>
            <tr>
                <th scope="col" class="border-0 bg-light">
                    <div class="p-2 px-3 text-uppercase">Product</div>
                </th>
                <th scope="col" class="border-0 bg-light">
                    <div class="py-2 text-uppercase">Price</div>
                </th>
                <th scope="col" class="border-0 bg-light">
                    <div class="py-2 text-uppercase">Amount</div>
                </th>
                <th scope="col" class="border-0 bg-light">
                    <div class="py-2 text-uppercase">Total</div>
                </th>
                <th scope="col" class="border-0 bg-light">
                    <div class="py-2 text-uppercase">Operations</div>
                </th>
            </tr>
        </thead>
        <tbody>
        <form action="<c:url value="/cart/buy_handler.do"/>">
            <button type="submit" class="text-dark btn btn-outline-success" name="op" value="buy" style="margin-right: 10px; margin-bottom: 10px">
                <i class="bi bi-cash-stack" style="margin-right: 5px; color: green"></i>Buy
            </button>
            <c:forEach var="entry" items="${cart}">
                <tr>
                    <td scope="row">
                        <div class="p-2">
                            <img src="<c:url value="/images/${entry.key.image}"/>" alt="" width="70" class="img-fluid rounded shadow-sm">
                            <div class="ml-3 d-inline-block align-middle">
                                <h5 class="mb-0"> <a href="#" class="text-dark d-inline-block">${entry.key.name}</a></h5><span class="text-muted font-weight-normal font-italic"></span>
                            </div>
                        </div>
                    </td>
                    <td class="align-middle">
                        <h5>$${entry.key.price}</h5>
                        <h6>-${entry.key.sale}%</h6>
                        <strong><h5>=$${entry.key.price*((100-entry.key.sale)*0.01)}</h5></strong>
                    </td>
                    <td class="align-middle">
                        <h5>${entry.value}</h5>
                    </td>
                    <td class="align-middle">
                        <h5>$${entry.value*entry.key.price*((100-entry.key.sale)*0.01)}</h5>
                    </td>
                    <td class="align-middle">
                        <input name="proId" value="${entry.key.proID}" hidden=""/>
                        <button type="submit" class="text-dark btn btn-outline-success" name="op" value="add">
                            Add<i class="bi bi-plus-lg" style="margin-left: 3px"></i>
                        </button>
                        <button type="submit" class="text-dark btn btn-outline-warning" name="op" value="sub">
                            Subtract<i class="bi bi-dash-lg" style="margin-left: 3px"></i>
                        </button>
                        <button type="submit" class="text-dark btn btn-outline-danger" name="op" value="remove">
                            Remove<i class="bi bi-x-lg" style="margin-left: 3px"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
            <button type="submit" class="text-dark btn btn-outline-danger" name="op" value="empty" style="margin-right: 10px; margin-bottom: 10px">
                <i class="bi bi-trash3" style="margin-right: 5px; color: red"></i>Empty
            </button>
            <a href='<c:url value='/shop/shop.do'/>' class='btn btn-outline-info' style="margin-right: 5px; margin-bottom: 10px; color: blue">
                <i class="bi bi-arrow-90deg-left" style="margin-right: 5px; color: blue"></i>Go back to shop
            </a>

        </form>
        </tbody>
    </table>
    <h3 style="margin-bottom:100px; margin-top: 20px">Total: $${total}</h3>
</div>
