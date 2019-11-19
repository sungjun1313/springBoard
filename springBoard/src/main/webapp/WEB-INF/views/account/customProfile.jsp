<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>
	
	<div class="container">
		<h3 class="mt-5 mb-3 text-center">Profile</h3>
		<div class="row justify-content-center">
			<div class="col-12 col-md-6">
				<div>
					<div class="row mt-2">
						<div class="col-4">principal</div>
						<div class="col-8">
							<sec:authentication property="principal" />
						</div>
					</div>
				</div>
				<div>
					<div class="row mt-2">
						<div class="col-4">MemberVO</div>
						<div class="col-8">
							<sec:authentication property="principal.member" />
						</div>
					</div>
				</div>
				<div>
					<div class="row mt-2">
						<div class="col-4">사용자 이름</div>
						<div class="col-8">
							<sec:authentication property="principal.member.userName" />
						</div>
					</div>
				</div>
				<div>
					<div class="row mt-2">
						<div class="col-4">사용자 아이디</div>
						<div class="col-8">
							<sec:authentication property="principal.member.userid" />
						</div>
					</div>
				</div>
				<div>
					<div class="row mt-2">
						<div class="col-4">사용자 권한 리스트</div>
						<div class="col-8">
							<sec:authentication property="principal.member.authList" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<%@ include file="../includes/footer.jsp" %>