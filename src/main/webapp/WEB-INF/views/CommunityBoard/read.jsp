<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<header>
	<!-- head -->
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<!-- End head -->
	<style>
		.container {
			width: 80%;
		}
		.read {
			margin: auto;
			padding: 50px;
			
		}
		.nickname {
			height: 30px;
			padding: 5px;
		}
		.content {
			height: 500px;
			padding-top: 20px;
			font-size: 30px;
		}
		.bottom {
			width: 490px;
			magin-right: 0px;
			magin-bottom: 50px;
			float: right;
			text-align: end;
		}
		button {
			margin-top: 20px;
		}
	</style>
</header>
<body>
   	<h2 class="py-5 text-center">커뮤니티 게시판</h2>
   	<div class="container">
		<div class="read border">
			<c:if test="${not empty board.getBoardNo()}">
				<input type="hidden" name="boardNo" id="boardNo" value="${board.getBoardNo()}"></input>
			</c:if>
			<div class="border-bottom">
			  	<div class="rownum">
				    <input type="text" class="d-none" name="rownum" value="${board.getBoardNo()}" readonly>
			    </div>
			  	<div class="title">
				    <h1 class="border-0 bg-light" name="title">${board.getTitle()}</h1>
			    </div>
			  	<div class="nickname">
				    <p class="border-0 bg-light" name="nickname">${board.getNickname()}&nbsp;님</p>
			    </div>
		    </div>
    		<div class="content">
		    	<p class="border-0 bg-light" name="content">${board.getContent()}</p>
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
		</div>
		<div class="d-grid gap-2 col-2 mx-auto">
			<button type="button" class="btn btn-outline-secondary btn-lg" onclick="location.href='b.list;'">목록보기</button>
		</div>
	</div>

     <!-- Footer -->
        <jsp:include page="../layout/footer.jsp"></jsp:include>
     <!-- End Footer -->
</body>
</html>