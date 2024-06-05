package User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Common.MyOracleConnection;

public class UserDAO {

    // 사용자 정보를 데이터베이스에 삽입합니다.
    public int userInsert(UserVO uvo) {
        int insertRows = 0;
        String sql = "INSERT INTO users (user_seq, userid, username, password, email, created_date, updated_date) " +
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

    // 모든 사용자 정보를 조회합니다.
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
                uvo.setUseremail(rs.getString("email"));
                uvo.setCreated_date(rs.getString("created_date"));
                uvo.setUpdated_date(rs.getString("updated_date"));
                userList.add(uvo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }

    // 특정 사용자의 정보를 조회합니다.
    public UserVO userSelectOne(int user_seq) {
        UserVO uvo = null;
        String sql = "SELECT * FROM users WHERE user_seq = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, user_seq);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                	System.out.println("음");
                    uvo = new UserVO();
                    uvo.setUser_seq(rs.getInt("user_seq"));
                    uvo.setUserid(rs.getString("userid"));
                    uvo.setUsername(rs.getString("username"));
                    uvo.setPassword(rs.getString("password"));
                    uvo.setUseremail(rs.getString("email"));
                    uvo.setCreated_date(rs.getString("created_date"));
                    uvo.setUpdated_date(rs.getString("updated_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return uvo;
    }

    // 특정 사용자의 정보를 삭제합니다.
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

    // 사용자 정보 업데이트
    public int userUpdate(UserVO uvo) {
        int updateRows = 0;
        String sql = "UPDATE users SET username = ?, password = ?, email = ?, userid = ?, updated_date = SYSDATE WHERE user_seq = ?";

        try (Connection conn = new MyOracleConnection().myOracleDataSource().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            // 값 확인을 위한 로그 추가
            System.out.println("Updating user: " + uvo.toString());

            // 파라미터 설정
            pstmt.setString(1, uvo.getUsername());
            pstmt.setString(2, uvo.getPassword());
            pstmt.setString(3, uvo.getUseremail());
            pstmt.setString(4, uvo.getUserid());
            pstmt.setInt(5, uvo.getUser_seq());

            // 쿼리 실행 및 결과 확인
            updateRows = pstmt.executeUpdate();
            System.out.println("Rows updated: " + updateRows);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updateRows;
    }

    // 사용자 로그인 검사
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
                    user.setUseremail(rs.getString("email"));
                    user.setCreated_date(rs.getString("created_date"));
                    user.setUpdated_date(rs.getString("updated_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // 주어진 ID에 대해 중복을 검사합니다.
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

    // 주어진 닉네임에 대해 중복을 검사합니다.
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

    // 주어진 이메일에 대해 중복을 검사합니다.
    public boolean checkDuplicateEmail(String email) {
        boolean isDuplicate = false;
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

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
