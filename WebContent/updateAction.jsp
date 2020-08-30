<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "consult.ConsultDAO" %> 
<%@ page import = "consult.Consult" %> 
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

	int conNum=0;
	if(request.getParameter("conNum") !=null){
		conNum = Integer.parseInt(request.getParameter("conNum"));
	}
	if(conNum==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'Consult.jsp'");
		script.println("</script>");			
	} 
	Consult consult = new ConsultDAO().getConsult(conNum);
	
	if(userID==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = 'login.jsp'"); 
		script.println("</script>");	
	}
	
		else{	
			
			if( request.getParameter("cliNum")==null || request.getParameter("contents")==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");	
			} else	{
				ConsultDAO consultDAO = new ConsultDAO();
				int result =consultDAO.update(conNum, Integer.parseInt(request.getParameter("cliNum")), request.getParameter("conSize"), request.getParameter("budget"), request.getParameter("conAddr"), request.getParameter("contents"));
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
					script.println("location.href = 'Consult.jsp'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body> 
</html> 