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
					<form rol="form" id="createForm" action="/board/register" method="post">
						<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
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
							<input class="form-control" name="writer" value="<sec:authentication property='principal.member.userid' />" readonly="readonly" />
						</div>
						<div class="form-group text-center">
							<button id="createBtn" type="submit" class="btn btn-primary">Submit</button>
						</div>
					</form>
				</div>
			</div>
			
			<div class="card mt-3">
				<div class="card-header">
					<h3>File Attach</h3>
				</div>
				<div class="card-body">
					<div class="form-group">
						<input type="file" name="uploadFile" multiple class="form-control" />
					</div>
					<div class="row" id="attachBody">
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		var formObj = $("#createForm");
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$("#createBtn").on("click", function(e){
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
		    
		    formObj.append(str).submit();
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
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data: formData,
				type: 'POST',
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
		    
		    var uploadUL = $("#attachBody");
		    
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
					str += "data-type='image' class='btn btn-danger btn-circle ml-3'>X</button>";
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
					str += "data-type='image' class='btn btn-danger btn-circle ml-3'>X</button>";
					str += "</div>";
					str += "</div>";
				}

		    });
		    
		    uploadUL.append(str);
		  }
		
		//파일 삭제
		$("#attachBody").on("click", "button", function(e){
		    
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