<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<form method="post" action="m.login">
		<div class="mb-3" >
			<label for="memberId" class="form-label">ID</label> 
			<input type="text" class="form-control" name="memberId" id="memberId" aria-describedby="emailHelp">
		</div>
		<div class="mb-3 mt-5">
			<label for="password" class="form-label">Password</label>
			<input type="password" class="form-control" id="password" name="password">
		</div>
		<div class="mb-3 form-check">
			<input type="checkbox" class="form-check-input" id="exampleCheck1">
			<label class="form-check-label" for="exampleCheck1">Check me out</label>
		</div>
		<button type="submit" class="btn btn-primary">로그인</button>
		<input type="button" class="btn btn-primary" value="아이디/비밀번호 찾기" onclick="location.href='m.findInfoPage'">
		<div class="mb-3 form-check">
			<a href="${naverurl}"> <img
				src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" />
			</a>
			<a href="${kakaourl }"> <img src="resources/image/kakaologo.png"></a>
		</div>	
	</form>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>