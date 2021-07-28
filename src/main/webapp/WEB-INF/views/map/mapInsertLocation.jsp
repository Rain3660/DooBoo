<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
  <script>
    $(document).ready(function(){
    	  fn_save_location();
    })

    function fn_save_location(){
        $('body').on('click','#save_location_btn',function(){
        if($('#location1').val()=='' && $('#location2').val()==''){
        	alert('지역을 선택해주세요');
        }else if($('#location1').val()==$('#location2').val()){
                alert('서로 다른지역을 선택해주세요');
            }else{
                $('#f').attr('action','m.firstInsertLocation');
                $('#f').submit();
            }
        })
    }
        function fn_saveLocation1(location){
        	$('#location1').val(location);
        	$('#location1_text').text(location);
        }
   	  function fn_saveLocation2(location){
      	  	$('#location2').val(location);
        	$('#location2_text').text(location);
        }
      

</script>
	<div class="container text-center" style="width: 80%;">
		<button type="button" class="btn btn-outline-primary" style="margin-top: 30%">거래할 지역을 선택해주세요</button><br><br>

		
		<div class="btn-group">
			<button type="button" id="location1_text" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
               	 지역 1선택
            </button>
            <ul class="dropdown-menu">
            	<li><a class="dropdown-item" onclick="fn_saveLocation1('강서구')">강서구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('강남구')">강남구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('성북구')">성북구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('강동구')">강동구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('중구')">중구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('은평구')">은평구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('금천구')">금천구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('광진구')">광진구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('서대문구')">서대문구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('중랑구')">중랑구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('강북구')">강북구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('관악구')">관악구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('구로구')">구로구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('영등포구')">영등포구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('마포구')">마포구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('종로구')">종로구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('도봉구')">도봉구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('용산구')">용산구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('동작구')">동작구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('서초구')">서초구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('송파구')">송파구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('노원구')">노원구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('성동구')">성동구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('양천구')">양천구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation1('동대문구')">동대문구 </a></li>
           </ul>
       </div>
             
       <div class="btn-group">
       		<button type="button" id="location2_text" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
               	 지역2 선택
            </button>
            <ul class="dropdown-menu">                   
                <li><a class="dropdown-item" onclick="fn_saveLocation2('강서구')">강서구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('강남구')">강남구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('성북구')">성북구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('강동구')">강동구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('중구')">중구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('은평구')">은평구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('금천구')">금천구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('광진구')">광진구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('서대문구')">서대문구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('중랑구')">중랑구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('강북구')">강북구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('관악구')">관악구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('구로구')">구로구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('영등포구')">영등포구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('마포구')">마포구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('종로구')">종로구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('도봉구')">도봉구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('용산구')">용산구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('동작구')">동작구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('서초구')">서초구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('송파구')">송파구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('노원구')">노원구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('성동구')">성동구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('양천구')">양천구</a></li>
                <li><a class="dropdown-item" onclick="fn_saveLocation2('동대문구')">동대문구 </a></li>
           </ul>
      </div><br><br>
		
		
		
      <form id="f" method="post">
            <input type="hidden" name="memberNo" value="${loginUser.memberNo}" >
            <input type="hidden" id="location1" name="location1">
            <input type="hidden" id="location2" name="location2">
            <input type="button" class="location_btn btn btn-outline-secondary" value="저장하기" id="save_location_btn">
      </form>
  </div>    
