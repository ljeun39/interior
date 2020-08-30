<!-- 견적 - 세부사항작성 -->
<script language="javascript">
	// 자바 스크립트 시작

	function writeCheck() {
		var form = document.writeform;

		if (!form.detNum.value) // form 에 있는 name 값이 없을 때
		{
			alert("세부ID를 적어주세요"); // 경고창 띄움
			form.deteNum.focus(); // form 에 있는 name 위치로 이동
			return;
		}

		if (!form.conNum.value) {
			alert("공사ID를 적어주세요");
			form.conNum.focus();
			return;
		}

		if (!form.conCode.value) {
			alert("공사분류를 적어주세요");
			form.title.focus();
			return;
		}

		form.submit();
	}
</script>

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
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>Bill House Interior 견적 세부사항 작성</title>
</head>
<body>
	<%
		// 로그인이 된 정보 담기
		String userID = null;
		// 세션이 존재하면 아이디값을 받아 관리
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = '../login.jsp'"); 
			script.println("</script>");	
		}
	
	%>
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
			<a class="navbar-brand" href="../main.jsp">
			<span style="font-size:15pt;font-family:naBrush; font-weight:'bolder';">Bill House Administrator</span></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		 	<ul class="nav navbar-nav">
		 		<!-- class="active"라는 것은 현재 동작하는 페이지를 나타냄 -->
		 		<li><a href="../main.jsp">메인</a></li>
		 		<li><a href="../clients.jsp">고객관리</a></li>
		 		<li><a href="../Consult.jsp">상담</a></li>
		 		<li class ="dropdown">
		 			<a href="#" class="dropdown-toggle"
		 				data-toggle="dropdown" role="button" aria-hashpop="true"
		 				aria-expanded="false">A/S<span class="caret"></span>
		 			</a>
               		<ul class="dropdown-menu">
                  		<li><a href="../freeAS.jsp">무상  A/S 내역</a>
                  		<li><a href="../ChargeAS.jsp">유상  A/S 내역</a></li>
               		</ul>
               	</li>
		 		<li class="active" class="dropdown"><a href="#" class="dropdown-toggle"
              	 	data-toggle="dropdown" role="button" aria-hashpop="true"
               		aria-expanded="false"> 견적서<span class="caret"></span>
           			</a>
               		<ul class="dropdown-menu">
                  		<li><a href="est_list.jsp">견적서 보기</a> </li>      				
               			<li><a href="est_write.jsp">견적서 작성</a></li>
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
							<li><a href="../logoutAction.jsp">로그아웃</a><li>
							<li><a href="../umain.jsp">사용자 페이지</a><li>
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
							<li><a href="../login.jsp">로그인</a><li>
							<li><a href="../umain.jsp">사용자 페이지</a><li>
						</ul>
					</li>
				</ul>	
			<%
		 	}
			%>
			
		</div> 
	 </nav>
	 
	<tr>
		<td>

			<div class="container" align="center">

				<h1>세부사항 작성</h1>
				<br> 
					<table class="table">
					<tbody>
						<form method="post" align="center" name="writeform" action="est_writeDetSuc.jsp">
				
						<tr>
							<td align="center">세부ID</td>
							<td><input name="detNum"  size="23" maxlength="20">
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center">공사ID</td>
							<td><input name="conNum" size="23" maxlength="20">
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center">공사코드</td>
							<td><input name="conCode" size="23" maxlength="20">
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center">하위분류</td>
							<td><input name="conDet" size="23" maxlength="20"></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center">규격</td>
							<td><input name="unit" size="23" maxlength="20"></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center">수량</td>
							<td><input name="amount" value="1" size="23" maxlength="20">
								<button class="disabled" data-toggle="tooltip"
									title="수량이 없을 경우 1로 저장하세요. 예)인건비" disabled>?</button></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center">단가</td>
							<td><input name="unitBudget" size="23" maxlength="20"></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align="center">금액</td>
							<td><input name="detBudget" size="23" maxlength="20"></td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
				</table>
					
						<br> <br>
				<td>
							<button class="btn btn-success pull-right" value="등록"
								OnClick="javascript:writeCheck();">등록하기</button>
							<button class="btn btn-warning pull-right" value="취소" TYPE="reset"
								OnClick="javascript:history.back(-1)">돌아가기</button> <!--중간에 warnig창 띄우기-->
			
				</td>
				</form>
					
			</div>

		</td>
	</tr>


	<!-- 애니메이션 참조 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
	<script src="../js/bootstrap.js">
		
	</script>

</body>
</html>