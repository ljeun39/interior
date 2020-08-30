<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "review.reviewDAO" %> 
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="review" class="review.review" scope="page" />
<jsp:setProperty name="review" property="revTitle" />
<jsp:setProperty name="review" property="revContent" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bill House Interior 관리자페이지</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		} 
		if(userID ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");			
		}
		else{
			if(review.getRevTitle()==null || review.getRevContent()==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");	
			} else	{
				reviewDAO reviewDAO = new reviewDAO();
				int result = reviewDAO.write(review.getRevTitle(),userID,review.getRevContent());
				if(result ==-1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기 실패')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('게시가 완료되었습니다.')");
					script.println("location.href = 'Review.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
<!-- 해야할 것 : mysql과 jsp 연동을 위한 mysql jdbc driver 다운로드 받기 : 4강 -->
</body> 
</html> 