<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<!-- head -->
	<jsp:include page="../layout/header.jsp"></jsp:include>
<!-- End head -->
<body>
	<form id="frm">
       	<h1>커뮤니티 게시판</h1>
	            <!-- 1-st column -->
	            <div>
	            <!-- Basic Text Inputs -->
		         <div>
                 <h3>게시글 작성하기</h3>
                  <!-- Default Input -->
	             <div>
	                <label>Title</label>
                    <input id="inputGroup-1_1" type="text"  value="${board.getTitle()}" name="title" placeholder="제목을 입력해주세요">
	             </div>
	                <!-- End Default Input -->
	                <!-- Textarea -->
	                <div>
                   		<label>Contents</label>
                    	<textarea id="inputGroup-1_1" rows="3" name="contents" placeholder="내용을 입력하세요">${board.getContents()}</textarea>
                    	<small>
                    		<strong>Note:</strong> height of the textarea depends on the rows attribute.
                  		</small>
	                 </div>
	                 <div style="text-align : center">
		                <c:if test="${empty board}"> 
		                		<a href="javascript:boardSave();">저장하기</a>
						</c:if>
						<c:if test="${not empty board}"> 
		                		<a href="javascript:boardSave();">수정하기</a>
						</c:if>
		                	<button><a href="/board/list">목록보기</a></button>
	                  <!-- End Textarea -->
	                </div>
              </form>  
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
</html>