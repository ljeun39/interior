package clients;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import clients.Clients;

public class ClientsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public ClientsDAO() {
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
		String SQL = "SELECT cliNum FROM clients ORDER BY cliNum DESC";	//가장 높은것에 1을 더해줌
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
	
	
	public int write(String cliName ,String cliPhone ,String cliBirth ,String cliEmail) {
		String SQL = "INSERT INTO clients VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, cliName);
			pstmt.setString(3, cliPhone);
			pstmt.setString(4, cliBirth);
			pstmt.setString(5, cliEmail);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();		//0이상 결과반환
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터에비스오류
		}
	
	
	public ArrayList<Clients> getList(int pageNumber){
			String SQL = "SELECT * FROM clients WHERE clinum < ? ORDER BY clinum DESC LIMIT 10";
			ArrayList<Clients> list = new ArrayList<Clients>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() -(pageNumber -1)*10);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Clients clients = new Clients();
					
					clients.setCliNum(rs.getInt(1));
					clients.setCliName(rs.getString(2));
					clients.setCliPhone(rs.getString(3));
					clients.setCliBirth(rs.getString(4));
					clients.setCliEmail(rs.getString(5));
					clients.setCliEx(rs.getInt(6));
					list.add(clients);
					
		
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;	//데이터에비스오류
		}
	
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM clients WHERE cliNum <  ? ";
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
	
	
	
	public Clients getClients(int cliNum) {
		String SQL = "SELECT * FROM clients WHERE cliNum =  ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cliNum);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				Clients clients = new Clients();
				
				clients.setCliNum(rs.getInt(1));
				clients.setCliName(rs.getString(2));
				clients.setCliPhone(rs.getString(3));
				clients.setCliBirth(rs.getString(4));
				clients.setCliEmail(rs.getString(5));
				clients.setCliEx(rs.getInt(6));
				
				return clients;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;	//데이터에비스오류
	}
	
	
	public int update(int cliNum, String cliName ,String cliPhone ,String cliBirth ,String cliEmail) {
		String SQL = "UPDATE clients SET cliName=?, cliPhone=?, cliBirth=?, cliEmail=? WHERE cliNum= ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cliName);
			pstmt.setString(2, cliPhone);
			pstmt.setString(3, cliBirth);
			pstmt.setString(4, cliEmail);
			pstmt.setInt(5, cliNum);
			return pstmt.executeUpdate();		//0이상 결과반환
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터에비스오류
		}
	
	public int delete(int cliNum) {
		String SQL = "UPDATE clients SET cliEx=0 WHERE clinum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,cliNum);
			return pstmt.executeUpdate();		//0이상 결과반환
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터에비스오류
		}

		
		
}
	