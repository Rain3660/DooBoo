<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	$(document).ready(function(){
		fn_joinPage();
	})
	
	function fn_findId(){
		$('#findId_btn').click(function(){
			location.href = '파인드 아이디 jsp';
		})
	}
	
	function fn_findPw(){
		$('#findPw_btn').click(function(){
			location.href = '파인드 Pw jsp';
		})
	}
	function fn_joinPage(){
		$('#join_btn').click(function(){
			location.href = 'm.joinPage'
		
			
		});
	}
</script>
</head>
<body>
	<p>두부마켓</p>
	<form id="f" method="post" action="m.login" >
	<p>아이디</p><br>
	<input type="text" name="id" id="id"><br>
	<p>비밀번호</p><br>
	<input type="password" name="pw" id="pw"><br>
	<input type="button" id="join_btn" value="회원가입">
	<input type="button" id="findId_btn" value="아이디 찾기">
	<input type="button" id="findPw_btn" value="비밀번호 찾기">
	<button>로그인</button>
	</form>
	
</body>
</html>