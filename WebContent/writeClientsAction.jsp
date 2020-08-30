<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "clients.ClientsDAO" %> 
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="clients" class="clients.Clients" scope="page"/>
<jsp:setProperty name="clients" property="cliName"/>
<jsp:setProperty name="clients" property="cliPhone"/>
<jsp:setProperty name="clients" property="cliBirth"/>
<jsp:setProperty name="clients" property="cliEmail"/>

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
	if(userID==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = 'login.jsp'"); 
		script.println("</script>");	
	}
		else{	
			if(clients.getCliName()==null || clients.getCliEmail()==null ||clients.getCliPhone()==null||clients.getCliBirth()==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");	
			} else	{
				ClientsDAO clientsDAO= new ClientsDAO();
				int result =clientsDAO.write(clients.getCliName(),clients.getCliPhone(),clients.getCliBirth(),clients.getCliEmail());
				if(result ==-1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('고객입력 실패.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('고객추가가 완료되었습니다.')");
					script.println("location.href = 'clients.jsp'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body> 
</html> 