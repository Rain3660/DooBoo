<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<div class="mb-3 text-right">
			<input class="form-control" type="file" id="images" name="images" multiple style="border: none;">
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
		
		<input type="hidden" value="${loginUser.memberNo }" name="regNo">
		<input type="hidden" name="mapNo" id="mapNo">	
	</form>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		fn_IdChange();
		$('#sellProduct_btn').on('click',function(){
			if(!fn_IdChange()){
				alert('지역이 인증되지 않았습니다. 다시확인해주세요');					
			}else{
				$.ajax({
					url:'p.sellProduct',
					data:$('#sellProductForm').serialize(),
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
					},error(){
						
					}
				})
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
	
	
</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>