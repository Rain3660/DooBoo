<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- set bodyTheme = "u-card-v1" -->

<!DOCTYPE html>
<html lang="en">
<header>
	<!-- head -->
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<!-- End head -->
</header>
<body>
	<div>
        <table style="border: solid 1px;width : 1000px;">
                 <tr>
		            <th>번호</th>
		            <th>제목</th>
		            <th>작성자</th>
		            <th>가격</th>
		            <th>등록일</th>
		            <th>수정일</th>
		            <th>조회수</th>
		            <th>관리</th>
                </tr>
                <c:if test="${empty resultMap.boardList}">
					<tr>
						<th colspan="8">검색 결과가 없습니다.</th>
					</tr>
				</c:if>
				<c:if test="${not empty resultMap.boardList}">
			        <c:forEach items="${resultMap.boardList}" var="post">
		            	<tr>
			                <td>${post.getProduct()}</td>
			                <td><a href="b.detail?boardNo=${post.getProductNo()}">${post.getTitle()}</a></td>
			                <td>${post.getNickname()}</td>
			                <td>${post.getPrice()}</td>
			                <td>${post.getRegDate()}</td>
			                <td>${post.getModDate()}</td>
			                <td>${post.getHit()}</td>
			                <td>
			                	<a href="p.updateProduct?productNo=${post.getProductNo()}" style="color: green;">수정</a><br>
			                	<a href="javascript:deleteProduct(${post.getProductNo()})" style="color: green;">삭제</a>
			                </td>
         				  </tr>
       				</c:forEach>
				</c:if>
        	</table>
 		</div>
		<div>
     	<button><a href="p.sellProductPage">작성하기</a></button>		
			<form  id ="frm" name="frm" method="get" action="productList">
		  		<if test="${resultMap.listPagingInfo.hasPreviousPage }">
			      <a href="productList?currentPageNo=${status.index +1}"  tabindex="-1" aria-label="Previous">
			        <span>Previous</span>
			        <span aria-hidden="true">«</span>
			      </a>
			    </if>
			    <c:forEach begin="${resultMap.listPagingInfo.firstPage}" end="${resultMap.listPagingInfo.lastPage}" varStatus="status">
			    	<%-- <c:if test="${param.currentPageNo eq  status.index}">active</c:if>"> --%>
			      <a href="productList?currentPageNo=${status.index}">${status.index}</a>
			  	</c:forEach>
			  	<if test="${resultMap.listPagingInfo.hasNextPage}">
			      	<a href="productList?currentPageNo=${resultMap.listPagingInfo.lastPage }"aria-label="Next">
			        	<span aria-hidden="true">»</span>
			        	<span>Next</span>
	     		    </a>
				 </if>  
			</form> 
		
			<form id="search"  action="productList" method="get" style="animation-duration: 300ms; right: 0px;" >
				<div>
			  		<select name="searchType" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"  style="width:150px;">
					    <option value="" >전체</option>
					    <option value="title" <c:if test="${params.searchType eq 'title'}">selected</c:if>>제목</option>
					    <option value="content" <c:if test="${params.searchType eq 'content'}">selected</c:if>>내용</option>
					</select>&nbsp;
	                <div>
	                   <input type="text" name="searchKeyword" placeholder="검색어 입력.." style="width:500px;" value="${params.searchKeyword }" />
	                   <div>
	                 		<button type="submit">검색</button>
	                   </div>
	                </div>
				  </div>
			 </form>
	   </div>
	
<script type="text/javascript">
	var searchForm = $("search");
	
	$("search").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return false;
		}
		e.preventDefault();
		searchForm.submit();
	});
	
	
	
	function deleteProduct(productNo){
		if(confirm('삭제 하시겠습니까?')){
			$.ajax({
			    url: "/dooboo/p.deleteProduct", 
			    data: {
			    	'productNo' : productNo
			    },                
			    type: "POST",                             
			    dataType: "json",                        
		        success : function(data) {
		        	console.log(data)
		        	alert('삭제 되었습니다.');
		       		location.href='/dooboo/productList'
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
