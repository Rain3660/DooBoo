<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 다음 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script> -->
<jsp:include page="../layout/header.jsp"></jsp:include>

<style>
	.product-link{
		cursor: pointer;
	}
</style>
<body class="bg-light">
	<div class="container">
		<h2 class="py-5 text-center">마이 페이지</h2>
		<div class="row">
			<!-- 왼쪽 -->
			<div class="col">
				<!-- 회원 프로필 -->
				<h3 class="mb-4">회원 프로필</h3>
				<form id="updateInfo" method="post">
					<div class="row">
						<div class="col-md-8">
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" name="name" id="name" placeholder="${loginUser.name}" required>
							<br>
						</div>
						<div class="col">
							<div class="mb-2"></div>
							<br>
							<input type="button" class="btn btn-outline-secondary" id="delete_info_btn" onclick="" value="회원탈퇴">
						</div>
					</div>
					<br>
					<div class="col-md-8">
						<label for="nickname" class="form-label">닉네임</label>
						<input type="text" class="form-control" name="nickname" id="nickname" placeholder="${loginUser.nickname}" required>
					</div>
					<br>
					<div>
						<p>성별</p>
						<br>
						<h6 class="my-0">${loginUser.gender}</h6>
						<br>
					</div>
					<div>
						<p>생년월일</p>
						<br>
						<h6 class="my-0">${loginUser.birthday}</h6>
						<br>
					</div>
					<input type="button" class="btn btn-primary" id="update_info_btn" value="수정">
				</form>
				<br>
				<br>

				<!-- 연락처 및 주소 -->
				<h3 class="mb-3">연락처 및 주소</h3>
				<form id="updateContact" method="post">
					<div class="col-md-8">
						<label for="phone" class="form-label">연락처</label>
						<input type="text" class="form-control" name="phone" id="phone" placeholder="${loginUser.phone}" required>
					</div>
					<br>
					<div>
						<p>이메일</p>
						<br>
						<h6 class="my-0">${loginUser.email}</h6>
						<br>
					</div>
					<div class="row">
						<div class="col-md-8">
							<label for="address" class="form-label">주소</label>
							<input type="text" class="form-control" name="address" id="address" placeholder="${loginUser.address }" required>
							<br>
						</div>
						<div class="col">
							<div class="mb-2"></div>
							<br>
							<input type="button" class="btn btn-outline-secondary" value="주소 검색" onclick="findAddr()">
						</div>
					</div>
					<br>
					<input type="button" class="btn btn-primary" id="update_contact_btn" value="수정">
				</form>
			</div>
			<br>
			<br>

			<!-- 오른쪽 -->
			<div class="col">
				<!-- 아이디, 비밀번호 -->
				<h3 class="mb-4">아이디, 비밀번호</h3>
				<form id="updatePassword" method="post">
					<div>
						<p>아이디</p>
						<br>
						<h6 class="my-0">${loginUser.memberId}</h6>
						<br>
					</div>
					<div class="col-md-10">
						<label for="pw0" class="form-label">현재 비밀번호</label>
						<input type="text" class="form-control" id="pw0" placeholder="" value="" required>
					</div>
					<br>
					<div class="col-md-10">
						<label for="pw" class="form-label"> <span id="currPw_msg"></span>새 비밀번호
						</label>
						<input type="text" class="form-control" name="password" id="pw" placeholder="" value="" required>
					</div>
					<br>
					<div class="col-md-10">
						<label for="pw2" class="form-label">비밀번호 확인</label>
						<input type="text" class="form-control" id="pw2" placeholder="" value="" required>
					</div>
					<br>
					<input type="button" class="btn btn-primary" id="update_pw_btn" value="수정">
				</form>
				<br>
				<br>

				<!-- 지역 인증 -->
				<h3 class="mb-3">지역 인증</h3>
				<div class="col-md-10">
					<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
		                <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
		                  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" />
		                </symbol>
		                <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
		                  <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
		                </symbol>
		            </svg>

					<button type="button" class="btn btn-outline-success">나의 동네 인증상태</button>
					<br>
					<c:if test="${mapSession1DTO eq null}">

						<div class="alert alert-danger d-flex align-items-center" role="alert">
							<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:">
								<use xlink:href="#exclamation-triangle-fill" /></svg>
							<div>지역을 등록해주세요</div>
						</div>
						<button type="button" class="btn btn-outline-primary">미등록</button>
						<br>
						<br>
					</c:if>
					<c:if test="${mapSession1DTO ne null}">
						<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" <c:if test="${mapSession1DTO.usenow eq 1}">checked</c:if>>
						<label class="btn btn-outline-primary" id="btnradio1text" for="btnradio1">${mapSession1DTO.location}</label>

						<c:if test="${mapSession1DTO.usenow eq 1}">
							<img src="resources/image/두부1.png" width="45px" height="45px">거래 선호지역!
						 </c:if>

						<c:if test="${mapSession1DTO.isChecked eq 0}">
							<div class="alert alert-warning d-flex align-items-center" role="alert">
								<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Warning:">
									<use xlink:href="#exclamation-triangle-fill" /></svg>
								<div>인증을 해주세요</div>
							</div>
							<br>
						</c:if>
						<c:if test="${mapSession1DTO.isChecked eq 1}">
							<div class="alert alert-success d-flex align-items-center" role="alert">
								<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:">
									<use xlink:href="#check-circle-fill" /></svg>
								<div>인증완료!</div>
							</div>
							<br>
						</c:if>
					</c:if>

					<c:if test="${mapSession2DTO eq null}">
						<div class="alert alert-danger d-flex align-items-center" role="alert">
							<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:">
								<use xlink:href="#exclamation-triangle-fill" /></svg>
							<div>지역을 등록해주세요</div>
						</div>
						<button type="button" class="btn btn-outline-primary">미등록</button>
						<br>
					</c:if>
					<c:if test="${mapSession2DTO ne null}">
						<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" <c:if test="${mapSession2DTO.usenow eq 1}">checked</c:if>>
						<label class="btn btn-outline-primary" id="btnradio2text" for="btnradio2">${mapSession2DTO.location}</label>
						<c:if test="${mapSession2DTO.usenow eq 1}">

							<img src="resources/image/두부1.png" width="45px" height="45px">거래 선호지역!
						 
						 </c:if>
						<c:if test="${mapSession2DTO.isChecked eq 0}">
							<div class="alert alert-warning d-flex align-items-center" role="alert">
								<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Warning:">
									<use xlink:href="#exclamation-triangle-fill" /></svg>
								<div>인증을 해주세요</div>
							</div>
						</c:if>
						<c:if test="${mapSession2DTO.isChecked eq 1}">
							<div class="alert alert-success d-flex align-items-center" role="alert">
								<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:">
									<use xlink:href="#check-circle-fill" /></svg>
								<div>인증완료!</div>
							</div>
						</c:if>
					</c:if>
					<br>
					<input class="useNow_btn btn btn-primary" type="button" value="선호지역 변경하기" id="update_usenow_location_btn">
					<input class="btn btn-primary" type="button" value="거래지역 수정하기" id="update_location_btn" onclick="window.open('m.mapCheckLocationPage','지역변경','width=530,height=424,location=no,status=no,scrollbars=yes');">
				</div>
			</div>
			<br>
			<br>

		</div>
		<div class="row">
			<div class="col-md-12 mx-auto">
				<h3 class="text-center">찜목록</h3>
					<!-- 찜 목록한 상품이 있을 때 -->
					<c:if test="${myFavoriteProductListSize ne 0 }">
					<div class="card-group">
						<c:forEach var="product" items="${myFavoriteProductList }">
							<div class="card product-link" data-productno="${product.productNo }">
								<c:if test="${product.images eq null }">
									<img src="resources/image/noimage.png" class="card-img-top" alt="...">
								</c:if>
								<c:if test="${product.images ne null }">
									<img src="${STATIC_IMAGE_ROOT}${product.images.split(',')[0]}" class="card-img-top" alt="...">
								</c:if>
								<div class="card-body">
									<h5 class="card-title">${product.title }</h5>
									<p class="card-text">${product.price }</p>
									<p class="card-text">${product.address }</p>
								</div>
							</div>
						</c:forEach>
						</div>
					</c:if>
					<!-- 판매자가 판매중인 상품이 없을 때 -->
					<c:if test="${myFavoriteProductListSize eq 0 }">
						<h3 class="text-center">등록된 상품이 없습니다.</h3>
					</c:if>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 mx-auto">
				<h3 class="text-center">판매중인 상품</h3>
					<!-- 찜 목록한 상품이 있을 때 -->
					<c:if test="${myOnSaleProductListSize ne 0 }">
					<div class="card-group">
						<c:forEach var="product" items="${myOnSaleProductList }">
							<div class="card product-link" data-productno="${product.productNo }">
								<c:if test="${product.images eq null }">
									<img src="resources/image/noimage.png" class="card-img-top" alt="...">
								</c:if>
								<c:if test="${product.images ne null }">
									<img src="${STATIC_IMAGE_ROOT}${product.images.split(',')[0]}" class="card-img-top" alt="...">
								</c:if>
								<div class="card-body">
									<h5 class="card-title">${product.title }</h5>
									<p class="card-text">${product.price }</p>
									<p class="card-text">${product.address }</p>
								</div>
							</div>
						</c:forEach>
						</div>
					</c:if>
					<!-- 판매자가 판매중인 상품이 없을 때 -->
					<c:if test="${myOnSaleProductListSize eq 0 }">
						<h3 class="text-center">등록된 상품이 없습니다.</h3>
					</c:if>
			</div>
		</div>
		
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function(){
		$('.product-link').on('click' , function(){
			var productNo = $(this).data('productno');
			
			location.href = 'p.selectOneProduct?productNo=' + productNo;
		})
		
		var currPwCheck = false;
		$('#update_info_btn').on('click' , function(){
			if($('#name').val() == ''){ // name 이 공백일 때 ,
				alert('이름은 필수정보 입니다.');
				$('#name').focus();
				return false;
			}
			if($('#nickname').val() == ''){ // nickname 이 공백일 때,
				alert('닉네임은 필수정보 입니다.');
				$('#nickname').focus();
				return false;
			}
			if($('#name').val() == '${loginUser.name}' && $('#nickname').val() == '${loginUser.nickname}'){
				alert('변경된 정보가 없습니다.');
				return false;
			}
			$('#updateInfo').attr('action' , 'm.updateInfo');
			$('#updateInfo').submit();
		})
		$('#pw0').on('keyup',function(){
			var obj = {
					memberNo : ${loginUser.memberNo} ,
					password : $('#pw0').val()
			};
			$.ajax({
				url : 'm.currentPwCheck' ,
				type : 'post' ,
				data : JSON.stringify(obj) ,
				contentType : 'application/json; charset=utf-8' ,
				dataType : 'json' ,
				success : function(resultMap){
					console.log(resultMap);
					if(resultMap.result > 0){
						currPwCheck = true;	
					}
				}
			})
		})
		
		$('#update_pw_btn').on('click' ,function(){
			if($('#pw0').val() == ''){
				alert('현재 비밀번호를 입력하세요');
				$('#pw0').focus();
				return false;
			}
			if(!currPwCheck){// 입력한 비밀번호가 현재 비밀번호와 맞지 않을 때
				alert('현재 비밀번호를 확인하세요');
				$('#pw0').focus();
				return false;
			}
			if($('#pw').val() == ''){
				alert('새로운 비밀번호를 입력하세요');
				$('#pw').focus();
				return false;
			}
			if($('#pw').val() != $('#pw2').val() ){
				alert('비밀번호를 확인하세요');
				$('#pw2').focus();
				return false;
			}
			$('#updatePassword').attr('action' , 'm.updatePassword');
			$('#updatePassword').submit();
		})
		$('#update_contact_btn').on('click' , function(){
			// phone ,address
			if($('#phone').val() == ''){
				alert('필수입력 사항입니다.');
				$('#phone').focus();
				return false;
			}
			if($('#address').val() == ''){
				alert('필수입력 사항입니다.');
				$('#address').focus();
				return false;
			}
			if($('#phone').val() == '${loginUser.phone}' && $('#address').val() == '${loginUser.address}' ){
				alert('변경사항이 없습니다.');
				return false;
			}
			$('#updateContact').attr('action' , 'm.updateContact');
			$('#updateContact').submit();
		})
		fn_IdChange();
		fn_update_usenow();
	})
	var result = false;
	   function fn_IdChange(){
            $("#btnradio1").change(function(){
                if($('#btnradio1').is(':checked')){

                  result = true;
                }
            }) 
            $("#btnradio2").change(function(){
                if($('#btnradio2').is(':checked')){

                    result = true;
                }
            }) 
        }
	function fn_update_usenow(){
		$('.useNow_btn').on('click',function(){
			if(!result){
				alert('지역을 먼저 선택해주세요');
			}else{
				
           	 if($('#btnradio1').is(':checked')){
           		 if(${mapSession1DTO.usenow eq 1}){
           			 alert('이미 선호지역으로 등록되어있습니다. 다른지역을 선택해주세요');
           		 }else if(confirm('선호지역을"'+$('#btnradio1text').text()+'"으로 변경하시겠습니까?')){
            		 if('${mapSession1DTO.isChecked}'==0){
            			 alert('인증을 먼저 해주세요!');
            			 $('#btnradio2').prop('checked',true);
            			 return;
            		 }else{
	            			$.ajax({
	                    		url:'m.updateUsenow',
	                    		type : 'post',
	                    		data : 'mapNo=${mapSession1DTO.mapNo} &memberNo=${loginUser.memberNo}',
	                    	    dataType : 'json',
	                            success : function(resultMap){
	                            	if(resultMap.result > 0){
	                                    alert('변경되었습니다');
	                                	window.location.assign('m.myPage');
	                                }
	                            },error(){
	                       
	            
	                            }
	                    });  
            		 }
        	 	}
        		 
            }
        	 if($('#btnradio2').is(':checked')){
        		 if(${mapSession2DTO.usenow eq 1}){
           			 alert('이미 선호지역으로 등록되어있습니다. 다른지역을 선택해주세요');
           		 }else if(confirm('선호지역을"'+$('#btnradio2text').text()+'"으로 변경하시겠습니까?')){
            		 if('${mapSession2DTO.isChecked}'==0){
            			 alert('인증을 먼저 해주세요!');
            			 $('#btnradio1').prop('checked',true);
            			 return;
            		 }else{
	            		 $.ajax({
	                    		url:'m.updateUsenow',
	                    		type : 'post',
	                    		data : 'mapNo=${mapSession2DTO.mapNo} &memberNo=${loginUser.memberNo}',
	                    	    dataType : 'json',
	                            success : function(resultMap){
	                                if(resultMap.result > 0){
	                                    alert('변경되었습니다');
	                                	window.location.assign('m.myPage');
	                                }
	                            },error(){
	            				
	                            }
	                    });
            		 }
        	 	}
        		 
              }
        	 
        	 
        	 
			
		}
			
	})
}
	
	
	function findAddr() {
	$('#address').val('');
	new daum.Postcode({
		oncomplete : function(data) {

			console.log(data);

			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.

			var address = data.address;

			$('#address').val(address);

		}
	}).open();
}

</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>