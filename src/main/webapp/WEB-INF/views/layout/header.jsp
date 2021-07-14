<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="msvalidate.01" content="5FCF8B779D34832FE2D36DFB6C126940">
<meta name="p:domain_verify" content="68d35eb0ac63d3477701ce6c902bd227">
<!-- This site is optimized with the Yoast SEO plugin v4.3 - https://yoast.com/wordpress/plugins/seo/ -->
<title>Welcome DooBoo-Market</title>
<link rel="stylesheet" id="framework-css" href="https://themewagon.com/wp-content/themes/wagoncore/css/framework.css?ver=4.7.2" type="text/css" media="all">
<link rel="stylesheet" id="wagoncore-style-css" href="https://themewagon.com/wp-content/themes/wagoncore/style.css?ver=4.7.2" type="text/css" media="all">
<link rel="stylesheet" id="child-style-css" href="https://themewagon.com/wp-content/themes/themewagon/style.css?ver=1.0.0" type="text/css" media="all">
<link rel="stylesheet" id="font-roboto-css" href="//fonts.googleapis.com/css?family=Roboto%3A300%2C400%2C700&amp;ver=4.7.2" type="text/css" media="all">
<link rel="stylesheet" id="rich-reviews-css" href="https://themewagon.com/wp-content/plugins/rich-reviews/css/rich-reviews.css?ver=4.7.2" type="text/css" media="all">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/easy-digital-downloads/assets/js/edd-ajax.min.js?ver=2.6.17"></script>
<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/themewagon_extended/assets/js/pjax.min.js?ver=1"></script>

<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/ultimate-social-deux/public/assets/js/min/us.script-min.js?ver=6.0.7"></script>

<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/ultimate-social-deux/public/assets/js/min/us.native-min.js?ver=6.0.7"></script>
<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/ultimate-social-deux/public/assets/js/min/jquery.cookie-min.js?ver=1.0"></script>
<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/ultimate-social-deux/public/assets/js/min/jquery.magnific-popup-min.js?ver=1.0"></script>
<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/ultimate-social-deux/public/assets/js/min/jquery.sticky-min.js?ver=1.0"></script>
<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/ultimate-social-deux/public/assets/js/min/jquery.fittext-min.js?ver=1.2"></script>
<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/ultimate-social-deux/public/assets/js/min/jquery.tooltipster-min.js?ver=3.3"></script>
<script type="text/javascript" src="https://themewagon.com/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.4.1"></script>
<script type="text/javascript" src="https://themewagon.com/wp-content/themes/wagoncore/js/framework.js?ver=1"></script>
<script type="text/javascript" src="https://themewagon.com/wp-content/plugins/rich-reviews/js/rich-reviews.min.js?ver=4.7.2"></script>
<link rel="https://api.w.org/" href="https://themewagon.com/wp-json/">
<link rel="EditURI" type="application/rsd+xml" title="RSD" href="https://themewagon.com/xmlrpc.php?rsd">
<link rel="wlwmanifest" type="application/wlwmanifest+xml" href="https://themewagon.com/wp-includes/wlwmanifest.xml">
<meta name="generator" content="WordPress 4.7.2">
<meta name="generator" content="Easy Digital Downloads v2.6.17">
<script async="" src="https://script.hotjar.com/modules.c057a0a680ba2bae7796.js" charset="utf-8"></script>
</head>
<body
	class="archive paged tax-theme_tag term-free term-480 paged-2 has-no-twpromo-top group-blog"
	data-spy="scroll" data-target="#jump-scroll-nav">
	<nav id="main-nav" class="navbar">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="https://themewagon.com/"
					title="Free Responsive Bootstrap Themes"> <img
					src="https://d2zav2bjdlctd5.cloudfront.net/themes/themewagon/img/logo.png"
					alt="ThemeWagon Logo">
				</a>
			</div>


			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">

				<div class="navbar-form navbar-left" role="search">
					<meta itemprop="url" content="https://themewagon.com">
					<form class="site-search" role="search" method="get"
						action="https://themewagon.com/">
						<div class="input-group mb-3">
							<input type="text" class="form-control" placeholder="검색어를 입력하세요"
								aria-label="Recipient's username"
								aria-describedby="button-addon2">
							<button class="btn btn-outline-secondary" type="button"
								id="button-addon2">Button</button>
						</div>
					</form>
				</div>

				<ul class="nav navbar-nav navbar-left">
					<li class=""></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<c:if test="${empty loginUser }">
						<li class="">
							<a href="m.joinPage"><i class="fa fa-heart"></i>회원가입</a>
						</li>
					</c:if>
					<c:if test="${not empty loginUser }">
						<li class="">
							<a href="#"><i class="fa fa-heart"></i>${loginUser.nickname } 님 환영합니다 !</a>
						</li>
					</c:if>
					<c:if test="${empty loginUser }">
						<li>
							<a href="m.loginPage">로그인</a>
						</li>						
					</c:if>
					<c:if test="${not empty loginUser }">
						<li>
							<a href="m.logout">로그아웃</a>
						</li>						
					</c:if>
					<li class="login_menu">
					<a href="m.myPage">
						<i class="fa fa-lock"></i> 마이페이지</a>
					</li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="header-second-menu-wrap hidden-xs">

		<div class="header-second-menu-wrap">
			<div class="container header-second-menu">
				<ul class="nav nav-pills nav-centered">
					<li id="menu-item-1769"
						class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1769">
						<a href="#">상품</a>
					</li>
					<li id="menu-item-1769"
						class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1769">
						<a href="#">자유게시판</a>
					</li>
					<li id="menu-item-1775"
						class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1775"><a
						href="#">New</a></li>
					<li id="menu-item-10166"
						class="menu-item menu-item-type-taxonomy menu-item-object-theme_category menu-item-10166"><a
						href="#">Popular </a></li>
					<li id="menu-item-49758"
						class="menu-item menu-item-type-custom menu-item-object-custom menu-item-49758"><a
						href="#">F&Q </a></li>
					<li id="menu-item-49758"
						class="menu-item menu-item-type-custom menu-item-object-custom menu-item-49758"><a
						href="#" onclick="location.href = 'chat'">1:1대화함 </a></li>
				</ul>
			</div>
		</div>
	</div>