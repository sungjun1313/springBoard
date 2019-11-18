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
					<form id="deleteForm" roll="form" action="/board/remove?bno=<c:out value='${ board.bno }' />" method="post">
						<input type="hidden" name="bno" value='<c:out value="${ board.bno }" />' >
						<input type="hidden" name="pageNum" value="<c:out value='${ cri.pageNum }' />" />
						<input type="hidden" name="amount" value="<c:out value='${ cri.amount }' />" />
						<input type="hidden" name="type" value="<c:out value='${ cri.type }' />" />
						<input type="hidden" name="keyword" value="<c:out value='${ cri.keyword }' />" />
						<div class="form-group">
							<label>Title</label>
							<input class="form-control" name="title" value='<c:out value="${ board.title }" />' readonly="readonly">
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${ board.content }" /></textarea>
						</div>
						<div class="form-group">
							<label>Writer</label>
							<input class="form-control" name="writer" value='<c:out value="${ board.writer }" />' readonly="readonly" >
						</div>
						<div class="form-group text-center">
							<a href="/board/modify?bno=<c:out value='${ board.bno }' /> " id="modifyBtn" class="btn btn-info mr-2">Modify</a>
							<button type="submit" class="btn btn-danger mr-2">Remove</button>
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
			
			<div class="card mt-4">
				<div class="card-header">
					<h4>Files</h4>
				</div>
				<div class="card-body">
					<div class="row" id="attachBody"></div>
				</div>
			</div>
			
			<div class="card mt-4">
				<div class="card-header">
					<h4 class="float-left">Reply</h4>
					<div class="float-right">
						<button class="btn btn-dark" id="addReplyBtn">New Reply</button>
					</div>
				</div>
				<div class="card-body" id="reply-body">
					<!-- 
					<div class="my-2" data-rno="9">
						<div class="d-flex justify-content-between">
							<div class="font-weight-bold text-primary">User00</div>
							<div class="text-muted">2018-01-01 13:13</div>
						</div>
						<div>
							Good
						</div>
					</div>
					 -->
					 
				</div>
				<div id="reply-paging" class="card-footer text-muted"></div>
			</div>
			
		</div>
	</div>
</div>

<!-- Modal 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label>
					<input type="text" class="form-control" name="reply" placeholder="New Reply" />
				</div>
				<div class="form-group">
					<label>Replyer</label>
					<input type="text" class="form-control" name="replyer" placeholder="Replyer" />
				</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input type="text" class="form-control" name="replyDate" placeholder="Reply Date" readOnly />
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="modalModBtn" class="btn btn-warning">Modify</button>
				<button type="button" id="modalRemoveBtn" class="btn btn-danger">Remove</button>
				<button type="button" id="modalRegisterBtn" class="btn btn-primary">Register</button>
				<button type="button" id="modalCloseBtn" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script src="/resources/js/reply.js"></script>

