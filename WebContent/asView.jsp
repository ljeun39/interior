<%@page import="org.apache.catalina.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="AS.ChargeAS" %>
<%@ page import="AS.ChargeASDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 반응형 웹 처리 , bootstrap.css 파일이용하여 디자인 처리 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Bill House Interior 관리자페이지 </title>
</head>
<body>
	<%
		// 로그인이 된 정보 담기
		String userID = null;
		// 세션이 존재하면 아이디값을 받아 관리
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int asNum=0;
		if(request.getParameter("asNum") !=null){
			asNum = Integer.parseInt(request.getParameter("asNum"));
		}
		if(asNum==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'ChargeAS.jsp'");
			script.println("</script>");			
		} 
		ChargeAS chargeAS = new ChargeASDAO().getChargeAS(asNum);
		
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
		 		<li><a href="clients.jsp">고객관리</a></li>
		 		<li class="active"><a href="Consult.jsp">상담</a></li>
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
	 
	 
	 
	 <!-- 게시판  -->
	 <div class="container">
	 	<div class = "col-lg-4"></div>
		 <div class="jumbotron">
		 	<div class="row" align="center">
		 		<h1 >상세 사항</h1>
		 		<br>
		 		<table class="table table.stripted" style="text-align:center;bord:3px solid #dddddd " >
		 			<thead>				
		 				<tr>
		 					<th colspan="2" style ="background-color:#eeeeee; text-align:center;">상담 내역 상세보기</th>
		 					
		 				</tr>
		 			</thead>
		 			<tbody>
		 				<tr>
		 					<td style ="width:20%;">글번호</td>
		 					<td colspan="2"><%=asNum%></td>
		 				</tr>
		 				<tr>
		 					<td style ="width:20%;">상담일자</td>
		 					<td colspan="2"><%=chargeAS.getAsDate()%></td>
		 				</tr>
		 				<tr>
		 					<td>고객번호</td>
		 					<td colspan="2"><%=chargeAS.getConNum()%></td>
		 				</tr>
		 				<tr>
		 					<td>예산</td>
		 					<td colspan="2"><%=chargeAS.getAsBudget()%></td>
		 				</tr>
		 				<tr>
		 					<td>상담내역</td>
		 					<td colspan="2" style="min-height:200px; text-align:left;"><%=chargeAS.getAsDetail().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll("<","&gt;").replaceAll("\n","<br>;")%></td>  
		 				</tr>
		 				
		 			</tbody>
		 			
		 		</table>
		 		<a href="Consult.jsp" class="btn btn-primary pull-left">목록 보기</a>
		 		<%
		 		if(userID !=null){
		 		%>
			 		<a href="update.jsp?asNUm=<%=asNum %>" class="btn btn-primary pull-right"> 수정하기 </a>
			 		<a onclick="return confirm('정말로 삭제하시겠습니까?')"href="deleteAction.jsp?asNum=<%=asNum%>" class="btn btn-primary pull-right"> 삭제하기 </a>
		 		<%
		 		} 
		 		%>
		 		</div>
		 	</div>
	 	</div>

	<!-- 애니메이션 참조 -->
	<script src ="https://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<script src ="js/bootstrap.js"> </script>
</body> 
</html> 