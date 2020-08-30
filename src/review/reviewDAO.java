package review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class reviewDAO {
	private Connection conn;
	private ResultSet rs;
	
	public reviewDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bill";
			String dbID = "root";
			String dbpassword = "bang";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbpassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//현재 시간 함수
	public String getDate() {
		String SQL="SELECT NOW()";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	// 게시글 번호 처리
	public int getNext() {
		String SQL="SELECT revID FROM review ORDER BY revID DESC";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1) +1;
			}
			return 1; //첫번쨰 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int write(String revTitle, String userID, String revContent) {
		String SQL="INSERT INTO review VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, revTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, revContent);
			pstmt.setInt(6, 1);

			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<review> getList(int pageNumber) {
		String SQL="SELECT * FROM review WHERE revID < ? AND revEx =1 ORDER BY revID DESC LIMIT 10";
		ArrayList<review> list = new ArrayList<review>();
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				review rev = new review();
				rev.setRevID(rs.getInt(1));
				rev.setRevTitle(rs.getString(2));
				rev.setUserID(rs.getString(3));
				rev.setRevDate(rs.getString(4));
				rev.setRevContent(rs.getString(5));
				rev.setRevEx(rs.getInt(6));
				list.add(rev);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage (int pageNumber) {
		String SQL="SELECT * FROM review WHERE revID < ? AND revEx =1";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public review getReview(int revID) {
		String SQL="SELECT * FROM review WHERE revID=?";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, revID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				review rev = new review();
				rev.setRevID(rs.getInt(1));
				rev.setRevTitle(rs.getString(2));
				rev.setUserID(rs.getString(3));
				rev.setRevDate(rs.getString(4));
				rev.setRevContent(rs.getString(5));
				rev.setRevEx(rs.getInt(6));
				
				return rev;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int revID, String revTitle, String revContent) {
		String SQL="UPDATE review SET revTitle=?, revContent=? WHERE revID=?";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, revTitle);
			pstmt.setString(2, revContent);
			pstmt.setInt(3, revID);

			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int revID) {
		String SQL="UPDATE review SET revEx=0 WHERE revID=?";
		try {
			PreparedStatement pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, revID);

			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
