<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../layout/header.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div class="hAddr">
        <input type="hidden" id="centerAddr">
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5ed12af5dc728fe381f7652e93c6b462&libraries=services"></script>
<script>



if (navigator.geolocation) {
  //--------------------------------------------------------------------------------------------------      
        // GeoLocation을 이용해서 접속 위치를 얻어옵니다
        navigator.geolocation.getCurrentPosition(function(position) {
            
            var  lat = position.coords.latitude, // 위도
                lon = position.coords.longitude; // 경도
            
            var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
                message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
            

//--------------------------------------------------------------------------------------------------

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(lat,lon), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
//--------------------------------------------------------------------------------------------------

var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    markerPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치입니다

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition, 
    image: markerImage // 마커이미지 설정 
});


// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//--------------------------------------------------------------------------------------------------

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
searchAddrFromCoords(map.getCenter(), displayCenterInfo);


// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', function() {
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

 
// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
    $('#location1_btn').on('click',function(){
        if(result[0].region_2depth_name != $('#location1').val()){
            alert('인증에실패하였습니다');    
        }else{
        	  $.ajax({
                  url:'m.checkLocation',
                  type : 'get',
                  data : 'mapno='+$('#mapno1').val(),
                  dataType : 'json',
                  success : function(resultMap){
                      if(resultMap.result > 0){
                          alert('인증되었습니다');
                          location.href='index';
                      }
                  },error(){
  
                  }
              });
        }
    })
    $('#location2_btn').on('click',function(){
        if(result[0].region_2depth_name != $('#location2').val()){
        	alert('인증에실패하였습니다');  
        }else{
        	  $.ajax({
                  url:'m.checkLocation',
                  type : 'get',
                  data : 'mapno='+$('#mapno2').val(),
                  dataType : 'json',
                  success : function(resultMap){
                      if(resultMap.result > 0){
                    	  
                          alert('인증되었습니다');
                          location.href='index';
                      }
                  },error(){
  
                  }
            });
        }
    })

}

//--------------------------------------------------------------------------------------------------


});
        
    } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
        
        var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
            message = 'geolocation을 사용할수 없어요..'
            
        displayMarker(locPosition, message);
    }

</script>

<form id="f">
    <h3>${location1.location}</h3>
    <h3>${location2.location}</h3>
    <br>
    <input type="hidden" value="${location1.mapNo}" name="mapNo" id="mapno1">
    <input type="hidden" value="${location1.location}" id="location1">
    <input type="hidden" value="${location2.mapNo}" name="mapNo" id="mapno2">
    <input type="hidden" value="${location2.location}" id="location2">


    <input type="button" value="${location1.location} 지역인증하기" id="location1_btn">
    <input type="button" value="${location2.location} 지역인증하기" id="location2_btn">
</form>
<jsp:include page="../layout/footer.jsp"></jsp:include>