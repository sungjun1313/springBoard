<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>
	<div class="container">
		<h4 class="my-3">
			<c:out value="${ exception.getMessage() }"></c:out>
		</h4>
		<ul>
			<c:forEach items="${ exception.getStackTrace() }" var="stack">
				<li>
					<c:out value="${ stack }"></c:out>
				</li>
			</c:forEach>
		</ul>
	</div>
<%@ include file="../includes/footer.jsp" %>