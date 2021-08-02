<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</head>

<body>
   <div class="row mx-auto">
            <button type="button" class="btn btn-outline-primary btn-lg">메세지함</button>
    </div>
	 <c:if test="${list ne null}">
	    <div class="list-group mx-auto mt-5" style="width: 500px;">
	      <c:forEach var="chat" items="${list}">
	      <c:if test="${chat.lastMessage ne '메세지가없습니다' }">
	      <c:if test="${loginUser.memberNo eq chat.buyerNo }">
	        <a href="chatPage?memberNo=${chat.buyerNo}&sellerNo=${chat.sellerNo}&roomNumber=${chat.roomNo}&buyer=1" class="list-group-item list-group-item-action" aria-current="true">
	      </c:if>
	      <c:if test="${loginUser.memberNo eq chat.sellerNo }">
	        <a href="chatPage?memberNo=${chat.buyerNo}&sellerNo=${chat.sellerNo}&roomNumber=${chat.roomNo}&buyer=0" class="list-group-item list-group-item-action" aria-current="true">
	      </c:if>
	          <div class="d-flex w-100 justify-content-between">
	            <h5 class="mb-1">
	            	${chat.othersNickname }님과의 대화
	            </h5>
	            <span class="badge bg-primary rounded-pill">14</span>
	          </div>
	          	<p class="mb-1">${chat.lastMessage}</p>
	          <small>3일전</small>
	        </a>
	        </c:if>
	      </c:forEach> 
        </div>
     </c:if>   
</body>
</html>