<script>
	$(document).ready(function(){
		//reply.js 모듈 사용
		var bnoValue = "<c:out value='${ board.bno }' />";
		var replyUL = $("#reply-body");
		var replyPageFooter = $("#reply-paging");
		var pageNum = 1;
		
		showList(1);
		
		//for replyService add test
		/*
		replyService.add(
			{reply:"JS Test", replyer:"tester", bno:bnoValue},
			function(result){
				alert("RESULT " + result);
			}
		);
		*/
		
		//for replyService getList test
		/*
		replyService.getList(
			{bno:bnoValue, page:1},
			function(list){
				for(var i=0, len = list.length||0; i<len; i++){
					console.log(list[i]);
				}
			}
		);
		*/
		
		//for replyService update test
		/*
		replyService.update(
			{rno:9, bno:bnoValue, reply: "JS Test Modify"},
			function(result){
				alert("수정 완료");
			}
		);
		*/
		
		//for replyService get test
		/*
		replyService.get(9, function(data){console.log(data);});
		*/
		
		//for replyService remove test
		/*
		replyService.remove(9,
			function(count){
				console.log(count);
				if(count === 'success'){
					alert("REMOVED");
				}
			},
			function(err){
				alert("Error...");
			}
		);
		*/
		
		//attach 불러오기
		(function(){
			$.getJSON("/board/getAttachList", {bno: bnoValue}, function(arr){
				var str = "";
				
				$(arr).each(function(i, attach){
					
					//image type
					if(attach.fileType){
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						str += "<div class='col-4 text-center li' data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType+"'>";
						str += "<div>"
						str += "<img src='/display?fileName=" + fileCallPath + "' />";
						str += "</div>";
						str += "<div>" + attach.fileName + "</div>";
						str += "</div>";
					}else{
						str += "<div class='col-4 text-center li' data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType+"'>";
						str += "<div>"
						str += "<img src='/resources/img/attach.png' style='width:100px;' />";
						str += "</div>";
						str += "<div>" + attach.fileName + "</div>";
						str += "</div>";
					}
					
					$("#attachBody").html(str);
				});
			})
		})();
		
		//attach file click
		$("#attachBody").on("click", ".li", function(e){
			var liObj = $(this);
			var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
			//console.log(path);
			//return false;
			if(liObj.data("type")){
				self.location = "/display?fileName=" + path;
			}else{
				self.location = "/download?fileName=" + path;
			}
		});
		
		//댓글 리스트 불러오기 함수 정의
		function showList(page){
			replyService.getList(
				{bno:bnoValue, page:page||1},
				function(replyCnt, list){
					
					if(page == -1){
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}
					
					var str = "";
					if(list == null || list.length == 0){
						replyUL.html("");
						return;
					}
					
					for(var i=0, len=list.length || 0; i<len; i++){
						str +=	"<div class='my-2 py-2 border-bottom chat' data-rno='" + list[i].rno + "'>";
						str +=		"<div class='d-flex justify-content-between'>";
						str +=			"<div class='font-weight-bold text-primary'>" + list[i].replyer +"</div>";
						str +=			"<div class='text-muted'>" + replyService.displayTime(list[i].replyDate) + "</div>";
						str += 		"</div>";
						str +=		"<div>" + list[i].reply + "</div>";
						str +=	"</div>";
					}
					replyUL.html(str);
					showReplyPage(replyCnt);
				}
			);
		}
		
		//modal element
		var modal = $("#myModal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		//reply register
		$("#addReplyBtn").on("click",function(){
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalRegisterBtn.show();
			
			modal.modal("show");
		});
		
		modalRegisterBtn.on("click", function(){
			var inputReply = modalInputReply.val();
			var inputReplyer = modalInputReplyer.val();
			if(!inputReply){
				alert("댓글이 적어주세요.");
				return false;
			}
			
			if(!inputReplyer){
				alert("작성자 이름을 적어주세요.");
				return false;
			}
			
			var reply = {reply:inputReply, replyer:inputReplyer, bno:bnoValue};
			replyService.add(reply, function(result){
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				
				pageNum = 1;
				showList(pageNum);
			});
			
		});
		
		//reply click
		replyUL.on("click", ".chat", function(e){
			var rno = $(this).data("rno");
			replyService.get(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate));
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalInputReplyDate.closest("div").show();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				modal.modal("show");
				//console.log(modal.data("rno"));
			});
		});
		
		//reply modify
		modalModBtn.on("click", function(e){
			var rno = modal.data("rno");
			var inputReply = modalInputReply.val();
			var inputReplyer = modalInputReplyer.val();
			if(!inputReply){
				alert("댓글이 적어주세요.");
				return false;
			}
			
			if(!inputReplyer){
				alert("작성자 이름을 적어주세요.");
				return false;
			}
			
			var reply = {rno:rno, reply:inputReply};
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		//reply remove
		modalRemoveBtn.on("click",function(e){
			var rno = modal.data("rno");
			replyService.remove(rno, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		//reply pagination
		function showReplyPage(replyCnt){
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt / 10.0);
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			var str = "<nav aria-label='Page navigation'>";
			str += "<ul class='pagination justify-content-end'>";
			
			if(prev){
				str += "<li class='page-item'><a class='page-link' href='" + (startNum-1) + "'>Previouse</a></li>";
			}
			
			for(var i=startNum; i<=endNum; i++){
				var active = pageNum == i ? "active":"";
				str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'><a class='page-link' href='" + (endNum+1) + "'>Next</a></li>";
			}
			
			str += "</ul></nav>";
			replyPageFooter.html(str);
		}
		
		//page button click
		replyPageFooter.on("click", "nav ul li a", function(e){
			e.preventDefault();
			var targetPageNum = $(this).attr("href");
			pageNum = targetPageNum;
			showList(pageNum);
		});
		
		
	});
</script>

<script>
	$(document).ready(function(){
		var operForm = $("#operForm")
		
		$("#listBtn").on("click", function(e){
			e.preventDefault();
			operForm.submit();
		});
		
		$("#modifyBtn").on("click", function(e){
			e.preventDefault();
			operForm.append("<input type='hidden' name='bno' value='"+<c:out value='${board.bno}' /> + "' />");
			operForm.attr("action", "/board/modify");
			operForm.submit();
		});
	});
</script>

<%@ include file="../includes/footer.jsp" %>