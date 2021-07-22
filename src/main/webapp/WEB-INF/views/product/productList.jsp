<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp"></jsp:include>

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
	
<jsp:include page="../layout/footer.jsp"></jsp:include>


