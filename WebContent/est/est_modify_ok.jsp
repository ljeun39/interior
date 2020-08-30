<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
			
<%
String dbUrl = "jdbc:mysql://localhost:3306/bill";
Class.forName("com.mysql.jdbc.Driver");
	String id = "root";
	String pass = "bang";
	int conNum1 = Integer.parseInt(request.getParameter("conNum"));
	
		try{
			
			request.setCharacterEncoding("euc-kr");
			String conNum = request.getParameter("conNum");
			String allBudget = request.getParameter("allBudget");
			String exBudget = request.getParameter("exBudget");
			String noBudget = request.getParameter("noBudget");
			String conEx = request.getParameter("conEx");
			String startDate = request.getParameter("startDate");
			String finalDate = request.getParameter("finalDate");
			String aspsDate = request.getParameter("aspsDate");
		
			Connection conn = DriverManager.getConnection(dbUrl,id,pass);
			Statement stmt = conn.createStatement();
			String sql = "UPDATE estimate SET conNum='" + conNum+ "' ,allBudget='"+ allBudget +"', exBudget='"+exBudget+"',noBudget='"+ noBudget +"' WHERE conNum = " + conNum;      
				stmt.executeUpdate(sql);
				
%>
				  <script language=javascript>
				  	self.window.alert("글이 수정되었습니다.");
				  	location.href="est_list.jsp";
				  </script>
<%

			stmt.close();
			conn.close();
		
		 
 } catch(SQLException e) {
	out.println( e.toString() );
} 
%>
