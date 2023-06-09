<%-- 
    Document   : register
    Created on : 23-03-2023, 13:42:04
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="logreg-form">
    <section class="vh-100">
        <div class="container-fluid h-custom">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-md-9 col-lg-6 col-xl-5">
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                         class="img-fluid" alt="Sample image">
                </div>
                <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                    <form class="form-signin" action="<c:url value="/login/register-handler.do"/>" method="post">
                        <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start" style="margin-bottom: 5px; font-weight: bold">
                            <h1 class="lead fw-normal mb-0 me-3">Sign in</h1>                     
                        </div>
                        <!-- Email input -->
                        <div class="form-outline mb-4" >
                            <label class="form-label" for="user">Username</label>
                            <input name="user"  type="text" id="user" class="form-control" placeholder="Username" required autofocus>

                        </div>
                        <div class="form-outline mb-4">
                            <label class="form-label" for="pass">Email </label>
                            <input name="email"  type="email" id="pass" class="form-control" placeholder="Email" required>          
                        </div>
                         <div class="form-outline mb-4">
                            <label class="form-label" for="pass">Password </label>
                            <input name="pass"  type="password" id="pass" class="form-control" placeholder="Password" required>          
                        </div>
                         <div class="form-outline mb-4">
                            <label class="form-label" for="pass">Retype Password </label>
                            <input name="repass"  type="password" id="pass" class="form-control" placeholder="Retype Password" required>          
                        </div>
                        <div class="text-center text-lg-start mt-4 pt-2">
                            <button class="btn btn-success btn-block" type="submit"><i class="fas fa-sign-in-alt"></i>Sign up</button>
                            <p class="small fw-bold mt-2 pt-1 mb-0">Already have an account? <a href="<c:url value="/login/login.do"/>"
                                                                                              class="link-danger">Login</a></p>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </section>
</div>
