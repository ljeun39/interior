<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="clients.Clients" %>
<%@ page import="clients.ClientsDAO" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 반응형 웹 처리 , bootstrap.css 파일이용하여 디자인 처리 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
<title>Bill House Interior 관리자페이지 </title>
<title>Bill House Interior 관리자페이지 </title>
</head>
<body>
	<%
		// 로그인이 된 정보 담기
		String userID = null;
		int cliNum=0;
		// 세션이 존재하면 아이디값을 받아 관리
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		int pageNumber =1;
		if(request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
<!-- 네비게이션(웹사이트 구성을 보여주는 역할) -->
	<nav class="navbar navbar-default" style="background-color:#FFE3EE;">
		<!-- 헤더 -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 화면의 크기를 줄였을때 오른쪽 상단 메뉴 바 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">
			<span style="font-size:15pt;font-family:naBrush; font-weight:'bolder';">Bill House Administrator</span></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		 	<ul class="nav navbar-nav">
		 		<!-- class="active"라는 것은 현재 동작하는 페이지를 나타냄 -->
		 		<li><a href="main.jsp">메인</a></li>
		 		<li class="active"><a href="clients.jsp">고객관리</a></li>
		 		<li><a href="Consult.jsp">상담</a></li>
		 		<li class ="dropdown">
		 			<a href="#" class="dropdown-toggle"
		 				data-toggle="dropdown" role="button" aria-hashpop="true"
		 				aria-expanded="false">A/S<span class="caret"></span>
		 			</a>
               		<ul class="dropdown-menu">
                  		<li><a href="freeAS.jsp">무상  A/S 내역</a>
                  		<li><a href="ChargeAS.jsp">유상  A/S 내역</a></li>
               		</ul>
               	</li>
		 		<li class="dropdown"><a href="#" class="dropdown-toggle"
              	 	data-toggle="dropdown" role="button" aria-hashpop="true"
               		aria-expanded="false"> 견적서<span class="caret"></span>
           			</a>
               		<ul class="dropdown-menu">
                  		<li><a href="est/est_list.jsp">견적서 보기</a> </li>      				
               			<li><a href="est/est_write.jsp">견적서 작성</a></li>
               		</ul>
               	</li>
		 	</ul>
		 	<% 	
		 	if(userID!=null){				
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-hashpop="true"
							aria-expanded="false">접속하기<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a><li>
							<li><a href="umain.jsp">사용자 페이지</a><li>
						</ul>
					</li>
				</ul>	
			

		 	<%
		 	}else if(userID ==null){
		 	%>
		 	
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-hashpop="true"
							aria-expanded="false">접속하기<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a><li>
							<li><a href="umain.jsp">사용자 페이지</a><li>
						</ul>
					</li>
				</ul>	
			<%
		 	}
			%>
			
		</div> 
	 </nav>
	 
	 
	 
	 <!-- 고객정보 게시판  -->
	 <div class="container">
	 	<div class="content-wrapper">
    <div class="container-fluid">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <h1>고객관리 게시판 </h1> 
        </li>
        <li class="breadcrumb-item active"></li>
      </ol>
      
      
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-body">
          <div class="table-responsive">
        
	 		<form action="clients.jsp" method="post">
		 		<<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		 			<thead>				
		 				<tr>
		 					<th style ="background-color:#eeeeee; text-align:center;">고객고유번호</th>
		 					<th style ="background-color:#eeeeee; text-align:center;">고객이름</th>
		 					<th style ="background-color:#eeeeee; text-align:center;">연락처</th>
		 					<th style ="background-color:#eeeeee; text-align:center;">생년월일</th>
		 					<th style ="background-color:#eeeeee; text-align:center;">이메일</th>
		 					
		 					<th style ="background-color:#eeeeee; text-align:center;">수정</th>
		 					<th style ="background-color:#eeeeee; text-align:center;">삭제</th>			
		 				</tr>
		 			</thead>
		 			<tbody>
	
		 					<%
		 						ClientsDAO clientsDAO= new ClientsDAO();
		 						ArrayList<Clients> list = clientsDAO.getList(pageNumber);
		 						
		 						for(int i=0;i<list.size();i++){
		 							if(list.get(i).getCliEx()==1){
		 					%>
		 					
		 			 			<tr>
			 			 			
		 		 					<td><%=list.get(i).getCliNum()%></td>
		 		 					<td><%=list.get(i).getCliName()%></td>
		 		 					<td><%=list.get(i).getCliPhone()%></td>
		 		 					<td><%=list.get(i).getCliBirth()%></td>
		 		 					<td><%=list.get(i).getCliEmail()%></td>
		 		 					
		 		 					<td>
		 		 						<a href="updateClients.jsp?cliNum=<%=list.get(i).getCliNum()%>" class="btn pull-right"> 수정 </a>
			 						</td>
			 						<td>	
			 							<a onclick="return confirm('정말로 삭제하시겠습니까?')"
			 							href="clientsDeleteAction.jsp?cliNum=<%=list.get(i).getCliNum()%>" class="btn pull-right"> 삭제 </a>
		 		 					</td>
		 		 				</tr>
		 		 				
		 		 			<%
		 						}}
		 					%>
		 			</tbody>
		 		</table>
		 	</form>
 			<%
				if(pageNumber != 1){
			%>
			<a href ="clients.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-primary pull-left">이전</</a>
	 			<%
				}
 				if(clientsDAO.nextPage(pageNumber+1)){
			%>
			<a href ="clients.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-primary pull-left">다음</</a>	 		
			<%
				}
			%>

			<a href="writeClients.jsp" class="btn btn-primary pull-right">고객 추가</a>
				<%
		 		if(userID !=null){
		 		%>
			 		
		 		<%
		 		} 
		 		%>		 		
		 
	 	</div>
	 </div>	 </div>
	 </div>	 </div>
	 </div>	 
	<!-- 애니메이션 참조 -->
		<script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>   
    <script src="js/sb-admin.min.js"></script>
    <script src="js/sb-admin-datatables.min.js"></script>
</body> 
</html>