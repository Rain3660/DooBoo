<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width">
<title>판매자와 대화하기</title>
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
	<table class="control">
		<tr>
			<td class="title">Status:</td>
			<td class="title">Messages:</td>
		</tr>
		<tr>
			<td><span style="font-weight: bold">ID: </span> <input
				type="text" id="receiver-id" title="Input the ID from receive.html">
				<button id="connect-button">Connect</button></td>
			<td><input type="text" id="sendMessageBox"
				placeholder="Enter a message..." autofocus="true" />
				<button type="button" id="sendButton">Send</button>
				<button type="button" id="clearMsgsButton">대화내역 초기화</button></td>
		</tr>
		<tr>
			<td><div id="status" class="status"></div></td>
			<td><div class="message" id="message"></div></td>
		</tr>
		<tr>
			<td>
				<button type="button" class="control-button" id="resetButton">Reset</button>
			</td>
			<td>
				<button type="button" class="control-button" id="goButton">Go</button>
			</td>
		</tr>
		<tr>
			<td>
				<button type="button" class="control-button" id="fadeButton">Fade</button>
			</td>
			<td>
				<button type="button" class="control-button" id="offButton">Off</button>
			</td>
		</tr>
	</table>
	<div class="container">
		<h1>대화를 진행해 보세요 !</h1>
		<div id="chat_box">
			
		</div>
	</div>

	<script src="https://unpkg.com/peerjs@1.3.1/dist/peerjs.min.js"></script>
	<script type="text/javascript">
		(function() {
			var lastPeerId = null;
			var peer = null; // own peer object
			var conn = null;
			var recvIdInput = document.getElementById("receiver-id");
			var status = document.getElementById("status");
			var message = document.getElementById("message");
			var goButton = document.getElementById("goButton");
			var resetButton = document.getElementById("resetButton");
			var fadeButton = document.getElementById("fadeButton");
			var offButton = document.getElementById("offButton");
			var sendMessageBox = document.getElementById("sendMessageBox");
			var sendButton = document.getElementById("sendButton");
			var clearMsgsButton = document.getElementById("clearMsgsButton");
			var connectButton = document.getElementById("connect-button");
			var cueString = "<span class=\"cueMsg\">Cue: </span>";

			/**
			 * Create the Peer object for our end of the connection.
			 *
			 * Sets up callbacks that handle any events related to our
			 * peer object.
			 */
			function initialize() {
				// Create own peer object with connection to shared PeerJS server
				peer = new Peer('buyer', {
					debug : 2
				});

				peer.on('open', function(id) {
					// Workaround for peer.reconnect deleting previous id
					if (peer.id === null) {
						console.log('Received null id from peer open');
						peer.id = lastPeerId;
					} else {
						lastPeerId = peer.id;
					}

					console.log('ID: ' + peer.id);
				});
				peer.on('connection', function(c) {
					// Disallow incoming connections
					c.on('open', function() {
						c.send("Sender does not accept incoming connections");
						setTimeout(function() {
							c.close();
						}, 500);
					});
				});
				peer.on('disconnected', function() {
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
				peer.on('error', function(err) {
					console.log(err);
					alert('' + err);
				});
			}
			;

			/**
			 * Create the connection between the two Peers.
			 *
			 * Sets up callbacks that handle any events related to the
			 * connection and data received on it.
			 */
			function join() {
				// Close old connection
				if (conn) {
					conn.close();
				}

				// Create connection to destination peer specified in the input field
				conn = peer.connect(recvIdInput.value, {
					reliable : true
				});

				conn.on('open', function() {
					status.innerHTML = "Connected to: " + conn.peer;
					console.log("Connected to: " + conn.peer);

					// Check URL params for comamnds that should be sent immediately
					var command = getUrlParam("command");
					if (command)
						conn.send(command);
				});
				// Handle incoming data (messages only since this is the signal sender)
				// 연결된 상대(판매자) 가 보낸 메세지 가 data 에 들어있다.
				conn.on('data', function(data) {
					addMessage("<span class=\"peerMsg\">Peer:</span> " + data);
					// 상대가 보낸 메세지가 왼쪽에 떠야한다 !!
					$('#chat_box').append('<div class="float-left">' + conn.peer + ':' + data +  '</div>');
					$('#chat_box').append('<br>');
				});
				conn.on('close', function() {
					status.innerHTML = "Connection closed";
				});
			}
			;

			/**
			 * Get first "GET style" parameter from href.
			 * This enables delivering an initial command upon page load.
			 *
			 * Would have been easier to use location.hash.
			 */
			function getUrlParam(name) {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null)
					return null;
				else
					return results[1];
			}
			;

			/**
			 * Send a signal via the peer connection and add it to the log.
			 * This will only occur if the connection is still alive.
			 */
			function signal(sigName) {
				if (conn && conn.open) {
					conn.send(sigName);
					console.log(sigName + " signal sent");
					addMessage(cueString + sigName);
				} else {
					console.log('Connection is closed');
				}
			}

			goButton.addEventListener('click', function() {
				signal("Go");
			});
			resetButton.addEventListener('click', function() {
				signal("Reset");
			});
			fadeButton.addEventListener('click', function() {
				signal("Fade");
			});
			offButton.addEventListener('click', function() {
				signal("Off");
			});

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
				}
				;

				message.innerHTML = "<br><span class=\"msg-time\">" + h + ":"
						+ m + ":" + s + "</span>  -  " + msg
						+ message.innerHTML;
			}
			;

			function clearMessages() {
				message.innerHTML = "";
				addMessage("Msgs cleared");
			}
			;

			// Listen for enter in message box
			sendMessageBox.addEventListener('keypress', function(e) {
				var event = e || window.event;
				var char1 = event.which || event.keyCode;
				if (char1 == '13')
					sendButton.click();
			});
			// Send message
			sendButton.addEventListener('click', function() {
				if (conn && conn.open) {
					var msg = sendMessageBox.value;
					sendMessageBox.value = "";
					conn.send(msg);
					console.log("Sent: " + msg);
					addMessage("<span class=\"selfMsg\">Self: </span> " + msg);
					// 내가 보낸 메세지가 오른쪽에 떠야한다 !!
					$('#chat_box').append('<div class="float-right">' + peer.id + ':' +  msg +  '</div>');
					$('#chat_box').append('<br>');
				} else {
					console.log('Connection is closed');
				}
			});

			// Clear messages box
			clearMsgsButton.addEventListener('click', clearMessages);
			// Start peer connection on click
			connectButton.addEventListener('click', join);

			// Since all our callbacks are setup, start the process of obtaining an ID
			initialize();
		})();
	</script>
</body>
</html>