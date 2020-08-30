<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "AS.ChargeASDAO" %> 
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="chargeAS" class="AS.ChargeAS" scope="page"/>
<jsp:setProperty name="chargeAS" property="asDate"/>
<jsp:setProperty name="chargeAS" property="asNum"/>
<jsp:setProperty name="chargeAS" property="conNum"/>
<jsp:setProperty name="chargeAS" property="asDetail"/>
<jsp:setProperty name="chargeAS" property="asBudget"/>

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
			if(chargeAS.getAsDetail()==null || chargeAS.getConNum()==0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");	
			} else	{
				ChargeASDAO chargeASDAO= new ChargeASDAO();
				int result =chargeASDAO.write(chargeAS.getConNum(),chargeAS.getAsDetail(),chargeAS.getAsBudget());
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
					script.println("location.href = 'ChargeAS.jsp'");
					script.println("</script>");
				}
			}
		}
		
	%>
</body> 
</html> 