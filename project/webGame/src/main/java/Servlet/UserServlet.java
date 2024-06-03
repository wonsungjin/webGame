package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UserServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//로그아웃
		HttpSession session = request.getSession();
		//일괄
		session.invalidate();
		//세션 유효타임 0초
		session.setMaxInactiveInterval(0);
		//메인페이지로 이동
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("포스트방식호출");
		/*
		String pagecode = request.getParameter("pagecode");
		UserDAO dao = new UserDAO();

		// -------------------register --------------------
		if (pagecode.equals("P001")) {
			// seq - user_seq.nextval
			String userid = request.getParameter("userid");
			String uname = request.getParameter("uname");
			String email = request.getParameter("email");
			String passwd = request.getParameter("passwd");
			// regdate - sysdate

			UserVO uvo = new UserVO();
			uvo.setUserid(userid);
			uvo.setUname(uname);
			uvo.setEmail(email);
			uvo.setPasswd(passwd);

			int insertRows = dao.userInsert(uvo);
			if (insertRows == 1) {
				// 회원가입 성공
				response.sendRedirect("index.jsp");
			} else {
				// 회원가입 실패
				response.sendRedirect("500.html");
			}

			// -------------------login --------------------
		} else if (pagecode.equals("P002")) {
			String userid = request.getParameter("userid");
			String passwd = request.getParameter("passwd");

			// boolean loginCheck = dao.userLogin(userid, passwd);
			// if(loginCheck == true) {

			UserVO uvo = dao.userLogin(userid, passwd);
			if (uvo != null) {
				// if(uvo.getLoginCheck()) {
				// 로그인 성공

				System.out.println("--------- 세션 할당 ------------" + uvo.getGrade());
				// userid, uname, grade
				HttpSession session = request.getSession();
				session.setAttribute("KEY_SESS_USERID", uvo.getUserid());
				session.setAttribute("KEY_SESS_UNAME", uvo.getUname());
				session.setAttribute("KEY_SESS_GRADE", uvo.getGrade());
				response.sendRedirect("index.jsp");
			} else {
				// 로그인 실패
				response.sendRedirect("500.html");
			}

			// -------------------other --------------------
		} else {
			response.sendRedirect("500.html");
		}
		*/
	}

}