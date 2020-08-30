<!-- 사용자-메인 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <META NAME="viewpoint" CONTENT="width=device-width", initial-scale="1">
  <link rel="stylesheet" href="../css/bootstrap.css">
  <link rel="stylesheet" href="../css/bill.css">
  <TITLE>Bill House Interior</TITLE>
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
	 						<li><a href="../User/logoutAction.jsp">로그아웃</a></li>
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
	 						<li><a href="../User/login.jsp">관리자 로그인</a></li>
 						</ul>				
 					</li>
 				</ul>
 			<%
		 	}
			%>
 			</div>
 		</div>
	</nav>
      
	 	<style type="text/css";>
 	  .jumbotron{
 	  	background-image: url('../img/6.gif');
 	  	background-size:cover;
 	  	text-shadow: blue 0.2em 0.2em 0.2em;
 	  	color:white;
 	  }
 	</style>
 	
 	<!--   점보트론     -->
	
	<div class="container-fluid">
		<div class="jumbotron">
			<h1 class="text-center" style="font-size:60;">Bill House Interior </h1><br>
			<h4 class="text-center">빌 하우스 인테리어</h4><br><br><br>
			<p class="text-center"> 25년 꾸준한 사랑을 받아온 인테리어 전문회사</p><br><br>		
			<p class="text-center "><a class="btn btn-default" href="Consult.jsp">견적 상담 신청하기</a></p><br><br><br><br><br><br><br>
		</div>
	</div>
	
	
		<hr>
  <div class="container">
 <!-- Portfolio -->
 <div class="wrapper">
  <div class="column">
    <div class="inner" ></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
  <div class="column">
    <div class="inner"></div>
  </div>
</div>
</div>

<br><br><br><br>
	 <!--   footer     -->
    <footer style="background-color: black; color:white;">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 text-center COLSPAN=5 ALIGN=center">
                    <br>
                    <h2><strong> Bill House Interior </strong>
                    </h2>
                    <p>서울시 송파구 가락동 <br> 140 쌍용프라자 내 위치 </p>
                    <ul class="list-unstyled">
                        <li><i class="fa fa-phone fa-fw"></i> 02 ) 407 - 0054</li>
                        
                        <li><i class="fa fa-phone fa-fw"></i> 010 - 7673 - 0054 </li>
                        <li><i class="fa fa-envelope-o fa-fw"></i>  
                        <a href="mailto:lim9990@naver.com">lim9990@naver.com</a><br>
                        <a href="http://blog.naver.com/lim9990/220147386195"> http://blog.naver.com/lim9990/</a></p>                      
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
    
	<!-- 애니메이션 참조 -->
	<script src ="https://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<script src ="../js/bootstrap.js"> </script>
</body> 
</html> 