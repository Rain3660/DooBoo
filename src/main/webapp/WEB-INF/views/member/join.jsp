
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
</head>
<body>
	<h3>스크립트 작업 전이니 아무 데이터나 넣지 마세요(넣으려면 잘 넣으세요)</h3>
	<h1>로고</h1>
	<form id="f" method="post" action="m.join">

		아이디<br> <input type="text" name="memberId"  id="id"><br>
		비밀번호<br> <input type="text" name="password" id="pw"><br>
		비밀번호 재확인<br> <input type="text" name="pw2" id="pw2"><br>
		닉네임<br> <input type="text" name="nickname" id="nickName" placeholder="닉네임"><br> 
		이름<br> <input type="text"name="name" id="name" placeholder="이름"><br> 
		생년월일<br> <input type="text" name="birthday" id="birthday"><br> 
		성별<br>
		<select name="gender">
			<option value="">성별</option>
			<option value="M">남</option>
			<option value="F">여</option>
		</select><br> 
		주소<br> 시/도<input type="text" name="city" id="city"><br>
		구/군<input type="text" name="region" id="region"><br>
		상세주소<input	type="text" name="location" id="location"><br>
	     연락처<br> <input type="text" name="phone" id="phone"><br>
	     이메일<br> <input type="text" name="email" id="email"><br> 
	    <button>가입하기</button>
	</form>
</body>
</html>