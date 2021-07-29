<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="wrapper">
        <div class="user_contatiner">
            대화명 : <input type="text" id="nickname">
        </div>
        <div class="display-container">
            <ul class="chatting-list"></ul>
        </div>
        <div class="input-contatiner">
            <input type="text" class="chatting-input">
            <button class="send-btn">전송</button>
        </div>

    </div>
    <script src="http://sih8859.iptime.org:9099/socket.io/socket.io.js"></script>
    <script src="js/chat.js"></script>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/4.1.3/socket.io.js" integrity="sha512-PU5S6BA03fRv1Q5fpwXjg5nlRrgdoguZ74urFInkbABMCENyx5oP3hrDzYMMPh3qdLdknIvrGj3yqZ4JuU7Nag==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>-->



</body>
</html>