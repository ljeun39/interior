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
	public int getNext() {		//�Խñ� ��ȣ �ڵ������Լ�
		String SQL = "SELECT estNum FROM estimate ORDER BY estNum DESC";	//���� �����Ϳ� 1�� ������
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
			return pstmt.executeUpdate();		//0�̻� �����ȯ
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//�����Ϳ��񽺿���
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
		return list;	//�����Ϳ��񽺿���	
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
			return null;	//�����Ϳ��񽺿���
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
			return false;	//�����Ϳ��񽺿���
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
				return pstmt.executeUpdate();		//0�̻� �����ȯ
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//�����Ϳ��񽺿���
			}
		public int delete(int estNum) {
			String SQL = "UPDATE estimate SET estEx=0 WHERE estNum=?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, estNum);
				return pstmt.executeUpdate();		//0�̻� �����ȯ
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//�����Ϳ��񽺿���
			}
	
		
		
	}
		