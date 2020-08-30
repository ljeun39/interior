<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="clients.Clients"%>
<%@ page import="clients.ClientsDAO" %>
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

	int cliNum=0;
	if(request.getParameter("cliNum") !=null){
		cliNum = Integer.parseInt(request.getParameter("cliNum"));
	}
	if(cliNum==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'Consult.jsp'");
		script.println("</script>");			
	} 
	Clients clients = new ClientsDAO().getClients(cliNum);
	
	if(userID==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = 'login.jsp'"); 
		script.println("</script>");	
	}
	
		else{	
			
			if( request.getParameter("cliNum")==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");	
			} else	{
				ClientsDAO clientsDAO = new ClientsDAO();
				int result =clientsDAO.update(cliNum,request.getParameter("cliName"),request.getParameter("cliPhone"),request.getParameter("cliBirth"),request.getParameter("cliEmail"));
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
					script.println("location.href = 'clients.jsp'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body> 
</html> 