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
		<div class="mb-3 text-right">
			<input class="form-control" type="file" id="images" name="images" multiple style="border: none;">
		</div>
	</form>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('#sellProduct_btn').on('click',function(){
			$('#sellProductForm').attr('action' , 'p.sellProduct');
			$('#sellProductForm').submit();
		})
	})
</script>
<jsp:include page="../layout/footer.jsp"></jsp:include>