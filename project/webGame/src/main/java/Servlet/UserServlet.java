package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import User.UserDAO;
import User.UserVO;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("logout".equals(action)) {
            // 로그아웃 처리
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
        } else if ("delete".equals(action)) {
            // 사용자 삭제
            int user_seq = Integer.parseInt(request.getParameter("seq"));
            userDAO.userDelete(user_seq);
            response.sendRedirect("mypage.jsp");
        } else if ("edit".equals(action)) {
            // 사용자 정보 수정 페이지로 이동
            int user_seq = Integer.parseInt(request.getParameter("seq"));
            UserVO user = userDAO.userSelectOne(user_seq);
            request.setAttribute("user", user);
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
        } else {
            response.sendRedirect("mypage.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String pagecode = request.getParameter("pagecode");
        UserDAO userDAO = new UserDAO();

        if ("register".equals(pagecode)) {
            // 회원가입 처리
            String nickname = request.getParameter("nickname");
            String userid = request.getParameter("id");
            String useremail = request.getParameter("userid");
            String emailDomain = request.getParameter("emailDomain");
            String otherDomain = request.getParameter("otherDomain");
            String password = request.getParameter("password");

            // 이메일 도메인 결정
            String email = otherDomain != null && !otherDomain.isEmpty() ? useremail + "@" + otherDomain
                    : useremail + "@" + emailDomain;

            // UserVO 생성
            UserVO uvo = new UserVO();
            uvo.setUserid(userid);
            uvo.setUsername(nickname);
            uvo.setPassword(password);
            uvo.setUseremail(email);

            // UserDAO 사용하여 db에 삽입
            int result = userDAO.userInsert(uvo);

            if (result > 0) {
                // 회원가입 성공
                response.sendRedirect("login.jsp");
            } else {
                // 회원가입 실패
                response.sendRedirect("register.jsp");
            }
        } else if ("login".equals(pagecode)) {
            // 로그인 처리
            String userid = request.getParameter("userid");
            String password = request.getParameter("password");

            UserVO user = userDAO.login(userid, password);

            if (user != null) {
                // 로그인 성공
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("index.jsp");
            } else {
                // 로그인 실패
                response.sendRedirect("login.jsp?error=1");
            }
        } else if ("update".equals(pagecode)) {
            // 사용자 정보 업데이트
            int user_seq = Integer.parseInt(request.getParameter("seq"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String userid = request.getParameter("userid");

            // 파라미터 값 확인 로그
            System.out.println("user_seq: " + user_seq);
            System.out.println("username: " + username);
            System.out.println("email: " + email);
            System.out.println("password: " + password);
            System.out.println("userid: " + userid);

            UserVO user = new UserVO();
            user.setUser_seq(user_seq);
            user.setUsername(username);
            user.setUseremail(email);
            user.setPassword(password);
            user.setUserid(userid);

            int result = userDAO.userUpdate(user);

            // 업데이트 결과 확인 로그
            System.out.println("Update result: " + result);

            if (result > 0) {
                response.sendRedirect("mypage.jsp?update=success");
            } else {
                response.sendRedirect("mypage.jsp?update=failure");
            }
        }
    }
}
