<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="java.sql.DriverManager"%>
<%
	// 페이징 관련 코드
	final int ROWSIZE = 10; // 한페이지에 보일 게시물수
	final int BLOCK = 5; // 아래에 보일 페이지 최대갯수 1~5 / 6~10 이런식으로 5개로 고정

	int pg = 1; // 기본 페이지 값

	// 첫페이지가 아니고 다른 페이지 일때 페이지값을 저장함.
	if (request.getParameter("pg") != null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}

	int start = (pg * ROWSIZE) - (ROWSIZE - 1); // 해당페이지에서 시작번호(STEP)
	int end = (pg * ROWSIZE); // 해당페이지에서 끝번호(STEP)

	int allPage = 0; // 전체 페이지수

	int startPage = ((pg - 1) / BLOCK * BLOCK) + 1; // 시작블럭숫자(1~5일경우 1, 6~10일경우 6)
	int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK; // 끝 블럭 숫자(1~5일경우 5, 6~10일경우 10)
%>
<!-- 견적 - 견적서 수정 -->
<script language="javascript">
	// 자바 스크립트 시작

	function writeCheck() {
		var form = document.writeform;

		if (!form.conNum.value) // form 에 있는 name 값이 없을 때
		{
			alert("공사ID를 적어주세요"); // 경고창 띄움
			form.conNum.focus(); // form 에 있는 name 위치로 이동
			return;
		}

		form.submit();
	}
</script>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 반응형 웹 처리 , bootstrap.css 파일이용하여 디자인 처리 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>Bill House Interior 견적서 수정</title>
</head>
<body>
	<!-- 네비게이션(웹사이트 구성을 보여주는 역할) -->
	<%
		
		
		int pageNumber =1;
		if(request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>

	<%
		// 로그인이 된 정보 담기
		String userID = null;
		// 세션이 존재하면 아이디값을 받아 관리
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
		 		<li><a href="../main.jsp">메인</a></li>
		 		<li><a href="../clients.jsp">고객관리</a></li>
		 		<li><a href="../Consult.jsp">상담</a></li>
		 		<li  class ="dropdown">
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
	<tr>
		<td>
			<div class="container" align="center">
					<h1>견적서 수정</h1>
					<%
				String dbUrl = "jdbc:mysql://localhost:3306/bill";
				Class.forName("com.mysql.jdbc.Driver");
				int conNum1 = Integer.parseInt(request.getParameter("conNum"));
				try {
					Connection conn = DriverManager.getConnection(dbUrl, "root", "bang");
					Statement stmt = conn.createStatement();
					String sql = "select * from estimate where conNum = "+conNum1;
					ResultSet rs = stmt.executeQuery(sql);

					if (rs.next()) {
						int conNum = rs.getInt(1);
						String allBudget = rs.getString(2);
						String exBudget = rs.getString(3);
						String noBudget = rs.getString(4);
						String conEx = rs.getString(5);
						String startDate = rs.getString(6);
						String finalDate = rs.getString(7);
						String aspsDate = rs.getString(8);
					

					%>

				<table class="table">
				
				<tbody>
						<form method="post" align="center" name="writeform" action="est_modify_ok.jsp">
				
							<tr>
								<td align="center">공사ID</td>
								<td><input name="conNum" size="23" maxlength="20" value="<%=conNum%>"></td>
								<td>&nbsp;</td>
							</tr>						
							<tr>
								<td align="center">공사합계</td>
								<td><input name="allBudget" size="23" maxlength="20" value="<%=allBudget%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="center">공과잡비</td>
								<td><input name="exBudget" size="23" maxlength="20" value="<%=exBudget%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="center">미납금액</td>
								<td><input name="noBudget" size="23" maxlength="20" value="<%=noBudget%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="center">금액납부여부</td>
								<td><input name="conEx" size="23" maxlength="20" value="<%=conEx%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="center">시작일</td>
								<td><input name="startDate" size="23" maxlength="20" value="<%=startDate%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="center">마감일</td>
								<td><input name="finalDate" size="23" maxlength="20" value="<%=finalDate%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td align="center">AS무상기간</td>
								<td><input name="aspsDate" size="23" maxlength="20" value="<%=aspsDate%>"></td>
								<td>&nbsp;</td>
							</tr>
						</form>
						</tbody>	<br> <br>
				</table>	
				<%
				}
				
						rs.close();
						stmt.close();
						conn.close();
					} catch (SQLException e) {
						out.print(e.toString());
					}
				%>
						
						<td align="right">
							<button class="btn btn-success pull-right" value="등록"
								OnClick="javascript:writeCheck(); ">등록하기</button>
							<button class="btn btn-warning pull-right" value="취소" TYPE="reset"
								OnClick="javascript:history.back(-1)">돌아가기</button> <!--중간에 warnig창 띄우기-->
						</td>
					</table>
					
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