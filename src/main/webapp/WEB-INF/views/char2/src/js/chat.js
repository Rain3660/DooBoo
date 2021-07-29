 "use strict"

 const socket = io("http://sih8859.iptime.org:9099"); //소켓에 클라이언트 io가 담기게 된다.

 const nickname = document.querySelector("#nickname")
 const chatList = document.querySelector(".chatting-list")
 const  chatInput = document.querySelector(".chatting-input")
 const sendButton = document.querySelector(".send-button")

sendButton.addEventListener("click",()=>{
    const param = {
        name  : nickname.Value,
        msg = chatInput.Value
    }
    socket.emit("chatting",param);
})

 
socket.on("chatting",(data)=> {
    const li = document.createElement("li");
    li.innerText = `${data.name} 님이 - ${data.msg}`;
    chatList.appendChild(li);
})

 console.log(socket);