<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			fn_update();
			fn_presentPwCheck();
			fn_updatePw();
		})
		// 수정 버튼 눌렀을 때
		function fn_update(){
			$('#update_btn').click(function(){
				if (confirm('수정할까요?')) {
					$('#f1').attr('action', 'updateMember.do');
					$('#f2').attr('action', 'updateMember.do');
					$('#f3').attr('action', 'updateMember.do');
					$('#f4').attr('action', 'updateMember.do');
					$('#f1').submit();
					$('#f2').submit();
					$('#f3').submit();
					$('#f4').submit();
				}
			});
		}
		// 현재 비밀번호 검사
		var presentPwPass = false;
		function fn_presentPwCheck(){
			$('#pw0').keyup(function(){
				var obj = {
						pw: $('#pw0').val()
				};
				$.ajax({
					url: 'm.presentPwCheck',
					type: 'post',
					contentType: 'application/json',
					data: JSON.stringify(obj),
					dataType: 'json',
					success: function(resultMap){
						console.log(resultMap.isCorrect);
						if (resultMap.isCorrect) {
							presentPwPass = true;
						} else {
							presentPwPass = false;
						}
					}
				});
			});
		}
		
		// 비밀번호 변경
		function fn_updatePw() {
			$('#pw_btn').click(function(){
				if (!presentPwPass) {
					alert('현재 비밀번호가 틀립니다.');
					$('#pw0').focus();
					return false;
				} else if ($('#pw').val() == '') {
					alert('비밀번호를 입력하세요.');
					$('#pw').focus();
					return false;
				} else if ($('#pw').val() != $('#pw2').val()) {
					alert('비밀번호 입력을 확인하세요.');
					return false;
				} else {
					$('#f3').attr('action', 'updatePw.do');
					$('#f3').submit();
				}
			});
		}
		
	</script>
<div class="container">
	<div class="row-md-6">
		<h3>회원 프로필</h3>
		<form id="f1" method="post">
			이름<br>
			${Member_NAME}<br><br>
			닉네임<br>
			<input type="text" name="nickname" value="${loginUser_NICKNAME}"><br><br>
			성별<br>
			${Member_GENDER}<br><br>
			생년월일<br>
			${Member_BIRTHDAY}<br><br>
			<input type="button" id="update_btn" value="수정">
		</form>
	
		<h3>연락처 및 알림</h3>
		<form id="f2" method="post">
			연락처<br>
			<input type="text" name="phone" value="${loginUser_PHONE}"><br><br>
			이메일<br>
			<input type="text" name="email" value="${loginUser_EMAIL}"><br><br>
			<input type="button" id="update_btn" value="수정">	
		</form>
	
		<h3>아이디, 비밀번호</h3>
		<form id="f3" method="post">
			아이디<br>
			${Member_ID}"<br><br>
			현재 비밀번호<br>
			<input type="password" name="pw0" id="pw0"><br>
			새 비밀번호<br>
			<input type="password" name="pw" id="pw"><br>
			비밀번호 확인<br>
			<input type="password" name="pw2" id="pw2">
			<input type="button" id="update_btn" value="수정">
		</form>
		
		<h3>지역설정</h3>
		<form id="f4" method="post">
			
			주소<br>
			<input type="text" name="city" value="${loginUser_CITY}">
			<input type="text" name="region" value="${loginUser_REGION}">
			<input type="text" name="location" value="${loginUser_LOCATION}">
			<br><br>
			<input type="button" id="update_btn" value="수정">	
		</form>
		
		<div>
			<h1>내가 올린 게시글</h1>
		</div>
		
		<div>
			<h1>구매내역</h1>
		</div>
		
		<div>
			<h1>찜 목록</h1>
		</div>
	</div>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>