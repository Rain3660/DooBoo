<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width">
<title>구매자와 대화하기</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
	integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF"
	crossorigin="anonymous"></script>
</head>
<body>
	<table class="display">
		<tr>
			<td class="title">Status:</td>
			<td class="title">Messages:</td>
		</tr>
		<tr>
			<td>
				<div id="receiver-id" style="font-weight: bold;"
					title="Copy this ID to the input on send.html.">ID:</div>
			</td>
			<td>
				<button type="button" id="clearMsgsButton">대화내역 초기화</button>
			</td>
		</tr>
		<tr>
			<td>
				<div id="status" class="status"></div>
			</td>
			<td>
				<div class="message" id="message"></div>
			</td>
		</tr>
	</table>
	<div class="container bg-light">
		<div id="status" class="status"></div>
		<h1>대화를 진행해 보세요 !</h1>
		<div id="chat_box"></div>
		<div class="input-group mt-3">
			<input type="text" class="form-control" placeholder="메세지를 입력해 주세요"
				aria-label="Recipient's username" aria-describedby="button-addon2"
				id="sendMessageBox">
			<div class="input-group-append">
				<button class="btn btn-outline-secondary" type="button"
					id="sendButton">전송</button>
			</div>
		</div>
	</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/peerjs/1.3.1/peerjs.min.js" referrerpolicy="no-referrer"></script>
	<!-- <script src="https://unpkg.com/peerjs@1.3.1/dist/peerjs.min.js"></script> -->
	<script type="text/javascript">
            $(document).ready(function(){
            	 var lastPeerId = null;
                 var peer = null; // Own peer object
                 var peerId = null;
                 var conn = null;
                 var recvId = document.getElementById("receiver-id");
                 var status = document.getElementById("status");
                 var message = document.getElementById("message");
                 var standbyBox = document.getElementById("standby");
                 var goBox = document.getElementById("go");
                 var fadeBox = document.getElementById("fade");
                 var offBox = document.getElementById("off");
                 var sendMessageBox = document.getElementById("sendMessageBox");
                 var sendButton = document.getElementById("sendButton");
                 var clearMsgsButton = document.getElementById("clearMsgsButton");

                 /**
                  * Create the Peer object for our end of the connection.
                  *
                  * Sets up callbacks that handle any events related to our
                  * peer object.
                  */
                  // (receive) peer 를 생성한다. null 자리에 판매자 아이디
                  function initialize() {
                     // Create own peer object with connection to shared PeerJS server
                    		peer = new Peer('seller', {
                         debug: 2
                     });

                     peer.on('open', function (id) {
                         // Workaround for peer.reconnect deleting previous id
                         if (peer.id === null) {
                             console.log('Received null id from peer open');
                             peer.id = lastPeerId;
                         } else {
                             lastPeerId = peer.id;
                         }

                         console.log('ID: ' + peer.id);
                         recvId.innerHTML = "ID: " + peer.id;
                         status.innerHTML = "구매자의 접속을 기다리고 있습니다.";
                     });
                     peer.on('connection', function (c) {
                         // Allow only a single connection
                         if (conn && conn.open) {
                             c.on('open', function() {
                                 c.send("Already connected to another client");
                                 setTimeout(function() { c.close(); }, 500);
                             });
                             return;
                         }

                         conn = c;
                         console.log("Connected to: " + conn.peer);
                         status.innerHTML = "구매자와 접속되었습니다.";
                         ready();
                     });
                     peer.on('disconnected', function () {
                         status.innerHTML = "Connection lost. Please reconnect";
                         console.log('Connection lost. Please reconnect');
 	
                         // Workaround for peer.reconnect deleting previous id
                         peer.id = lastPeerId;
                         peer._lastServerId = lastPeerId;
                         peer.reconnect();
                     });
                     peer.on('close', function() {
                         conn = null;
                         status.innerHTML = "Connection destroyed. Please refresh";
                         console.log('Connection destroyed');
                     });
                     peer.on('error', function (err) {
                         console.log(err);
                         alert('' + err);
                     });
                 };

                 /**
                  * Triggered once a connection has been achieved.
                  * Defines callbacks to handle incoming data and connection events.
                  */
                 function ready() {
                     conn.on('data', function (data) {
                         console.log("Data recieved");
                         var cueString = "<span class=\"cueMsg\">Cue: </span>";
                         switch (data) {
                             case 'Go':
                                 go();
                                 addMessage(cueString + data);
                                 break;
                             case 'Fade':
                                 fade();
                                 addMessage(cueString + data);
                                 break;
                             case 'Off':
                                 off();
                                 addMessage(cueString + data);
                                 break;
                             case 'Reset':
                                 reset();
                                 addMessage(cueString + data);
                                 break;
                             default:
                                 
                             	// 상대방이 보낸 메세지가 왼쪽에 떠야한다!!!!
                           		/* $('#chat_box').append('<div class="float-left">' + conn.peer + ':'  + data +  '</div>');
                           		$('#chat_box').append('<br>'); */
                           		$('#chat_box').append('<div class="input-group"><div class="input-group-prepend"><span class="input-group-text" style="border: 1px solid gray;">' + conn.peer +'</span></div>' +			
                    					'<input type="text" aria-label="First name" class="form-control" value="' + data +'"style="border: none; border-left: 1px solid gray;"></div>');
                           		
                                 break;
                         };
                     });
                     conn.on('close', function () {
                         status.innerHTML = "Connection reset<br>Awaiting connection...";
                         conn = null;
                     });
                 }
                 function addMessage(msg) {
                     var now = new Date();
                     var h = now.getHours();
                     var m = addZero(now.getMinutes());
                     var s = addZero(now.getSeconds());

                     if (h > 12)
                         h -= 12;
                     else if (h === 0)
                         h = 12;

                     function addZero(t) {
                         if (t < 10)
                             t = "0" + t;
                         return t;
                     };

                     
                   
                 }

                 function clearMessages() {
                     message.innerHTML = "";
                     addMessage("Msgs cleared");
                 } 

                 // Listen for enter in message box
                 sendMessageBox.addEventListener('keypress', function (e) {
                     var event = e || window.event;
                     var char = event.which || event.keyCode;
                     if (char == '13')
                         sendButton.click();
                 });
                 // Send message
                 sendButton.addEventListener('click', function () {
                     if (conn && conn.open) {
                         var msg = sendMessageBox.value;
                         sendMessageBox.value = "";
                         conn.send(msg);
                         console.log("Sent: " + msg)
                         
                         // 내가 보낸 메세지가 오른쪽에 떠야한다 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        /*  $('#chat_box').append('<div class="float-right">' + peer.id + ':' + msg +  '</div>');
                         $('#chat_box').append('<br>');     */
                         $('#chat_box').append('	<div class="input-group"><input type="text" value="' + msg + '" aria-label="First name" class="form-control" style="border: none; text-align: right;"><div class="input-group-prepend">' +
     							'<span class="input-group-text" style="border: 1px solid gray; ">' + peer.id +'</span></div></div>');
                     } else {
                         console.log('Connection is closed');
                     }
                 });

                 // Clear messages box
                 clearMsgsButton.addEventListener('click', clearMessages);

                 initialize();
            })
        </script>
</body>
</html>