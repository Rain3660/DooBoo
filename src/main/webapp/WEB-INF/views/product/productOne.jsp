<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp" %>
<!--
		상품 Detail : ${produtVO}
		판매자가판매하고 있는 상품 리스트 : ${productList}  
 -->
<div class="container">
	<div class="row"> <!-- 상단에 상품 이미지 -->
		<div id="carouselExampleIndicators" class="carousel slide col-md-6 carousel slide mx-auto" data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<c:forEach var="boardFile" items="${productVO.productImageList}" varStatus="status">
					<div class="carousel-item <c:if test="${status.index eq 0 }">active</c:if>">
						<img src="${STATIC_IMAGE_ROOT}${boardFile.filePath}" class="d-block w-100" alt="${boardFile.fileName}">
					</div>
    			</c:forEach>				
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
				${productVO.address}
			</div>
			<div class="float-end" id="likeOrDislike">
				<!-- 좋아요 했을 때  <i class="far fa-heart"></i>-->
				</i><!-- 좋아요 안 했을 때 <i class="fas fa-heart">-->
				<!-- Ajax 로 좋아요 누르면 > DB 업데이트 > 화면 업데이트 로 바꾸기 -->
			</div>
			
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto"><!-- 제목 -->
			${productVO.title }
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto"><!-- 가격 -->
			${productVO.price }
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto"><!-- 내용 -->
			${productVO.content }
		</div>
	</div>
	<div class="row">
	
		<div class="col-md-6 mx-auto border-bottom"><!-- Like , hit -->
			<div class="float-start">
				<p class="text-secondary fs-6">${productVO.hit } | ${productVO.likeCount }</p>
			</div>
			<div class="float-end">
				<button id="send-to-btn" class="btn btn-secondary onclick="fn_kakoShare()">	
					    공유하기
			    </button>
				<input type="button" class="btn btn-secondary" value="판매자와 채팅하기">  
			</div>
		</div>
	</div>
	<div class="row">
		<!-- 이 판매자가 팔고있는 상품 보여주면 될듯? -->
	</div>
</div>
<script>
	$(document).ready(function(){
		$('.carousel').carousel()
		
		
	})
</script>
<!-- 카카오 공유하기 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
            Kakao.init('5ed12af5dc728fe381f7652e93c6b462');
            Kakao.isInitialized();
</script>
<script type="text/javascript">
function fn_kakoShare(){
	Kakao.Link.sendDefault({
		  objectType: 'feed',
		  content: {
		    title: '${productVO.title}',
		    description: '${productVO.content}',
		    imageUrl:
				'${STATIC_IMAGE_ROOT}${productVO.images}',
		    link: {
		      mobileWebUrl: 'http://sih8859.iptime.org:9099/p.selectOneProduct?productNo=${productVO.productNo}',
		      webUrl :'http://sih8859.iptime.org:9099/p.selectOneProduct?productNo=${productVO.productNo}',
		    },
		  },
		  social: {
		    likeCount: ${productVO.likeCount},
		    sharedCount: 30,
		  },
		  buttons: [
		    {
		      title: '상품보러가기',
		      link: {
		        mobileWebUrl: 'http://sih8859.iptime.org:9099/p.selectOneProduct?productNo=${productVO.productNo}',
		        webUrl :'http://sih8859.iptime.org:9099/p.selectOneProduct?productNo=${productVO.productNo}',
		      },
		    },
		  ]
		});
}
</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>