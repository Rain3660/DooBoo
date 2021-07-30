<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<script type="text/javascript">
	// 페이지의 기본값 1을 전역변수로 선언한다.
	var page = 1;
	$(document).ready(function() {

		
				getProductList();
				
				$('#productList').on('click' , '.card_link' , function(){
					var productNo = $(this).data('productno');
					
					/* 상품 번호에 해당하는 상품 상세 페이지로 이동 */
					location.href = 'p.selectOneProduct?productNo=' + productNo;

					
				})

			})
	function getProductList() {
		var obj = {
				page : page
		};

		$.ajax({
			url : 'p.selectNewProductList',
			type : 'post',
			data : JSON.stringify(obj),
			contentType : 'application/json; charset=utf-8',
			dataType : 'json',
			success : function(resultMap) {

				listMaker(resultMap.productList);

				pageMaker(resultMap.pageAndQueryVO);
				console.log(resultMap.pageAndQueryVO);
				// 페이징에 링크처리
				linkMaker();

			}
		})
	}
	function listMaker(list) {

		// 리스트를 뿌리기 전에 비워야한다.
		$('#productList').empty();

		$
				.each(
						list,
						function(index, productVO) {
							// 이미지 파일의 배열
							// var images = productVO.images.split(',');
							// 대표이미지
							// var mainImage = images[0];

							// 0 , 3 , 6 ... 번쨰 마다 행을 만들어야 합니다.
							// 선언해둔다.

							var row;
							// 행이 바뀌면 productList 안에 행부터 만들고 그 행 안에 col 을 만들어 준다.
							// 행이 바뀌지 않는다면 그 !! 행 안에 col을 만들어야 한다.
							if (index % 4 == 0) {
								// 행
								row = $('<div class="row row-cols-lg-3 row-cols-md-2 mt-5"></div>');
								row.append(
										columnMaker(productVO.images,
												productVO.title,
												productVO.price,
												productVO.address,
												productVO.hit,
												productVO.likeCount,
												productVO.productNo)).appendTo(
										'#productList');
							} else {
								$(
										columnMaker(productVO.images,
												productVO.title,
												productVO.price,
												productVO.address,
												productVO.hit,
												productVO.likeCount,
												productVO.productNo)).appendTo(
										$('#productList > div:last-child'));
							}

						})
	}
	function columnMaker(images, title, price, address, hit, likecount,
			productNo) {
		var col;
		/* src="${STATIC_IMAGE_ROOT }${boardFile.filePath }" */
		// image 에는 , 를 포함한 문자열 또는 '' 빈 문자열이 넘어온다.
		if (images == null) { // 첨부한 사진이 없어서 빈 문자열이 넘어 올 때,
			image = 'resources/image/noimage.png';
		} else { // 첨부한 사진이 있을 때는 제일 먼저 첨부한 사진을 보여준다.
			image = '${STATIC_IMAGE_ROOT }' + images.split(',')[0];
		}

		col = '<div class="col-lg-3 col-md-6 col-sm-12  mb-5">'
				+ '<div class="card border-0 mb-3 mx-auto card_link" data-productno="' + productNo + '" style="width: 18rem;">'
				+ '<img src="' + image + '" class="card-img-top" alt="..." style="height: 192px;">'
				+ '<div class="card-body">' + '<p class="card-text">' + title
				+ '<br>' + price + '<br>' + address
				+ '<br> <span class="text-secondary fs-6">조회' + hit + ' | 좋아요'
				+ likecount + '</span>' + '</p></div></div></div>';
		return col;
	}

	function pageMaker(pageAndQueryVO) {
		$('#paging').empty();
		if (pageAndQueryVO.beginPage <= pageAndQueryVO.pagePerBlock) { // 이전이 없음
			$('#paging')
					.append(
							'<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a></li>');
		} else {
			$('#paging')
					.append(
							'<li class="page-item"><a class="page-link" href="#" tabindex="-1" aria-disabled="true" data-page="'
									+ (pageAndQueryVO.beginPage - 1)
									+ '">Previous</a></li>');
		}
		for (let p = pageAndQueryVO.beginPage; p <= pageAndQueryVO.endPage; p++) {
			if (p == page) {//현재 페이지에 배경색적용
				$('#paging')
						.append(
								'<li class="page-item active"><a class="page-link" href="#" data-page="' + p + '">'
										+ p + '</a></li>');
			} else {
				$('#paging').append(
						'<li class="page-item"><a class="page-link" href="#" data-page="' + p + '">'
								+ p + '</a></li>');
			}
		}

		if (pageAndQueryVO.endPage == pageAndQueryVO.totalPage) { // 마지막 블록
			$('#paging')
					.append(
							'<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">Next</a></li>');
		} else {
			$('#paging')
					.append(
							'<li class="page-item"><a class="page-link" href="#" tabindex="-1" aria-disabled="true" data-page="'
									+ (pageAndQueryVO.endPage + 1)
									+ '">Next</a></li>');
		}
	}
	function linkMaker() {
		//data-page속성 가진 a 태그들 
		$('#paging').on('click', 'a[data-page]', function() {
			// 페이지 변경해주고
			page = $(this).data('page');
			// ajax 로 list 호출
			getProductList();
		})
	}
</script>
<div class="container">
	<div class="row">
		<h2 class="text-center" id="header_title">최신 상품 목록</h2>
	</div>
	<div id="productList">
	</div>
	<ul class="pagination justify-content-center" id="paging">
	</ul>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>
