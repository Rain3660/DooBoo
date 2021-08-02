<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
 <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<meta charset="UTF-8">
	<title>대화방</title>

</head>
  <style>
        #time{font-size: 5px;}
    </style>
<script type="text/javascript">
	var ws;
	wsOpen();
	function wsOpen(){
		//웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
		ws = new WebSocket("ws://sih8859.iptime.org:9099/chating/"+'${roomNumber}');
		//ws = new WebSocket("ws://localhost:9090/ROOT/chating/"+'${roomNumber}');
		wsEvt();
	}
		
	function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 동작
		}
		
		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			var msg = data.data;
			console.log(msg);
			if(msg != null && msg.trim() != ''){
				var d = JSON.parse(msg);
				if(d.type == "getId"){
					var si = d.sessionId != null ? d.sessionId : "";
					if(si != ''){
						$("#sessionId").val(si); 
					}
				}else if(d.type == "message"){
					if(d.userName == '${loginUser.nickname}'){
						$("#chating").append("<li class='list-group-item text-end'>" + d.msg + "</li>");	
						$("#chating").append("<p class='text-end' id='time'>" + d.time + "</p>");
					}else{
						$("#chating").append("<li class='list-group-item text-start'>${roomName}:" + d.msg + "</li>");
						$("#chating").append("<p class='text-end' id='time'>" + d.time + "</p>");
					}	
				}else{
					console.warn("unknown type!")
				}
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}

/* 	function chatName(){
		var userName = $("#userName").val();
		if(userName == null || userName.trim() == ""){
			alert("사용자 이름을 입력해주세요.");
			$("#userName").focus();
		}else{
			wsOpen();
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	} */

	function send() {
		let today = new Date();  
		let day = today.toLocaleDateString();
		let time = today.toLocaleTimeString();
		var option ={
			type: "message",
			roomNumber: '${roomNumber}',
			sessionId : $("#sessionId").val(),
			userName : '${loginUser.nickname}',
			memberNo : '${loginUser.memberNo}',
			msg : $("#chatting").val(),
			fileName : '${fileName}',
			day : day,
			time : time
		}
		ws.send(JSON.stringify(option));
		$('#chatting').val("");
	}
	
</script>
<body>
	
	<div id="container" class="container">
		 <div class="row mx-auto">
        	<button type="button" class="btn btn-outline-primary btn-lg">${roomName}님과의 대화방</button>
    	</div>
		   <ul class="list-group list-group-flush mx-auto mt-5" id="chating" style="width: 500px;">
    		<c:if test="${list ne null }">
		   		<c:forEach var="chat" items="${list }">
		   		<c:if test="${chat.writer eq loginUser.nickname }">
			        <li class="list-group-item text-end"> ${chat.content}</li>
			        <p class="text-end" id="time">${chat.time }</p>
		   		</c:if>
		   		<c:if test="${chat.writer ne loginUser.nickname }">
			        <li class="list-group-item text-start">${chat.writer} : ${chat.content}</li>
			        <p class="text-end" id="time">${chat.time }</p>
		   		</c:if>
		   		</c:forEach>
	    	</c:if> 	
		    </ul>		    
    	
	    <div class="row mx-auto" style="width: 500px;">
	        <div class="col-12">
	            <div class="form-floating mt-3">
	                <input type="text" class="form-control" id="chatting" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px; width:100%;"/>
	                <label for="floatingTextarea2">메시지작성</label>
	    
	            </div>
	        </div>
	    </div>
	    <div class="row text-end mt-4 mx-auto mb-5" style="width: 500px;">
	        <div class="col-12">
	            <button type="button" onclick="send()" id="sendBtn" class="btn btn-outline-primary btn-lg">전송</button>
	        </div>
	    </div>
    	
		<input type="hidden" id="sessionId" value="">
		<input type="hidden" id="roomNumber" value="${roomNumber}">
    	
	</div>
</body>
</html>