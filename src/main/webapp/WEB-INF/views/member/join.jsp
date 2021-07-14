
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Insert title here</title>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
		$(document).ready(function(){
			fn_datepicker();
			fn_idCheck();
			fn_idMessage();
			fn_pwMessage();
			fn_pw2Message();
			
		});
		function fn_datepicker() {
	    	$( "#birthday" ).datepicker();
	  	});
	  	
	  	var idPass = false;
		function fn_idCheck() {
			$('#id').keyup(function(){
				$.ajax({
					url: 'm.idCheck',
					type: 'get',
					data: 'id=' + $('#id').val(),
					dataType: 'json',
					success: function(res){
						if (res.count == 0) {
							idPass = true;
						} else {
							idPass = false;
						}
					}
				});
			})
		}
		
		// 이메일 인증번호 받기 함수
		function fn_verify_num(){
			$('#verify_num_btn').click(function(){
				if($('#email').val() == '') {
					alert('이메일을 입력하세요.');
					return false;
				}
				$.ajax({
					url: 'm.verifyNum',
					data: 'email=' + $('#email').val(),
					dataType: 'json',
					success: function(resultMap){
						alert('인증코드가 발송되었습니다.');
						fn_verify(resultMap.authCode); // 인증번호 검증 함수로 발행된 인증코드 전달
					},
					error: function(xhr, textStatus, errorThrown) {
						
					}
				})
			}));
		}
		// 이메일 인증번호 검증 함수
		var authPass = false; // 이메일 인증 통과여부
		function fn_verify(authCode) {
			$('#verify_btn').click(function(){
				if(authCode == $('#user_key').val()) {
					alert('인증되었습니다.');
					authPass = true;
				} else {
					alert('인증에 실패했습니다.');
					authPass = false;
				}
			});
		}
		// 회원가입함수
		// 아이디 메시지
		const id = $('#id');
		const id_message = $('#id_message');
		function idMessage() {
			let result = false;
			if (id.val() == '') {
				id_message.text('아이디는 필수입니다.');
			} else {
				id_message.text('아이디 통과.');
				result = true;
			}
			return result;
		}
		id.blur(function(){
			idCheck();
		})
		// 비밀번호 메시지
		const pw = $('#pw');
		const pw_message = $('#pw_message');
		function fn_pwMessage(){
			let result = false;
			if (pw.val() == '') {
				pw_message.text('비밀번호는 필수입니다.');
			} else {
				pw_message.text('비밀번호 통과.');
				result = true;
			}
			return result;
		}
		pw.blur(function(){
			pwCheck();
		})
		// 비밀번호 확인 메시지
		const pw2 = $('#pw2');
		const pw2_message = $('#pw2_message');
		function fn_pw2Message(){
			let result = false;
			if (pw2.val() == '') {
				pw2_message.text('비밀번호 확인은 필수입니다.');
			} else if (pw.val() != pw2.val()) {
				pw2_message.text('비밀번호를 확인하세요.');
			} else {
				pw2_message.text('비밀번호 확인 통과.');
				result = truie;
			}
			return result;
		}
		pw2.blur(function(){
			pw2Check();
		})
		
		// 이메일 메시지
		const email = $('#email');
		const email_message = $('#email_message');
		function fn_emailMessage(){
			let result = false;
			if (email.val() == '') {
				email_message.text('이메일은 필수입니다.');
			} else {
				email_message.text('이메일 통과.');
				result = true;
			}
			return result;
		}
		email.blur(function(){
			emailCheck();
		})
		
		const f = $('#f');
		f.submit(function(event){
			if ( !idMessage() || !pwMessage() || !pw2Message() || !emailMessage() ) {
				alert('회원가입 정보를 확인하세요.');
				event.preventDefault();
				return false;
			}
		})
		
	</script>
	<style>
        #ui-datepicker-div{
        	margin-left: 250px;
        }
    </style>
</head>
<body>
	<h1>로고</h1>
	<form id="f" method="post" action="m.join">
		
		아이디<br>
		<input type="text" name="id" id="id"><br>
		<p></p>
		비밀번호<br>
		<input type="text" name="pw" id="pw"><br>
		비밀번호 재확인<br>
		<input type="text" name="pw2" id="pw2"><br>
		닉네임<br>
		<input type="text" name="nickName" id="nickName" placeholder="닉네임"><br>
		이름<br>
		<input type="text" name="name" id="name" placeholder="이름"><br>
		생년월일<br>
		<input type="text" name="birthday" id="birthday"><br>
		성별<br>
		<label for="man">남<input type="radio" id="man" name="gender" value="남"></label>
        <label for="woman">여<input type="radio" id="woman" name="gender" value="여"></label>
		주소<br>
		시/도<input type="text" name="city" id="city"><br>
		구/군<input type="text" name="region" id="region"><br>
		상세주소<input type="text" name="location" id="location"><br>
		
		연락처<br>
		<input type="text" name="phone" id="phone"><br>
		이메일<br>
		<input type="text" name="email" id="email"><br>
		
		<input type="button" id="join_btn" value="가입하기">
		
	</form>
</body>
</html>