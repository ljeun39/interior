<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "review.reviewDAO" %> 
<%@ page import = "review.review" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
		int revID= 0;
		if(request.getParameter("revID") != null) {
			revID = Integer.parseInt(request.getParameter("revID"));
		}
		if(revID==0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'Review.jsp'"); 
			script.println("</script>");
		}
		
		review rev = new reviewDAO().getReview(revID);
		if(!userID.equals(rev.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'Review.jsp'"); 
			script.println("</script>");
		}else{
				reviewDAO reviewDAO = new reviewDAO();
				int result = reviewDAO.delete(revID);
				if(result ==-1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제 실패')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제가 완료되었습니다.')");
					script.println("location.href = 'Review.jsp'");
					script.println("</script>");
				}
		}
	%>
<!-- 해야할 것 : mysql과 jsp 연동을 위한 mysql jdbc driver 다운로드 받기 : 4강 -->
</body> 
</html> 