<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<div class="row-md-6">
		<h1>회원 정보</h1>
		
		<h3>회원 프로필</h3>
		<form id="profile" method="post">
			이름<br>
			<input type="text" name="name" value="${loginUser.name}" ><br>
			
			닉네임<br>
			<input type="text" name="nickname" value="${loginUser.nickname}" ><br>
			
			성별<br>
			${loginUser.gender}<br>
			
			생년월일<br>
			${loginUser.birthday}<br>
			
			<input type="button" id="nameNickname_btn" value="수정">
		</form>
		
		
		<h3>아이디, 비밀번호</h3>
		<form id="idPassword" method="post">
			아이디<br>
			${loginUser.memberId}<br>
			
			현재 비밀번호<br>
			<input type="password" name="pw0" id="pw0"><br>
			
			새 비밀번호<br>
			<input type="password" name="pw" id="pw"><br>
			
			비밀번호 확인<br>
			<input type="password" name="pw2" id="pw2">
			<input type="button" id="password_btn" value="수정" ><br><br>
		</form>
		
		
		<h3>연락처 및 알림</h3>
		<form id="phoneEmail" method="post">
			연락처<br>
			<input type="text" name="phone" value="${loginUser.phone}" ><br>
			
			이메일<br>
			<input type="text" name="email" value="${loginUser.email}" ><br>
			<input type="button" id="phoneEmail_btn" value="수정">
		</form>
		
		
		<h3>주소</h3>
		<form id="address" method="post">
			시<br>
			<input type="text" name="city" value="${loginUser.city}" ><br>
			구<br>
			<input type="text" name="region" value="${loginUser.region}" ><br>
			상세주소<br>
			<input type="text" name="location" value="${loginUser.location}" ><br>
			<input type="button" id="address_btn" value="수정">
		</form>
		
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
<jsp:include page="../layout/footer.jsp"></jsp:include>