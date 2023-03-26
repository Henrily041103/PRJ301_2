<%-- 
    Document   : user
    Created on : Mar 26, 2023, 12:49:57 PM
    Author     : ACER NITRO FPT
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">

    <div class="col-4">

        <div class="card-body">
            Username <input class="form-control" style="margin-top:5px" id="username" type="text" value="${account.username}"></br>   
            Role <input class="form-control" style="margin-top:5px" id="role" type="text" value="${account.role}"></br>

            Current password <input class="form-control" style="margin-top:5px" id="currentPass" type="text" value="${account.password}"></br>
            New password <input class="form-control" style="margin-top:5px" id="newPass1" type="text"></br>
            Retype password <input class="form-control" style="margin-top:5px" id="newPass2" type="text"></br>

            UserID <input class="form-control" style="margin-top:5px" id="userID" type="text" step = "1" value="${account.userID}"></br>       
            Email <input class="form-control" style="margin-top:5px" id="email" type="email" value="${account.email}"></br>
            Phone <input class="form-control" style="margin-top:5px" id="phone" type="text" value="${account.phone}"></br>
            Address <input class="form-control" style="margin-top:5px" id="address" type="text" value="${account.address}"></br>
            <div class="mt-3 d-flex justify-content-between">    
                <a href='<c:url value='/shop/user.do?id=${account.userID}'/>' class='btn btn-outline-warning'>Update</a>
                <a href='<c:url value='/shop/shop.do'/>' class='btn btn-outline-danger'>Cancel</a>
            </div>
        </div>


    </div>    
    <div class="col-8">   
        
    </div>             
</div>


