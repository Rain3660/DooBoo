<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<!-- ajax 파일첨부 관련 스크립트 S -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.3.0/jquery.form.min.js" integrity="sha512-YUkaLm+KJ5lQXDBdqBqk7EVhJAdxRnVdT2vtCzwPHSweCzyMgYV/tgGF4/dCyqtCC2eCphz0lRQgatGVdfR0ww==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- ajax 파일첨부 관련 스크립트 E -->

<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href='<c:url value="/"></c:url>'>
				<img src="resources/image/DoobooLogo.png" alt="" width="80" height="100" class="d-inline-block align-text-top">
			</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active" aria-current="page" href="#">상품</a></li>
					<li class="nav-item"><a class="nav-link" href="b.list">자유게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="#">New</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Popular</a></li>
					<li class="nav-item"><a class="nav-link" href="#">F&Q</a></li>
					<li class="nav-item"><a class="nav-link" href="chat">1:1대화함</a></li>
					<li class="nav-item">
						<form class="d-flex">
							<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
							<button class="btn btn-outline-success" type="submit">Search</button>
						</form>
					</li>
				</ul>
				<ul class="navbar-nav float-end">
					<c:if test="${empty loginUser }">
						<li class="">
							<a class="btn" href="m.joinPage">회원가입</a>
						</li>
					</c:if>
					<c:if test="${not empty loginUser }">
						<li class="">
							<a class="btn" href="#">${loginUser.nickname } 님 환영합니다 !</a>
						</li>
					</c:if>
					<c:if test="${empty loginUser }">
						<li>
							<a class="btn" href="m.loginPage">로그인</a>
						</li>						
					</c:if>
					<c:if test="${not empty loginUser }">
						<li>
							<a class="btn" href="m.logout" id="logout">로그아웃</a>
						</li>						
					</c:if>
					<li class="login_menu">
					<a href="m.myPage" id="mypage" class="btn">
						마이페이지</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>