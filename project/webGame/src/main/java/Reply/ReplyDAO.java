package Reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import Common.MyOracleConnection;
import User.UserVO;

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
			String sql = "update reply set reply = ?,updated_date = sysdate where reply_seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rvo.getReply());
			pstmt.setInt(2, rvo.getReply_seq());
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
	public ArrayList<ReplyVO> replySelect(String webGLName) {
		MyOracleConnection moc = new MyOracleConnection(); // 클래스 분리시켜놓아서 인스턴스 생성해서 사용
		DataSource ds = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		ArrayList<ReplyVO> list = null;
		try 
		{
			// conn = moc.oracleConn();
			ds = moc.myOracleDataSource();
			conn = ds.getConnection();
			if (conn != null)
				System.out.println("conn ok ");
			else
				System.out.println("conn fail ");
			String sql = "select * from reply r,gametable gt where r.webgl = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,webGLName);
			rs=pstmt.executeQuery();
			list = new ArrayList<ReplyVO>();
			while(rs.next()==true)
			{
				ReplyVO rvo = new ReplyVO();				
				rvo.setCreated_date(rs.getString("created_date"));
				rvo.setReply(rs.getString("reply"));
				rvo.setUpdated_date(rs.getString("updated_date"));
				rvo.setUser_seq(rs.getInt("user_seq"));
				rvo.setGrade(rs.getInt("grade"));
				rvo.setWebGL(rs.getString("webgl"));
				list.add(rvo);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			moc.oracleClose(conn, pstmt);
		}
		return list;
	}
	public ArrayList<ReplyVO> replyUserSelect(String webGLName) {
		MyOracleConnection moc = new MyOracleConnection(); // 클래스 분리시켜놓아서 인스턴스 생성해서 사용
		DataSource ds = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		ArrayList<ReplyVO> list = null;
		try 
		{
			// conn = moc.oracleConn();
			ds = moc.myOracleDataSource();
			conn = ds.getConnection();
			if (conn != null)
				System.out.println("conn ok ");
			else
				System.out.println("conn fail ");
			String sql = "select "
					+ "r.reply_seq, r.user_seq, r.webgl, r.reply, r.grade, r.created_date, r.updated_date,"
					+ " gt.gamename, gt.contents,"
					+ " gt.grade AS game_grade, "
					+ " gt.created_date AS game_created_date, "
					+ " gt.updated_date AS game_updated_date,"
					+ " u.userid, u.username, u.password, u.email, "
					+ " u.created_date AS user_created_date, "
					+ " u.updated_date AS user_updated_date"
					+ " from reply r,gametable gt,users u "
					+ " where r.webgl = ? and u.user_seq=r.user_seq";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,webGLName);
			rs=pstmt.executeQuery();
			list = new ArrayList<ReplyVO>();
			while(rs.next()==true)
			{
				ReplyVO rvo = new ReplyVO();				
				rvo.setCreated_date(rs.getString("created_date"));
				rvo.setReply(rs.getString("reply"));
				rvo.setUpdated_date(rs.getString("updated_date"));
				rvo.setUser_seq(rs.getInt("user_seq"));
				rvo.setReply_seq(rs.getInt("reply_seq"));
				rvo.setGrade(rs.getInt("grade"));
				rvo.setWebGL(rs.getString("webgl"));
				UserVO userVO = new UserVO(); // 새 UserVO 객체 생성
	            userVO.setUserid(rs.getString("userid"));
	            userVO.setUsername(rs.getString("username"));
	            userVO.setPassword(rs.getString("password"));
	            userVO.setCreated_date(rs.getString("user_created_date"));
	            userVO.setUpdated_date(rs.getString("user_updated_date"));
	            
	            rvo.setUserVO(userVO);
				list.add(rvo);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			moc.oracleClose(conn, pstmt);
		}
		return list;
	}
}
