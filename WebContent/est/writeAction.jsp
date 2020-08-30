<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "est.EstimateDAO" %> 
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="estimate" class="est.Estimate" scope="page"/>
<jsp:setProperty name="estimate" property="conNum"/>
<jsp:setProperty name="estimate" property="totalCost"/>
<jsp:setProperty name="estimate" property="exCost"/>
<jsp:setProperty name="estimate" property="startDate"/>
<jsp:setProperty name="estimate" property="finalDate"/>

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
	EstimateDAO estimateDAO = new EstimateDAO();
	
	if(userID==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href = '../login.jsp'"); 
		script.println("</script>");	
	}
		else{	
			
			if(estimate.getConNum()==0 ||estimate.getTotalCost()==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");	
			} else	{
				
				int result =estimateDAO.write(estimate.getConNum(),estimate.getTotalCost(),estimate.getExCost(),estimate.getStartDate(),estimate.getFinalDate());
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
					script.println("alert('게시가 완료되었습니다.')");
					script.println("location.href = 'est_list.jsp'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body> 
</html> 