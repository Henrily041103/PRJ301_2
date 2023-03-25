<%-- 
    Document   : productedit
    Created on : 23-03-2023, 13:44:04
    Author     : Admin
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>${product.name}</h1>
<c:if test="${product.size!=' '}"><h6 style="margin-top:5px" class="id">Size: ${product.size}</h6></c:if>
<c:if test="${product.size==' '}"></br></c:if>
<c:if test="${product.color!=' '}"><h6 style="margin-top:5px" class="id">Color ${product.color}</h6></c:if>
<c:if test="${product.color==' '}"></br></c:if>