<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<!-- datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- 다음 주소검색 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	var idCheck = false;
	var isUsablePassword = false;
	var pwCheck = false;
	var nicknameCheck = false;
	var nameCheck = false;
	var phoneCheck = false;
	var emailCheck = false;
	$(document).ready(function() {
		$('#birthday').datepicker();
		fn_idCheck();
		fn_isUsablePassword();
		fn_pwCheck();
		fn_isUsableNickname();
		fn_isUsableName();
		fn_phoneCheck();
		fn_join();
		fn_emailCheck();
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
	function fn_idCheck() {
		$('#memberId').on('keyup', function() {
			var memberId = $('#memberId').val();
			// 소문자 + 숫자로 구성된 4 ~ 15 자리
			const regID = /^[a-z0-9]{4,15}$/;
			const regIdMsg = '아이디는 4 ~ 15글자 로 구성된 소문자,숫자만 입력해 주세요';
			const existIdMsg = '이미 존재하거나 탈퇴한 아이디 입니다.';
			const idPassMsg = '멋진 아이디네요 !';
			// 정규식 테스트
			if (!regID.test(memberId)) { // 통과하지 못한 경우
				$('#idCheck').html(regIdMsg);
			} else { // 정규식 통과했을경우
				var obj = {
					memberId : memberId
				};

				$.ajax({
					url : 'm.idCheck',
					type : 'post',
					data : JSON.stringify(obj),
					contentType : 'application/json; charset=utf-8',
					dataType : 'json',
					success : function(resultMap) {
						if (resultMap.result - 1 == 0) { // 존재하는 경우
							$('#idCheck').html(existIdMsg);
						} else {// 사용가능한 아이디
							$('#idCheck').html(idPassMsg);
							idCheck = true;
						}
					}
				})
			}
		})
	}
	function fn_isUsablePassword() {
		$('#password').on('keyup', function() {
			var password = $('#password').val();
			const regPw = /^[a-z0-9]{4,15}$/;
			const regPwMsg = '비밀번호느 4 ~ 15글자 로 구성된 소문자,숫자만 입력해 주세요';
			const idPassMsg = '안전합니다 !';
			if (!regPw.test(password)) { // 비밀번호 정규식 통과 못한 경우
				$('#isAvailablePassword').html(regPwMsg);
			} else {// 비밀번호 통과
				$('#isAvailablePassword').html(idPassMsg);
				isUsablePassword = true;
			}
		})
	}
	function fn_pwCheck() {
		$('#passwordCheck').on('keyup', function() {
			var pwCheckFail = '비밀번호가 맞지 않습니다.';
			var passwordCheck = $('#passwordCheck').val();

			if (passwordCheck != $('#password').val()) {// 비밀번호 확인이 틀린경우
				$('#pwCheck').html(pwCheckFail);
			} else {
				$('#pwCheck').html('');
				pwCheck = true;
			}
		})
	}
	function fn_isUsableNickname() {
		$('#nickname').on('keyup' , function(){
			var nickname = $('#nickname').val();
			const regNickname = /^[가-힣a-zA-Z0-9]{1,9}$/;
			const regNicknameMsg = '닉네임은 최대 9글자로 구성된 한글 , 숫자 , 영문자로만 입력해 주세요';
			const nicknamePassMsg = '멋진 닉네임 이네요 !';
			if(!regNickname.test(nickname)){  // 닉네임 정규식 통과 못한 경우
				$('#nicknameCheck').html(regNicknameMsg);
			}else{// 닉네임 정규식 통과
				$('#nicknameCheck').html(nicknamePassMsg);
				nicknameCheck = true;
			}
		})

	}
	function fn_isUsableName() {
		$('#name').on('keyup', function() {
			var name = $('#name').val();
			const regName = /^[가-힣]{1,6}$/;
			const regNameMsg = '한국인 이세요 ?';
			const namePassMsg = '멋진 이름 이네요 !';
			if (!regName.test(name)) { // 닉네임 정규식 통과 못한 경우
				$('#nameCheck').html(regNameMsg);
			} else {// 닉네임 정규식 통과
				$('#nameCheck').html(namePassMsg);
				nameCheck = true;
			}
		})
	}

	function fn_phoneCheck() {
		$('#phone').on('keyup', function() {
			var phone = $('#phone').val();
			const regPhone = /^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$/;
			const regPhoneMsg = '연락처 형식에 맞지 않습니다.';

			if (!regPhone.test(phone)) { // 닉네임 정규식 통과 못한 경우
				$('#phoneCheck').html(regPhoneMsg);
			} else {// 닉네임 정규식 통과
				$('#phoneCheck').html('');
				phoneCheck = true;
			}
		})
	}
	function fn_emailCheck() {
		$('#email')
				.on(
						'keyup',
						function() {
							var email = $('#email').val();
							const regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
							const regEmailMsg = '이메일 형식에 맞지 않습니다.';

							if (!regEmail.test(email)) { // 닉네임 정규식 통과 못한 경우
								$('#emailCheck').html(regEmailMsg);
							} else {// 닉네임 정규식 통과
								$('#emailCheck').html('');
								emailCheck = true;
							}
						})
	}
	/* var idCheck = false;
	var isUsablePassword = false;
	var pwCheck = false;
	var nicknameCheck = false;
	var nameCheck = false;
	var phoneCheck = false; */
	function fn_join() {
		if('${apiNumber}' == null){
			$('#join_btn').on('click', function() {
	
				if(!idCheck){
					alert('아이디를 확인하세요');
					$('#memberId').focus();
					return false;
				}
				if(!isUsablePassword){
					alert('비밀번호를 확인하세요');
					$('#password').focus();
					return false;
				}
				if(!pwCheck){
					alert('비밀번호가 맞지 않습니다.');
					$('#passwordCheck').focus();
					return false;
				}
				if(!nicknameCheck){
					alert('닉네임을 확인하세요');
					$('#nickname').focus();
					return false;
				}
				if(!phoneCheck){
					alert('전화번호를 확인하세요');
					$('#phone').focus();
					return false;
				}
				if(!nameCheck){
					alert('이름을 확인하세요');
					$('#name').focus();
					return false;
				}
				
				if($('#birthday').val() == ''){
					alert('생년월일을 입력해 주세요');
					$('#birthday').focus();
					return false;
				}
				if($('#address').val() == ''){
					alert('주소를 입력해 주세요');
					$('#address').focus();
					return false;
				} 
				if ($(':radio[name="gender"]:checked').length < 1) {
					alert('성별을 선택해 주세요');
					return false;
				}
	
				 if(!emailCheck){
				 alert('이메일을 확인하세요');
				 $('#email').focus();
				 return false;
				 }
				 
				
				$('#join_form').attr('action', 'm.join');
				$('#join_form').submit();
			})
			
		}else if('${apiNumber}' == '1'){
			$('#join_btn').on('click', function() {
				
				if(!idCheck){
					alert('아이디를 확인하세요');
					$('#memberId').focus();
					return false;
				}
				if(!isUsablePassword){
					alert('비밀번호를 확인하세요');
					$('#password').focus();
					return false;
				}
				if(!pwCheck){
					alert('비밀번호가 맞지 않습니다.');
					$('#passwordCheck').focus();
					return false;
				}
				
				if($('#address').val() == ''){
					alert('주소를 입력해 주세요');
					$('#address').focus();
					return false;
				} 
				 
				$('#join_form').attr('action', 'm.join');
				$('#join_form').submit();
			})
			
		}else if('${apiNumber}' == '2'){
			$('#join_btn').on('click', function() {
				
				if(!idCheck){
					alert('아이디를 확인하세요');
					$('#memberId').focus();
					return false;
				}
				if(!isUsablePassword){
					alert('비밀번호를 확인하세요');
					$('#password').focus();
					return false;
				}
				if(!pwCheck){
					alert('비밀번호가 맞지 않습니다.');
					$('#passwordCheck').focus();
					return false;
				}
				if(!nicknameCheck){
					alert('닉네임을 확인하세요');
					$('#nickname').focus();
					return false;
				}
				if(!phoneCheck){
					alert('전화번호를 확인하세요');
					$('#phone').focus();
					return false;
				}

				
				if($('#birthday').val() == ''){
					alert('생년월일을 입력해 주세요');
					$('#birthday').focus();
					return false;
				}
				if($('#address').val() == ''){
					alert('주소를 입력해 주세요');
					$('#address').focus();
					return false;
				} 
				 
				
				$('#join_form').attr('action', 'm.join');
				$('#join_form').submit();
			})
		}
	}
</script>
<style>
.body {
	margin: auto;
	width: 500px;
}

label {
	font-size: 20px;
}
</style>

<div class="body">
	<h2 class="py-5 text-center">회원가입</h2>
	<!-- 소셜 ID 로 로그인 하지 않은 경우 -->
	<c:if test="${loginApi eq null }">
		<form method="post" id="join_form">
			<div class="mb-3">
				<label for="memberId" class="form-label">아이디</label>
				<input type="text" class="form-control" id="memberId" name="memberId">
				<div id="idCheck" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">비밀번호</label>
				<input type="password" class="form-control" id="password" name="password">
				<div id="isAvailablePassword" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="passwordCheck" class="form-label">비밀번호 확인</label>
				<input type="password" class="form-control" id="passwordCheck">
				<div id="pwCheck" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="nickname" class="form-label">닉네임</label>
				<input type="text" class="form-control" id="nickname" name="nickname">
				<div id="nicknameCheck" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="phone" class="form-label">연락처</label>
				<input type="text" class="form-control" id="phone" autocomplete="off" name="phone">
				<div id="phoneCheck" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="name" class="form-label">이름</label>
				<input type="text" class="form-control" id="name" name="name">
				<div id="nameCheck" class="form-text"></div>
			</div>
			<label for="birthday" class="form-label">생년월일</label>
			<input type="text" class="form-control" name="birthday" id="birthday" autocomplete="off">
			<br>
			<div class="row">
				<div class="col-md-9">
					<label for="address" class="form-label">주소</label>
					<input type="text" class="form-control" id="address" name="address">
				</div>
				<div class="col">
					<div class="mb-2"></div>
					<br>
					<input type="button" class="btn btn-outline-secondary mb-0" style="float: right" value="주소 검색" onclick="findAddr()">
				</div>
			</div>
			<div class="col mt-4 mb-4 form-control">
				성별
				<div class="form-check form-check-inline" style="float: right">
					<input class="form-check-input" type="radio" name="gender" id="genderW" value="W">
					<label class="form-check-label" for="genderW">여</label>
				</div>
				<div class="form-check form-check-inline" style="float: right">
					<input class="form-check-input" type="radio" name="gender" id="genderM" value="M">
					<label class="form-check-label" for="genderM">남</label>
				</div>
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">이메일</label>
				<input type="text" class="form-control" id="email" autocomplete="off" name="email">
				<div id="emailCheck" class="form-text"></div>
			</div>
			<br>
			<input type="hidden" value="0" name="apiMemberNo">
			<input type="hidden" value="0" name="apiNumber">
			<input type="button" class="btn btn-primary" style="float: right" value="회원가입" id="join_btn">
		</form>
	</c:if>
	<!-- 소셜 아이디로 로그인한 경우 -->
	<c:if test="${loginApi ne null }">
		<form style="margin-top: 50px;" method="post" id="join_form">
			<div class="mb-3">
				<label for="memberId" class="form-label">아이디</label>
				<input type="text" class="form-control" id="memberId" name="memberId">
				<div id="idCheck" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">비밀번호</label>
				<input type="password" class="form-control" id="password" name="password">
				<div id="isAvailablePassword" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="passwordCheck" class="form-label">비밀번호 확인</label>
				<input type="password" class="form-control" id="passwordCheck">
				<div id="pwCheck" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="nickname" class="form-label">닉네임</label>
				<input type="text" class="form-control" id="nickname" name="nickname" <c:if test="${nickname ne null }"> value="${nickname }" readonly</c:if>>
				<div id="nicknameCheck" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="phone" class="form-label">연락처</label>
				<input type="text" class="form-control" id="phone" name="phone" autocomplete="off" <c:if test="${phone ne null}"> value="${phone }" readonly</c:if>>
				<div id="phoneCheck" class="form-text"></div>
			</div>
			<div class="mb-3">
				<label for="name" class="form-label">이름</label>
				<input type="text" class="form-control" id="name" name="name" <c:if test="${name ne null }"> value="${name }" readonly</c:if>>
				<div id="nameCheck" class="form-text"></div>
			</div>

			<label for="birthday" class="form-label">생년월일</label>
			<input type="text" class="form-control" name="birthday" id="birthday" autocomplete="off" <c:if test="${birthday ne null }"> value="${birthday }" readonly</c:if>>
			<br>
			<div class="row">
				<div class="col-md-9">
					<label for="address" class="form-label">주소</label>
					<input type="text" class="form-control" id="address" name="address">
				</div>
				<div class="col">
					<div class="mb-2"></div>
					<br>
					<input type="button" class="btn btn-outline-secondary" value="주소 검색" onclick="findAddr()">
				</div>
			</div>
			<c:if test="${gender ne null }">
				<c:if test="${gender  eq 'M' || gender eq 'male'}">
					<label for="M">남<input type="radio" id="M" name="gender" value="M" checked></label>
					<label for="W">여<input type="radio" id="W" name="gender" value="W" disabled></label>
				</c:if>
				<c:if test="${gender  eq 'W' || gender eq 'female'}">
					<label for="M">남<input type="radio" id="M" name="gender" value="M" disabled></label>
					<label for="W">여<input type="radio" id="W" name="gender" value="W" checked></label>
				</c:if>
			</c:if>
			<div class="mb-3">
				<label for="email" class="form-label">이메일</label>
				<input type="text" class="form-control" id="email" name="email" autocomplete="off" <c:if test="${email ne null}"> value="${email }" readonly</c:if>>
				<div id="emailCheck" class="form-text"></div>
			</div>
			<br>
			<input type="hidden" value="${apiMemberNo }" name="apiMemberNo">
			<input type="hidden" value="${apiNumber }" name="apiNumber">
			<input type="button" class="btn btn-primary" value="회원가입" id="join_btn">
		</form>
	</c:if>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>