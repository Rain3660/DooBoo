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
			    <label>번호</label>
			    <input type="text"  name="rownum" value="${board.getBoardNo()}" readonly>
		    </div>
		  	<div>
			    <label>제목</label>
			    <input type="text"  name="title" value="${board.getTitle()}" readonly >
		    </div>
		  	<div>
			    <label>작성자</label>
			    <input name="nickname" value="${member.getNickname()}" readonly >
		    </div>
    		<div>
		    	<label>내용</label>
		    	<textarea name="content" id="inputGroup2_2" readonly>${board.getContent()}</textarea>
		    </div>
    		<div>
		    	<label>첨부파일</label>
		    	<c:forEach var="boardFile" items="${board.productImageList}" varStatus="status">
		    		<div id="div_file_${boardFile.fileNo}">
		    			<img src="${STATIC_IMAGE_ROOT }${boardFile.filePath }" width="100px">
						<span>${boardFile.fileName}<button type="button" class="btn-close file-close" onclick="removeFile(this)" data-file-seq="${boardFile.fileNo}" aria-label="Close"></button></span>						
		    		</div>
		    	</c:forEach>
		    </div>
		  	<div>
			    <label>등록일</label>
			    <input name="regdate" value="${board.getRegDate()}" readonly >
		    </div>
		  	<div>
			    <label>수정일</label>
			    <input name="moddate" value="${board.getModDate()}" readonly >
		    </div>
		  	<div>
			    <label>조회수</label>
			    <input name="hit" value="${board.getHit()}" readonly >
		    </div>
		</form>
		<a href="b.list">목록보기</a>
	</div>
     <!-- Footer -->
        <jsp:include page="../layout/footer.jsp"></jsp:include>
     <!-- End Footer -->
</body>
</html>