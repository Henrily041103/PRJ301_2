<%-- 
    Document   : register
    Created on : 23-03-2023, 13:42:04
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="logreg-form">
    <form action="<c:url value="/login/register-handler.do"/>" method="post" class="form-signup">
        <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Sign up</h1>

        <label for="user">Username: </label>
        <input name="user" type="text" id="user" class="form-control" placeholder="User name" required autofocus>
        <label for="user">Password: </label>
        <input name="pass" type="password" id="pass" class="form-control" placeholder="Password" required >
        <label for="user">Email: </label>
        <input name="email" type="email" id="email" class="form-control" placeholder="Email" required>
        <label for="user">Retype Password: </label>
        <input name="repass" type="password" id="repass" class="form-control" placeholder="Repeat Password" required>

        <button class="btn btn-success btn-block" type="submit"><i class="fas fa-user-plus"></i> Sign Up</button>
        <a href="<c:url value="/login/login.do"/>" class="btn btn-primary btn-block"> <i class="fas fa-user-plus"></i>Login</a>
        <hr>
    </form>
    <br>
</div>
