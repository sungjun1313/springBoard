<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row my-4">
		<div class="col-lg-12">
			<h1 class="page-header">Board Read Page</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-header">
					<h3>Board Read Page</h3>
				</div>
				<div class="card-body">
					<form roll="form" action="/board/modify" method="post">
						<input type="hidden" name="bno" value='<c:out value="${ board.bno }" />' >
						<input type="hidden" name="pageNum" value="<c:out value='${ cri.pageNum }' />" />
						<input type="hidden" name="amount" value="<c:out value='${ cri.amount }' />" />
						<input type="hidden" name="type" value="<c:out value='${ cri.type }' />" />
						<input type="hidden" name="keyword" value="<c:out value='${ cri.keyword }' />" />
						<div class="form-group">
							<label>Title</label>
							<input class="form-control" name="title" value='<c:out value="${ board.title }" />'>
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea class="form-control" rows="3" name="content"><c:out value="${ board.content }" /></textarea>
						</div>
						<div class="form-group">
							<label>Writer</label>
							<input class="form-control" name="writer" value='<c:out value="${ board.writer }" />'>
						</div>
						<div class="form-group text-center">
							<button type="submit" data-oper="modify" class="btn btn-success">Modify</button>
							
							<a href="/board/list" id="listBtn" class="btn btn-primary">List</a>
						</div>
					</form>
					<form id="operForm" action="/board/list" method="get">
						<input type="hidden" name="pageNum" value="<c:out value='${ cri.pageNum }' />" />
						<input type="hidden" name="amount" value="<c:out value='${ cri.amount }' />" />
						<input type="hidden" name="type" value="<c:out value='${ cri.type }' />" />
						<input type="hidden" name="keyword" value="<c:out value='${ cri.keyword }' />" />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		var operForm = $("#operForm")
		
		$("#listBtn").on("click", function(e){
			e.preventDefault();
			operForm.submit();
		});
		
	});
</script>



<%@ include file="../includes/footer.jsp" %>