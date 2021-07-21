<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<style>
	.form-signin{
		display: table; 
		margin-left: auto; 
		
		margin-right: auto;

		
		
			
		
	}
	
	.mb-3 form-check{
		  
			margin : 0;
			
	}
	#naver{
	
	    position : absolute;
	    left : 450px;
		
		margin-top : 30px;
	
	}
	
</style>
<div class="container">
	<form method="post" action="m.login" class="form-signin">

	 <img class="mb-4" src="resources/image/DoobooLogo.png"" alt="" width="72" height="57">
    <h1 class="h3 mb-3 fw-normal">DOO BOO Market<br> Login</h1>
	 <div class="form-floating">
          <input type="email" class="form-control" name="memberId" id="memberId">
           <label for="fmemberId">ID</label>
    </div><br><br>
	  <div class="form-floating">
      <input type="password" class="form-control" id="password" name="password">
      <label for="floatingPassword">Password</label>
    </div>
		<div class="mb-3 form-check"> 
			<input type="checkbox" class="form-check-input" id="exampleCheck1">
			<label class="form-check-label" for="exampleCheck1">Check me out</label>
		</div>
		<button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
		<br><br>
		<input type="button" class="w-100 btn btn-lg btn-primary" value="아이디/비밀번호 찾기" onclick="location.href='m.findInfoPage'">
		<div class="mb-3 form-check">
		
			<div id="naver"><a href="${naverurl}"  >
				<img src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" style="width: 183px; height: 45px;" />
			</a>&nbsp;&nbsp;
			
		<a href="${kakaourl }">
				<img src="resources/image/kakaologo.png">
			</a>
			</div>
		</div>
	</form>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>