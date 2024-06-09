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

		
		try 
		{
			ds = moc.myOracleDataSource();
			conn = ds.getConnection();
			if (conn != null)
				System.out.println("conn ok ");
			else
				System.out.println("conn fail ");
			String sql ="INSERT INTO reply (reply_seq, user_seq, webgl, reply, grade, created_date, updated_date)\r\n"
					+ "VALUES (reply_seq.NEXTVAL, ?, ?, ?, 5, SYSDATE, SYSDATE)"
					;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rvo.getUser_seq());
			pstmt.setString(2, rvo.getWebGL());
			pstmt.setString(3, rvo.getReply());
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

		try 
		{
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
	
	public ReplyVO replySelect(int seq) {
		MyOracleConnection moc = new MyOracleConnection(); // 클래스 분리시켜놓아서 인스턴스 생성해서 사용
		DataSource ds = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		ReplyVO rvo = null;
		try 
		{
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
	
	/**
     * 특정 사용자의 댓글을 조회합니다.
     *
     * @param userSeq 사용자 고유 번호
     * @return 댓글 정보가 담긴 ReplyVO 객체의 리스트
     */
	public ArrayList<ReplyVO> replyUserSelect(int userSeq) {
	    MyOracleConnection moc = new MyOracleConnection();
	    DataSource ds = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<ReplyVO> list = new ArrayList<>();

	    try {
	        ds = moc.myOracleDataSource();
	        conn = ds.getConnection();
	        String sql = "SELECT r.reply_seq, r.user_seq, r.webgl, r.reply, r.grade, r.created_date, r.updated_date, u.userid, u.username " +
	                     "FROM reply r JOIN users u ON r.user_seq = u.user_seq WHERE r.user_seq = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, userSeq);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ReplyVO rvo = new ReplyVO();
	            rvo.setReply_seq(rs.getInt("reply_seq"));
	            rvo.setUser_seq(rs.getInt("user_seq"));
	            rvo.setWebGL(rs.getString("webgl"));
	            rvo.setReply(rs.getString("reply"));
	            rvo.setGrade(rs.getInt("grade"));
	            rvo.setCreated_date(rs.getString("created_date"));
	            rvo.setUpdated_date(rs.getString("updated_date"));
	            UserVO userVO = new UserVO();
	            userVO.setUserid(rs.getString("userid"));
	            userVO.setUsername(rs.getString("username"));
	            rvo.setUserVO(userVO);
	            list.add(rvo);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        moc.oracleClose(conn, pstmt, rs);
	    }
	    return list;
	}



    /**
     * 특정 게임의 댓글 조회
     *
     * @param webGLName 게임 고유 번호
     * @return 댓글 정보가 담긴 ReplyVO 객체의 리스트
     */
	public ArrayList<ReplyVO> replyUserSelect(String webGLName) {
		MyOracleConnection moc = new MyOracleConnection(); // 클래스 분리시켜놓아서 인스턴스 생성해서 사용
		DataSource ds = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		ArrayList<ReplyVO> list = null;
		try 
		{
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
					+ " where r.webgl = ? and r.webgl=gt.webgl and u.user_seq=r.user_seq"
					+ " order by r.created_date asc";
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
	
	public int replyDelete(int replySeq) {
	    MyOracleConnection moc = new MyOracleConnection();
	    DataSource ds = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    int deleteRows = 0;

	    try {
	        ds = moc.myOracleDataSource();
	        conn = ds.getConnection();
	        if (conn != null)
	            System.out.println("conn ok ");
	        else
	            System.out.println("conn fail ");
	        String sql = "DELETE FROM reply WHERE reply_seq = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, replySeq);
	        deleteRows = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        moc.oracleClose(conn, pstmt);
	    }
	    return deleteRows;
	}
}
