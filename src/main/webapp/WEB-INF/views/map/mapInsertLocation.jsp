<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../layout/header.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
    $(document).ready(function(){
        fn_save_location();
    })

    function fn_save_location(){
        $('#save_location_btn').on('click',function(){
            if($('#location1').val()==$('#location2').val()){
                alert('서로 다른지역을 선택해주세요');
            }else{
                $('#f').attr('action','m.insertLocation');
                $('#f').submit();
            }
        })
    }
</script>
		<h3>거래할 지역을 선택해주새요</h3>
        <form id="f">
            <input type="hidden" name="memberNo" value="${loginUser.memberNo}" >
            <select name="location1" id="location1">
                <option value="마포구">마포구</option>
                <option value="용산구">용산구</option>
                <option value="서대문구">서대문구</option>
                <option value="은평구">은평구</option>
                <option value="강서구">강서구</option>
                <option value="덕양구">덕양구</option>
            </select>
    
            <select name="location2" id="location2">
                <option value="마포구">마포구</option>
                <option value="용산구">용산구</option>
                <option value="서대문구">서대문구</option>
                <option value="은평구">은평구</option>
                <option value="강서구">강서구</option>
                <option value="덕양구">덕양구</option>
            </select>
            <input type="button" value="저장하기" id="save_location_btn">
        </form>
<jsp:include page="../layout/footer.jsp"></jsp:include>