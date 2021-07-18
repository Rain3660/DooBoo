<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script>
        $(document).ready(function(){
            fn_IdChange();
            fn_checking();
            fn_checkLocation();
            fn_delete();
        })
        var result = false;
        function fn_IdChange(){
            $("#btnradio1").change(function(){
                if($('#btnradio1').is(':checked')){
                  $('.location_btn').prop('id','location1_btn');
                  $('.delete_btn').prop('id','delete1_btn');
                  result = true;
                }
            }) 
            $("#btnradio2").change(function(){
                if($('#btnradio2').is(':checked')){
                    $('.location_btn').prop('id','location2_btn');
                  	$('.delete_btn').prop('id','delete2_btn');
                    result = true;
                }
            }) 
        }
        function fn_checking(){
            $('.location_btn').on('click',function(){
                console.log(result);
                if(!result){
                    alert('지역을 먼저 선택해주세요');
                }
            })
        }
        function fn_checkLocation(){
            $('body').on('click','#location1_btn',function(){
                if('${nowLocation}' != $('#btnradio1text').text()){
                	alert('인증에 실패하였습니다');
                }else{
              	  $.ajax({
                      url:'m.checkLocation',
                      type : 'get',
                      data : 'mapno='+$('#mapno1').val()+'&memberNo=${loginUser.memberNo}',
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
            $('body').on('click','#location2_btn',function(){
            	   if('${nowLocation}' != $('#btnradio2text').text()){
                   	alert('인증에 실패하였습니다');
                   }else{
                 	  $.ajax({
                         url:'m.checkLocation',
                         type : 'get',
                         data : 'mapno='+$('#mapno2').val()+'&memberNo=${loginUser.memberNo}',
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
        function fn_updateLocation(location){
        	
                if(!result){
                    alert('지역을 먼저 선택해주세요');
                    return;
                }else{
                    if(confirm('선택하신 지역은"'+location+'"입니다 변경하시겠습니까?')){
                    	if($('#btnradio1').is(':checked')){
                        	$.ajax({
                        		url:'m.changeLocation',
                        		type : 'post',
                        		data : 'location='+location+'&mapNo='+$('#mapno1').val()+'&memberNo='+$('#memberNo').val()+'&locationNo=1',
                        	    dataType : 'json',
                                success : function(resultMap){
                                    if(resultMap.result > 0){
                                        alert('변경되었습니다');
                                    	window.location.assign('mapCheck');
                                    }else{
                                    	
                                    }
                                },error(){
                
                                }
                        	});
                        }else{
                    	 	$.ajax({
                        		url:'m.changeLocation',
                        		type : 'post',
                        		data : 'location='+location+'&mapNo='+$('#mapno2').val()+'&memberNo='+$('#memberNo').val()+'&locationNo=2',
                        	    dataType : 'json',
                                success : function(resultMap){
                                    if(resultMap.result > 0){
                                    	 alert('변경되었습니다');
                                     	window.location.assign('mapCheck');
                                    }
                                },error(){
                
                                }
                        });             		
                	}
                    }
                    
                }
            }
        
            function fn_nowLocation(){
                var location = '${nowLocation}';
                fn_updateNowLocation(location);
            }
            
            function fn_updateNowLocation(location){
                if(!result){
                        alert('지역을 먼저 선택해주세요');
                        return;
                    }else{
	                  if(confirm('현재 계신 지역은"'+location+'"입니다 변경하시겠습니까?(확인시 인증이 추가로 완료됩니다.)')){
                    	if($('#btnradio1').is(':checked')){
                    		if($('#btnradio2text').text()=='${nowLocation}'){
                    			alert('이미 추가된 지역입니다 다른지역을 선택해주세요!');
                    			return;
                    		}else{
	                        	$.ajax({
	                        		url:'m.changeToNowLocation',
	                        		type : 'post',
	                        		data : 'nowLocation=${nowLocation}&mapNo='+$('#mapno1').val()+'&memberNo='+$('#memberNo').val()+'&locationNo=1',
	                        	    dataType : 'json',
	                                success : function(resultMap){
	                                    if(resultMap.result > 0){
	                                        alert('인증되었습니다');
	                                    	window.location.assign('mapCheck');
	                                    }
	                                },error(){
	                
	                                }
	                        	});        			
                    		}
	                        }else{
	                        	if($('#btnradio1text').text()=='${nowLocation}'){
	                        		alert('이미 추가된 지역입니다 다른지역을 선택해주세요!');
	                    			return;
	                        	}else{
		                    	 	$.ajax({
		                        		url:'m.changeToNowLocation',
		                        		type : 'post',
		                        		data : 'nowLocation=${nowLocation}&mapNo='+$('#mapno2').val()+'&memberNo='+$('#memberNo').val()+'&locationNo=2',
		                        	    dataType : 'json',
		                                success : function(resultMap){
		                                    if(resultMap.result > 0){
		                                        alert('인증되었습니다');
		                                    	window.location.assign('mapCheck');
		                                    }
		                                },error(){
		                
		                                }
		                        });             		
	                        		
	                        	}
                    	}
                    }
                        //ajax
                }
            }
            function fn_delete(){
            	$('.delete_btn').on('click',function(){
	            	 if(!result){
	                     alert('지역을 먼저 선택해주세요');
	                     return;
	                 }else{
	                	 if($('#btnradio1').is(':checked')){
		                	 if(confirm('현재 선택한 지역은"'+$('#btnradio1text').text()+'"입니다 삭제하시겠습니까?')){
		                			$.ajax({
		                        		url:'m.deleteLocation',
		                        		type : 'post',
		                        		data : 'mapNo='+$('#mapno1').val()+'&locationNo=1',
		                        	    dataType : 'json',
		                                success : function(resultMap){
		                                    if(resultMap.result > 0){
		                                        alert('삭제되었습니다');
		                                    	window.location.assign('mapCheck');
		                                    }
		                                },error(){
		                
		                                }
		                        });  
	                	 	}
	                		 
	 	               	 }
	                	 if($('#btnradio2').is(':checked')){
		                	 if(confirm('현재 선택한 지역은"'+$('#btnradio2text').text()+'"입니다 삭제하시겠습니까?')){
		                		 $.ajax({
		                        		url:'m.deleteLocation',
		                        		type : 'post',
		                        		data : 'mapNo='+$('#mapno2').val()+'&locationNo=2',
		                        	    dataType : 'json',
		                                success : function(resultMap){
		                                    if(resultMap.result > 0){
		                                        alert('삭제되었습니다');
		                                    	window.location.assign('mapCheck');
		                                    }
		                                },error(){
		                
		                                }
		                        });
	                	 	}
	                		 
	 	               	 }
	                 }
            		
            	})
            }
            
            function fn_insertLocation1(location){
            	if(confirm('선택하신 지역은"'+location+'"입니다 추가 하시겠습니까?')){
	            	$.ajax({
	            		url : 'm.insertLocation',
	            		data : 'location1='+location+'&ajax=1&memberNo=${loginUser.memberNo}&nowLocation=0',
	            		dataType : 'json',
	            		success : function(resultMap){
	            			if(resultMap.result > 0){
	            				 alert('추가되었습니다');
	                         	window.location.assign('mapCheck');
	            			}
	            		},error(){
			                
	                    }
	            	})            		
            	}
            }
            function fn_insertLocation2(location){
            if(confirm('선택하신 지역은"'+location+'"입니다 추가 하시겠습니까?')){
            	$.ajax({
            		url : 'm.insertLocation',
            		data : 'location2='+location+'&ajax=1&memberNo=${loginUser.memberNo}&nowLocation=0',
            		dataType : 'json',
            		success : function(resultMap){
            			if(resultMap.result > 0){
            				 alert('추가되었습니다');
                         	window.location.assign('mapCheck');
            			}
            		},error(){
		                
                    }
            	})         	
            }
            }
            function fn_cant_delete(){
            	alert('지역 1개는 필수입니다.');
            }
            function fn_nowLocation1(){
            	if($('#btnradio2text').text()=='${nowLocation}'){
            		alert('현재 "${nowLocation}"는 이미 추가된 지역입니다 다른지역을 선택해주세요!');
            	}else{
	            	 var location = '${nowLocation}';
	            	 fn_InsertNowLocation1(location);            		
            	}
            }
            
            function fn_InsertNowLocation1(location){
            	if(confirm('현재 위치하시는 지역은"'+location+'"입니다 추가하시겠습니까?(확인시 인증이 추가로 완료됩니다.)')){
	            	$.ajax({
	            		url : 'm.insertLocation',
	            		data : 'location1='+location+'&ajax=1&memberNo=${loginUser.memberNo}&nowLocation=1',
	            		dataType : 'json',
	            		success : function(resultMap){
	            			if(resultMap.result > 0){
	            				 alert('추가되었습니다');
	                         	window.location.assign('mapCheck');
	            			}
	            		},error(){
			                
	                    }
	            	});         		
            	}
            }
			function fn_nowLocation2(){
				if($('#btnradio1text').text()=='${nowLocation}'){
            		alert('현재 "${nowLocation}"는 이미 추가된 지역입니다 다른지역을 선택해주세요!');
            	}else{
					 var location = '${nowLocation}';
					 fn_InsertNowLocation2(location);            		
            	}
            }
            function fn_InsertNowLocation2(location){
            	if(confirm('현재 위치하시는 지역은"'+location+'"입니다 추가하시겠습니까?(확인시 인증이 추가로 완료됩니다.)')){
	            	$.ajax({
	            		url : 'm.insertLocation',
	            		data : 'location2='+location+'&ajax=1&memberNo=${loginUser.memberNo}&nowLocation=1',
	            		dataType : 'json',
	            		success : function(resultMap){
	            			if(resultMap.result > 0){
	            				 alert('추가되었습니다');
	                         	window.location.assign('mapCheck');
	            			}
	            		},error(){
			                
	                    }
	            	});         		
            	}
            }
            
    </script>
<body>
	<form id="f">
        <div style="text-align: center; margin-top: 200px;">
            <button type="button" class="btn btn-outline-success btn-lg">내 동내 인증하기</button><br>
          		 지역은 최소 1개이상 최대 2개이하 인증해야해요.
            
            <br>
				<c:if test="${location1 ne null }">
		            <input type="radio" class="btn-check"  name="btnradio" id="btnradio1" autocomplete="off">
		            <label class="btn btn-outline-primary" id="btnradio1text" for="btnradio1">${location1.location}</label>
		            <c:if test="${location1IsChecked eq 1}">인증완료</c:if>				
		            <c:if test="${location1IsChecked ne 1}">미인증</c:if>
				</c:if>
				<c:if test="${location1 eq null }">
				<div class="btn-group">
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="dropdown" aria-expanded="false">
                	새로운 지역 선택하기
           		</button>
	            <ul class="dropdown-menu">
	                  <li><a class="dropdown-item" onclick="fn_nowLocation1()">현재 위치로 추가하기</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('강서구')">강서구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('강남구')">강남구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('성북구')">성북구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('강동구')">강동구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('중구')">중구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('은평구')">은평구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('금천구')">금천구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('광진구')">광진구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('서대문구')">서대문구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('중랑구')">중랑구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('강북구')">강북구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('관악구')">관악구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('구로구')">구로구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('영등포구')">영등포구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('마포구')">마포구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('종로구')">종로구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('도봉구')">도봉구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('용산구')">용산구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('동작구')">동작구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('서초구')">서초구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('송파구')">송파구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('노원구')">노원구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('성동구')">성동구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('양천구')">양천구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation1('동대문구')">동대문구 </a></li>
	                </ul>
              </div>
				</c:if>
	                &nbsp;
				<c:if test="${location2 ne null }">
	                <input type="radio" class="btn-check"  name="btnradio" id="btnradio2" autocomplete="off">
	                <label class="btn btn-outline-primary" id="btnradio2text" for="btnradio2">${location2.location}</label>
	                <c:if test="${location2IsChecked eq 1}">인증완료</c:if>				
		            <c:if test="${location2IsChecked ne 1}">미인증</c:if>
				</c:if>
				<c:if test="${location2 eq null }">
				<div class="btn-group">
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="dropdown" aria-expanded="false">
                	새로운 지역 선택하기
           		</button>
	            <ul class="dropdown-menu">
	                  <li><a class="dropdown-item" onclick="fn_nowLocation2()">현재 위치로 추가하기</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('강서구')">강서구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('강남구')">강남구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('성북구')">성북구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('강동구')">강동구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('중구')">중구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('은평구')">은평구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('금천구')">금천구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('광진구')">광진구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('서대문구')">서대문구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('중랑구')">중랑구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('강북구')">강북구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('관악구')">관악구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('구로구')">구로구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('영등포구')">영등포구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('마포구')">마포구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('종로구')">종로구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('도봉구')">도봉구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('용산구')">용산구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('동작구')">동작구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('서초구')">서초구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('송파구')">송파구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('노원구')">노원구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('성동구')">성동구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('양천구')">양천구</a></li>
	                  <li><a class="dropdown-item" onclick="fn_insertLocation2('동대문구')">동대문구 </a></li>
	                </ul>
              </div>
				</c:if>
              

             

            <br>
          
	            <input type="hidden" value="${location1.mapNo}" name="mapNo" id="mapno1">
	            <input type="hidden" value="${location1.location}" id="location1">
	            <input type="hidden" value="${location2.mapNo}" name="mapNo" id="mapno2">
	            <input type="hidden" value="${location2.location}" id="location2">  
	            <input type="hidden" value="${loginUser.memberNo}" id="memberNo">              
          
            <input type="button" class="location_btn" value="지역인증하기" id="location_btn">
            <br>

            <div class="btn-group">
                <button type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
               	 선택한 지역변경
            	</button>
            <ul class="dropdown-menu">
                    <li><a class="dropdown-item" id="nowlocation" onclick="fn_nowLocation()">현재 위치로 변경하기</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('강서구')">강서구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('강남구')">강남구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('성북구')">성북구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('강동구')">강동구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('중구')">중구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('은평구')">은평구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('금천구')">금천구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('광진구')">광진구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('서대문구')">서대문구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('중랑구')">중랑구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('강북구')">강북구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('관악구')">관악구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('구로구')">구로구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('영등포구')">영등포구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('마포구')">마포구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('종로구')">종로구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('도봉구')">도봉구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('용산구')">용산구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('동작구')">동작구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('서초구')">서초구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('송파구')">송파구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('노원구')">노원구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('성동구')">성동구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('양천구')">양천구</a></li>
                  <li><a class="dropdown-item" onclick="fn_updateLocation('동대문구')">동대문구 </a></li>
                </ul>
              </div>
              <c:if test="${location1 eq null && location2 ne null}">
              	<button type="button" id="cant_delete_btn" class=" btn btn-danger" onclick="fn_cant_delete()">선택한 지역삭제</button>              
              </c:if>
              <c:if test="${location2 eq null && location1 ne null}">
              	<button type="button" id="cant_delete_btn" class=" btn btn-danger" onclick="fn_cant_delete()">선택한 지역삭제</button>                            
              </c:if>
              <c:if test="${location1 ne null && location2 ne null }">
              	<button type="button" id="delete_btn" class="delete_btn btn btn-danger">선택한 지역삭제</button>              
              </c:if>
        </div>
    </form>
</body>
</html>