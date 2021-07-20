<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<!-- section -->
<br><br>
<div class="text-center container">
	<div class="row">
		<div class="col-md-6" >
		<h3>아이디 찾기</h3>
		<form id="f1">
  			<div class="form-group row">
    		<label for="name_for_id" class="col-sm-2 col-form-label">이름</label>
    			<div class="col-sm-12">
      				<input type="text" class="form-control" id="name_for_id">
    			</div>
  			</div>
  			<div class="form-group row">
    		<label for="email_for_id" class="col-sm-2 col-form-label">이메일</label>
    			<div class="col-sm-12">
      				<input type="text" class="form-control" id="email_for_id">
    			</div>
  			</div>
  			<input type="button" class="btn btn-primary btn-lg btn-block" value="아이디 찾기" id="find_id_btn">
		</form>
	</div>
	<div class="col-md-6" >
		<h3>비밀번호 찾기</h3>
		<form id="f2">
  			<div class="form-group row">
    		<label for="id_for_pw" class="col-sm-2 col-form-label">아이디</label>
    			<div class="col-sm-12">
      				<input type="text" class="form-control" id="id_for_pw">
    			</div>
  			</div>
  			<div class="form-group row">
    		<label for="email_for_pw" class="col-sm-2 col-form-label">이메일</label>
    			<div class="col-sm-12">
      				<input type="text" class="form-control" id="email_for_pw">
    			</div>
  			</div>
  			<input type="button" class="btn btn-primary btn-lg btn-block" value="비밀번호 찾기" id="find_pw_btn">
		</form>
	</div>
	</div>
</div>
<script>
	
	$(document).ready(function(){
		findId();
		findPw();
	})
	function findId() {
		$('#find_id_btn').on('click',function(){
			if($('#name_for_id').val() == ''){
				alert('이름을 입력하세요');
				$('#name_for_id').focus();
				return false;
			}
			if($('#email_for_id').val() == ''){
				alert('이메일를 입력하세요');
				$('#email_for_id').focus();
				return false;
			}
			var obj = {
					name : $('#name_for_id').val() ,
					email : $('#email_for_id').val()
			};
			$.ajax({
				url : 'm.findId',
				type : 'post' ,
				data : JSON.stringify(obj),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json' ,
				success : function(resultMap){
					if(resultMap.status == 500){
						alert('일치하는 회원정보가 없습니다.');
					}else{
						alert('회원님의 아이디는 ' + resultMap.id + '입니다.');
						$('#name_for_id').val('');
						$('#email_for_id').val('');
					}
				}
		})
		})
	}
	function findPw() {
		$('#find_pw_btn').on('click',function(){
			if($('#id_for_pw').val() == ''){
				alert('아이디를 입력하세요');
				$('#id_for_pw').focus();
				return false;
			}
			if($('#email_for_pw').val() == ''){
				alert('이메일를 입력하세요');
				$('#email_for_pw').focus();
				return false;
			}
			var obj = {
					memberId : $('#id_for_pw').val() ,
					email : $('#email_for_pw').val()
			};
			$.ajax({
				url : 'm.findPw',
				type : 'post' ,
				data : JSON.stringify(obj),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json' ,
				success : function(resultMap){
					if(resultMap.status == 500){
						alert('일치하는 회원정보가 없습니다.');
					}else if(resultMap.status == 200){
						// 실제로는 비밀번호를 알려주지 않을거임
						alert('회원님의 이메일로 임시 비밀번호를 전송했습니다, 로그인 페이지로 이동합니다.' + '비밀번호 : ' + resultMap.tempPw);
						location.href ='m.loginPage';
					}
				}
		})
		})
	}
</script>
<!-- section -->
<jsp:include page="../layout/footer.jsp"></jsp:include>