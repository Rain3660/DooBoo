<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container">
	<div class="row">
		<h1>회원 정보</h1>

		<h3>회원 프로필</h3>
		<form id="profile" method="post">
			이름<br> <input type="text" name="name" value="${loginUser.name}"
				id="name"><br> 닉네임<br> <input type="text"
				name="nickname" value="${loginUser.nickname}" id="nickname"><br>

			성별<br> ${loginUser.gender}<br> 생년월일<br>
			${loginUser.birthday}<br> <input type="button"
				id="update_info_btn" value="수정">
		</form>


		<h3>아이디, 비밀번호</h3>
		<form id="idPassword" method="post">
			아이디<br> ${loginUser.memberId}<br>
			 현재 비밀번호<br> 
			 <input type="password" id="pw0"><br>
			 <span id="currPw_msg"></span> 
			 새 비밀번호<br> 
			 <input type="password" name="password" id="pw"><br>
			  비밀번호 확인<br>
			<input type="password" id="pw2"> 
			<input type="button" d="update_pw_btn" value="수정"><br>
			<br>
		</form>


		<h3>연락처 및 주소</h3>
		<form id="contect" method="post">
			연락처<br> <input type="text" name="phone"
				value="${loginUser.phone}"><br> 이메일<br>
			${loginUser.email}<br> <input type="button" id="update_contect"
				value="수정"> 시<br> <input type="text" name="city"
				value="${loginUser.city}"><br> 구<br> <input
				type="text" name="region" value="${loginUser.region}"><br>
			상세주소<br> <input type="text" name="location"
				value="${loginUser.location}"><br> <input
				type="button" id="update_contact_btn" value="수정">
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

<script type="text/javascript">
	$(document).ready(function(){
		var currPwCheck = false;
		$('#update_info_btn').on('click' , function(){
			if($('#name').val() == ''){ // name 이 공백일 때 ,
				alert('이름은 필수정보 입니다.');
				$('#name').focus();
				return false;
			}
			if($('#nickname').val() == ''){ // nickname 이 공백일 때,
				alert('닉네임은 필수정보 입니다.');
				$('#nickname').focus();
				return false;
			}
			if($('#name').val() == '${loginUser.name}' && $('#nickname').val() == '${loginUser.nickname}'){
				alert('변경된 정보가 없습니다.');
				return false;
			}
			$('#profile').attr('action' , 'm.updateInfo');
			$('#profile').submit();
		})
		$('#pw0').on('keyup',function(){
			var obj = {
					memberNo : ${loginUser.memberNo} ,
					password : $('#pw0').val()
			};
			$.ajax({
				url : 'm.currentPwCheck' ,
				type : 'post' ,
				data : JSON.stringify(obj) ,
				contentType : 'application/json; charset=utf-8' ,
				dataType : 'json' ,
				success : function(resultMap){
					console.log(resultMap);
					if(resultMap.result > 0){
						currPwCheck = true;	
					}
				}
			})
		})
		
		
	})

</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>