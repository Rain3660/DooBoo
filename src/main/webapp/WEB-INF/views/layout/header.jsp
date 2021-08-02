<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title></title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@500&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<!-- ajax 파일첨부 관련 스크립트 S -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.3.0/jquery.form.min.js" integrity="sha512-YUkaLm+KJ5lQXDBdqBqk7EVhJAdxRnVdT2vtCzwPHSweCzyMgYV/tgGF4/dCyqtCC2eCphz0lRQgatGVdfR0ww==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- ajax 파일첨부 관련 스크립트 E -->

<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" referrerpolicy="no-referrer" />
<style type="text/css">
	.card_link:hover{
		cursor: pointer;
	}
</style>
<!-- 이미지 루트 -->
<c:set var="STATIC_IMAGE_ROOT" value="http://sih8859.iptime.org:8081/dooboo" scope="application"></c:set>
</head>
<body style="font-family: 'Sunflower', sans-serif; " class=bg-light  >
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href='<c:url value="/"></c:url>'>
				<%-- <img src="<c:if test="${loginUser.apiNumber eq 1 || apiLogout eq 1}">resources/image/DoobooLogo.png</c:if>" alt="" width="80" height="100" class="d-inline-block align-text-top"> --%>
				<img src="<c:url value="resources/image/DoobooLogo.png"></c:url>" alt="" width="80" height="100" class="d-inline-block align-text-top">
			</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">

					<li class="nav-item"><a class="nav-link" aria-current="page" href="#" id="product_btn">상품</a></li>
					<li class="nav-item"><a class="nav-link" href="b.list">자유게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="#" id="new">New</a></li>
					<li class="nav-item"><a class="nav-link" href="#" id="popular">Popular</a></li>
					<li class="nav-item"><a class="nav-link" href="#" id="insertProduct_btn">상품등록</a></li>
					<c:if test="${empty loginUser }">
						<li class="nav-item"><a class="nav-link" id="chatList_btn" href="#">메세지함</a></li>
					</c:if>
					<c:if test="${not empty loginUser }">
						<li class="nav-item"><a class="nav-link" href="#" onclick="window.open('c.selectChatList?memberNo=${loginUser.memberNo }','메세지함','width=530,height=424,location=no,toolbar=no,status=no,scrollbars=yes');">메세지함</a></li>
					</c:if>
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
							<c:if test="${apiNumber eq 2 }">
							<a class="btn" href="kakaoLogout" id="logout">로그아웃</a>
							</c:if>
							<c:if test="${apiNumber ne 2 }">
							<a class="btn" href="m.logout" id="logout">로그아웃</a>
							</c:if>
						</li>						
					</c:if>
					<li class="login_menu">
					<a href="#" id="mypage" class="btn">
						마이페이지</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Dooboo-Market</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">로그인이 필요합니다 , 로그인 페이지로 이동할까요 ?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="loginModal_btn">로그인 하기</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			
			$('#mypage').on('click' , function(){
				if(${loginUser eq null}){
					openModal();
				}else{
					location.href = 'm.myPage';
				}
			})
			$('#new').on('click' , function(){
				if(${loginUser eq null}){
					openModal();
				}else{
					location.href = 'p.newProductList';
				}
			})
			$('#popular').on('click' , function(){
				if(${loginUser eq null}){
					openModal();
				}else{
					location.href = 'p.popularProductList';
				}
			})
			$('#communityBoard_btn').on('click' , function(){
				if(${loginUser eq null}){
					openModal();
				}else{
					location.href = 'b.list';
				}
			})
			$('#insertProduct_btn').on('click' , function(){
				if(${loginUser eq null}){
					openModal();
				}else{
					location.href = 'p.insertSellProductPage';
				}
			})
			$('#chatList_btn').on('click' , function(){
				if(${loginUser eq null}){
					openModal();
				}
			})
			$('#product_btn').on('click' , function(){
				if(${loginUser eq null}){
					openModal();
				}else{
					let obj = {
							memberNo : '${loginUser.memberNo}'	
						};
					$.ajax({
						url : 'm.locationCheckTest',
						type : 'post',
						data : JSON.stringify(obj),
						contentType : 'application/json; charset=utf-8',
						dataType : 'json',
						success : function(resultMap) {
							let address = resultMap.address;
							//console.log(resultMap.location);
							if(address == null){ // 지역 인증이 안된 경우
								alert('마이페이지에서 지역인증을 해주세요');
								location.href = 'm.myPage';
							}else{ // 지역인증이 된 경우
								location.href = 'p.myHomeProductListPage?address=' + address;
							}
							
						}
					})
				}
			})
		})
		function openModal(){
			var myModal = new bootstrap.Modal(document.getElementById('exampleModal'), {
				  keyboard: false
				})
			myModal.show();
		}
		$('#loginModal_btn').on('click' , function(){
			location.href = 'm.loginPage';
		})
	</script>