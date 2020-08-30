<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="consult.ConsultDAO" %>
<%@ page import="consult.Consult" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <META NAME="viewpoint" CONTENT="width=device-width", initial-scale="1">
  <link rel="stylesheet" href="../css/bootstrap.css">
  <link rel="stylesheet" href="../css/bill.css">
   <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <link href="../vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
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
		if(request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
      
	<div class="container">
<div class="content-wrapper">
    <div class="container-fluid">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <h1>상담 게시판 </h1> 
        </li>
        <li class="breadcrumb-item active"></li>
      </ol>
      
      
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-body">
          <div class="table-responsive">
        
	 		<!-- table class :홀/짝수 색상변경을 하여 보기좋게하는요소 -->
	 		<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	 			<thead>				
	 				<tr>
	 					<th style ="background-color:#eeeeee; text-align:center;">신규상담번호</th>
	 					<th style ="background-color:#eeeeee; text-align:center;">고객번호</th>
	 					<th style ="background-color:#eeeeee; text-align:center;">평수</th>
	 					<th style ="background-color:#eeeeee; text-align:center;">예산</th>
	 					<th style ="background-color:#eeeeee; text-align:center;">현장주소</th>
	 					<th style ="background-color:#eeeeee; text-align:center;">상담날짜</th>					
	 				</tr>
	 			</thead>
	 			<tbody>

	 					<%
	 						ConsultDAO consultDAO =new ConsultDAO();
	 						ArrayList<Consult> list = consultDAO.getList(pageNumber);
	 						
	 						for(int i=0;i<list.size();i++){
	 							if(list.get(i).getInteEx()==1){
	 					%>
	 					
	 			 			<tr>
	 		 					<td><%=list.get(i).getConNum()%></td>
	 		 					<td><%=list.get(i).getCliNum() %></td>
	 		 					<td><%=list.get(i).getConSize() %></td>
	 		 					<td><%=list.get(i).getBudget() %></td>
	 		 					<td><%=list.get(i).getConAddr() %></td>
	 		 					<td><a href="view.jsp?conNum=<%= list.get(i).getConNum() %>">
	 		 					<%=list.get(i).getConDate().substring(0,11)
	 		 					+list.get(i).getConDate().substring(11,13)+"시"
	 		 							+list.get(i).getConDate().substring(14,16)+"분" %></a></td>
	 		 					
	 		 				</tr>
	 		 				
	 		 			<%
	 						}}
	 					%>
	 				
	 			</tbody>
	 		</table>
	 		 			<%
	 						if(pageNumber != 1){
	 					%>
	 					
	 					<a href ="Consultlist.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-primary pull-left">이전</</a>
	  		 			<%
	 						}
	 		 				if(consultDAO.nextPage(pageNumber+1)){
	 					%>
	 					<a href ="Consultlist.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-primary pull-left">다음</</a>	 		
	 					<%
	 						}
	 					%>
	 		
	 					<a href="Consult.jsp" class="btn btn-primary pull-right">나의 상담 추가</a>
	 					<br><br><br>
	 	</div>
	 </div>	 </div>
	 </div>	 </div>
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