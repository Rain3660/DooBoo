<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<!-- head -->
	<jsp:include page="../layout/header.jsp"></jsp:include>
<!-- End head -->
<style>
	a {text-decoration:none}
	#frm {
		margin: auto;
		width: 50%;
		height: 800px;
		font-size: 20px;
	}
</style>
<body>
	<form id="frm" name="frm">
<<<<<<< Updated upstream
       	<h1>커뮤니티 게시판</h1>
	            <div>
		         <div>
                 <h3>게시글 작성하기</h3>
	             <div>
	                <label>Title</label>
                    <input type="text"  value="${communityboard.getTitle()}" name="title" placeholder="제목을 입력해주세요">
	             </div>
                <div>
                  	<label>Contents</label>
                   	<textarea rows="3" name="content" placeholder="내용을 입력하세요"></textarea>
                  
                 </div>
	    		<!-- <div>
			    	<label>파일</label>
			    	<input type="file" name="uploadFile" id="fileUpload" title="첨부파일 추가1">
			    	<label>파일2</label>
			    	<input type="file" name="uploadFile" id="fileUpload2" title="첨부파일 추가2">
			    	<label>파일3</label>
			    	<input type="file" name="uploadFile" id="fileUpload3" title="첨부파일 추가3">
			    </div>         -->         
                 <div style="text-align : center">
	                <c:if test="${empty board}"> 
	                		<a href="javascript:boardSave();">저장하기</a>
					</c:if>
					<c:if test="${not empty board}"> 
	                		<a href="javascript:boardSave();">수정하기</a>
					</c:if>
	                	<button><a href="b.list">목록보기</a></button>
                  <!-- End Textarea -->
                </div>
              </form>  
=======
      <h1 class="py-5 text-center">커뮤니티 게시판</h1>
         <h3 class="py-3 text-center">게시글 작성하기</h3>

				  <label for="title" class="form-label mt-3">Title</label>
				  <input type="text" class="form-control" name="title" id="title"
				  value="${communityboard.getTitle()}" placeholder="제목을 입력해주세요">

				  <label for="contents" class="form-label mt-5">Contents</label>
				  <textarea class="form-control" name="content" id="contents" rows="5" placeholder="내용을 입력하세요"></textarea>
	
           <div class="text-center mt-5">
             <c:if test="${empty board}"> 
               	<button type="button" class="btn btn-outline-success" onclick="location.href='javascript:boardSave();'">저장하기</button>
			 </c:if>
			 <c:if test="${not empty board}"> 
			 	<button type="button" class="btn btn-outline-success" onclick="location.href='javascript:boardSave();'">수정하기</button>
			 </c:if>
			 <button type="button" class="btn btn-outline-secondary" onclick="location.href='b.list'">목록보기</button>
          </div>
    </form>
>>>>>>> Stashed changes
	<script>
		function boardSave(){
			
			var saveTxt = $("#boardNo").val() != null ? '수정' : '저장';
			if(confirm(saveTxt+'하시겠습니까?')){
				//var formData = $("#frm").serializeArray();
				var formData = new FormData(document.frm);				
				$.ajax({
					processData: false,
		            contentType: false,							
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