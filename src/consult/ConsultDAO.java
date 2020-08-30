package consult;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ConsultDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public ConsultDAO() {
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
	
	
	public int getNext() {		//�Խñ� ��ȣ �ڵ������Լ�
		String SQL = "SELECT conNum FROM consult ORDER BY conNum DESC";	//���� �����Ϳ� 1�� ������
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
	
	
	public int write(int cliNum,String conSize,String budget,String conAddr,String contents,int inteEx) {
		String SQL = "INSERT INTO consult VALUES(?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, cliNum);
			pstmt.setString(3, conSize);
			pstmt.setString(4, budget);
			pstmt.setString(5, conAddr);
			pstmt.setString(6, getDate());
			pstmt.setString(7, contents);
			pstmt.setInt(8, 1);
			return pstmt.executeUpdate();		//0�̻� �����ȯ
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����Ϳ��񽺿���
		}
	
	
	public ArrayList<Consult> getList(int pageNumber){
			String SQL = "SELECT * FROM consult WHERE conNum < ? ORDER BY conNum DESC LIMIT 10";
			ArrayList<Consult> list = new ArrayList<Consult>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() -(pageNumber -1)*10);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Consult consult = new Consult();
					consult.setConNum(rs.getInt(1));
					consult.setCliNum(rs.getInt(2));
					consult.setConSize(rs.getString(3));
					consult.setBudget(rs.getString(4));
					consult.setConAddr(rs.getString(5));
					consult.setConDate(rs.getString(6));
					consult.setContents(rs.getString(7));
					consult.setInteEx(rs.getInt(8));
					list.add(consult);
					
		
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;	//�����Ϳ��񽺿���
		}
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM consult WHERE conNum <  ? ";
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
		
		
		public Consult getConsult(int conNum) {
			String SQL = "SELECT * FROM consult WHERE conNum =  ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, conNum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					Consult consult = new Consult();
					consult.setConNum(rs.getInt(1));
					consult.setCliNum(rs.getInt(2));
					consult.setConSize(rs.getString(3));
					consult.setBudget(rs.getString(4));
					consult.setConAddr(rs.getString(5));
					consult.setConDate(rs.getString(6));
					consult.setContents(rs.getString(7));
					consult.setInteEx(rs.getInt(8));
					return consult;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return null;	//�����Ϳ��񽺿���
		}
		
		
		public int update(int conNum, int cliNum,String conSize,String budget,String conAddr,String contents) {
			String SQL = "UPDATE consult SET cliNum=?, conSize=?, budget=?, conAddr=?, contents=? WHERE conNum= ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, cliNum);
				pstmt.setString(2, conSize);
				pstmt.setString(3, budget);
				pstmt.setString(4, conAddr);
				pstmt.setString(5, contents);
				pstmt.setInt(6, conNum);
				return pstmt.executeUpdate();		//0�̻� �����ȯ
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//�����Ϳ��񽺿���
			}
		public int delete(int conNum) {
			String SQL = "UPDATE consult SET inteEx=0 WHERE conNum=?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, conNum);
				return pstmt.executeUpdate();		//0�̻� �����ȯ
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//�����Ϳ��񽺿���
			}
	
		
		
	}
		