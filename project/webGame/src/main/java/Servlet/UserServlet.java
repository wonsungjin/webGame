package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        // 로그아웃 처리
        request.getSession().invalidate();
        response.sendRedirect("index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // form 데이터
        String pagecode = request.getParameter("pagecode");

        // 회원가입 처리
        if ("register".equals(pagecode)) {
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

            // UserDAO사용하여 db에 삽입
            UserDAO userDAO = new UserDAO();
            int result = userDAO.userInsert(uvo);

            if (result > 0) {
                // 회원가입 성공
                response.sendRedirect("login.jsp");
            } else {
                // 회원가입 실패
                response.sendRedirect("register.jsp");
            }
        }
        // 로그인 처리
        else if ("login".equals(pagecode)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // 여기부터에 로그인 처리 코드 작성
            
            // 유효성검사

            // 로그인 성공 시 세션 처리
        }
        
    }
}
