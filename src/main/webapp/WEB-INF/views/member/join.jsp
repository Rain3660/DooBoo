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
		$('#memberId').on('keyup',function(){
			var memberId = $('#memberId').val();
			// 소문자 + 숫자로 구성된 4 ~ 15 자리
			const regID = /^[a-z0-9]{4,15}$/;
			const regIdMsg = '아이디는 4 ~ 15글자 로 구성된 소문자,숫자만 입력해 주세요';
			const existIdMsg = '이미 존재하거나 탈퇴한 아이디 입니다.';
			const idPassMsg = '멋진 아이디네요 !';
			// 정규식 테스트
			if(!regID.test(memberId)){ // 통과하지 못한 경우
				$('#idCheck').html(regIdMsg);
			}else{ // 정규식 통과했을경우
				var obj = {
				memberId : memberId	
			};

				$.ajax({
					url : 'm.idCheck' ,
					type : 'post' ,
					data : JSON.stringify(obj) ,
					contentType : 'application/json; charset=utf-8' ,
					dataType : 'json' ,
					success : function(resultMap){
						if(resultMap.result - 1 == 0){ // 존재하는 경우
							$('#idCheck').html(existIdMsg);
						}else{// 사용가능한 아이디
							$('#idCheck').html(idPassMsg);
							idCheck = true;
						}
					}
				})
			}
		})
	}
	function fn_isUsablePassword() {
		$('#password').on('keyup' , function(){
			var password = $('#password').val();
			const regPw = /^[a-z0-9]{4,15}$/;
			const regPwMsg = '비밀번호느 4 ~ 15글자 로 구성된 소문자,숫자만 입력해 주세요';
			const idPassMsg = '안전합니다 !';
			if(!regPw.test(password)){  // 비밀번호 정규식 통과 못한 경우
				$('#isAvailablePassword').html(regPwMsg);
			}else{// 비밀번호 통과
				$('#isAvailablePassword').html(idPassMsg);
				isUsablePassword = true;
			}
		})
	}
	function fn_pwCheck() {
		$('#passwordCheck').on('keyup' , function(){
			var pwCheckFail = '비밀번호가 맞지 않습니다.';
			var passwordCheck = $('#passwordCheck').val();
			
			if(passwordCheck != $('#password').val()){// 비밀번호 확인이 틀린경우
				$('#pwCheck').html(pwCheckFail);
			}else{
				$('#pwCheck').html('');
				pwCheck = true;
			}
		})
	}
	function fn_isUsableNickname() {
		$('#nickname').on('keyup' , function(){
			var nickname = $('#nickname').val();
			const regNickname = /^[가-힣a-zA-Z0-9]{4,10}$/;
			const regNicknameMsg = '닉네임은 4 ~ 10글자로 구성된 한글 , 숫자 , 영문자로만 입력해 주세요';
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
		$('#name').on('keyup' , function(){
			var name = $('#name').val();
			const regName = /^[가-힣]{1,6}$/;
			const regNameMsg = '한국인 이세요 ?';
			const namePassMsg = '멋진 이름 이네요 !';
			if(!regName.test(name)){  // 닉네임 정규식 통과 못한 경우
				$('#nameCheck').html(regNameMsg);
			}else{// 닉네임 정규식 통과
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
		$('#email').on('keyup', function() {
			var email = $('#email').val();
			const regEmail =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
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
		$('#join_btn').on('click' , function(){
			
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
			if(idCheck || isUsablePassword || pwCheck || nicknameCheck || nameCheck || phoneCheck || emailCheck){
				
				$('#join_form').attr('action' , 'm.join');
				$('#join_form').submit();			
			}
		})
	}
</script>

<style>
	#box{
		display: table; 
		margin-left: auto; 
		
		margin-right: auto;


		
			
		
	}
</style>
<div class="container">
<!-- 소셜 ID 로 로그인 하지 않은 경우 -->
<c:if test="${loginApi eq null }">

    <div class="py-5 text-center">
      <img class="d-block mx-auto mb-4" src="resources/image/DoobooLogo.png"  alt="" width="72" height="57">
      <h2>회원 가입</h2>
     
	<div id="box">
	<form style="margin-top: 50px;" method="post" id="join_form">
		<div class="col-md-12">
			<label for="memberId" class="form-label">아이디</label>
			<input type="text" class="form-control" id="memberId" name="memberId">
			<div id="idCheck" class="form-text"></div>
		</div>
	
	<div class="col-md-12">
			<label for="password" class="form-label">비밀번호</label>
			<input type="password" class="form-control" id="password" name="password">
			<div id="isAvailablePassword" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="passwordCheck" class="form-label">비밀번호 확인</label>
			<input type="password" class="form-control" id="passwordCheck">
			<div id="pwCheck" class="form-text"></div>
		</div>
	<div class="col-md-12">
			<label for="nickname" class="form-label">닉네임</label>
			<input type="text" class="form-control" id="nickname" name="nickname">
			<div id="nicknameCheck" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="phone" class="form-label">연락처</label>
			<input type="text" class="form-control" id="phone" autocomplete="off" name="phone">
			<div id="phoneCheck" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="name" class="form-label">이름</label>
			<input type="text" class="form-control" id="name" name="name">
			<div id="nameCheck" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="birthday" class="form-label">생년월일</label>
			<input type="text" name="birthday" id="birthday" autocomplete="off">
			<input type="button" value="주소 검색" onclick="findAddr()">
			<input type="text" id="address" name="address"><br>
			<label for="form-check-input" class="form-label"><h5>성별</h5></label>
			 <div class="form-check">
			<input class="form-check-input" type="radio" id="genderM" name="gender" value="M">
			<label class="form-check-label" for="genderM">남</label>
			</div>
			<div class="form-check">
			<input class="form-check-input" type="radio" id="genderW" name="gender" value="W">
			<label class="form-check-label" for="genderW">여</label>
			</div>
		</div>
		<div class="col-md-12">
			<label for="email" class="form-label">이메일</label>
			<input type="text" class="form-control" id="email" autocomplete="off" name="email">
			<div id="emailCheck" class="form-text"></div>
		</div>
		<br>
		<input type="hidden" value="0" name="apiMemberNo">
		<input type="hidden" value="0" name="apiNumber">
		<input type="button"  class="btn btn-success btn btn-primary btn-lg col-md-12 " value="회원가입" id="join_btn">
	</form>
	</div>
</c:if>
<!-- 소셜 아이디로 로그인한 경우 -->
<c:if test="${loginApi ne null }">
       <div class="py-5 text-center">
      <img class="d-block mx-auto mb-4" src="resources/image/DoobooLogo.png"  alt="" width="72" height="57">
      <h2>회원 가입</h2>
	<div id="box">
	<form style="margin-top: 50px;" method="post" id="join_form">
		<div class="col-md-12">
			<label for="memberId" class="form-label">아이디</label>
			<input type="text" class="form-control" id="memberId" name="memberId">
			<div id="idCheck" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="password" class="form-label">비밀번호</label>
			<input type="password" class="form-control" id="password" name="password">
			<div id="isAvailablePassword" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="passwordCheck" class="form-label">비밀번호 확인</label>
			<input type="password" class="form-control" id="passwordCheck">
			<div id="pwCheck" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="nickname" class="form-label">닉네임</label>
			<input type="text" class="form-control" id="nickname" name="nickname" <c:if test="${nickname ne null }"> value="${nickname }" readonly</c:if>>
			<div id="nicknameCheck" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="phone" class="form-label">연락처</label>
			<input type="text" class="form-control" id="phone" name="phone" autocomplete="off" <c:if test="${phone ne null}"> value="${phone }" readonly</c:if>>
			<div id="phoneCheck" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="name" class="form-label">이름</label>
			<input type="text" class="form-control" id="name" name="name" <c:if test="${name ne null }"> value="${name }" readonly</c:if>>
			<div id="nameCheck" class="form-text"></div>
		</div>
		<div class="col-md-12">
			<label for="birthday" class="form-label">생년월일</label>
			<input  class="col-md-12" type="text" name="birthday" id="birthday" autocomplete="off"  <c:if test="${birthday ne null }"> value="${birthday }" readonly</c:if>>
			</div>
				<br>
			<div class="col-md-12">
			<input  type="button" value="주소 검색"  class="btn btn-success" onclick="findAddr()">
			<input type="text" id="address" name="address"><br>
				</div>
				<label for="form-check-input" class="form-label"><h5>성별</h5></label>
			<c:if test="${gender ne null }">
			<c:if test="${gender  eq 'M' || gender eq 'male'}">
			 <div class="form-check">
					<input class="form-check-input" type="radio" id="genderM" name="gender" value="M">
			<label class="form-check-label" for="genderM">남</label>
				</div>
				<div class="form-check">
					<input class="form-check-input" type="radio" id="genderW" name="gender" value="W">
			<label class="form-check-label" for="genderW">여</label>
				</div>
			</c:if>
			<c:if test="${gender  eq 'W' || gender eq 'female'}">
			<div class="form-check">
					<input class="form-check-input" type="radio" id="genderM" name="gender" value="M">
			<label class="form-check-label" for="genderM">남</label>
				</div>
				<div class="form-check">
				<input class="form-check-input" type="radio" id="genderW" name="gender" value="W">
			<label class="form-check-label" for="genderW">여</label>
				</div>
			</c:if>
		</c:if>
	
		<div class="col-md-12">
			<label for="email" class="form-label">이메일</label>
			<input type="text" class="form-control" id="email" name="email" autocomplete="off" <c:if test="${email ne null}"> value="${email }" readonly</c:if>>
			<div id="emailCheck" class="form-text"></div>
		</div>
		<br>
		<input type="hidden" value="${apiMemberNo }" name="apiMemberNo">
		<input type="hidden" value="${apiNumber }" name="apiNumber">
		<input type="button"  class="btn btn-success" value="회원가입" id="join_btn">
	</form>
	</div>
</c:if>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>