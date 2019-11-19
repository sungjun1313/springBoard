<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>
	<div class="container">
		<h2 class="mt-3 text-center">
			<c:out value="${ SPRING_SECURITY_403_EXCEPTION.getMessage() }" />
		</h2>
		<h2 class="mt-3 text-center">
			<c:out value="${ msg }" />
		</h2>
	</div>
<%@ include file="../includes/footer.jsp" %>