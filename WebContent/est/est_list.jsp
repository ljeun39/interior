<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
	src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<!-- bootstrap CSS -->
<link
	href="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet">
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
		<div class="row" align="center">
			<h1>견적서</h1>
			<br>
			<%
				String dbUrl = "jdbc:mysql://localhost:3306/bill";
				Class.forName("com.mysql.jdbc.Driver");
				try {
					Connection conn = DriverManager.getConnection(dbUrl, "root", "bang");
					Statement stmt = conn.createStatement();
					Statement stmt1 = conn.createStatement();
					String sql = "select * from estimate";

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

					out.print("총 견적서 : " + total + "개");

					String sqlList = "SELECT conNum, allBudget, exBudget, noBudget, conEx, aspsDate FROM estimate ";
					rs = stmt.executeQuery(sqlList);
			%>
			<table id="estimate" class="table table.stripted" style="text-align: center;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">공사번호
						</td>
						<th style="background-color: #eeeeee; text-align: center;">총금액
						</td>
						<th style="background-color: #eeeeee; text-align: center;">부가금액
						</td>
						<th style="background-color: #eeeeee; text-align: center;">미납금액
						</td>
						<th style="background-color: #eeeeee; text-align: center;">금액납부
						</td>
						<th style="background-color: #eeeeee; text-align: center;">무상AS기한
						</td>


					</tr>
				</thead>
				<tbody>
				<%
					if (total == 0) {
				%>
				<tr align="left" bgcolor="#FFFFFF" height="30">
					<td colspan="6">등록된 글이 없습니다.</td>
				</tr>
				<%
					} else {
							while (rs.next()) {
								String conNum = rs.getString(1);
								String allBudget = rs.getString(2);
								String exBudget = rs.getString(3);
								String noBudget = rs.getString(4);
								String conEx = rs.getString(5);
								String aspsDate = rs.getString(6);
				%>
				<tr onClick="location.href='est_listMore.jsp?conNum=<%=conNum%>'">
					<td align="center"><%=conNum%></td>
					<td align="center"><%=allBudget%></td>
					<td align="center"><%=exBudget%></td>
					<td align="center"><%=noBudget%></td>
					<td align="center"><%=conEx%></td>
					<td align="center"><%=aspsDate%></td>
				</tr>

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
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<!-- 
			<td colspan="4" height="5">
			</td>
			 -->
					<td align="center">
						<%
							if (pg > BLOCK) {
						%> [<a href="list.jsp?pg=1">◀◀</a>] [<a
						href="list.jsp?pg=<%=startPage - 1%>">◀</a>] <%
							}

							for (int i = startPage; i <= endPage; i++) {
								if (i == pg) {
						%> <u><b>[<%=i%>]
						</b></u> <%
 	} else {
 %> [<a href="list.jsp?pg=<%=i%>"><%=i%></a>] <%
 	}
 	}

 	if (endPage < allPage) {
 %> [<a href="list.jsp?pg=<%=endPage + 1%>">▶</a>] [<a
						href="list.jsp?pg=<%=allPage%>">▶▶</a>] <%
 	}
 %>

					</td>
				</tr>
				<tr align="center">
					<td><input type=button class="btn btn-primary pull-right"
						value="글쓰기" OnClick="window.location='est_write.jsp'"></td>
				</tr>
</tbody>
</table></div></div>

				<script>
					// 테이블의 Row 클릭시 값 가져오기
					$("#estimate tr").click(
							function() {

								var str = ""
								var tdArr = new Array(); // 배열 선언

								// 현재 클릭된 Row(<tr>)
								var tr = $(this);
								var td = tr.children();

								// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
								//console.log("클릭한 Row의 모든 데이터 : " + tr.text());

								// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
								//td.each(function(i) {
								//	tdArr.push(td.eq(i).text());
								//});

								//console.log("배열에 담긴 값 : " + tdArr);

								// td.eq(index)를 통해 값을 가져올 수도 있다.
								var conNUM = td.eq(0).text();
								//var userid = td.eq(1).text();
								//var name = td.eq(2).text();
								//var email = td.eq(3).text();

								/*str += " * 클릭된 Row의 td값 = No. : <font color='red'>"
										+ no + "</font>"
										+ ", 아이디 : <font color='red'>" + userid
										+ "</font>" + ", 이름 : <font color='red'>"
										+ name + "</font>"
										+ ", 이메일 : <font color='red'>" + email
										+ "</font>";
								 */
								$("#ex1_Result1").html(
										" * 클릭한 Row의 모든 데이터 = " + tr.text());
								$("#ex1_Result2").html(str);
							});
				</script>
				<!-- 애니메이션 참조 -->
				<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		
	</script>
				<script src="../js/bootstrap.js">
		
	</script>
</body>
</html>






