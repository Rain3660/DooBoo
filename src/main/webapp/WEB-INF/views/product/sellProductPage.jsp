<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<br>
	<br>
	
	<form method="post" enctype="multipart/form-data" id="sellProductForm">
		<div class="mb-3 text-right">
			<h1 class="text-center">중고거래 등록하기</h1>
		</div>
		<div class="mb-3 text-right">
			<input type="button" class="btn btn-primary float-right" value="등록" id="sellProduct_btn">
		</div>
		<div class="mb-3">
			<label for="title" class="form-label">제목</label>
			<input type="text" class="form-control" id="title" name="title" placeholder="title">
		</div>
		<div class="mb-3">
			<label for="price" class="form-label">가격</label>
			<input type="text" class="form-control" id="price" name="price" placeholder="$">
		</div>
		<div class="mb-3">
			<label for="content" class="form-label">내용</label>
			<textarea class="form-control" id="content" rows="3" cols="5" name="content"></textarea>
		</div>
		<div>
	    	<label>파일</label>
	    	<input type="file" name="uploadFile" id="fileUpload" title="첨부파일 추가1">
	    	<label>파일2</label>
	    	<input type="file" name="uploadFile" id="fileUpload2" title="첨부파일 추가2">
	    	<label>파일3</label>
	    	<input type="file" name="uploadFile" id="fileUpload3" title="첨부파일 추가3">
	    </div>                 
	</form>
</div>
<script type="text/javascript">
	/* $(document).ready(function(){
		$('#sellProduct_btn').on('click',function(){
			$('#sellProductForm').attr('action' , 'p.sellProduct');
			$('#sellProductForm').submit();
		})
	})
	 */
	function boardSave(){
		var saveTxt = $("#sellProduct_btn").val() != null ? '수정' : '저장';
		if(confirm(saveTxt+'하시겠습니까?')){
			//var formData = $("#frm").serializeArray();
			var formData = new FormData(document.frm);				
			$.ajax({
				processData: false,
	            contentType: false,							
			    url: "p.save", 
			    data: formData,                
			    type: "POST",                           
		        success : function(data) {
		        	alert('저장 되었습니다.');
		       		location.href='p.sellProduct'
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
<jsp:include page="../layout/footer.jsp"></jsp:include>