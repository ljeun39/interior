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
  <link rel="stylesheet" href="/maps/documentation/javascript/demos/demos.css">
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
	<!-- Map 위치값 밭는법 찾아보기! -->
	<div align=center>
	<br>
	<h1>안녕하세요. 빌 하우스 인테리어입니다.</h1>
	<br>
	<h3>"100% 맞춤형 인테리어"</h3>
	<br><br>
	저희 업체는 인테리어 "전문" 업체로 <br>
	최고의 기술진을 바탕으로 완벽한 시공, <br>
	그리고 "1년 무상" A/S 등 확실한 서비스를 제공하고 있습니다. <br>
	<br> <br>
	<h4>"20년" 경력의 노하우</h4>
	정확하고 꼼꼼하게 언제나 고객님의 입장에서 최선을 다할 것입니다. <br>
	 <br> 
	궁금하신 사항이 있으시면 언제든지 문의하여 주시기 바랍니다.
	<br>
	감사합니다.
	
	<br> <br>
	<h3>위치</h3>
	<style>
 	#map {
  		width: 35%;
   		height: 450px;
   		background-color: grey;
 	}
	</style>
	
  <div id="map"></div>
  <br><br>
    <script>

      function initMap() {
        var bill = {lat: 37.494898 , lng: 127.129863};

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 16,
          center: bill
        });

        var marker = new google.maps.Marker({
          position: bill,
          map: map,
          title: 'Bill House'
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCGhppPvmhip-96BWhG2-soDrosCHp6URc&callback=initMap">
    </script>
  	</div>
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
    
    <!-- 로그인 모달 -->
	<div class="row">
		<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    	  	<div class="modal-dialog">
				<div class="loginmodal-container">
					<h1>Administrator Login</h1><br>
				  <form>
					Name : <input type="text" name="user" placeholder="Username">
					PW : <input type="password" name="pass" placeholder="Password">
					<input type="submit" name="login" class="login loginmodal-submit" value="Login">
				  </form>
				</div>
			</div>
		</div>
	</div>
	<!-- 애니메이션 참조 -->
	<script src ="https://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<script src ="../js/bootstrap.js"> </script>
</body> 
</html> 