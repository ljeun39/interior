<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="AS.FreeAS"%>
<%@ page import="AS.FreeASDAO" %>
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
	if(session.getAttribute("userID") !=null){
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
		script.println("location.href = 'freeAS.jsp'");
		script.println("</script>");			
	} 
	FreeAS freeAS= new FreeASDAO().getFreeAS(asNum);
	
	if(userID==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = 'login.jsp'"); 
		script.println("</script>");	
	}
	
		else{	
			
			if( request.getParameter("asNum")==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");	
			} else	{
				FreeASDAO freeASDAO = new FreeASDAO();
				int result =freeASDAO.update(Integer.parseInt(request.getParameter("conNum")) ,request.getParameter("asDetail"),asNum);
				if(result ==-1){	
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기 실패.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('수정이 완료되었습니다.')");
					script.println("location.href = 'freeAS.jsp'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body> 
</html> 