<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
	<head>
		<meta charset="UTF-8">
  		<meta http-equiv="X-UA-Compatible" content="IE=edge">
  		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<meta name="keywords" content="성준, 포트폴리오, 게시판, 스프링">
  		<meta name="description" content="성준, 포트폴리오, 게시판, 스프링">

  		<title>Board</title>
  		<!-- Bootstrap css -->
  		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  		
  		<!-- Bootstrap js -->
  		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

  		<!-- Custom fonts for this template -->
  		<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  		<!-- Custom styles for this template -->
		<link href="/resources/css/custom.css" rel="stylesheet">
	</head>
	<body>
		<!-- Header -->
		<nav class="navbar navbar-expand-lg sticky-top navbar-dark bg-dark">
			<div class="container">
  				<a class="navbar-brand" href="/board/list">SJ Board</a>
  				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    				<span class="navbar-toggler-icon"></span>
  				</button>
  			

  				<div class="collapse navbar-collapse" id="navbarSupportedContent">
    				<ul class="navbar-nav ml-auto">
    				<!-- 
      					<li class="nav-item active">
        					<a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      					</li>
      					<li class="nav-item">
        					<a class="nav-link" href="#">Link</a>
      					</li>
      					<li class="nav-item dropdown">
        					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          						Dropdown
        					</a>
        					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
          						<a class="dropdown-item" href="#">Action</a>
          						<a class="dropdown-item" href="#">Another action</a>
          						<div class="dropdown-divider"></div>
          						<a class="dropdown-item" href="#">Something else here</a>
        					</div>
      					</li>
      					<li class="nav-item">
        					<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
      					</li>
      				 -->
      				 	<sec:authorize access="isAnonymous()">
      				 		<li class="nav-item">
      				 			<a class="nav-link" href="#">Register</a>
      				 		</li>
      				 		<li class="nav-item">
      				 			<a class="nav-link" href="/customLogin">Login</a>
      				 		</li>
      				 	</sec:authorize>
      				 	
      				 	<sec:authorize access="isAuthenticated()">
      				 		<li class="nav-item">
      				 			<a class="nav-link" href="/customProfile">Profile</a>
      				 		</li>
      				 		<li class="nav-item">
      				 			<a class="nav-link" href="/customLogout">Logout</a>
      				 		</li>
      				 	</sec:authorize>
    				</ul>
  				</div>
  			</div>
		</nav>