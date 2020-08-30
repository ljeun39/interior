<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "review.review" %>
<%@ page import = "review.reviewDAO" %>
<%@ page import = "java.util.ArrayList" %>
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
		
		int pageNumber =1;
		if(request.getParameter("pageNumber") !=null) {
			pageNumber= Integer.parseInt(request.getParameter("pageNumber"));
			
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
	 <!-- 화면 구성 -->
<div class="container" >

  <h1>대표 후기</h1><br><br>
	 	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" height="300">
 	<!-- Indicators -->
 	<ol class="carousel-indicators">
    	<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    	<li data-target="#carousel-example-generic" data-slide-to="1"></li>
    	<li data-target="#carousel-example-generic" data-slide-to="2"></li>
  	</ol>

  	<!-- Wrapper for slides -->
  	<div class="carousel-inner" role="listbox">
    	<div class="item active">
      		<img src="a.gif" alt="벽난로가 포함된 거실">
      	<div class="carousel-caption">
       	 ...
     	 </div>
    	</div>
    	<div class="item">
   		<img src="a.gif" alt="벽난로가 포함된 거실">
      	<div class="carousel-caption">
       	 ...
     	</div>
    	</div>
    		...
  	</div>

  	<!-- Controls -->
  
  	<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
   	 	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    	<span class="sr-only">Previous</span>
  	</a>
  	<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    	<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    	<span class="sr-only">Next</span>
  	</a>
		</div>
      </div>  
       <br><br> 
  
	<div class="container">
	<h1>후기 목록</h1><br><br>
		<div class="row">
			<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">번호</th>
						<th style="background-color:#eeeeee; text-align:center;">제목</th>
						<th style="background-color:#eeeeee; text-align:center;">작성자</th>
						<th style="background-color:#eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					reviewDAO reviewDAO = new reviewDAO();
					ArrayList<review> list = reviewDAO.getList(pageNumber);
					for(int i=0;i < list.size(); i ++){
				%>
					<tr>
						<td><%= list.get(i).getRevID() %></td>
						<td><a href="revView.jsp?revID=<%= list.get(i).getRevID() %>"><%= list.get(i).getRevTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getRevDate().substring(0, 11) + list.get(i).getRevDate().substring(11, 13) + "시" +list.get(i).getRevDate().substring(14, 16) + "분" %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="Review.jsp?pageNumber=<%= pageNumber -1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(reviewDAO.nextPage(pageNumber+1)) {
			%>
				<a href="Review.jsp?pageNumber=<%= pageNumber +1 %>" class="btn btn-success btn-arrow-right">다음</a>
			<%
				}
			%>
			<a href="revWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	 </div>	
	 <br>
	 <br>
	 
	 <!--   footer     -->
    <footer style="background-color: black; color:white; widht:100%">
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