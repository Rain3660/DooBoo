<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="layout/header.jsp"></jsp:include>
<script type="text/javascript">
$('document').ready(function() {
	   var area0 = ["시/도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
	   var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
	   var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
	   var area3 = ["대덕구","동구","서구","유성구","중구"];
	   var area4 = ["광산구","남구","동구",     "북구","서구"];
	   var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
	   var area6 = ["남구","동구","북구","중구","울주군"];
	   var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
	   var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
	   var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
	   var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
	   var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
	   var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
	   var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
	   var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
	   var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
	   var area16 = ["서귀포시","제주시","남제주군","북제주군"];

	 	
	   const city = $('#city');
	   const region = $('#region');
	   
	   $.each(area0 , function(index , item){ // 페이지 로드시 자동적으로 select 완성
		   if(index == 0){ // 인덱스가 0 이면 시/도 선택
			   city.append('<option value="" selected>' + item + '</option>');
		   }else{
			   city.append('<option value="' + item + '">' + item + '</option>');
		   }
	   })
	   
	   // 시 선택했을 경우
	   city.on('change' , function(){
		   alert(city.val());
	   })
});
</script>
<div class="container">
	<div class="row">
		<h2 class="text-center">중고거래 인기매물</h2>
	</div>

	<div class="float-end">
		<div class="row">
			<div class="col">
				<select class="form-select" aria-label="Default select example" id="city">
				</select>
			</div>
			<div class="col">
				<select class="form-select" aria-label="Default select example" disabled>
					<option selected>Open this select menu</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
		</div>
	</div>



	<div class="row row-cols-lg-3 row-cols-md-2 row-cols-lg-1 mt-5">
		<div class="col-lg-4 col-md-6 col-sm-12  mb-5">
			<div class="card border-0 mb-3 mx-auto" style="width: 18rem;">
				<img src="<c:if test="${loginUser.apiNumber eq 1 || apiLogout eq 1}"></c:if>resources/image/DoobooLogo.png" class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">
						두부 한모 팝니다 <br> 10000 <br> 경기도 고양시 <br><span class="text-secondary fs-6">조회1 | 좋아요12</span>
					</p>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="layout/footer.jsp"></jsp:include>