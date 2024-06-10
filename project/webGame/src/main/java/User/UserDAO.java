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
     * 사용자 정보를 데이터베이스에 삽입합니다.
     *
     * @param uvo 사용자 정보가 담긴 UserVO 객체
     * @return 삽입된 행의 개수
     */
    public int userInsert(UserVO uvo) {
        int insertRows = 0;
        String sql = "INSERT INTO users (user_seq, userid, username, password, useremail, created_date, updated_date) " +
                     "VALUES (users_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, SYSDATE)";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, uvo.getUserid());
            pstmt.setString(2, uvo.getUsername());
            pstmt.setString(3, uvo.getPassword());
            pstmt.setString(4, uvo.getUseremail());
            insertRows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return insertRows;
    }

    /**
     * 모든 사용자 정보를 조회합니다.
     *
     * @return 사용자 정보가 담긴 UserVO 객체의 리스트
     */
    public List<UserVO> userSelect() {
        List<UserVO> userList = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                UserVO uvo = new UserVO();
                uvo.setUser_seq(rs.getInt("user_seq"));
                uvo.setUserid(rs.getString("userid"));
                uvo.setUsername(rs.getString("username"));
                uvo.setPassword(rs.getString("password"));
                uvo.setUseremail(rs.getString("useremail"));
                uvo.setCreated_date(rs.getString("created_date"));
                uvo.setUpdated_date(rs.getString("updated_date"));
                userList.add(uvo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }

    /**
     * 특정 사용자의 정보를 조회합니다.
     *
     * @param user_seq 사용자 고유 번호
     * @return 사용자 정보가 담긴 UserVO 객체
     */
    public UserVO userSelectOne(int user_seq) {
        UserVO uvo = null;
        String sql = "SELECT * FROM users WHERE user_seq = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, user_seq);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    uvo = new UserVO();
                    uvo.setUser_seq(rs.getInt("user_seq"));
                    uvo.setUserid(rs.getString("userid"));
                    uvo.setUsername(rs.getString("username"));
                    uvo.setPassword(rs.getString("password"));
                    uvo.setUseremail(rs.getString("useremail"));
                    uvo.setCreated_date(rs.getString("created_date"));
                    uvo.setUpdated_date(rs.getString("updated_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return uvo;
    }
    
    /**
     * 모든 사용자의 정보를 조회
     *
     * @param user_seq 사용자 고유 번호
     * @return 사용자 정보가 담긴 UserVO 객체
     */
    public List<UserVO> userSelectAll() throws SQLException {
        List<UserVO> userList = new ArrayList<>();
        String sql = "SELECT * FROM users"; // 적절한 SQL 쿼리를 작성합니다.

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                UserVO user = new UserVO();
                user.setUser_seq(rs.getInt("user_seq"));
                user.setUserid(rs.getString("userid"));
                user.setUsername(rs.getString("username"));
                user.setUseremail(rs.getString("useremail"));
                user.setCreated_date(rs.getString("created_date"));
                user.setUpdated_date(rs.getString("updated_date"));
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

        return userList;
    }

    /**
     * 특정 사용자의 정보를 삭제합니다.
     *
     * @param user_seq 사용자 고유 번호
     * @return 삭제된 행의 개수
     */
    public int userDelete(int user_seq) {
        int deleteRows = 0;
        String sql = "DELETE FROM users WHERE user_seq = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, user_seq);
            deleteRows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deleteRows;
    }

    /**
     * 사용자 정보를 업데이트합니다.
     *
     * @param uvo 업데이트할 사용자 정보가 담긴 UserVO 객체
     * @return 업데이트된 행의 개수
     */
    public int userUpdate(UserVO uvo) {
        int updateRows = 0;
        String sql = "UPDATE users SET username = ?, password = ?, useremail = ?, userid = ?, updated_date = SYSDATE WHERE user_seq = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, uvo.getUsername());
            pstmt.setString(2, uvo.getPassword());
            pstmt.setString(3, uvo.getUseremail());
            pstmt.setString(4, uvo.getUserid());
            pstmt.setInt(5, uvo.getUser_seq());

            updateRows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updateRows;
    }

    /**
     * 사용자 로그인 검사
     *
     * @param userid 사용자 아이디
     * @param password 사용자 비밀번호
     * @return 로그인된 사용자 정보가 담긴 UserVO 객체
     */
    public UserVO login(String userid, String password) {
        UserVO user = null;
        String sql = "SELECT * FROM users WHERE userid = ? AND password = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new UserVO();
                    user.setUser_seq(rs.getInt("user_seq"));
                    user.setUserid(rs.getString("userid"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setUseremail(rs.getString("useremail"));
                    user.setCreated_date(rs.getString("created_date"));
                    user.setUpdated_date(rs.getString("updated_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    /**
     * 주어진 ID에 대해 중복을 검사합니다.
     *
     * @param userid 사용자 아이디
     * @return 중복 여부 (true: 중복됨, false: 중복되지 않음)
     */
    public boolean checkDuplicateId(String userid) {
        boolean isDuplicate = false;
        String sql = "SELECT COUNT(*) FROM users WHERE userid = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    isDuplicate = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDuplicate;
    }

    /**
     * 주어진 닉네임에 대해 중복을 검사합니다.
     *
     * @param nickname 사용자 닉네임
     * @return 중복 여부 (true: 중복됨, false: 중복되지 않음)
     */
    public boolean checkDuplicateNickname(String nickname) {
        boolean isDuplicate = false;
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, nickname);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    isDuplicate = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDuplicate;
    }

    /**
     * 주어진 이메일에 대해 중복을 검사합니다.
     *
     * @param email 사용자 이메일
     * @return 중복 여부 (true: 중복됨, false: 중복되지 않음)
     */
    public boolean checkDuplicateEmail(String email) {
        boolean isDuplicate = false;
        String sql = "SELECT COUNT(*) FROM users WHERE useremail = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    isDuplicate = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDuplicate;
    }
}
