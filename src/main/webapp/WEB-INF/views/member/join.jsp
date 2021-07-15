
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

<script>

	// 페이지 로드
	$(document).ready(function(){
		
		// DOM 선언
		const join_form = $('#f');
		const id = $('#id');
		const id_msg = $('#id_msg');
		var id_pass = false;
		const join_btn = $('#join.btn');
		
		// 아이디 정규식 : 4~32자, 문자/숫자/특수문자(_, -), 소문자 시작
		const regID = /^[a-z][a-z0-9_-]{3,31}$/;
		
		// 이벤트
		id.blur(idCheck);
		
		let idResult = idCheck();
		
		id.blur(function(){
			idCheck();
		})
		f.submit(function(event){
			if( !idResult ) {
				event.preventDefault(0;)
				return false;
			}
		})
		
	})
</script>
	
<!-- 생년월일 달력 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$( function() {
    	$( "#birthday" ).datepicker();
  	});
</script>
<style>#ui-datepicker-div{margin-left: 180px;}</style>
</head>
<body>
	<h3>스크립트 작업 전이니 아무 데이터나 넣지 마세요(넣으려면 잘 넣으세요)</h3>
	<h1>로고</h1>
<<<<<<< Updated upstream
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
=======
		<c:if test="${loginApi ne null }">
		<form id="f" method="post" action="m.join">		
		아이디<br>
	      
	   		<input type="text" name="memberId" id="id"><br>
	   		<span class="error_next_box" id="idMesg" style aria-live="assertive">필수 정보입니다.</span>
	      비밀번호<br>
	      
	   		<input type="password" name="password" id="pw"><br>
	   		<span class="error_next_box" id="idMesg" style aria-live="assertive">필수 정보입니다.</span>
	      비밀번호 재확인<br>
	      
	   		<input type="password" id="pw2"><br>
	   		<span class="error_next_box" id="idMesg" style aria-live="assertive">필수 정보입니다.</span>
	      닉네임<br>
	   		<input type="text" name="nickname" id="nickname" placeholder="닉네임" <c:if test="${nickname ne null }"> value="${nickname }" readonly</c:if>><br>
	   		<span class="error_next_box" id="idMesg" style aria-live="assertive">필수 정보입니다.</span>  
	      이름<br>
	   		<input type="text" name="name" id="name" placeholder="이름"<c:if test="${name ne null }"> value="${name }" readonly</c:if>><br>      
	   		<span class="error_next_box" id="idMesg" style aria-live="assertive">필수 정보입니다.</span>
	      생년월일<br>
	   		<input type="text" name="birthday" id="birthday" <c:if test="${birthday ne null }"> value="${birthday }" readonly disabled </c:if> ><br>      
	   		<span class="error_next_box" id="idMesg" style aria-live="assertive">필수 정보입니다.</span>
	   
	      성별
	      <br>
	         <c:if test="${gender ne null }">
	            <c:if test="${gender  eq 'M' || gender eq 'male'}">
	            	<label for="M">남<input type="radio" id="M" name="gender" value="남" checked></label>
	             	<label for="W">여<input type="radio" id="W" name="gender" value="여" disabled></label>   
	            </c:if>
	            <c:if test="${gender  eq 'W' || gender eq 'female'}">
	            	<label for="M">남<input type="radio" id="M" name="gender" value="남" disabled></label>
	              	<label for="W">여<input type="radio" id="W" name="gender" value="여" checked></label>      
	            </c:if>         
	         </c:if>
	      <br>
	      주소<br>
	      시/도<input type="text" name="city" id="city"><br>
	      구/군<input type="text" name="region" id="region"><br>
	      상세주소<input type="text" name="location" id="location"><br>   
	     
	      연락처<br>
	   		<input type="text" name="phone" id="phone" <c:if test="${phone ne null}"> value="${phone }" readonly</c:if> ><br>
	   		<span class="error_next_box" id="idMesg" style aria-live="assertive">필수 정보입니다.</span>
	   
	      이메일<br>
	   		<c:if test="${email ne null}">
	      		<input type="text" name="email" id="email" <c:if test="${email ne null}"> value="${email }" readonly</c:if>><br>      
	   		</c:if>
	   		<input type="button" id="join_btn" value="가입하기">
	   		<span class="error_next_box" id="idMesg" style aria-live="assertive">필수 정보입니다.</span>
	   		<span class="error_next_box" id="authNoMesg" style aria-live="assertive">인증이 필요합니다.</span>
   </form>
	</c:if>
	
	<c:if test="${loginApi eq null }">
		<form id="f" method="post" action="m.join">		
			아이디<br>
			<input type="text" name="memberId" id="memberId"><br>
			비밀번호<br>
			<input type="text" name="password" id="password"><br>
			비밀번호 재확인<br>
			<input type="text" name="password2" id="password2"><br>
			닉네임<br>
			<input type="text" name="nickname" id="nickname" placeholder="닉네임"><br>
			이름<br>
			<input type="text" name="name" id="name" placeholder="이름"><br>
			생년월일<br>
			<input type="text" name="birthday" id="birthday"><br>
			성별<br>
			<select name="gender">
				<option value="">성별</option>
				<option value="M">남</option>
				<option value="W">여</option>
			</select><br>
			주소<br>
			시/도<input type="text" name="city" id="city"><br>
			구/군<input type="text" name="region" id="region"><br>
			상세주소<input type="text" name="location" id="location"><br>	
			연락처<br>
			<input type="text" name="phone" id="phone"><br>
				<input type="text" name="email" id="email"><br>		
			이메일<br>
			<button>가입하기</button>
		</form>
	</c:if>
>>>>>>> Stashed changes
</body>
</html>