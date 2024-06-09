package GameTable;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import Common.MyOracleConnection;
import User.UserVO;

public class GameTableDAO {
 	

	public int gameTableInsert(GameTableVO gvo) {
		MyOracleConnection moc = new MyOracleConnection(); // 클래스 분리시켜놓아서 인스턴스 생성해서 사용
		DataSource ds = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int insertRows = 0;
		
		try 
		{
			ds = moc.myOracleDataSource();
			conn = ds.getConnection();
			if (conn != null)
				System.out.println("conn ok ");
			else
				System.out.println("conn fail ");
			String sql ="INSERT INTO gametable (webgl, gamename, contents, grade, user_seq)\r\n"
					+ "VALUES (?, ?, ?, 5, ?)"
					;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gvo.getWebGL());
			pstmt.setString(2, gvo.getGameName());
			pstmt.setString(3, gvo.getContents());
			pstmt.setInt(4, gvo.getUser_seq());
			insertRows = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			moc.oracleClose(conn, pstmt);
		}
		return insertRows;
	}
	/**
     * 특정 사용자의 댓글을 조회합니다.
     *
     * @param 없음 
     * @return GameTable에 있는 모든 게임 GameTableVO를 리스트 형태로 반환
     */
	public ArrayList<GameTableVO> GameTableSelectAll() {
	    MyOracleConnection moc = new MyOracleConnection();
	    DataSource ds = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<GameTableVO> list = new ArrayList<>();

	    try {
	        ds = moc.myOracleDataSource();
	        conn = ds.getConnection();
	        String sql = "SELECT *FROM gametable";
	        pstmt = conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	        	GameTableVO gvo = new GameTableVO();
	            gvo.setCreated_date(rs.getString("created_date"));
	            gvo.setUpdated_date(rs.getString("updated_date"));
	            gvo.setContents(rs.getString("contents"));
	            gvo.setGameName(rs.getString("gamename"));
	            gvo.setGrade(Integer.parseInt(rs.getString("grade")));
	            gvo.setUser_seq(Integer.parseInt(rs.getString("grade")));
	            gvo.setWebGL(rs.getString("webgl"));
	            list.add(gvo);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        moc.oracleClose(conn, pstmt, rs);
	    }
	    return list;
	}
}
