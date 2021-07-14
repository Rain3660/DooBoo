<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<header>
	<!-- head -->
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<!-- End head -->
</header>
<body>
    <h2>커뮤니티 게시판</h2>
	<div>
		<form>
			<c:if test="${not empty board.getBoardNo()}">
				<input type="hidden" name="boardNo" id="boardNo" value="${board.getBoardNo()}"></input>
			</c:if>
		  	<div>
			    <label>제목</label>
			    <input id="inputGroup1_1" value="${board.getTitle()}" readonly >
			    <small>제목을 입력하세요</small>
		    </div>
		  <!-- Textarea Resizable -->
		  <div>
		    <label>내용</label>
		    <textarea id="inputGroup2_2">${board.getContents()}</textarea>
		    <small>내용을 입력하세요</small>
		  </div>
		  <!-- End Textarea Resizable -->
		</form>
		<a href="/board/list" class="btn btn-md u-btn-inset u-btn-indigo g-mr-10 g-mb-15">목록보기</a>
	</div>
     <!-- Footer -->
        <jsp:include page="../layout/footer.jsp"></jsp:include>
     <!-- End Footer -->
</body>
</html>