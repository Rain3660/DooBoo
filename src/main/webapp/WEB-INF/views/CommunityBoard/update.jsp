<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<!-- head -->
	<jsp:include page="../layout/header.jsp"></jsp:include>
<!-- End head -->
<body>

    <h2>커뮤니티 게시판</h2>
	<div>
		<form id="frm">
			<c:if test="${not empty board.getBoardNo()}">
				<input type="hidden" name="boardNo" id="boardNo" value="${board.getBoardNo()}"></input>
			</c:if>
		  <!-- Text Input -->
		  <div>
		    <label>제목</label>
		    <input id="inputGroup1_1" type="text" name="title"value="${board.getTitle()}" >
		    <small>제목을 입력하세요</small>
		  </div>
		  <!-- End Text Input -->
		  <!-- Textarea Resizable -->
		  <div>
		    <label>내용</label>
		    <textarea id="inputGroup2_2" name="contents" rows="10">${board.getContents()}</textarea>
		    <small>내용을 입력하세요</small>
		  </div>
		  <!-- End Textarea Resizable -->
		</form>			
		<c:if test="${not empty board}"> 
				<a href="javascript:boardSave()">수정하기</a>
			</c:if>
			<c:if test="${empty board}"> 
				<a href="javascript:boardSave()">저장하기</a>
			</c:if>
			<button><a href="/board/list">목록보기</a></button>
	</div>
	<script>
		function boardSave(){
			
			var saveTxt = $("#boardNo").val() != null ? '수정' : '저장';
			if(confirm(saveTxt+'하시겠습니까?')){
				var formData = $("#frm").serializeArray();
				$.ajax({
				    url: "/board/save", // 클라이언트가 요청을 보낼 서버의 URL 주소
				    data: formData,                // HTTP 요청과 함께 서버로 보낼 데이터
				    type: "POST",                             // HTTP 요청 방식(GET, POST)
				    dataType: "json",                         // 서버에서 보내줄 데이터의 타입
			        success : function(data) {
			        	alert('저장 되었습니다.');
			       		location.href='/board/list'
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