<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
</head>
<body>
	
	<form method="post" action="m.login">
		아이디 <input type="text" name="memberId">
		비밀번호 <input type="password" name="password">  
		<button>로그인</button>
	</form>
	
	<a href="${naverurl}">
	<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/>
	</a>
	<br>
	<a href ="${kakaourl }">
	<img src="resources/image/kakaologo.png">
	</a>
</body>
</html>