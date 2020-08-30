<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>견적서 작성</title>
</head>
<body>
	<%
	request.setCharacterEncoding("euc-kr");

	Class.forName("com.mysql.jdbc.Driver");
	
	String url = "jdbc:mysql://localhost:3306/bill";
	String id = "root";
	String pass = "bang";
	String conNum = request.getParameter("conNum");
	String allBudget = request.getParameter("allBudget");
	String exBudget = request.getParameter("exBudget");
	String noBudget = request.getParameter("noBudget");
	String conEx = request.getParameter("conEx");
	String startDate = request.getParameter("startDate");
	String finalDate = request.getParameter("finalDate");
	String aspsDate = request.getParameter("aspsDate");
	int max=0;
	try {	
		Connection conn = DriverManager.getConnection(url,"root","bang");
		Statement stmt = conn.createStatement();
		
		String SQL = "SELECT MAX(conNum) FROM estimate";
		ResultSet rs = stmt.executeQuery(SQL);
		
		if(rs.next()){
			max = rs.getInt(1);
		}
		
		SQL = "INSERT INTO estimate(`conNum`, `allBudget`,`exBudget`, `noBudget`,`conEx`, `startDate`,`finalDate`, `aspsDate`) VALUES('"+conNum+"','"+allBudget+"','"+exBudget+"','"+noBudget+"','"+conEx+"','"+startDate+"','"+finalDate+"','"+aspsDate+"') ";
		stmt.executeUpdate(SQL);
		stmt.close();
		conn.close();
} catch(SQLException e) {
	out.println( e.toString() );
	}
%>
  <script language=javascript>
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="est_list.jsp"; 
</script>
</body>
</html>
