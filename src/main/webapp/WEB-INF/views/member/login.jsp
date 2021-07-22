<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<title>로그인</title>


<style>
    .login{
        width: 500px;
        height: 700px;
        margin: auto;
        margin-top: 150px;
        margin-bottom: 300px;
    }
    .form-floating{
        margin: auto;
    }
</style>

</head>
<body class="text-center bg-light" >
<div class="login">
        
        <h1 class="py-5 text-center"> <img class="mb-4" src="resources/image/DoobooLogo.png" alt="" width="72" height="57">두부 마켓</h1>
        
        <form method="post" action="m.login">
            <div class="form-floating">
                <input type="text" class="form-control" name="memberId" id="memberId" aria-describedby="emailHelp">
                <label for="memberId" class="form-label">ID</label>
            </div>

            <div class="form-floating mt-3">
                <input type="password" class="form-control" name="password" id="password" >
				<label for="password" class="form-label">Password</label>                
            </div>
            <div class="form-check mt-3" style="float: right">
                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                <label class="form-check-label" for="exampleCheck1">Check me out</label>
            </div>
            <input type="button" class="w-100 btn btn-primary btn-lg mt-3" style="font-size: 20px" value="아이디/비밀번호 찾기" onclick="location.href='m.findInfoPage'">
            <button type="submit" class="w-100 btn btn-primary btn-lg mt-3" style="font-size: 20px">로그인</button>
                
            <div class="img mt-3">
                <a href="${naverurl}">
                    <img src="resources/image/naverlogin.png" style="width:500px"/>
                </a><br>
            </div>
            <div class="img mt-3">
                <a href="${kakaourl}">
                    <img src="resources/image/kakaologin.png" style="width:500px">
                </a>
            </div>
        </form>
    </div>
</body>
<jsp:include page="../layout/footer.jsp"></jsp:include>