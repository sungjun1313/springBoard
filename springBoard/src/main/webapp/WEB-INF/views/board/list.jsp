<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

<div class="container">
	<div class="row my-4">
		<div class="col-lg-12">
			<h1 class="page-header border-bottom">Tables</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-header">
					<h3 class="float-left">Board List Page</h3>
					<div class="float-right">
						<a href="/board/register" class="btn btn-dark">Register New Board</a>
					</div>
				</div>
				<div class="card-body">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ list }" var="board">
								<tr class="custom-pointer" data-href='<c:out value="${ board.bno }" />'>
									<td><c:out value="${ board.bno }" /></td>
									<td><c:out value="${ board.title }" /></td>
									<td><c:out value="${ board.writer }" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${ board.regdate }" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${ board.updateDate }" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!-- search -->
					<div class="row">
						<div class="col-lg-12">
							<form id="searchForm" class="text-center" action="/board/list" method="get">
								<select name="type" style="height:38px;">
									<option value="" <c:out value="${ pageMaker.cri.type == null ? 'selected' : '' }"/> >--</option>
									<option value="T" <c:out value="${ pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
									<option value="C" <c:out value="${ pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
									<option value="W" <c:out value="${ pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
									<option value="TC" <c:out value="${ pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목 or 내용</option>
									<option value="TW" <c:out value="${ pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목 or 작성자</option>
									<option value="TWC" <c:out value="${ pageMaker.cri.type eq 'TWC' ? 'selected' : '' }"/>>제목 or 내용 or 작성자</option>
								</select>
								<input type="text" name="keyword" style="height:38px;" value="<c:out value="${ pageMaker.cri.keyword }"/>" />
								<input type="hidden" name="pageNum" value="${ pageMaker.cri.pageNum }" />
								<input type="hidden" name="amount" value="${ pageMaker.cri.amount }" />
								<button class="btn btn-info" style="margin-top:-7px;">Search</button>
							</form>
						</div>
					</div>
					
					<!-- pagination -->
					<nav aria-label="Page navigation">
						<ul class="pagination justify-content-end">
							<c:if test="${ pageMaker.prev }">
								<li class="page-item paginate_button">
									<a href="${ pageMaker.startPage - 1 }" class="page-link">Previous</a>
								</li>
							</c:if>
							<c:forEach var="num" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }">
								<li class="page-item paginate_button ${ pageMaker.cri.pageNum == num ? 'active': '' }">
									<a href="${ num }" class="page-link">${ num }</a>
								</li>
							</c:forEach>
							<c:if test="${ pageMaker.next }">
								<li class="page-item paginate_button">
									<a href="${ pageMaker.endPage + 1 }" class="page-link">Next</a>
								</li>
							</c:if>
						</ul>
					</nav>
					<form id="actionForm" action="/board/list" method="get">
						<input type="hidden" name="pageNum" value="${ pageMaker.cri.pageNum }" />
						<input type="hidden" name="amount" value="${ pageMaker.cri.amount }" />
						<input type="hidden" name="type" value="<c:out value='${ pageMaker.cri.type }'/>" />
						<input type="hidden" name="keyword" value="<c:out value='${ pageMaker.cri.keyword }'/>" />
					</form>
					
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		var result = '<c:out value="${ result }" />';
		
		checkModal(result);
		
		history.replaceState({}, null, null);
		
		function checkModal(result){
			if(result === '' || history.state){
				return;
			}
			
			if(parseInt(result) > 0){
				$(".modal-body").html("게시글  " + parseInt(result) + " 번이 등록되었습니다.")
			}
			
			$("#myModal").modal("show");
		}
		
		var actionForm = $('#actionForm');
		var searchForm = $('#searchForm');
		
		$("tr").click(function(e){
			e.preventDefault();
			var href = $(this).data("href");
			if(href){
				actionForm.append("<input type='hidden' name='bno' value='" + href +"' />");
				actionForm.attr("action", "/board/get");
				actionForm.submit();
				//window.location = '/board/get?bno='+href;
			}
		});
		
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			//pageNum input의 value를 a tag의 href 값으로 변경
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		$("#searchForm button").on("click", function(e){
			e.preventDefault();
			if(!searchForm.find("option:selected").val()){
				
				alert("검색 종류를 선택하세요.");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				
				alert("키워드를 입력하세요.")
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			
			searchForm.submit();
		});
	});
</script>

<%@ include file="../includes/footer.jsp" %>