<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row my-4">
		<div class="col-lg-12">
			<h1 class="page-header">Board Register</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-header">
					<h3>Board Register</h3>
				</div>
				<div class="card-body">
					<form rol="form" action="/board/register" method="post">
						<div class="form-group">
							<label>Title</label>
							<input class="form-control" name="title" />
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea class="form-control" rows="3" name="content"></textarea>
						</div>
						<div class="form-group">
							<label>Writer</label>
							<input class="form-control" name="writer" />
						</div>
						<div class="form-group text-center">
							<button type="submit" class="btn btn-primary">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>