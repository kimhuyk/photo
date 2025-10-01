<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>Home</title>
<style>
.area-1 {
	background-image: url('resources/images/main/car.jpg');
}

.area-2 {
	background-image: url('resources/images/main/clothes.jpg');
}

.area-2-1 {
	background-image: url('resources/images/main/build.jpg');
	margin-left: 10px;
}

.area-3 {
	background-image: url('resources/images/main/tennis.jpg');
	margin-left: 10px;
}

.area-3-1 {
	background-image: url('resources/images/main/sky.jpg');
	margin-left: 20px;
}

/* SEARCH 텍스트 스타일 */

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css">    
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/homesearch.css"> 

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body style="background-color: #121212;">
<!-- 메인 섹션 -->
<section class="section-1" style="height: 200px;">
    <div class="top">
        <div class="area-1"> 
            <div class="area1-content">
                <form id="searchForm" name="searchForm" method="GET"
                	action="${pageContext.request.contextPath}/search/list">
                    <div class="search-group">
	                    <input type="text" name="keyword" class="search-input" placeholder="어떤걸 찾으세요?">
                    	<span id="searchspan">SEARCH</span>
                    	<button type="submit" class="search-icon">
                            <i class="fa fa-search"></i> <!-- Font Awesome 돋보기 아이콘 -->
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- 이미지 섹션 -->
<section class="section-2">
	<div class="center">
		<div class="area-2">
			<div class="area-2-write">
	        	<span>&nbsp;&nbsp;Clothes</span>
	    	</div>
	    	
		</div>
		<div class="area-2-1">
		    <div class="area-2-write">
		        <span>&nbsp;&nbsp;Traveler</span>
		    </div>
		</div>
    </div>
</section>

<section class="section-3">
    <div class="bottom">
        <div class="area-3">
        	<div class="area-3-write">
				<span>&nbsp;&nbsp;&nbsp;Sports</span>
            </div>
        </div>

        <div class="area-3-1">
        	<div class="area-3-write">
				<span>&nbsp;&nbsp;&nbsp;Dream</span>
            </div>
        </div>
    </div>
</section>

<section class="section-4">
	<div class="under">
		<div>
		
		</div>
	</div>
</section>

<div>
	<div>
	
	
	</div>
</div>


</body>
</html>
