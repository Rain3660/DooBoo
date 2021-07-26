<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="layout/header.jsp"></jsp:include>
<style>
	.container {
		width: 80%;
		margin-top: 300px;
		margin-bottom: 300px;
		
	}
</style>
	<div class="container text-center">
		<div class="px-3">
	        <img src="resources/image/error.jpg">
	        <h1>Error 404</h1>
	        <h3>죄송합니다. 현재 찾을수 없는 페이지를 요청 하셨습니다.</h3>
	        <pre>존재하지 않는 주소를 입력하셨거나, 요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.
	            궁금한 점이 있으시면 언제든 고객센터를 통해 문의해 주시기 바랍니다.</pre>
	        <p class="lead">
	          <a href="#">홈으로 이동</a>
	        </p>
	    </div>
	</div>

<jsp:include page="layout/footer.jsp"></jsp:include>
