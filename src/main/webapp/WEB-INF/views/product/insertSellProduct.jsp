<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container">
	<br>
	<br>
	
	<form method="post" id="sellProductForm" name="sellProductForm" onsubmit="return false">
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
			<input type="text" class="form-control" id="price" name="price" placeholder="$" >
		</div>
		<div class="mb-3">
			<label for="content" class="form-label">내용</label>
			<textarea class="form-control" id="content" rows="3" cols="5" name="content"></textarea>
		</div>
		<div class="mb-3 text-right">
			<button class="btn btn-outline-success" id="fileAddBtn">파일첨부</button>
			<div id="fileArea">
		    	<c:forEach var="boardFile" items="${board.productImageList}" varStatus="status">
		    		<div id="div_file_${boardFile.fileNo}">
		    			<img src="${STATIC_IMAGE_ROOT }${boardFile.filePath}" width="100px">
						<span>${boardFile.fileName}<button type="button" class="btn-close file-close" onclick="removeFile(this)" data-file-seq="${boardFile.fileNo}" aria-label="Close"></button></span>						
		    		</div>
		    	</c:forEach>
		    </div>
		</div>
		
		<c:if test="${mapSession1DTO ne null }">
		            <input type="radio" class="btn-check"  name="btnradio" id="btnradio1" autocomplete="off">
		            <label class="btn btn-outline-primary" id="btnradio1text" for="btnradio1">${mapSession1DTO.location}</label>
		            <c:if test="${mapSession1DTO.isChecked eq 1}">인증완료</c:if>				
		            <c:if test="${mapSession1DTO.isChecked ne 1}">미인증</c:if>
		</c:if>
		<c:if test="${mapSession1DTO eq null }">
			 <input type="radio" class="btn-check"  name="btnradio" id="btnradio1" autocomplete="off" disabled>
		     <label class="btn btn-outline-primary" id="btnradio1text" for="btnradio1" >미등록</label>
		</c:if>
		<c:if test="${mapSession2DTO ne null }">
		            <input type="radio" class="btn-check"  name="btnradio" id="btnradio2" autocomplete="off">
		            <label class="btn btn-outline-primary" id="btnradio2text" for="btnradio2">${mapSession2DTO.location}</label>
		            <c:if test="${mapSession2DTO.isChecked eq 1}">인증완료</c:if>				
		            <c:if test="${mapSession2DTO.isChecked ne 1}">미인증</c:if>
		</c:if>
		<c:if test="${mapSession1DTO eq null }">
			 <input type="radio" class="btn-check"  name="btnradio" id="btnradio2" autocomplete="off" disabled>
		     <label class="btn btn-outline-primary" id="btnradio2text" for="btnradio2" >미등록</label>
		</c:if>
		&nbsp;&nbsp; <input type="button" value="거래지역수정하기" id="update_location_btn" onclick="window.open('m.mapCheckLocationPage','지역변경','width=430,height=500,location=no,status=no,scrollbars=yes');">
		<input type="hidden" value="1043" name="regNo">
		<input type="hidden" name="mapNo" id="mapNo" value="58">
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		fn_IdChange();
		$('#sellProduct_btn').on('click',function(){
			if(!fn_IdChange()){
				alert('지역이 인증되지 않았습니다. 다시확인해주세요');					
			}else{
				if(confirm('저장 하시겠습니까?')){
					var formData = new FormData(document.sellProductForm);
					$.ajax({
						processData: false,
			            contentType: false,				
						url:'p.sellProduct',
						data: formData,
						type :'post',
						datatype:'json',
						success : function(resultMap){
							if(resultMap.result > 0){
								alert('등록되었습니다.');
								location.href='p.selectOneProduct?productNo='+resultMap.productNo;
							}else{
								alert('등록에 실패하였습니다');
								return false;
							}
						}
						,error : function(res){
							console.log(res,'error');
						}
					})
				}
			}
		})
	})
	
	
	var result = false;
	   function fn_IdChange(){
            $("#btnradio1").change(function(){
                if($('#btnradio1').is(':checked')){
                 if('${mapSession1DTO.isChecked}'== 0 ){
                	 alert('미인증 지역입니다 인증을 진행해주세요');
                 }else{
                	 $('#mapNo').val('${mapSession1DTO.mapNo}');
	                  result = true;
                 }
                }
            }) 
            $("#btnradio2").change(function(){
                if($('#btnradio2').is(':checked')){
                	if('${mapSession2DTO.isChecked}'== 0 ){
                		alert('미인증 지역입니다 인증을 진행해주세요');
                	}else{
                		$('#mapNo').val('${mapSession2DTO.mapNo}');
	                    result = true;
                	}
                }
            })
            return result;
        }
	
		function boardSave(){
			
			var saveTxt = $("#productNo").val() != null ? '수정' : '저장';
			if(confirm(saveTxt+'하시겠습니까?')){
				console.log(document.frm)
				var formData = new FormData(document.frm);
				console.log('formdata',formData)
				$.ajax({
					processData: false,
		            contentType: false,					
				    url: "p.save", // 클라이언트가 요청을 보낼 서버의 URL 주소
				    data: formData,                // HTTP 요청과 함께 서버로 보낼 데이터
				    type: "POST",                             // HTTP 요청 방식(GET, POST)
			        success : function(data) {
			        	alert('저장 되었습니다.');
			       		location.href='home.jsp'
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
<jsp:include page="../layout/footer.jsp"></jsp:include>