<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head profile="http://www.w3.org/2005/10/profile">
<link rel="icon" type="image/png" href="http://example.com/myicon.png">
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
        var memberNo = '${loginUser.memberNo}';
        var fullLocation = '${fullLocation}';
        
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
                if(!result){
                    alert('지역을 먼저 선택해주세요');
                }
            })
        }
        function fn_checkLocation(){
            $('body').on('click','#location1_btn',function(){
                if('${nowLocation}' != $('#btnradio1text').text()){
                	alert('인증에 실패하였습니다');
                }else if(${mapSession1DTO.isChecked eq 1}){
                	alert('이미 인증이 완료된 지역입니다! 다른지역을 선택해주세요');
                }else{
              	  $.ajax({
                      url:'m.checkLocation',
                      type : 'get',
                      data : 'mapNo='+$('#mapno1').val()+'&memberNo='+memberNo+'&location='+fullLocation+'&locationOrd=1',
                      dataType : 'json',
                      success : function(resultMap){
                          if(resultMap.result > 0){
                              alert('인증되었습니다');
                             <c:if test="${mapSession1DTO.isChecked eq 0 && mapSession2DTO.isChecked eq 0}">
                          	window.location.assign('index');
                          	</c:if>
                          	 <c:if test="${mapSession1DTO.isChecked eq 1 || mapSession2DTO.isChecked eq 1}">
                         	window.location.assign('mapCheck');
                         	</c:if>
                          }else{
                        	
                          }
                      },error(){
                        	 
                        
      
                      }
                  });
                }
            })
            $('body').on('click','#location2_btn',function(){
            	   if('${nowLocation}' != $('#btnradio2text').text()){
                   	alert('인증에 실패하였습니다');
                   }else if(${mapSession2DTO.isChecked eq 1}){
                   	alert('이미 인증이 완료된 지역입니다! 다른지역을 선택해주세요');
                   }else{
                 	  $.ajax({
                         url:'m.checkLocation',
                         type : 'get',
                         data : 'mapNo='+$('#mapno2').val()+'&memberNo='+memberNo+'&location='+fullLocation+'&locationOrd=2',
                         dataType : 'json',
                         success : function(resultMap){
                             if(resultMap.result > 0){
                                 alert('인증되었습니다');
                                 <c:if test="${mapSession1DTO.isChecked eq 0 && mapSession2DTO.isChecked eq 0}">
                             	window.location.assign('index');
                             	</c:if>
                             	 <c:if test="${mapSession1DTO.isChecked eq 1 || mapSession2DTO.isChecked eq 1}">
                             	window.location.assign('mapCheck');
                             	</c:if>
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
                    		if($('#btnradio2text').text()==location){
                    			alert('이미 추가된 지역입니다 다른지역을 선택해주세요!');
                    			return;
                    		}else if(${mapSession2DTO.isChecked eq 0 && mapSession1DTO.isChecked eq 1}){
	                			 alert('최소 1개의 인증지역은 필수입니다 다른지역을 수정해주세요!');
	                			 return false;
	                		 }else{		
                        	$.ajax({
                        		url:'m.updateLocation',
                        		type : 'post',
                        		data : 'location='+location+'&mapNo='+$('#mapno1').val()+'&memberNo='+memberNo+'&locationOrd=1',
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
                    		}
                        }else{
                        
                        if($('#btnradio1text').text()==location){
                        	alert('이미 추가된 지역입니다 다른지역을 선택해주세요!');
                			return;
                        }else if(${mapSession1DTO.isChecked eq 0 && mapSession2DTO.isChecked eq 1}){
               			 alert('최소 1개의 인증지역은 필수입니다 다른지역을 수정해주세요!');
            			 return false;
            		 }else{
                  			$.ajax({
                        		url:'m.updateLocation',
                        		type : 'post',
                        		data : 'location='+location+'&mapNo='+$('#mapno2').val()+'&memberNo='+memberNo+'&locationOrd=2',
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
	                        		url:'m.updateLocation',
	                        		type : 'post',
	                        		data : 'location='+fullLocation+'&mapNo='+$('#mapno1').val()+'&memberNo='+memberNo+'&locationOrd=1',
	                        	    dataType : 'json',
	                                success : function(resultMap){
	                                    if(resultMap.result > 0){
	                                        alert('인증되었습니다');
	                                        <c:if test="${mapSession1DTO.isChecked eq 0 && mapSession2DTO.isChecked eq 0}">
	                                    	window.location.assign('index');
	                                    	</c:if>
	                                        <c:if test="${mapSession1DTO.isChecked eq 1 || mapSession2DTO.isChecked eq 1}">
	                                    	window.location.assign('mapCheck');
	                                    	</c:if>
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
		                        		url:'m.updateLocation',
		                        		type : 'post',
		                        		data : 'location='+fullLocation+'&mapNo='+$('#mapno2').val()+'&memberNo='+memberNo+'&locationOrd=2',
		                        	    dataType : 'json',
		                                success : function(resultMap){
		                                    if(resultMap.result > 0){
		                                        alert('인증되었습니다');
		                                        <c:if test="${mapSession1DTO.isChecked eq 0 && mapSession2DTO.isChecked eq 0}">
		                                    	window.location.assign('index');
		                                    	</c:if>
		                                    	 <c:if test="${mapSession1DTO.isChecked eq 1 || mapSession2DTO.isChecked eq 1}">
			                                    	window.location.assign('mapCheck');
			                                    </c:if>
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
	                		 if(${mapSession2DTO.isChecked eq 0}){
	                			 alert('최소 1개의 인증지역은 필수입니다 다른지역을 수정해주세요!');
	                			 return false;
	                		 }else if(confirm('현재 선택한 지역은"'+$('#btnradio1text').text()+'"입니다 삭제하시겠습니까?')){
		                			$.ajax({
		                        		url:'m.deleteLocation',
		                        		type : 'post',
		                        		data : 'mapNo='+$('#mapno1').val()+'&locationOrd=1',
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
	                		 if(${mapSession1DTO.isChecked eq 0}){
	                			 alert('최소 1개의 인증지역은 필수입니다 다른지역을 수정해주세요!');
	                			 return false;
	                		 }else if(confirm('현재 선택한 지역은"'+$('#btnradio2text').text()+'"입니다 삭제하시겠습니까?')){
		                		 $.ajax({
		                        		url:'m.deleteLocation',
		                        		type : 'post',
		                        		data : 'mapNo='+$('#mapno2').val()+'&locationOrd=2',
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
            		if($('#btnradio2text').text()==location){
            			alert('이미 추가된 지역입니다 다른지역을 선택해주세요!');
            			return;
            		}else{
		            	$.ajax({
		            		url : 'm.insertLocation',
		            		type : 'post',
		            		data : 'location='+location+'&memberNo='+memberNo+'&locationOrd=1',
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
            }
            function fn_insertLocation2(location){
            if(confirm('선택하신 지역은"'+location+'"입니다 추가 하시겠습니까?')){
            	if($('#btnradio1text').text()==location){
        			alert('이미 추가된 지역입니다 다른지역을 선택해주세요!');
        			return;
        		}else{
	            	$.ajax({
	            		url : 'm.insertLocation',
	            		type : 'post',
	            		data : 'location='+location+'&memberNo='+memberNo+'&locationOrd=2',
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
            }
            function fn_cant_delete(){
            	alert('지역 1개는 필수입니다.');
            }
            function fn_nowLocation1(){
            	if($('#btnradio2text').text()=='${nowLocation}'){
            		alert('현재 "${nowLocation}"는 이미 추가된 지역입니다 다른지역을 선택해주세요!');
            	}else{
	            	 fn_InsertNowLocation1('${nowLocation}');            		
            	}
            }
            
            function fn_InsertNowLocation1(location){
            	if(confirm('현재 위치하시는 지역은"'+location+'"입니다 추가하시겠습니까?(확인시 인증이 추가로 완료됩니다.)')){
	            	$.ajax({
	            		url : 'm.insertLocation',
	            		type : 'post',
	            		data : 'location='+fullLocation+'&memberNo='+memberNo+'&locationOrd=1',
	            		dataType : 'json',
	            		success : function(resultMap){
	            			if(resultMap.result > 0){
	            				 alert('추가되었습니다');
                                 <c:if test="${mapSession1DTO.isChecked eq 0 && mapSession2DTO.isChecked eq 0}">
                             		window.location.assign('index');
                             	 </c:if>
                             	 <c:if test="${mapSession1DTO.isChecked eq 1 || mapSession2DTO.isChecked eq 1}">
                                 	window.location.assign('mapCheck');
                                 </c:if>
	            			}
	            		},error(){
	            			
	                    }
	            	});         		
            	}else{
            		return;
            	}
            }
			function fn_nowLocation2(){
				if($('#btnradio1text').text()=='${nowLocation}'){
            		alert('현재 "${nowLocation}"는 이미 추가된 지역입니다 다른지역을 선택해주세요!');
            	}else{
					 fn_InsertNowLocation2('${nowLocation}');            		
            	}
            }
            function fn_InsertNowLocation2(location){
            	if(confirm('현재 위치하시는 지역은"'+location+'"입니다 추가하시겠습니까?(확인시 인증이 추가로 완료됩니다.)')){
	            	$.ajax({
	            		url : 'm.insertLocation',
	            		type : 'post',
	            		data : 'location='+fullLocation+'&memberNo='+memberNo+'&locationOrd=2',
	            		dataType : 'json',
	            		success : function(resultMap){
	            			if(resultMap.result > 0){
	            				 alert('추가되었습니다');
                                 <c:if test="${mapSession1DTO.isChecked eq 0 && mapSession2DTO.isChecked eq 0}">
                             		window.location.assign('index');
                             	 </c:if>
                             	 <c:if test="${mapSession1DTO.isChecked eq 1 || mapSession2DTO.isChecked eq 1}">
                                 	window.location.assign('mapCheck');
                                 </c:if>
	            			}
	            		},error(){
			                
	                    }
	            	});         		
            	}
            }
            

            
            
            
            
    </script>
<body>
	<form id="f">
        <div class="mt-5 px-4" style="text-align: center;">
            <button type="button" class="btn btn-outline-success btn-lg mb-3">내 동내 인증하기</button><br>
          		 지역은 최소 1개이상 최대 2개이하 인증해야해요.
            
            <br>
           <div class="container px-3 mt-3" style="margin: 0 auto;">
			<div class="row mx-auto px-3 justify-content-center">				
				<c:if test="${mapSession1DTO ne null }">
					<div class="col-auto my-auto px-0"> <!-- 세션에있으면 -->
		            <input type="radio" class="btn-check"  name="btnradio" id="btnradio1" autocomplete="off">
		            <label class="btn btn-outline-primary" id="btnradio1text" for="btnradio1">${mapSession1DTO.location}</label>
		             </div><!-- 세션에있으면 -->
		             <div class="col-auto my-auto  px-4"> <!-- 세션에있으면 -->
			            <c:if test="${mapSession1DTO.isChecked eq 1}">
			            	인증완료
			            </c:if>				
			            <c:if test="${mapSession1DTO.isChecked ne 1}">
			            	미인증
			            </c:if>
		             </div> <!-- 세션에있으면 -->
				</c:if>
				<c:if test="${mapSession1DTO eq null }">
				<div class="col my-auto"><!-- 세션에없으면 -->
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
             </div> <!-- 세션에없으면 -->
				</c:if>
         
	                &nbsp;
				<c:if test="${mapSession2DTO ne null }">
		           	<div class="col-auto my-auto px-0"><!-- 세션에있으면 -->
	                <input type="radio" class="btn-check"  name="btnradio" id="btnradio2" autocomplete="off">
	                <label class="btn btn-outline-primary" id="btnradio2text" for="btnradio2">${mapSession2DTO.location}</label>
	            	</div> <!-- 세션에있으면 -->
	            	<div class="col-auto my-auto px-4"><!-- 세션에있으면 -->
					<c:if test="${mapSession2DTO.isChecked eq 1}">
						인증완료						
	                </c:if>				
		            <c:if test="${mapSession2DTO.isChecked ne 1}">
		            	미인증
		            </c:if>
		            </div><!-- 세션에있으면 -->       
				</c:if>
				<c:if test="${mapSession2DTO eq null }">
				<div class="col my-auto"><!-- 세션에있으면 -->
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
				</div><!-- 세션에있으면 -->
				</c:if>
              

           
			</div>
		</div>
            <br>
          
	            <input type="hidden" value="${mapSession1DTO.mapNo}" name="mapNo" id="mapno1">
	            <input type="hidden" value="${mapSession1DTO.location}" id="location1">
	            <input type="hidden" value="${mapSession2DTO.mapNo}" name="mapNo" id="mapno2">
	            <input type="hidden" value="${mapSession2DTO.location}" id="location2">  
	            <input type="hidden" value="${loginUser.memberNo}" id="memberNo">              

          	<input type="button" class="location_btn btn btn-outline-secondary mb-3 " value="지역인증하기" id="location_btn">
            
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
              <c:if test="${mapSession1DTO ne null && mapSession2DTO eq null}">
              	<button type="button" id="cant_delete_btn" class=" btn btn-danger" onclick="fn_cant_delete()">선택한 지역삭제</button>              
              </c:if>
              <c:if test="${mapSession2DTO ne null && mapSession1DTO eq null}">
              	<button type="button" id="cant_delete_btn" class=" btn btn-danger" onclick="fn_cant_delete()">선택한 지역삭제</button>                            
              </c:if>
              <c:if test="${mapSession1DTO ne null && mapSession2DTO ne null }">
              	<button type="button" id="delete_btn" class="delete_btn btn btn-danger">선택한 지역삭제</button>              
              </c:if>
        </div>
    </form>
    
    <c:if test="${mapSession1DTO.isChecked eq 1 || mapSession2DTO.isChecked eq 1}">
    <div class="container">
		<div class="row justify-content-center">			
		    	<input type="button" class="col-4 btn btn-outline-secondary mx-auto mt-3" value="저장하기" onclick="reload()">
		</div>
    </div>

    	
    </c:if>
    <script>
		function reload(){
		    window.opener.location.reload();
		    window.close();
		}
</script>
</body>
</html>