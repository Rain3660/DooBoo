<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<header>
	<!-- head -->
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<!-- End head -->
	<script>
		$(document).ready(function(){
			fn_insertReply();
			fn_selectAllReply();
			fn_delete();
			fn_paging();
		});
		
		function fn_insertReply(){
			$('#insert_btn').click(function(){
				$('#f').attr('action', 'b.insertReply');
				$('#f').submit();
			});
		}
		
		var page = 1;
		var boardNo = '${board.boardNo}';
		function fn_selectAllReply(){
			$.ajax({
				url: 'r.selectAllReply',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify({boardNo : boardNo,  page : page}),
				dataType: 'json',
				success: function(result) {
					console.log(result);
					$('#replyList').empty();  
					$.each(result.list, function(i, reply) {
						if(reply.delYn == 'N' ){
						
						$('<tr>')
							.append($('<td>').text(reply.replyNo))
							.append($('<td>').text(reply.regNo))
							.append($('<td>').text(reply.replyContent))
							.append($('<td>').text(reply.modNo))
							.append($('<td>').html('<input type="button" id="deleteReply"  value="삭제" ><input type="hidden" name="replyNo" id="replyNo" value="' + reply.replyNo + '">'))
							.appendTo($('#replyList'));
						} else if(reply.delYn == 'Y'){   
							$('<tr>')
							.append($('<td colspan="5">').text('삭제된 계시물입니다.'))
							.appendTo($('#replyList'));
						}
					});
					
	               var paging = result.paging;
	               console.log(paging);
					
					// 페이징 영역 초기화
					$('#paging').empty();
					
					// 이전
					if (paging.beginPage <= paging.pagePerBlock) {  // 이전이 없는 1블록
						// class
						// 1. disable : 링크가 없다. css 색상 lightgray
						$('<div class="disable">이전</div>').appendTo('#paging');
					} else {
						// class
						// 1. prev_block : click 이벤트에서 사용
						// 2. link : 링크가 있다. css 포인터
						$('<div class="prev_block link" data-page="' + (paging.beginPage - 1) + '">이전</div>').appendTo('#paging');
					}
					// 1 2 3 4 5
					for (let p = paging.beginPage; p <= paging.endPage; p++) {
						if (paging.page == p) {  // 현재 페이지는 링크가 없다.
							// class
							// 1. now_page : 링크가 없다. css 색상 limegreen
							$('<div class="now_page">' + p + '</div>').appendTo('#paging');
						} else {
							// class
							// 1. go_page : click 이벤트에서 사용
							// 2. link : 링크가 있다. css 포인터
							$('<div class="go_page link" data-page="' + (p) + '">' + p + '</div>').appendTo('#paging');
						}
					}
					// 다음
					if (paging.endPage == paging.totalPage) {  // 링크가 없는 마지막 블록
						// class
						// 1. disable : 링크가 없다. css 색상 lightgray
						$('<div class="disable">다음</div>').appendTo('#paging');
					} else {
						// class
						// 1. next_block : click 이벤트에서 사용
						// 2. link : 링크가 있다. css 포인터
						$('<div class="next_block link" data-page="' + (paging.endPage + 1) + '">다음</div>').appendTo('#paging');
					}
				}
			}); 			   
		} 	
		
		
		
		function fn_paging(){
	
		    $(document).on('click','.prev_block', function(){
				page = $(this).data('page');
				fn_selectAllReply();
			})
			$(document).on('click','.go_page', function(){
				page = $(this).data('page');
				fn_selectAllReply();
			})
			$(document).on('click','.next_block', function(){
				page = $(this).data('page');
				fn_selectAllReply();
			})
		
		}
		
		function fn_delete(){
			$(document).on('click','#deleteReply',function(){
				var replyNo = $(this).next().val();
			 	$.ajax({
			 		url:'r.delete',
			 		type: 'get',
			 		data:'replyNo='+replyNo ,
			 		dataType:'json',
			 		success:function(result){
			 			if(result.count>0){
			 			alert('삭제되었습니다');
			 			 fn_selectAllReply()
			 			}
			 		}
			 	
			 		
			 		
			 		
			 	})
			 	
				
			})
		}
 	</script>
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
			#paging {
			width: 50%; 
			margin: 0 auto;
			display: flex;
			justify-content: space-between;
			text-align: center;
		}
		#paging div {
			width: 40px;
			height: 20px;
		}
		.disable {
			color: lightgray;
		}
		.link {
			cursor: pointer;
		}
		.now_page {
			color: limegreen;
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


			<div>
        <table style="border: solid 1px;width : 1000px;">
        	  <thead>
                 <tr>
		            <td>글번호</td>
		             <td>작성자</td>
		             <td>내용</td>
		             <td>수정자</td>
		            <td>관리</td>
                </tr>
          		</thead>
				<tbody id="replyList">
				
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6">
							<div id="paging"></div>
						</td>
					</tr>
				</tfoot>
        	</table>
     		<c:if test="${ not empty loginUser}">
     		<form id="f"  method="post" action="b.insertReply">
      			<input type="hidden"  name="memberNo" value="${loginUser.memberNo }">
      			<input type="hidden" name="boardNo"  value="${board.boardNo }">
      			<input type="text" name="content" required>
                 <button>댓글입력</button>
               
		    </form>
		      </c:if>
		      	<c:if test="${ empty loginUser}"><input type="text" name="content"  value="댓글입력을 위해 로그인" readonly></c:if>
 		</div>
     <!-- Footer -->
        <jsp:include page="../layout/footer.jsp"></jsp:include>
     <!-- End Footer -->
</body>
</html>