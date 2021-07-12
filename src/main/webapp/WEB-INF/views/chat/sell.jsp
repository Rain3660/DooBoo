<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body>
	<form id="f">
		판매자
		<input type="button" value="대화함(판매자)" onclick="location.href='receive.do'">
		구매자
		 <input type="button" value="대화함(구매자)" id="btn">
		 <input type="hidden" value="seller" name="seller">
	</form>
</body>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#btn').on('click',function(){
				$('#f').attr('action','send.do');
				$('#f').submit();
			})
		})
	</script>
</html>