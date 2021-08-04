<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../layout/header.jsp" %>
<!--
		상품 Detail : ${produtVO}
		판매자가판매하고 있는 상품 리스트 : ${productList}  
 -->
<style>
	.fa-heart:hover{
		cursor: pointer;
	}
	.product-link{
		cursor: pointer;
	}
</style>
<div class="container">
	<div class="row"> <!-- 상단에 상품 이미지 -->
		
		<!-- 이미지 첨부를 안했을 경우에는 default 이미지를 사용-->
		<c:if test="${imageListSize eq 0 }">
			<div id="carouselExampleIndicators" class="carousel slide col-md-6 carousel slide mx-auto" data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			</div>
			<div class="carousel-inner">
					<div class="carousel-item active">
						<img src="resources/image/noimage.png" class="d-block w-100" alt="${boardFile.fileName}">
					</div>			
			</div>
		</div>		
		</c:if>
		<!-- 이미지를 첨부했을 경우 -->
		<c:if test="${imageListSize ne 0 }">
		<!-- 인덱스 : k.index , 순번 : k.count -->
			<div id="carouselExampleControls" class="carousel slide col-md-6 mx-auto" data-bs-ride="carousel">
				<div class="carousel-inner">
					<c:forEach var="image" items="${productVO.imageList }" varStatus="k">
						<div class="carousel-item <c:if test="${k.index eq 0 }">active</c:if>">
      						<img src="${STATIC_IMAGE_ROOT}${image}" class="d-block w-100" alt="...">
    					</div>
					</c:forEach>
				</div>
				<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="visually-hidden">Next</span>
				</button>
			</div>	
		</c:if>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto border-bottom">
			<div class="float-start"><!-- 판매자 정보 --> 


				${productVO.address}<button type="button" class="btn btn-success" onclick="window.open('m.dealLocationByMap?location=${productVO.address}&image=${OneImage}','거래지역 근처 확인하기','width=432,height=355,location=no,status=no,scrollbars=yes');">거래지역 근처 확인하기</button>

			

			</div>
			<div class="float-end" id="likeOrDislike">
				
				<!-- Ajax 로 좋아요 누르면 > DB 업데이트 > 화면 업데이트 로 바꾸기 -->
				
				<!-- 빈하트 -->
				<c:if test="${likeOrDislike eq 0 }">
					 <i class="far fa-heart" id="like"></i>
				</c:if>
				<!-- 꽉찬하트 -->
				<c:if test="${likeOrDislike eq 1 }">
					 <i class="fas fa-heart" id="dislike"></i>
				</c:if>
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
				<button id="send-to-btn" class="btn btn-secondary" onclick="fn_kakoShare()">	
					    공유하기
			    </button>
			    <!-- 자신의 게시물이 아닌경우에만 채팅 버튼이 보여진다.+로그인했을시만 보인다 -->
			    <c:if test="${loginUser ne null && productVO.regNo ne loginUser.memberNo}">
					<input type="button" class="btn btn-secondary" value="판매자와 채팅하기" id="chatting_btn" > 		 
			    </c:if>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 mx-auto">
			<h3 class="text-center">판매자가 판매중인 상품</h3>
			<div class="card-group">
				<!-- 판매자가 판매중인 상품이 있을 때 -->
				<c:if test="${productListSize ne 0 }">
					<c:forEach	var="product" items="${productList }">
						<div class="card product-link" data-productno="${product.productNo }">
							<c:if test="${product.images eq null }">
								<img src="resources/image/noimage.png" class="card-img-top" alt="..." style="height: 120px;">
							</c:if>
							<c:if test="${product.images ne null }">
								<img src="${STATIC_IMAGE_ROOT}${product.images.split(',')[0]}" class="card-img-top" alt="..." style="height: 120px;">
							</c:if>
							<div class="card-body">
								<h5 class="card-title">${product.title }</h5>
								<p class="card-text">${product.price }</p>
								<p class="card-text">${product.address }</p>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<!-- 판매자가 판매중인 상품이 없을 때 -->
				<c:if test="${productListSize eq 0 }">
					<h3 class="text-center">등록된 상품이 없습니다.</h3>					
				</c:if>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){		
		
		$('#chatting_btn').on('click',function(){
			$.ajax({
				url:'c.getRoomNumber',
				type:'post',
				data:'buyerNo=${loginUser.memberNo}&sellerNo=${productVO.regNo}',
				dataType:'json',
				success : function(resultMap){
					if(resultMap!=null){
						var url="chatPage?memberNo=${loginUser.memberNo}&sellerNo=${productVO.regNo}&buyer=0&roomNumber="+resultMap.roomNumber;
						window.open(url,'대화창','width=530,height=424,location=no,toolbar=no,status=no,scrollbars=yes');
						//location.href="window.open('chatPage?memberNo=${loginUser.memberNo}&sellerNo=${productVO.regNo}&roomNumber='"+resultMap.roomNumber+"','대화창','width=530,height=424,location=no,toolbar=no,status=no,scrollbars=yes');";
						//location.href='chatPage?memberNo=${loginUser.memberNo}&sellerNo=${productVO.regNo}&roomNumber='+resultMap.roomNumber;
					}
				}
			})
		})
		
		
		// <i class="far fa-heart" id="like"></i> : 빈하트
		// <i class="fas fa-heart" id="dislike"></i> : 꽉찬하트
		
		$('#likeOrDislike').on('click' , '#like' , function(){
			
			if('${productVO.regNo}' == '${loginUser.memberNo}'){
				alert('자신의 상품에는 좋아요를 누를 수 없습니다.');
				return;
			}
			 
			var obj = {
					productNo : ${productVO.productNo},
					regNo : ${loginUser.memberNo}
			};
			
			$.ajax({
				url : 'p.iLikeThisProduct',
				type : 'post',
				data : JSON.stringify(obj),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(resultMap) {
					
					if(resultMap.result - 1 == 0){
						//$('#likeOrDislike').html('<i class="fas fa-heart" id="dislike"></i>');
						location.href = 'p.selectOneProduct?productNo=${productVO.productNo}';
					}
	
				}
			})
		})
		$('#likeOrDislike').on('click' , '#dislike' , function(){
			var obj = {
					productNo : ${productVO.productNo},
					regNo : ${loginUser.memberNo}
			};
			
			$.ajax({
				url : 'p.iDontLikeThisProduct',
				type : 'post',
				data : JSON.stringify(obj),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(resultMap) {
					
					if(resultMap.result - 1 == 0){
						//$('#likeOrDislike').html('<i class="far fa-heart" id="like"></i>');
						location.href = 'p.selectOneProduct?productNo=${productVO.productNo}';
					}
				}
			})
		})
		
		$('.product-link').on('click' , function(){
			var productNo = $(this).data('productno');
			
			location.href = 'p.selectOneProduct?productNo=' + productNo;
		})
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

	var url;
	if(${imageListSize} == 0){ // 이미지 첨부 안한 경우
		url = 'resources/image/noimage.png';
	}else{ // 한 경우
		url = '${STATIC_IMAGE_ROOT}${productVO.images.split(',')[0]}';
	}
	console.log(url);
	Kakao.Link.sendDefault({
		  objectType: 'feed',
		  content: {
		    title: '${productVO.title}',
		    description: '${productVO.content}',
		    imageUrl:
				/* '${STATIC_IMAGE_ROOT}${productVO.images}', */
				url,
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