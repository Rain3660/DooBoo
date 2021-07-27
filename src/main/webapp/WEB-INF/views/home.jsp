<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="layout/header.jsp"></jsp:include>
<script type="text/javascript">
	const area0 = [ "지역을 선택하세요", "서울특별시", "인천광역시", "대전광역시", "광주광역시", "대구광역시",
			"울산광역시", "부산광역시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도",
			"경상북도", "경상남도", "제주도" ];
	const area1 = [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구",
			"노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구",
			"송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ];
	const area2 = [ "계양구", "남구", "남동구", "동구", "부평구", "서구", "연수구", "중구", "강화군",
			"옹진군" ];
	const area3 = [ "대덕구", "동구", "서구", "유성구", "중구" ];
	const area4 = [ "광산구", "남구", "동구", "북구", "서구" ];
	const area5 = [ "남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군" ];
	const area6 = [ "남구", "동구", "북구", "중구", "울주군" ];
	const area7 = [ "강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구",
			"사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군" ];
	const area8 = [ "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시",
			"동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시",
			"오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시",
			"화성시", "가평군", "양평군", "여주군", "연천군" ];
	const area9 = [ "강릉시", "동해시", "삼척시", "속초시", "원주시", "춘천시", "태백시", "고성군",
			"양구군", "양양군", "영월군", "인제군", "정선군", "철원군", "평창군", "홍천군", "화천군",
			"횡성군" ];
	const area10 = [ "제천시", "청주시", "충주시", "괴산군", "단양군", "보은군", "영동군", "옥천군",
			"음성군", "증평군", "진천군", "청원군" ];
	const area11 = [ "계룡시", "공주시", "논산시", "보령시", "서산시", "아산시", "천안시", "금산군",
			"당진군", "부여군", "서천군", "연기군", "예산군", "청양군", "태안군", "홍성군" ];
	const area12 = [ "군산시", "김제시", "남원시", "익산시", "전주시", "정읍시", "고창군", "무주군",
			"부안군", "순창군", "완주군", "임실군", "장수군", "진안군" ];
	const area13 = [ "광양시", "나주시", "목포시", "순천시", "여수시", "강진군", "고흥군", "곡성군",
			"구례군", "담양군", "무안군", "보성군", "신안군", "영광군", "영암군", "완도군", "장성군",
			"장흥군", "진도군", "함평군", "해남군", "화순군" ];
	const area14 = [ "경산시", "경주시", "구미시", "김천시", "문경시", "상주시", "안동시", "영주시",
			"영천시", "포항시", "고령군", "군위군", "봉화군", "성주군", "영덕군", "영양군", "예천군",
			"울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군" ];
	const area15 = [ "거제시", "김해시", "마산시", "밀양시", "사천시", "양산시", "진주시", "진해시",
			"창원시", "통영시", "거창군", "고성군", "남해군", "산청군", "의령군", "창녕군", "하동군",
			"함안군", "함양군", "합천군" ];
	const area16 = [ "서귀포시", "제주시", "남제주군", "북제주군" ];
	// 페이지의 기본값은 1로 한다.
	var page = 1;
	$('document').ready(
			function() {

				const header_title = $('#header_title');
				const city = $('#city');
				const region = $('#region');

				$.each(area0, function(index, item) { // 페이지 로드시 자동적으로 select 완성
					if (index == 0) { // 인덱스가 0 이면 시/도 선택
						city.append('<option value="" selected>' + item
								+ '</option>');
					} else {
						city.append('<option value="' + item + '">' + item
								+ '</option>');
					}
				})
				
				
				// '시' 선택했을 경우
					
				city.on('change', function() {

					if (city.val() == '') {// '지역은 선택하세요' 선택한 경우
						header_title.text('중고거래 인기 매물');
						region.empty();
						region.attr('disabled', true); // disable 속성은 true > 비활성화
						getProductList();
						return;
					}
					// 경기도 같이 정확한 주소 선택한경우
					header_title.text(city.val() + ' 인기 매물');
					region.attr('disabled', false);
					var area;

					switch (city.val()) {
					case area0[1]:
						area = area1;
						break;
					case area0[2]:
						area = area2;
						break;
					case area0[2]:
						area = area2;
						break;
					case area0[3]:
						area = area3;
						break;
					case area0[4]:
						area = area4;
						break;
					case area0[5]:
						area = area5;
						break;
					case area0[6]:
						area = area6;
						break;
					case area0[7]:
						area = area7;
						break;
					case area0[8]:
						area = area8;
						break;
					case area0[9]:
						area = area9;
						break;
					case area0[10]:
						area = area10;
						break;
					case area0[11]:
						area = area11;
						break;
					case area0[12]:
						area = area12;
						break;
					case area0[13]:
						area = area13;
						break;
					case area0[14]:
						area = area14;
						break;
					case area0[15]:
						area = area15;
						break;
					case area0[16]:
						area = area16;
						break;
					default:
						break;
					}
					// 비우고
					region.empty();
					region.append('<option value="" selected>' + '동네를 선택해주세요'
							+ '</option>');
					// 해당 시에 존재하는 구 넣기
					$.each(area, function(index, item) {
						region.append('<option value="' + item + '">' + item
								+ '</option>');
					})
					// '시' 에 해당하는 물품 출력 , 페이지는 1로 초기화 해야 한다.
					page = 1;
					getProductList();
				})
				
				region.on('change' , function(){
					header_title.text(city.val() + ' ' + region.val() + ' 인기 매물');
					// '구' 에 해당하는 물품 출력 , 페이지는 1로 초기화 해야 한다.
					page = 1;
					getProductList();
				})
				
				getProductList();
				
				// 카드를 클릭했을 때 (상품 클릭) click 이벤트 추가
				$('#productList').on('click' , '.card_link' , function(){
					var productNo = $(this).data('productno');
					
					/* 상품 번호에 해당하는 상품 상세 페이지로 이동 */
					location.href = 'p.selectOneProduct?productNo=' + productNo;
					
				})

			});

	function getProductList() {
		var obj;

		$('#city').val() == '' ? obj = {
			page : page ,
			city : '' ,
			region : ''
		} : $('#region').val() == null ? obj = {
			page : page,
			city : $('#city').val() ,
			region : ''
		} : obj = {
			page : page,
			city : $('#city').val(),
			region : $('#region').val()
		}


		$.ajax({
			url : 'p.selectProductList',
			type : 'post',
			data : JSON.stringify(obj),
			contentType : 'application/json; charset=utf-8',
			dataType : 'json',
			success : function(resultMap) {

				// resultMap.productList , resultMap.pageAndQueryVO
				
				// list 를 받아온 후 , 메인페이지에 뿌려준다.
				listMaker(resultMap.productList);
				
				pageMaker(resultMap.pageAndQueryVO);
				console.log(resultMap.pageAndQueryVO);
				// 페이징에 링크처리
				linkMaker();
				
			}
		})
	}
	function listMaker(list){
		
		
		
		// 리스트를 뿌리기 전에 비워야한다.
		$('#productList').empty();
		
		$.each(list , function(index , productVO){
			// 이미지 파일의 배열
			// var images = productVO.images.split(',');
			// 대표이미지
			// var mainImage = images[0];
			
			// 0 , 3 , 6 ... 번쨰 마다 행을 만들어야 합니다.
			// 선언해둔다.
			
			
			
			var row;
			// 행이 바뀌면 productList 안에 행부터 만들고 그 행 안에 col 을 만들어 준다.
			// 행이 바뀌지 않는다면 그 !! 행 안에 col을 만들어야 한다.
			if(index % 3 == 0){
				// 행
				row = $('<div class="row row-cols-lg-3 row-cols-md-2 row-cols-lg-1 mt-5"></div>');
				row.append(columnMaker(productVO.images , productVO.title , productVO.price , productVO.address , productVO.hit , productVO.likeCount , productVO.productNo))
				.appendTo('#productList');
			}else{
				$(columnMaker(productVO.images, productVO.title , productVO.price , productVO.address , productVO.hit , productVO.likeCount , productVO.productNo))
				.appendTo($('#productList > div:last-child'));
			} 
			
			
		})
	}
	function columnMaker(images , title , price , address , hit , likecount , productNo ){
		var col;
		/* src="${STATIC_IMAGE_ROOT }${boardFile.filePath }" */
		// image 에는 , 를 포함한 문자열 또는 '' 빈 문자열이 넘어온다.
		 	
		if(images == null){ // 첨부한 사진이 없어서 빈 문자열이 넘어 올 때,
			image = 'resources/image/noimage.png'; 
		}else{ // 첨부한 사진이 있을 때는 제일 먼저 첨부한 사진을 보여준다.
			image = '${STATIC_IMAGE_ROOT }' + images.split(',')[0];
		}
		
		col = '<div class="col-lg-4 col-md-6 col-sm-12  mb-5">' +
		'<div class="card border-0 mb-3 mx-auto card_link" data-productno="' + productNo + '" style="width: 18rem;">' +
		  '<img src="' + image + '" class="card-img-top" alt="...">' +
		  	'<div class="card-body">' +
		  		'<p class="card-text">' +
		  			title + '<br>' + price + '<br>' + address + '<br> <span class="text-secondary fs-6">조회' + hit + ' | 좋아요' + likecount + '</span>' 
		  			+ '</p></div></div></div>';
		return col;
	}
	
	function pageMaker(pageAndQueryVO){
		 $('#paging').empty();
		 if(pageAndQueryVO.beginPage <= pageAndQueryVO.pagePerBlock){ // 이전이 없음
			 $('#paging').append('<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a></li>');
		 }else{
			 $('#paging').append('<li class="page-item"><a class="page-link" href="#" tabindex="-1" aria-disabled="true" data-page="' + (pageAndQueryVO.beginPage - 1) + '">Previous</a></li>');
		 }
		 for(let p = pageAndQueryVO.beginPage ; p <= pageAndQueryVO.endPage ; p++){
			 if(p == page){//현재 페이지에 배경색적용
				 $('#paging').append('<li class="page-item active"><a class="page-link" href="#" data-page="' + p + '">' + p + '</a></li>');
			 }else{
				 $('#paging').append('<li class="page-item"><a class="page-link" href="#" data-page="' + p + '">' + p + '</a></li>');				 
			 }
		 }
		 
		if (pageAndQueryVO.endPage == pageAndQueryVO.totalPage) { // 마지막 블록
			$('#paging').append('<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">Next</a></li>');
			} else {
				$('#paging').append('<li class="page-item"><a class="page-link" href="#" tabindex="-1" aria-disabled="true" data-page="' + (pageAndQueryVO.endPage + 1) +'">Next</a></li>');
			}
		}
	 function linkMaker(){
		 //data-page속성 가진 a 태그들 
		 $('#paging').on('click' , 'a[data-page]' , function(){
			 // 페이지 변경해주고
			 page = $(this).data('page');
			 // ajax 로 list 호출
			 getProductList();
		 })
	 }
</script>
<div class="container">
	<div class="row">
		<h2 class="text-center" id="header_title">중고거래 인기매물</h2>
	</div>

	<div class="float-end">
		<div class="row">
			<div class="col">
				<select class="form-select" aria-label="Default select example" id="city" style="width: 190px;">
				</select>
			</div>
			<div class="col">
				<select class="form-select" aria-label="Default select example" id="region" style="width: 190px;" disabled>

				</select>
			</div>
		</div>
	</div>
	<div id="productList">

	</div>
	<ul class="pagination justify-content-center" id="paging">
	</ul>
</div>
<jsp:include page="layout/footer.jsp"></jsp:include>