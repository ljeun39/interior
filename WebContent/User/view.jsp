<%@page import="org.apache.catalina.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="consult.Consult" %>
<%@ page import="consult.ConsultDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 반응형 웹 처리 , bootstrap.css 파일이용하여 디자인 처리 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
 <META NAME="viewpoint" CONTENT="width=device-width", initial-scale="1">
  <link rel="stylesheet" href="../css/bootstrap.css">

<link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="../vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
<title>Bill House Interior 관리자페이지 </title>
</head>
<body>
	<%

		int conNum=0;
		if(request.getParameter("conNum") !=null){
			conNum = Integer.parseInt(request.getParameter("conNum"));
		}
		if(conNum==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'Consultlist.jsp'");
			script.println("</script>");			
		} 
		Consult consult = new ConsultDAO().getConsult(conNum);
		
	%><!--   네비게이션바     -->
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

 				<ul class="nav navbar-nav navbar-right">
 					<li class="dropdown">
 						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
 							aria-expanded="false" aria-haspopup="true" >관리자<span class="caret"></span></a>
 						<ul class="dropdown-menu">
	 						
	 						<li><a href="../main.jsp">관리자 페이지</a><li>
 						</ul>				
 					</li>
 				</ul>
 			
 			</div>
 		</div>
	</nav>
		
	 
	 <!-- 게시판  -->
	 <div class="container">
	 	<div class = "col-lg-4"></div>
		 <div class="jumbotron">
		 	<div class="row" align="center">
		 		<h1 >상담게시판</h1>
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
		 					<td colspan="2"><%=consult.getConNum()%></td>
		 				</tr>
		 				<tr>
		 					<td style ="width:20%;">고객번호</td>
		 					<td colspan="2"><%=consult.getCliNum()%></td>
		 				</tr>
		 				<tr>
		 					<td>평수</td>
		 					<td colspan="2"><%=consult.getConSize()%></td>
		 				</tr>
		 				<tr>
		 					<td>예산</td>
		 					<td colspan="2"><%=consult.getBudget()%></td>
		 				</tr>
		 				<tr>
		 					<td>주소지</td>
		 					<td colspan="2"><%=consult.getConAddr()%></td>
		 				</tr>
		 				<tr>
		 					<td>상담신청일</td>
		 					<td colspan="2"><%=consult.getConDate()%></td>
		 				</tr>
		 				<tr>
		 					<td>상담내역</td>
		 					<td colspan="2" style="min-height:200px; text-align:left;"><%=consult.getContents().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll("<","&gt;").replaceAll("\n","<br>;")%></td>  
		 				</tr>
		 				<tr>
		 					<td>공사확정여부</td>
		 					<td colspan="2"><%=consult.getInteEx()%></td>
		 				</tr>
		 				
		 			</tbody>
		 			
		 		</table>
		 		<a href="Consultlist.jsp" class="btn btn-primary pull-left">목록 보기</a>
		 		
		 		</div>
		 	</div>
	 	</div>

	<!-- 애니메이션 참조 -->
	<script src="../vendor/jquery/jquery.min.js"></script>
    <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="../vendor/datatables/jquery.dataTables.js"></script>
    <script src="../vendor/datatables/dataTables.bootstrap4.js"></script>   
    <script src="../js/sb-admin.min.js"></script>
    <script src="../js/sb-admin-datatables.min.js"></script>	
</body> 
</html> 