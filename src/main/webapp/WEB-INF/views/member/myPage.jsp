<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<!-- 다음 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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


		<div class="col-md-12">
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