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
		<form id="frm" name="frm" onsubmit="return false">
			<c:if test="${not empty board.getBoardNo()}">
				<input type="hidden" name="boardNo" id="boardNo" value="${board.getBoardNo()}"></input>
			</c:if>
		  <!-- Text Input -->
		 	<div>
			    <label>제목</label>
			    <input name="title" value="${board.getTitle()}">
			    <small>수정할 제목을 입력하세요</small>
		    </div>
		  	<div>
			    <label>작성자</label>
			    <input name="nickname" value="${member.getNickname()}" readonly >
		    </div>
    		<div>
		    	<label>내용</label>
		    	<textarea name="content">${board.getContent()}</textarea>
			    <small>수정할 내용을 입력하세요</small>
		    </div>
    		<div>
    			<button class="btn btn-outline-success" id="fileAddBtn">파일첨부</button>
		    	<div id="fileArea">
		    	<c:forEach var="boardFile" items="${board.productImageList}" varStatus="status">
		    		<div id="div_file_${boardFile.fileNo}">
		    			<img src="${STATIC_IMAGE_ROOT }${boardFile.filePath }" width="100px">
						<span>${boardFile.fileName}<button type="button" class="btn-close file-close" onclick="removeFile(this)" data-file-seq="${boardFile.fileNo}" aria-label="Close"></button></span>						
		    		</div>
		    	</c:forEach>
					<!-- <input type="file" name="uploadFile" id="fileUpload" title="첨부파일 추가1"> -->
		    	</div>
		    </div>
		  	<div>
			    <label>등록일</label>
			    <input value="${board.getRegDate()}" readonly >
		    </div>
		  	<div>
			    <label>수정일</label>
			    <input value="${board.getModDate()}" readonly >
		    </div>
		  	<div>
			    <label>조회수</label>
			    <input value="${board.getHit()}" readonly >
		    </div>

		</form>			
		<c:if test="${not empty board}"> 
			<a href="javascript:boardSave()">수정하기</a>
		</c:if>
		<c:if test="${empty board}"> 
			<a href="javascript:boardSave()">저장하기</a>
		</c:if>
		<button><a href="b.list">목록보기</a></button>
	</div>
	<script>
		function boardSave(){
			
			var saveTxt = $("#boardNo").val() != null ? '수정' : '저장';
			if(confirm(saveTxt+'하시겠습니까?')){
				//var formData = $("#frm").serializeArray();
				console.log(document.frm)
				var formData = new FormData(document.frm);
				console.log('formdata',formData)
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
	
		
		$("#fileAddBtn").off().on('click',function(e){
			if($("#fileArea div[id^=div_file_]").length > 2){
				alert("파일은 최대 3개 까지 등록 할 수 있습니다.");
				return false;
			}else{
				var fileId = "file_"+($("#fileArea input[type=file]").length);
				var file ='<div id="div_'+fileId+'" data-temp-yn="Y"><input type="file" style="display:none" name="uploadFile" accept="image/*" id='+fileId+' title="첨부파일 추가"></div>';
				$("#fileArea").append(file);
				$("#"+fileId).click();
				$("#"+fileId).change(function(event){
					console.log($(this)[0].files[0])
					var fakeFileHtml = '<span>'+$(this)[0].files[0].name+'<button type="button" class="btn-close" onclicK="removeFile(this)" data-file-seq="" aria-label="Close"></button></span>';
					$("#div_"+fileId).append(fakeFileHtml);
					$("#div_"+fileId).data('tempYn','N');
					$("#div_"+fileId).data('tempYn');
					
					var reader = new FileReader();
					reader.onload = function(event) { 
						var img = document.createElement("img"); 
						img.setAttribute("src", event.target.result);
						
						img.width = 100; 
						img.height = 100; 

						$("#div_"+fileId).prepend(img);
					}; 
					reader.readAsDataURL(event.target.files[0]);

				});
			}
		});
		
		function removeFile(el){
			if(confirm('삭제 하시겠습니까?')){
				if($(el).data('fileSeq')){
					$.ajax({
					    url: "deleteFile", // 클라이언트가 요청을 보낼 서버의 URL 주소
					    data: {
					    	'fileNo' : $(el).data('fileSeq')
					    },                // HTTP 요청과 함께 서버로 보낼 데이터
					    type: "POST",                             // HTTP 요청 방식(GET, POST)
				        success : function(data) {
				        	console.log(data)
				        	$(el).parent().parent().remove();
				        	alert('삭제 되었습니다.');
				        }, // success 
				        error : function(xhr, status) {
				        	alert('error')
				        	alert(xhr + " : " + status);
				        }
					})								
				}else{
					$(el).parent().parent().remove();
				}
			}
		}
		


	</script>
	  	<!-- Footer -->
        	 <jsp:include page="../layout/footer.jsp"></jsp:include>
        <!-- End Footer -->
</body>
</html>