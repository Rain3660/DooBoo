
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		$(document).ready(function(){
			fn_idCheck();
			fn_pwCheck();
			fn_pwCheck2();
			fn_emailCheck();
			fn_nicknameCheck();
			fn_nameCheck();
			fn_phoneCheck();
			fn_join();
			
		
			
		})
		
		var idPass= false;
		function fn_idCheck(){
			$('#id').keyup(function(){
			var regID = /^[a-z][a-z0-9_-]{3,31}$/;
			if(!regID.test($('#id').val())) {
				$('#id_result').text('아이디는 영문 숫자 _- 조합  ').css('color','red');
				
				return idPass;
				
			}
			$.ajax({
				url:'m.idCheck',
				type: 'get',
				data:'id=' + $('#id').val(),
				dataType: 'json',
				success: function(result){
					if(result.count ==  0){
						$('#id_result').text('사용가능한 아이디 입니다').css('color','blue');
						idPass = true 
						return true;
					}else{
						$('#id_result').text('이미 사용중인 아이디 입니다.').css('color','red');
						idPass = false;
					}
				},
				error: function(xhr,textStatus, errorThrown) {
					
				}
				
			})
			
				
			})
			
		}
		
		var pwPass= false;
		function fn_pwCheck(){
				if($('#pw').val() == ''){
					$('#pw_result').text('필수정보 입니다. ')
					pwPass= false;
				}
			$('#pw').keyup(function(){
				
				var regPW = /^[0-9]{1,4}$/;
				
				 if(!regPW.test($('#pw').val())){
					$('#pw_result').text('허용하지 않는  비밀번호 형식입니다').css('color','red');
					pwPass = false;
					
				}else{
					$('#pw_result').text('사용가능').css('color','blue');
					pwPass = true;
					return true;
				}
			})
			
		}
		
		var pwPass2 =false;
		function fn_pwCheck2(){
			$('#pw2').keyup(function(){
				if ($('#pw2').val() ==$('#pw').val()){
					$('#pw_result2').text('비밀 번호가 일치합니다.');
					pwPass2 = true;
					return true;
				}else{
					$('#pw_result2').text('비밀 번호가 일치하지 않습니다.')
					pwPass2= false;
				}
				
			})
			
		}
		
		var emailPass = false;
		function fn_emailCheck() {
		      var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		      $('#email').on('keyup', function() {
		         if ($('#email').val() == '') {
		            $('#email_result').text('필수 정보 입니다.')
		            emailPass = false;
		            console.log(emailPass);
		            return false;
		         }
		         if (!regEmail.test($('#email').val())) {
		            $('#email_result').text('이메일 형식에 부합하지 않습니다.')
		            emailPass = false;
		            console.log(emailPass);
		            return false;
		         }
		         $('#email_result').text('적합한 이메일 입니다')
		         emailPass = true;
		         console.log(emailPass);
		         return true;
		      })
		   }
		
		var nicknamePass = false;
		function fn_nicknameCheck(){
			var regNickname = /^[가-힣ㄱ-ㅎa-zA-Z0-9._-]{2,10}$/;
			
			$('#nickname').keyup(function(){
				if($('#nickname').val() == '' ){
					$('#nickname_result').text('필수정보 입니다');
					nicknamePass = false;
					return false;
					
				}
				if(!regNickname.test( $('#nickname').val())){
					$('#nickname_result').text('닉네임은 한글, 영문, 숫자만 가능하며 2-10자리 가능.')
					nicknamePass = false;
				     return false;
					
							
				}
				$('#nickname_result').text('적합한 닉네임입니다.')
				nicknamePass = true;
				return true;
				
				
			})
			
		}
			var namePass = false;
		function fn_nameCheck(){
			var regname = /^[가-힣]{2,6}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/

			$('#name').keyup(function(){
				if($('#name').val() == '' ){
					$('#name_result').text('필수정보 입니다');
					namePass = false;
					return false;
					
				}
				if(!regname.test( $('#name').val())){
					$('#name_result').text('이름은 한글, 영문, 숫자만 가능하며   한글 2-6 자리 영문 2-10자리 가능.')
					namePass = false;
				     return false;
					
							
				}
				$('#name_result').text('적합한 이름입니다.')
				namePass = true;
				return true;
				
				
			})
			

			
		}
		
		
		var phonePass = false;
		function fn_phoneCheck(){
			var regname = /^[0-9]{3}-[0-9]{3,4}-[0-9]{4}/

			$('#phone').keyup(function(){
				if($('#phone').val() == '' ){
					$('#phone_result').text('필수정보 입니다');
					phonePass = false;
					return false;
					
				}
				if(!regname.test( $('#phone').val())){
					$('#phone_result').text('숫자, -을 포함해 휴대전화 형식에 맞게 입력해주세요.')
					phonePass = false;
				     return false;
					
							
				}
				$('#phone_result').text('적합한 번호입니다.')
				phonePass = true;
				return true;
				
				
			})
			

			
		}
				

			
				

			
		
		
		
		
		function fn_join(){
			$('#join_btn').click(function(){
			if(!idPass && !fn_idCheck() == true){
				alert('아이디 확인')
				return false;
			}else if(!pwPass || !pwPass2){
				alert('비밀번호 확인')
			}else if(!emailPass){
				alert('이메일 확인 ')
			}else if(!nicknamePass){
				alert('닉네임 확인')
			}
			else if(!namePass){
				alert('이름 확인')
			}
			else if(!phonePass){
				alert('연락처  확인')
			}
			
			else{
			$('#f').attr('action','m.join');
			$('#f').submit();
			alert('가입 완료')
			
			}
			
				
			})
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
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

	<form id="f" method="post" >

		아이디<br> <input type="text" name="memberId"  id="id"><br>
			<span  id="id_result" style aria-live="assertive"></span>
		비밀번호<br> <input type="text" name="password" id="pw"><br>
				<span  id="pw_result" style aria-live="assertive"></span>
		비밀번호 재확인<br> <input type="text" name="pw2" id="pw2"><br>
				<span  id="pw_result2" style aria-live="assertive"></span>
		닉네임<br> <input type="text" name="nickname" id="nickname" placeholder="닉네임"><br>
				<span  id="nickname_result" style aria-live="assertive"></span>
		이름<br> <input type="text"name="name" id="name" placeholder="이름"><br> 
			   <span  id="name_result" style aria-live="assertive"></span>
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
	     <span  id="phone_result" style aria-live="assertive"></span>
	     이메일<br> <input type="text" name="email" id="email"><br> 
	     
	  <p  id="email_result" style aria-live="assertive"></p><br>
	  
	   <input type="button" id="join_btn" value="가입하기">
	</form>
		
		
		
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

</body>
</html>