<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>
	<div class="container">
		<h3 class="mt-5 mb-3 text-center">
			Login
		</h3>
		<div class="row justify-content-center">
			<div class="col-12 col-md-6">
				<c:if test="${ error != null }">
					<div class="alert alert-danger mt-3">
						<c:out value="${ error }" />
					</div>
				</c:if>
				
				<c:if test="${ logout != null }">
					<div class="alert alert-danger mt-3">
						<c:out value="${ logout }" />
					</div>
				</c:if>
				<form class="mt-3" method="post" action="/login">
					<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
					<div class="form-group">
						<div class="text-primary">아이디</div>
						<input type="text" name="username" class="form-control" />
					</div>
					<div class="form-group">
						<div class="text-primary">비밀번호</div>
						<input type="password" name="password" class="form-control" />
					</div>
					<div class="form-group text-center">
						<input type="checkbox" name="remember-me" />
						<span class="mr-2">Remember</span>
						<input type="submit" class="btn btn-primary" value="로그인"  />
					</div>
				</form>
			</div>
		</div>
	</div>
<%@ include file="../includes/footer.jsp" %>