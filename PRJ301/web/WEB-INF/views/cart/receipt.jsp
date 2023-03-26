<%-- 
    Document   : receipt
    Created on : 25-03-2023, 10:01:45
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<button onclick=window.print(.5) class="text-dark btn btn-outline-primary">Print Receipt</button>
<a href='<c:url value='/shop/shop.do'/>' class='btn btn-outline-info' style="margin-right: 5px; margin-bottom: 10px; color: blue">
    <i class="bi bi-arrow-90deg-left" style="margin-right: 5px; color: blue"></i>Go back to shop
</a>
<h1 style="text-align: center; font-weight: bold; color: blue; font-style: italic">Receipt</h1>
<div class="table-responsive print-container">
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
            </tr>
        </thead>
        <tbody>
        <form action="<c:url value="/cart/buy_handler.do"/>">
            <c:forEach var="entry" items="${order}">
                <tr>
                    <td scope="row">
                        <div class="p-2">
                            <div class="ml-3 d-inline-block align-middle">
                                <h5 class="mb-0"> <a href="#" class="text-dark d-inline-block">Name: ${entry.key.name}</a></h5><span class="text-muted font-weight-normal font-italic"></span>
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
                </tr>
            </c:forEach>
        </form>
        </tbody>
    </table>
    <h3 style="margin-bottom:100px; margin-top: 20px">Total: ${total}</h3>
</div>
