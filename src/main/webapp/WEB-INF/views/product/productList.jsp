<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp"></jsp:include>
<script>
	$(document).ready(function(){
		 	$.ajax({
				 url:'p.selectProductListByLocation',
				 data:'memberNo=${loginUser.memberNo}',
				 dataType :'json',
				 success : function(resultMap){
					if(resultMap.result > 0){
						//productVO =  resultMap.list
						//resultMap.result == 인서트에 성공하면 1 실패하면 0
						//resultMap.list.address = '서울시 은평구 녹번동' 으로 풀주소가 나와있습니다
						//화면상단에 '은평구'  지역 매물 만 넣고싶다면(중간이름만 빼서 넣어야하긴함 '구' 기준 매물들이니)
						//resultMap.midLocation  = '은평구'
						//따로 스플릿해서 중간주소만 빼온것이니 
						
					}
				 }
			 })
	})
	

		
		
</script>
	<div id="productList">


	</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>


