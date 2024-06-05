package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Reply.ReplyDAO;
import Reply.ReplyVO;
import User.UserDAO;
import User.UserVO;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserServlet() {
        super();
    }

    /**
     * GET 요청을 처리하는 메서드
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 요청 파라미터의 인코딩을 설정
        request.setCharacterEncoding("UTF-8");

        // action 파라미터를 가져옴
        String action = request.getParameter("action");

        // DAO 객체 생성
        UserDAO userDAO = new UserDAO();
        ReplyDAO replyDAO = new ReplyDAO();

        // action에 따른 처리 분기
        if ("logout".equals(action)) {
            // 로그아웃 처리
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
        } else if ("delete".equals(action)) {
            // 사용자 삭제 처리
            int user_seq = Integer.parseInt(request.getParameter("seq"));
            userDAO.userDelete(user_seq);
            response.sendRedirect("mypage.jsp");
        } else if ("edit".equals(action)) {
            // 사용자 정보 수정 페이지로 이동
            int user_seq = Integer.parseInt(request.getParameter("seq"));
            UserVO user = userDAO.userSelectOne(user_seq);
            request.setAttribute("user", user);
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
        } else if ("mypage".equals(action)) {
            // 마이페이지 요청 처리
            HttpSession session = request.getSession();
            UserVO user = (UserVO) session.getAttribute("user");
            if (user != null) {
                // 사용자 정보가 있을 경우 댓글 데이터를 가져옴
                ArrayList<ReplyVO> userReplies = replyDAO.replyUserSelect(user.getUser_seq());
                session.setAttribute("userReplies", userReplies);
                response.sendRedirect("mypage.jsp");
            } else {
                // 사용자 정보가 없을 경우 로그인 페이지로 리다이렉트
                response.sendRedirect("login.jsp");
            }
        } else {
            // 알 수 없는 action에 대한 처리
            response.sendRedirect("mypage.jsp");
        }
    }

    /**
     * POST 요청을 처리하는 메서드
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 요청 파라미터의 인코딩을 설정
        request.setCharacterEncoding("UTF-8");

        // pagecode 파라미터를 가져옴
        String pagecode = request.getParameter("pagecode");

        // DAO 객체 생성
        UserDAO userDAO = new UserDAO();

        // pagecode에 따른 처리 분기
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

            // UserVO 객체 생성 및 값 설정
            UserVO uvo = new UserVO();
            uvo.setUserid(userid);
            uvo.setUsername(nickname);
            uvo.setPassword(password);
            uvo.setUseremail(email);

            // UserDAO를 사용하여 데이터베이스에 사용자 삽입
            int result = userDAO.userInsert(uvo);

            if (result > 0) {
                // 회원가입 성공 시 로그인 페이지로 리다이렉트
                response.sendRedirect("login.jsp");
            } else {
                // 회원가입 실패 시 회원가입 페이지로 리다이렉트
                response.sendRedirect("register.jsp");
            }
        } else if ("login".equals(pagecode)) {
            // 로그인 처리
            String userid = request.getParameter("userid");
            String password = request.getParameter("password");

            // 사용자 인증
            UserVO user = userDAO.login(userid, password);

            if (user != null) {
                // 로그인 성공 시 세션에 사용자 정보 저장 후 인덱스 페이지로 리다이렉트
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("index.jsp");
            } else {
                // 로그인 실패 시 로그인 페이지로 리다이렉트
                response.sendRedirect("login.jsp?error=1");
            }
        } else if ("update".equals(pagecode)) {
            // 사용자 정보 업데이트 처리
            int user_seq = Integer.parseInt(request.getParameter("seq"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String userid = request.getParameter("userid");

            // UserVO 객체 생성 및 값 설정
            UserVO user = new UserVO();
            user.setUser_seq(user_seq);
            user.setUsername(username);
            user.setUseremail(email);
            user.setPassword(password);
            user.setUserid(userid);

            // UserDAO를 사용하여 사용자 정보 업데이트
            int result = userDAO.userUpdate(user);

            if (result > 0) {
                // 업데이트 성공 시 마이페이지로 리다이렉트
                response.sendRedirect("mypage.jsp?update=success");
            } else {
                // 업데이트 실패 시 마이페이지로 리다이렉트
                response.sendRedirect("mypage.jsp?update=failure");
            }
        }
    }
}
