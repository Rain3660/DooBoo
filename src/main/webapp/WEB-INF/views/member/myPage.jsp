<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 다음 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script> -->
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<h1 class="text-center">마이 페이지</h1>
		<div class="col-md-6">
			<h3>회원 프로필</h3>
			<form id="updateInfo" method="post">
				이름<br>
				<input type="text" name="name" value="${loginUser.name}" id="name">
				<br> 닉네임<br>
				<input type="text" name="nickname" value="${loginUser.nickname}" id="nickname">
				<br> 성별<br> ${loginUser.gender}<br> 생년월일<br> ${loginUser.birthday}<br>
				<input type="button" id="update_info_btn" value="수정">
			</form>
		</div>

		<div class="col-md-6">
			<h3>아이디, 비밀번호</h3>
			<form id="updatePassword" method="post">
				아이디<br> ${loginUser.memberId}<br> 현재 비밀번호<br>
				<input type="password" id="pw0">
				<br> <span id="currPw_msg"></span> 새 비밀번호<br>
				<input type="password" name="password" id="pw">
				<br> 비밀번호 확인<br>
				<input type="password" id="pw2">
				<input type="button" id="update_pw_btn" value="수정">
				<br> <br>
			</form>
		</div>


		<div class="col-md-6">
			<h3>연락처 및 주소</h3>
			<form id="updateContact" method="post">
				연락처<br>
				<input type="text" name="phone" id="phone" value="${loginUser.phone}">
				<br> 이메일<br> ${loginUser.email}<br>
				<input type="button" value="주소 검색" onclick="findAddr()">
				<input type="text" id="address" name="address" value="${loginUser.address }">
				<input type="button" id="update_contact_btn" value="수정">
			</form>
		</div>
		<div class="col-md-6">
		<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
        <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
          <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
        </symbol>
        <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
          <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
        </symbol>
        
      </svg>	
		
		<button type="button" class="btn btn-outline-success">내 동내 인증상태</button><br>
		<c:if test="${mapSession1DTO eq null}">
			<button type="button" class="btn btn-outline-primary">미등록</button><br>
			<div class="alert alert-danger d-flex align-items-center col-3" role="alert">
	        	<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
	        	<div>
	        	  	지역을 등록해주세요
	        	</div>
	      	</div>
	      	<br>
		</c:if>
		<c:if test="${mapSession1DTO ne null}">
			<button type="button" class="btn btn-outline-primary">${mapSession1DTO.location}</button><br>
			<c:if test="${mapSession1DTO.isChecked eq 0}">
				<div class="alert alert-warning d-flex align-items-center col-3" role="alert">
      				<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Warning:"><use xlink:href="#exclamation-triangle-fill"/></svg>
      				  <div>
          				인증을 해주세요
       				 </div>
      			</div>
      			<br>
			</c:if>
			<c:if test="${mapSession1DTO.isChecked eq 1}">
				<div class="alert alert-success d-flex align-items-center col-3" role="alert">
      			 <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
        			<div>
         			 인증완료!
       				 </div>
      			</div>
      			<br>
			</c:if>
		</c:if>
		
		<c:if test="${mapSession2DTO eq null}">
		<button type="button" class="btn btn-outline-primary">미등록</button><br>
			<div class="alert alert-danger d-flex align-items-center" role="alert">
	        	<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
	        	<div>
	        	  	지역을 등록해주세요
	        	</div>
	      	</div>
		</c:if>
		<c:if test="${mapSession2DTO ne null}">
			<button type="button" class="btn btn-outline-primary">${mapSession2DTO.location}</button><br>
			<c:if test="${mapSession2DTO.isChecked eq 0}">
				<div class="alert alert-warning d-flex align-items-center" role="alert">
      				<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Warning:"><use xlink:href="#exclamation-triangle-fill"/></svg>
      				  <div>
          				인증을 해주세요
       				 </div>
      			</div>
			</c:if>
			<c:if test="${mapSession2DTO.isChecked eq 1}">
				<div class="alert alert-success d-flex align-items-center col-3" role="alert">
      			 <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
        			<div>
         			 인증완료!
       				 </div>
      			</div>
			</c:if>
		</c:if>
		<input type="button" value="거래지역수정하기" id="update_location_btn" onclick="window.open('m.mapCheckLocationPage','지역변경','width=430,height=500,location=no,status=no,scrollbars=yes');">
	</div>		
		<div>
			<h1>내가 올린 게시글</h1>
		</div>
		<div>
			<h1>구매 내역</h1>
		</div>
		<div>
			<h1>찜 목록</h1>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
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
	})
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