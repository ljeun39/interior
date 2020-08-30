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
			<a class="navbar-brand" href="../main.jsp">
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

	<div class="container">
		<form method="post">

			<h1>견적서</h1>
			<br>
			<%
				String dbUrl = "jdbc:mysql://localhost:3306/bill";
				Class.forName("com.mysql.jdbc.Driver");
				int conNum1 = Integer.parseInt(request.getParameter("conNum"));
				
				
				try {
					Connection conn = DriverManager.getConnection(dbUrl, "root", "bang");
					Statement stmt = conn.createStatement();
					Statement stmt1 = conn.createStatement();
					String sql = "select * from estimate ";

					int total = 0;
					String SQL = "select count(*) from estimate";
					ResultSet rs = stmt.executeQuery(SQL);

					if (rs.next()) {
						total = rs.getInt(1);
					}

					int sort = 1;
					String sqlSort = "SELECT conNum FROM estimate ORDER BY conNum ASC";
					rs = stmt.executeQuery(sqlSort);

					allPage = (int) Math.ceil(total / (double) ROWSIZE);

					if (endPage > allPage) {
						endPage = allPage;
					}

					
					String sqlList = "SELECT conNum, allBudget, exBudget, noBudget, conEx, startDate, finalDate, aspsDate FROM estimate where conNum="+conNum1;
					rs = stmt.executeQuery(sqlList);
			%>
			<table width="350"  id="estimate" class="table-bordered table-hover">
				<thead>
				
				<%
					if (total == 0) {
				%>
				<tr align="left" bgcolor="#FFFFFF" height="30">
					<td colspan="6">등록된 글이 없습니다.</td>
				</tr>
				<%
					} else {
							while (rs.next()) {
								int conNum = rs.getInt(1);
								String allBudget = rs.getString(2);
								String exBudget = rs.getString(3);
								String noBudget = rs.getString(4);
								String conEx = rs.getString(5);
								String startDate = rs.getString(6);
								String finalDate = rs.getString(7);
								String aspsDate = rs.getString(8);
				%>
					<tbody>
							
							<tr bgcolor=beige>
								<td>공사ID</td>
								<td align="center"><%=conNum%></td>
							</tr>
							<tr>
								<td>공사합계</td>
								<td align="center"><%=allBudget%></td>
							</tr>
							<tr>
								<td>공과잡비</td>
								<td align="center"><%=exBudget%></td>
							</tr>
							<tr>
								<td>미납금액</td>
								<td align="center"><%=noBudget%></td>
					
							</tr>
							<tr>
								<td>금액납부여부</td>
								<td align="center"><%=conEx%></td>
							</tr>
							<tr>
								<td>시작일</td>
								<td align="center"><%=startDate%></td>
							</tr>
							<tr>
								<td>마감일</td>
								<td align="center"><%=finalDate%></td>
							</tr>
							<tr>
								<td>AS무상기간</td>
								<td align="center"><%=aspsDate%></td>
							</tr>
						</tbody>
<%
					}
						}
						rs.close();
						stmt.close();
						conn.close();
					} catch (SQLException e) {
						out.print(e.toString());
					}
				%>
				</table>
			<tr align="right">
						<td width="0">&nbsp;</td>
						<td colspan="2" width="399">
							<input type=button class="btn btn-primary pull-right" value="견적서 작성" Onclick="window.location='est_write.jsp'">
							<input type=button class="btn btn-primary pull-right" value="견적사항 추가" Onclick="window.location='est_writeDetail.jsp'">
							<input type=button class="btn btn-primary pull-right" value="수정하기" Onclick="window.location='est_modify.jsp?conNum=<%=conNum1%>'">
							
						<td width="0">&nbsp;</td>
					</tr>
		</form>
		
		
		<form method="post">
<br>
			<h1>견적세부사항</h1>
	<br>		<br>
			<%
				String Url = "jdbc:mysql://localhost:3306/bill";
				Class.forName("com.mysql.jdbc.Driver");
				try {
					Connection conn = DriverManager.getConnection(dbUrl, "root", "bang");
					Statement stmt = conn.createStatement();
					Statement stmt1 = conn.createStatement();
					String sql = "select * from estimatedet";

					int total = 0;
					String SQL = "select count(*) from estimatedet";
					ResultSet rs = stmt.executeQuery(SQL);

					if (rs.next()) {
						total = rs.getInt(1);
					}

					int sort = 1;
					String sqlSort = "SELECT conNum FROM estimatedet ORDER BY conNum ASC";
					rs = stmt.executeQuery(sqlSort);

					allPage = (int) Math.ceil(total / (double) ROWSIZE);

					if (endPage > allPage) {
						endPage = allPage;
					}

				//	out.print("세부견적 : " + total + "개");

					String sqlList = "SELECT detNum, conNum, conCode, conDet, unit, amount, unitBudget, detBudget FROM estimatedet  where conNum="+conNum1;
					rs = stmt.executeQuery(sqlList);
			%>
			<table width="350"  id="estimatedet" class="table-bordered table-hover">
				<thead>
				
				<%
					if (total == 0) {
				%>
				<tr align="left" bgcolor="#FFFFFF" height="30">
					<td colspan="6">등록된 글이 없습니다.</td>
				</tr>
				<%
					} else {
							while (rs.next()) {
								int detNum = rs.getInt(1);
								String conNum = rs.getString(2);
								String conCode = rs.getString(3);
								String conDet = rs.getString(4);
								String unit = rs.getString(5);
								String amount = rs.getString(6);
								String unitBudget = rs.getString(7);
								String detBudget = rs.getString(8);
				%>
					<tbody>
							<tr bgcolor="beige">
								<td>세부ID</td>
								<td align="center"><%=detNum%></td>
							</tr>
							<tr>
								<td>공사ID</td>
								<td align="center"><%=conNum%></td>
							</tr>
							<tr>
								<td>공사코드</td>
								<td align="center"><%=conCode%></td>
							</tr>
							<tr>
								<td>하위분류</td>
								<td align="center"><%=conDet%></td>
							</tr>
							<tr>
								<td>규격</td>
								<td align="center"><%=unit%></td>
					
							</tr>
							<tr>
								<td>수량</td>
								<td align="center"><%=amount%></td>
							</tr>
							<tr>
								<td>단가</td>
								<td align="center"><%=unitBudget%></td>
							</tr>
							<tr>
								<td>금액</td>
								<td align="center"><%=detBudget%></td>
							</tr>
						</tbody>
<%
					}
						}
						rs.close();
						stmt.close();
						conn.close();
					} catch (SQLException e) {
						out.print(e.toString());
					}
				%>

			</table>
</form>

	</div>

		
	<!-- 애니메이션 참조 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
	<script src="../js/bootstrap.js">
		
	</script>
</body>
</html>




