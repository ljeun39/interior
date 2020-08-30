package AS;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import AS.ChargeAS;
public class ChargeASDAO {


		private Connection conn;
		private ResultSet rs;
		
		public ChargeASDAO() {
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
		
		
		public int write(int conNum, String asDetail,String asBudget) {
			String SQL = "INSERT INTO chargeAS VALUES(?,?,?,?,?,?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, getDate());
				pstmt.setInt(2, getNext());
				pstmt.setInt(3, conNum);
				pstmt.setString(4, asDetail);
				pstmt.setString(5, asBudget);
				pstmt.setInt(6, 1);
				return pstmt.executeUpdate();		//0이상 결과반환
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//데이터에비스오류
			}
		
		
		public int getNext() {		//게시글 번호 자동지정함수
			String SQL = "SELECT asNum FROM chargeAS ORDER BY asNum DESC";	//가장 높은것에 1을 더해줌
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
		
		
		public ArrayList<ChargeAS> getList(int pageNumber){
				String SQL = "SELECT * FROM chargeAS WHERE  asNum < ? ORDER BY asNum DESC LIMIT 10";
				ArrayList<ChargeAS> list = new ArrayList<ChargeAS>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext() -(pageNumber -1)*10);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						ChargeAS chargeAS= new ChargeAS();
						
						chargeAS.setAsDate(rs.getString(1));
						chargeAS.setAsNum(rs.getInt(2));
						chargeAS.setConNum(rs.getInt(3));
						chargeAS.setAsDetail(rs.getString(4));
						chargeAS.setAsBudget(rs.getString(5));
						chargeAS.setAsEx(rs.getInt(6));
						list.add(chargeAS);					
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				return list;	//데이터에비스오류
			}
		
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM chargeAS WHERE asNum <  ? ";
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
		
		
		
		public ChargeAS getChargeAS(int asNum) {
			String SQL = "SELECT * FROM chargeAS  WHERE asNum =  ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, asNum);
				rs = pstmt.executeQuery();

				if(rs.next()) {
					ChargeAS chargeAS = new ChargeAS();
					
					chargeAS.setAsDate(rs.getString(1));
					chargeAS.setAsNum(rs.getInt(2));
					chargeAS.setConNum(rs.getInt(3));
					chargeAS.setAsDetail(rs.getString(4));
					chargeAS.setAsBudget(rs.getString(5));
					chargeAS.setAsEx(rs.getInt(6));
					
					return chargeAS;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return null;	//데이터에비스오류
		}
		
		
		public int update(int conNum, String asDetail,String asBudget,int asNum) {
			String SQL = "UPDATE chargeAS SET conNum=?, asDetail=?,asBudget=? WHERE asNum= ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, conNum);
				pstmt.setString(2, asDetail);
				pstmt.setString(3, asBudget);
				pstmt.setInt(4, asNum);
				return pstmt.executeUpdate();		//0이상 결과반환
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//데이터에비스오류
			}
		
		public int delete(int asNum) {
			String SQL = "UPDATE chargeAS SET asEx=0 WHERE asNum=?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,asNum);
				return pstmt.executeUpdate();		//0이상 결과반환
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//데이터에비스오류
			}

			
			
	}
