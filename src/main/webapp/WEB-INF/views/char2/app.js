const express = require("express") //express 라는 라이브러리 가져오기
const http = require("http") //사용하는 소켓은 http를 사용하기때문에 http를 불러온다
const app = express();   //express 를 실행시키고 그것을 app이라는 변수에 저장
const path = require("path") //보여줄 홈페이지의 경로
const server = http.createServer(app) //불러온 http를 통해 서버를 만든다
const socketIO = require("socket.io") //소켓에 서버를 담아두기위해

const io = socketIO(server);

app.use(express.static(path.join(__dirname,"src"))) //보여줄 폴더를 지정해준다
const PORT = process.env.PORT || 9099;

io.on("connection",(socket)=>{
    socket.on("chatting",(data)=>{     //socket.on("chat.js안에 socket.emit("여기있는게 채팅아이디","from front")",()=>{
        console.log(data);  
        io.emit("chatting",`그래 반가워${data}`)                              //data는 파라미터로 받을값임
    })
})

server.listen(PORT ,() =>console.log(`Server is running ${PORT}`)) // app.listen(포트,명령) ${PORT}를 사용하기위해 '' 이게아니 `` 사용(Shift + ~)
