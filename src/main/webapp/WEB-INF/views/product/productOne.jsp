<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<div class="row"> <!-- 상단에 상품 이미지 -->
		<div id="carouselExampleIndicators" class="carousel slide col-md-6 carousel slide mx-auto" data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="resources/image/DoobooLogo.png" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="resources/image/DoobooLogo.png" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="resources/image/DoobooLogo.png" class="d-block w-100" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto border-bottom">
			<div class="float-start"><!-- 판매자 정보 --> 
				${product.address }
			</div>
			<div class="float-end">
				<i class="far fa-heart"></i><!-- 좋아요 했을 때 -->
				<i class="fas fa-heart"></i><!-- 좋아요 안 했을 때 -->
				<!-- Ajax 로 좋아요 누르면 > DB 업데이트 > 화면 업데이트 로 바꾸기 -->
			</div>
			
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto"><!-- 제목 -->
			${productDTO.title }
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto"><!-- 가격 -->
			${productDTO.price }
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto"><!-- 내용 -->
			${productDTO.content }
		</div>
	</div>
	<div class="row">
	
		<div class="col-md-6 mx-auto border-bottom"><!-- Like , hit -->
			<div class="float-start">
				<p class="text-secondary fs-6">${productDTO.hit } | ${likes }</p>
			</div>
			<div class="float-end">
				<input type="button" class="btn btn-secondary" value="판매자와 채팅하기">  
			</div>
		</div>
	</div>
	<%-- <div>
    	<label>첨부파일</label>
    	<c:forEach var="boardFile" items="${board.productImageList}" varStatus="status">
    		<div id="div_file_${boardFile.fileNo}">
    			<img src="${STATIC_IMAGE_ROOT }${boardFile.filePath }" width="100px">
				<span>${boardFile.fileName}<button type="button" class="btn-close file-close" onclick="removeFile(this)" data-file-seq="${boardFile.fileNo}" aria-label="Close"></button></span>						
    		</div>
    	</c:forEach>
    </div> --%>
	<div class="row">
		<!-- 이 판매자가 팔고있는 상품 보여주면 될듯? -->
	</div>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>