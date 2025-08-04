<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/complete.css">

<div class="features-1">
	<div class="body-container">	

        <div class="row justify-content-md-center mt-5">
            <div class="col">
                <div class="div-form">
                       <h4 class="text-center fw-bold">${title}</h4>
                       <hr class="mt-4">
                       
	                <div class="d-grid p-3">
						<p class="text-center">${message}</p>
	                </div>
                       
                       <div class="d-grid">
                           <button type="button" class="login__button" onclick="location.href='${pageContext.request.contextPath}/home';">메인화면</button>
                       </div>
                </div>

            </div>
        </div>
	        
	</div>
</div>
