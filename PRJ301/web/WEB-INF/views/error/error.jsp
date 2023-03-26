<%-- 
    Document   : error
    Created on : 23-03-2023, 14:36:48
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${error_message!=null}"><div class="alert alert-warning">${error_message}</div></c:if>