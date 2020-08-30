package est;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EstimateDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public EstimateDAO() {
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
	public int getNext() {		//게시글 번호 자동지정함수
		String SQL = "SELECT estNum FROM estimate ORDER BY estNum DESC";	//가장 높은것에 1을 더해줌
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;	//현재가 첫번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터에비스오류
	}
	
	
	public String getDate() {
		String SQL = "SELECT NOW()";	//현재시간을 가져오는 sql문구
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	//sql실행준비단계
			rs = pstmt.executeQuery();	//쿼리실행결과 가져옴
			if(rs.next()) {				
				return rs.getString(1);	//결과 반환
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";	//데이터에비스오류
	}
	
	
	
	public int write(int conNum ,String totalCost ,String exCost ,String startDate ,String finalDate ) {
		String SQL = "INSERT INTO estimate VALUES(?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, conNum);
			pstmt.setString(3, totalCost);
			pstmt.setString(4, exCost);
			pstmt.setInt(5, 1);
			pstmt.setString(6, startDate);
			pstmt.setString(7, finalDate);
			return pstmt.executeUpdate();		//0이상 결과반환
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터에비스오류
		}
	
	
	
	public ArrayList<Estimate> getList(int pageNumber){
		String SQL = "SELECT * FROM estimate WHERE estNum < ? ORDER BY estNum DESC LIMIT 10";
		ArrayList<Estimate> list = new ArrayList<Estimate>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() -(pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Estimate estimate = new Estimate();
				
				estimate.setEstNum(rs.getInt(1));
				estimate.setConNum(rs.getInt(2));
				estimate.setTotalCost(rs.getString(3));
				estimate.setExCost(rs.getString(4));
				estimate.setEstEx(rs.getInt(5));
				estimate.setStartDate(rs.getString(6));
				estimate.setFinalDate(rs.getString(7));
				list.add(estimate);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;	//데이터에비스오류	
	}
	
		
		public Estimate getEstimate(int estNum) {
			String SQL = "SELECT * FROM estimate WHERE estNum =? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, estNum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					Estimate estimate = new Estimate();

					estimate.setConNum(rs.getInt(1));
					estimate.setConNum(rs.getInt(2));
					estimate.setTotalCost(rs.getString(3));
					estimate.setExCost(rs.getString(4));
					estimate.setEstEx(rs.getInt(5));
					estimate.setStartDate(rs.getString(6));
					estimate.setFinalDate(rs.getString(7));
					
					return estimate;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return null;	//데이터에비스오류
		}
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM estimate WHERE estNum <  ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() -(pageNumber -1)*10);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return true;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false;	//데이터에비스오류
		}
		
		public int update(int estNum, int conNum ,String totalCost ,String exCost ,String startDate ,String finalDate ) {
			String SQL = "UPDATE estimate SET conNum = ?, totalCost=?, exCost=?, startDate=? ,finalDate=? WHERE estNum= ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, conNum);
				pstmt.setString(2, totalCost);
				pstmt.setString(3, exCost);
				pstmt.setString(4, startDate);
				pstmt.setString(5, finalDate);
				pstmt.setInt(6, estNum);
				return pstmt.executeUpdate();		//0이상 결과반환
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//데이터에비스오류
			}
		public int delete(int estNum) {
			String SQL = "UPDATE estimate SET estEx=0 WHERE estNum=?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, estNum);
				return pstmt.executeUpdate();		//0이상 결과반환
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//데이터에비스오류
			}
	
		
		
	}
		
