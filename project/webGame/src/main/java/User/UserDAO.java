package User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Common.MyOracleConnection;

public class UserDAO {

    /**
     * 
     * @param UserVO를 받아서 Insert 쿼리문 실행
     * @return 몇 건을 삽입하였는지 정수로 반환
     */
    public int userInsert(UserVO uvo) {
        int insertRows = 0;

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                 "INSERT INTO users (user_seq, userid, username, password, email, created_date, updated_date) " +
                 "VALUES (users_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, SYSDATE)")) {

            pstmt.setString(1, uvo.getUserid());
            pstmt.setString(2, uvo.getUsername());
            pstmt.setString(3, uvo.getPassword());
            pstmt.setString(4, uvo.getUseremail());
            insertRows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // 추가적인 예외 처리
        }
        return insertRows;
    }

    /**
     * 모든 사용자 조회
     * 
     * @return 사용자 리스트
     */
    public List<UserVO> userSelect() {
        List<UserVO> userList = new ArrayList<>();

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users");
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                UserVO uvo = new UserVO();
                uvo.setUserid(rs.getString("userid"));
                uvo.setUsername(rs.getString("username"));
                uvo.setPassword(rs.getString("password"));
                uvo.setUseremail(rs.getString("email"));
                userList.add(uvo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 추가적인 예외 처리
        }

        return userList;
    }

    /**
     * @param user_seq 사용자 한명 조회
     * 
     * @return 사용자 VO 객체
     */
    public UserVO userSelectOne(int seq) {
        UserVO uvo = null;

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE user_seq = ?")) {

            pstmt.setInt(1, seq);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                	System.out.println("음");
                    uvo = new UserVO();
                    uvo.setUser_seq(rs.getInt("user_seq"));
                    uvo.setUserid(rs.getString("userid"));
                    uvo.setUsername(rs.getString("username"));
                    uvo.setPassword(rs.getString("password"));
                    uvo.setUseremail(rs.getString("email"));
                    uvo.setUpdated_date(rs.getString("updated_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 추가적인 예외 처리
        }

        return uvo;
    }

    /**
     * 사용자 삭제
     * 
     * @param user_seq 삭제할 사용자의 seq
     * @return 삭제된 행 수
     */
    public int userDelete(int seq) {
        int deleteRows = 0;

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM users WHERE user_seq = ?")) {

            pstmt.setInt(1, seq);
            deleteRows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // 추가적인 예외 처리
        }
        return deleteRows;
    }

    /**
     * 사용자 수정
     * 
     * @param uvo 수정할 사용자 정보를 담고 있는 UserVO 객체
     * @return 수정된 행 수
     */
    public int userUpdate(UserVO uvo) {
        int updateRows = 0;

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                 "UPDATE users SET username = ?, password = ?, email = ? WHERE userid = ?")) {

            pstmt.setString(1, uvo.getUsername());
            pstmt.setString(2, uvo.getPassword());
            pstmt.setString(3, uvo.getUseremail());
            pstmt.setString(4, uvo.getUserid());
            updateRows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // 추가적인 예외 처리
        }
        return updateRows;
    }
}
