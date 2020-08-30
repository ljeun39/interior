<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 반응형 웹 처리 , bootstrap.css 파일이용하여 디자인 처리 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- jQuery  -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- bootstrap JS -->
<script
	src = "https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<!-- bootstrap CSS -->
<link href="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">

<title>Bill House Interior 견적서 모아보기</title>
</head>
<body>
		<%
		// 로그인이 된 정보 담기
		String userID = null;
		// 세션이 존재하면 아이디값을 받아 관리
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
<!--   네비게이션바     -->
 	<nav class="navbar navbar-default">
 		<div class="container-fluid">
 			<div class="navbar-header">
 				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
 					data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
 					<span class="sr-only"></span>
 					<span class="icon-bar"></span>
 					<span class="icon-bar"></span>
 					<span class="icon-bar"></span>
 				</button>
 				<a class="navbar-brand" href="../User/index.jsp">Bill House Interior</a>
 			</div>

 			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
 				<ul class="nav navbar-nav">	
     				<li><a href="../User/introduce.jsp">About Bill</a></li>
 					<li class="action"><a href="../User/Review.jsp">Gallery</a></li>
 					<li class="dropdown"><a href="#" class="dropdown-toggle"
              	 	data-toggle="dropdown" role="button" aria-hashpop="true"
               		aria-expanded="false"> 상담 <span class="caret"></span>
           			</a>
               		<ul class="dropdown-menu">
                  		<li><a href="../User/Consult.jsp">상담 신청</a>
                  		<li><a href="../User/Consultlist.jsp">상담 현황</a></li>
               		</ul></li>
 				</ul>
 			<% 	
		 	if(userID!=null){				
			%>
 				<ul class="nav navbar-nav navbar-right">
 					<li class="dropdown">
 						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
 							aria-expanded="false" aria-haspopup="true" >관리자<span class="caret"></span></a>
 						<ul class="dropdown-menu">
	 						<li><a data-target="#login-modal" data-toggle="modal">로그아웃</a></li>
	 						<li><a href="../main.jsp">관리자 페이지</a><li>
 						</ul>				
 					</li>
 				</ul>
 			<%
		 	}else if(userID ==null){
		 	%>
		 		<ul class="nav navbar-nav navbar-right">
 					<li class="dropdown">
 						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
 							aria-expanded="false" aria-haspopup="true" >관리자<span class="caret"></span></a>
 						<ul class="dropdown-menu">
	 						<li><a data-target="#login-modal" data-toggle="modal">관리자 로그인</a></li>
 						</ul>				
 					</li>
 				</ul>
 			<%
		 	}
			%>
 			</div>
 		</div>
	</nav>

	<div class="container">

			<h1>후기</h1>
	</div>
		
	<!-- 애니메이션 참조 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
	<script src="../js/bootstrap.js">
		
	</script>
</body>
</html>


