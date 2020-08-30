package AS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import AS.FreeAS;

public class FreeASDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public FreeASDAO() {
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
		String SQL = "SELECT NOW()";	//����ð��� �������� sql����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	//sql�����غ�ܰ�
			rs = pstmt.executeQuery();	//���������� ������
			if(rs.next()) {				
				return rs.getString(1);	//��� ��ȯ
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";	//�����Ϳ��񽺿���
	}
	
	
	public int write(int conNum, String asDetail) {
		String SQL = "INSERT INTO freeAS VALUES(?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, getDate());
			pstmt.setInt(2, getNext());
			pstmt.setInt(3, conNum);
			pstmt.setString(4, asDetail);
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();		//0�̻� �����ȯ
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����Ϳ��񽺿���
		}
	
	
	public int getNext() {		//�Խñ� ��ȣ �ڵ������Լ�
		String SQL = "SELECT asNum FROM freeAS ORDER BY asNum DESC";	//���� �����Ϳ� 1�� ������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;	//���簡 ù��° �Խù��� ���
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����Ϳ��񽺿���
	}
	
	
	public ArrayList<FreeAS> getList(int pageNumber){
			String SQL = "SELECT * FROM freeAS WHERE  asNum < ? ORDER BY asNum DESC LIMIT 10";
			ArrayList<FreeAS> list = new ArrayList<FreeAS>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() -(pageNumber -1)*10);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					FreeAS freeAS= new FreeAS();
					
					freeAS.setAsDate(rs.getString(1));
					freeAS.setAsNum(rs.getInt(2));
					freeAS.setConNum(rs.getInt(3));
					freeAS.setAsDetail(rs.getString(4));
					freeAS.setAsEx(rs.getInt(5));
					list.add(freeAS);					
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;	//�����Ϳ��񽺿���
		}
	
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM freeAS WHERE asNum <  ? ";
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
		return false;	//�����Ϳ��񽺿���
	}
	
	
	
	public FreeAS getFreeAS(int asNum) {
		String SQL = "SELECT * FROM freeAS WHERE asNum =  ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, asNum);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				FreeAS freeAS = new FreeAS();
				
				freeAS.setAsDate(rs.getString(1));
				freeAS.setAsNum(rs.getInt(2));
				freeAS.setConNum(rs.getInt(3));
				freeAS.setAsDetail(rs.getString(4));
				freeAS.setAsEx(rs.getInt(5));
				
				return freeAS;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;	//�����Ϳ��񽺿���
	}
	
	
	public int update(int conNum,String asDetail,int asNum) {
		String SQL = "UPDATE freeAS SET  conNum=?, asDetail=? WHERE asNum= ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, conNum);
			pstmt.setString(2, asDetail);
			pstmt.setInt(3, asNum);
			return pstmt.executeUpdate();		//0�̻� �����ȯ
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����Ϳ��񽺿���
		}
	
	public int delete(int asNum) {
		String SQL = "UPDATE freeAS SET asEx=0 WHERE asNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,asNum);
			return pstmt.executeUpdate();		//0�̻� �����ȯ
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����Ϳ��񽺿���
		}

		
		
}
	