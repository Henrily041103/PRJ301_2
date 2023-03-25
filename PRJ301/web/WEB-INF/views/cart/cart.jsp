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
                    <div class="py-2 text-uppercase">Discount</div>
                </th>
                <th scope="col" class="border-0 bg-light">
                    <div class="py-2 text-uppercase">Price</div>
                </th>
                <th scope="col" class="border-0 bg-light">
                    <div class="py-2 text-uppercase">Amount</div>
                </th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="entry" items="${cart}">
                <tr>
                    <td scope="row">
                        <div class="p-2">
                            <img src="<c:url value="/images/${entry.key.image}"/>" alt="" width="70" class="img-fluid rounded shadow-sm">
                            <div class="ml-3 d-inline-block align-middle">
                                <h5 class="mb-0"> <a href="#" class="text-dark d-inline-block">${entry.key.brandId} ${entry.key.type}</a></h5><span class="text-muted font-weight-normal font-italic"></span>
                            </div>
                        </div>
                    </td>
                    <td class="align-middle">
                        <h5>${entry.key.sale}</h5>
                        <h6  style = "text-decoration: line-through">${entry.key.amount}</h6>
                    </td>
                    <td class="align-middle">
                        <strong>${entry.key.amount*((1-entry.key.sale)*0.01)}</strong>
                    </td>
                    <td class="align-middle"><a href="#" class="text-dark">    
                            <button type="submit" class="btn btn-warning" name="op" value="remove"><i class="bi bi-x-lg"></i>Remove</button>
                        </a>
                    </td>
                </tr> 
            </c:forEach>
        </tbody>
    </table>
</div>
