package Reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import Common.MyOracleConnection;

public class ReplyDAO {
 	

	public int replyInsert(ReplyVO rvo) {
		MyOracleConnection moc = new MyOracleConnection(); // 클래스 분리시켜놓아서 인스턴스 생성해서 사용
		DataSource ds = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int insertRows = 0;

		// 파라미터가 잘 넘어왔는지 확인용 코드 (seq=0, regdate=null)
		System.out.println(rvo.toString());
		
		try 
		{
			// conn = moc.oracleConn();
			ds = moc.myOracleDataSource();
			conn = ds.getConnection();
			if (conn != null)
				System.out.println("conn ok ");
			else
				System.out.println("conn fail ");
			String sql = "insert into reply values(reply_seq.nextval,?,?,sysdate,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rvo.getUser_seq());
			pstmt.setString(2, rvo.getReply());
			insertRows = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			moc.oracleClose(conn, pstmt);
		}
		return insertRows;
	}
	public int replyUpdate(ReplyVO rvo) {
		MyOracleConnection moc = new MyOracleConnection(); // 클래스 분리시켜놓아서 인스턴스 생성해서 사용
		DataSource ds = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int updateRows = 0;

		// 파라미터가 잘 넘어왔는지 확인용 코드 (seq=0, regdate=null)
		System.out.println(rvo.toString());
		
		try 
		{
			// conn = moc.oracleConn();
			ds = moc.myOracleDataSource();
			conn = ds.getConnection();
			if (conn != null)
				System.out.println("conn ok ");
			else
				System.out.println("conn fail ");
			String sql = "update reply set reply = ?,updated_date = sysdate; where reply_seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rvo.getReply());
			pstmt.setInt(2, rvo.getUser_seq());
			updateRows = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			moc.oracleClose(conn, pstmt);
		}
		return updateRows;
	}
	public ReplyVO replySelectOne(int seq) {
		MyOracleConnection moc = new MyOracleConnection(); // 클래스 분리시켜놓아서 인스턴스 생성해서 사용
		DataSource ds = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		ReplyVO rvo = null;
		try 
		{
			// conn = moc.oracleConn();
			ds = moc.myOracleDataSource();
			conn = ds.getConnection();
			if (conn != null)
				System.out.println("conn ok ");
			else
				System.out.println("conn fail ");
			String sql = "select r.seq as rseq,r.created_date,r.reply,r.updated_date,r.user_seq from reply r,users u  where r.user_seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seq);
			rs=pstmt.executeQuery();
			rvo = new ReplyVO();
			while(rs.next()==true)
			{
				rvo.setCreated_date(rs.getString("created_date"));
				rvo.setReply(rs.getString("reply"));
				rvo.setUpdated_date(rs.getString("updated_date"));
				rvo.setUser_seq(rs.getInt("user_seq"));
				rvo.setReply_seq(rs.getInt("rseq"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			moc.oracleClose(conn, pstmt);
		}
		return rvo;
	}
}
