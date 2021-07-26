<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<!-- head -->
	<jsp:include page="../layout/header.jsp"></jsp:include>
<!-- End head -->
	<style>
		.container {
			width: 80%;
		}
		.update {
			margin: auto;
			padding: 50px;
		}
		.nickname {
			height: 40px;
			padding: 5px;
		}
		.content {
			height: 500px;
			padding-top: 20px;
		}
		small {
			font-weight: 700;
			color: green;
		}
		.bottom {
			width: 490px;
			magin-right: 0px;
			magin-bottom: 50px;
			float: right;
			text-align: end;
		}
		.title {
			width: 100%;
			font-size: 30px;
			
		}
		button {
			margin-top: 20px;
			margin-right: 10px;
		}
	</style>
<body>

    <h2 class="py-5 text-center">커뮤니티 게시판</h2>
	<div class="container">
		<form class="update border" id="frm" name="frm" onsubmit="return false">
			<c:if test="${not empty board.getBoardNo()}">
				<input type="hidden" name="boardNo" id="boardNo" value="${board.getBoardNo()}"></input>
			</c:if>
		  	<!-- Text Input -->
		  	<div class="border-bottom">
			 	<div>
			 		<input class="title border-0 bg-light" name="title" value="${board.getTitle()}"><br>	
					<small>수정할 제목을 입력하세요</small>
				</div>
				<div class="nickname">
					<input class="border-0 bg-light" name="nickname" value="${member.getNickname()}" readonly >
				</div>
			</div>
			<div class="content">
		    	<textarea class="form-control h-25 border-0 bg-light" rows="10" style="font-size: 30px;"name="content">${board.getContent()}</textarea><br>
		    	<small style="margin-left:12px;">수정할 내용을 입력하세요</small>
		    </div>
		    <div class="bottom row md-12">
		    	<div class="col-4">
				    <div class="border-0 bg-light" name="regdate">등록일 : ${board.getRegDate()}</div>
				</div>
				<div class="col-4">
				    <div class="border-0 bg-light" name="moddate">수정일 : ${board.getModDate()} </div>
				</div>
				<div class="col-3">
				    <div class="border-0 bg-light" name="hit">조회수 : ${board.getHit()}</div>
				</div>
			</div>

		</form>
		<div class="text-center">
			<c:if test="${not empty board}">
				<button type="button" class="btn btn-outline-success btn-lg" onclick="location.href='javascript:boardSave()'">수정하기</button>
			</c:if>
			<c:if test="${empty board}"> 
				<button type="button" class="btn btn-outline-success btn-lg" onclick="location.href='javascript:boardSave()'">저장하기</button>
			</c:if>
			<button type="button" class="btn btn-outline-secondary btn-lg" onclick="location.href='b.list;'">목록보기</button>
		</div>
	</div>
	<script>
		function boardSave(){
			
			var saveTxt = $("#boardNo").val() != null ? '수정' : '저장';
			if(confirm(saveTxt+'하시겠습니까?')){
				var formData = $("#frm").serializeArray();
				console.log(document.frm)
				console.log('formdata',formData)
				$.ajax({
				    url: "b.save", // 클라이언트가 요청을 보낼 서버의 URL 주소
				    data: formData,                // HTTP 요청과 함께 서버로 보낼 데이터
				    type: "POST",                             // HTTP 요청 방식(GET, POST)
			        success : function(data) {
			        	alert('저장 되었습니다.');
			       		location.href='b.list'
			        	console.log(data);
			        	var jsonObj = JSON.parse(data);
			        }, // success 
			        error : function(xhr, status) {
			        	alert('error')
			        	alert(xhr + " : " + status);
			        }
				})
			}
			
		}
	</script>
	  	<!-- Footer -->
        	<jsp:include page="../layout/footer.jsp"></jsp:include>
        <!-- End Footer -->
</body>
</html>