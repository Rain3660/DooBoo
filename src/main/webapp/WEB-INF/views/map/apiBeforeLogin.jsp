<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#f').submit();
	
})
</script>
<body>

	<form method="post" id="f" action="m.login">
		 <input type="hidden" value="${loginUser.memberId }" name="memberId">
		 <input type="hidden" value="${loginUser.password }" name="password">
		 <input type="hidden" value="${loginUser.apiNumber}" name="apiNumber">  
	</form>
</body>
</html>