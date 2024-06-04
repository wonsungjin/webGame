package User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import Common.MyOracleConnection;

public class UserDAO {
	public int userInsert(UserVO uvo) {
		MyOracleConnection moc = new MyOracleConnection();
		Connection conn = null;
		PreparedStatement pstmt = null;
		int insertRows = 0;

		try {
			conn = moc.myOracleDataSource().getConnection();
			String sql = "INSERT INTO \"User\" (user_seq, userid, username, password, email, created_date, updated_date) "
					+ "VALUES (user_seq_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uvo.getUserid());
			pstmt.setString(2, uvo.getUsername());
			pstmt.setString(3, uvo.getPassword());
			pstmt.setString(4, uvo.getUseremail());
			insertRows = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return insertRows;
	}
}
