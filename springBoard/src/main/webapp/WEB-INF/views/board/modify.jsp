<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

<sec:authentication property="principal" var="pinfo" />

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
					<form id="modifyForm" roll="form" action="/board/modify" method="post">
						<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
					
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
							<input class="form-control" name="writer" value='<c:out value="${ board.writer }" />' readonly="readonly">
						</div>
						<div class="form-group text-center">
							<sec:authorize access="isAuthenticated()">
								<c:if test="${ pinfo.member.userid eq board.writer }">
									<button type="submit" data-oper="modify" id="modifyBtn" class="btn btn-success">Modify</button>
								</c:if>
							</sec:authorize>
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
					<div class="form-group">
						<input class="form-control" type="file" name="uploadFile" multiple="multiple" />
					</div>
					<div class="row" id="attachBody"></div>
				</div>
			</div>
			
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		var bnoValue = "<c:out value='${ board.bno }' />";
		var operForm = $("#operForm");
		var attachBody = $("#attachBody");
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
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
						str += "<div class='text-center'>"
						str += "<button type='button' data-file='" + fileCallPath + "' data-type='" + attach.fileType + "' ";
						str += "class='btn btn-danger old'>X</button>";
						str += "</div>";
						str += "</div>";
					}else{
						str += "<div class='col-4 text-center li' data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType+"'>";
						str += "<div>"
						str += "<img src='/resources/img/attach.png' style='width:100px;' />";
						str += "</div>";
						str += "<div>" + attach.fileName + "</div>";
						str += "<div class='text-center'>"
						str += "<button type='button' data-file='" + fileCallPath + "' data-type='" + attach.fileType + "' ";
						str += "class='btn btn-danger old'>X</button>";
						str += "</div>";
						str += "</div>";
					}
					
					$("#attachBody").html(str);
				});
			})
		})();
		
		$("#listBtn").on("click", function(e){
			e.preventDefault();
			operForm.submit();
		});
		
		//기존 파일 삭제 버튼 눌렀을때
		attachBody.on("click", ".old", function(e){
			if(confirm("Remove this file?")){
				var targetLi = $(this).closest(".li");
				targetLi.remove();
			}
		});
		
		$("#modifyBtn").on("click", function(e){
			e.preventDefault();
			var str = "";
		    
		    $("#attachBody .li").each(function(i, obj){
		      
		      var jobj = $(obj);
		      
		      console.dir(jobj);
		      console.log("-------------------------");
		      console.log(jobj.data("filename"));
		      
		      
		      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		      
		    });
		    
		    console.log(str);
		    
		    $("#modifyForm").append(str).submit();
		});
		
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			for(var i=0; i<files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				beforeSend: function(xhr){
			    	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);  
			     },
				dataType: 'json',
				success: function(result){
					console.log(result);
					showUploadResult(result);
				}
			});
		});
		
		//파일 처리
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		//파일 보여주는 함수
		function showUploadResult(uploadResultArr){
		    
		    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
		    
		    //var uploadUL = $(".uploadResult ul");
		    
		    var str ="";
		    
		    $(uploadResultArr).each(function(i, obj){
				//console.log(obj.uploadPath);
				if(obj.image){
					var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					str += "<div class='col-4 text-center li' data-path='"+obj.uploadPath+"'";
					str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
					str +=" ><div>";
					str += "<img src='/display?fileName="+fileCallPath+"'></div>";
					str += "<div> "+ obj.fileName+"</div>";
					str += "<div>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' ";
					str += "data-type='image' class='btn btn-danger new btn-circle ml-3'>X</button>";
					str += "</div>";
					str += "</div>";
				}else{
					var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
				    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				      
					str += "<div class='col-4 text-center li' "
					str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
					str += "<img src='/resources/img/attach.png' style='width:100px;'></div>";
					str += "<div>" + obj.fileName + "</div>";
					str += "<div>"
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
					str += "data-type='image' class='btn btn-danger new btn-circle ml-3'>X</button>";
					str += "</div>";
					str += "</div>";
				}

		    });
		    
		    attachBody.append(str);
		  }
		
		//새 파일 삭제
		attachBody.on("click", ".new", function(e){
		    
		    console.log("delete file");
		      
		    var targetFile = $(this).data("file");
		    var type = $(this).data("type");
		    
		    var targetLi = $(this).closest(".li");
		    
		    $.ajax({
		      url: '/deleteFile',
		      data: {fileName: targetFile, type:type},
		      beforeSend: function(xhr){
			    	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);  
			  },
		      dataType:'text',
		      type: 'POST',
		        success: function(result){
		           alert(result);
		           
		           targetLi.remove();
		         }
		    }); //$.ajax
		 });
		
	});
</script>



<%@ include file="../includes/footer.jsp" %>