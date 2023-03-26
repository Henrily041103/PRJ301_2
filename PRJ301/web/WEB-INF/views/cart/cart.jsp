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
            <button style="margin-right: 10px" type="submit" name="op" value="back" class="text-dark btn-outline-warning"><i class="bi bi-arrow-left">Back</i></button>
            <button type="submit" class="text-dark btn btn-danger" name="op" value="empty">
                <i class="bi bi-trash3"></i>Empty
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
                        <h5>${entry.key.price}</h5>
                        <h6>-${entry.key.sale}%</h6>
                        <strong><h5>=${entry.key.price*((100-entry.key.sale)*0.01)}</h5></strong>
                    </td>
                    <td class="align-middle">
                        <h5>${entry.value}</h5>
                    </td>
                    <td class="align-middle">
                        <h5>${entry.value*entry.key.price*((100-entry.key.sale)*0.01)}</h5>
                    </td>
                    <td class="align-middle">
                        <input name="proId" value="${entry.key.proID}" hidden=""/>
                        <button type="submit" class="text-dark btn btn-warning" name="op" value="remove">
                            <i class="bi bi-x-lg"></i>Remove
                        </button>
                        <button type="submit" class="text-dark btn btn-warning" name="op" value="add">
                            <i class="bi bi-plus-lg"></i>Add
                        </button>
                        <button type="submit" class="text-dark btn btn-warning" name="op" value="sub">
                            <i class="bi bi-dash-lg"></i>Subtract
                        </button>
                    </td>
                </tr> 
            </c:forEach>
            <button style = "margin-left: 10px" type="submit" class="text-dark btn btn-success" name="op" value="buy">
                <i class="bi bi-check-lg"></i>Buy
            </button>
        </form>
        </tbody>
    </table>
</div>
