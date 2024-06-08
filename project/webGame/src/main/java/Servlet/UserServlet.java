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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");

		UserDAO userDAO = new UserDAO();
		ReplyDAO replyDAO = new ReplyDAO();

		if ("logout".equals(action)) {
			request.getSession().invalidate();
			response.sendRedirect("index.jsp");
		} else if ("delete".equals(action)) {
			int user_seq = Integer.parseInt(request.getParameter("seq"));
			userDAO.userDelete(user_seq);
			response.sendRedirect("mypage.jsp");
		} else if ("edit".equals(action)) {
			int user_seq = Integer.parseInt(request.getParameter("seq"));
			UserVO user = userDAO.userSelectOne(user_seq);
			request.setAttribute("user", user);
			request.getRequestDispatcher("editUser.jsp").forward(request, response);
		} else if ("mypage".equals(action)) {
			HttpSession session = request.getSession();
			UserVO user = (UserVO) session.getAttribute("user");
			if (user != null) {
				ArrayList<ReplyVO> userReplies = replyDAO.replyUserSelect(user.getUser_seq());
				session.setAttribute("userReplies", userReplies);
				response.sendRedirect("mypage.jsp");
			} else {
				response.sendRedirect("login.jsp");
			}
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
			String nickname = request.getParameter("nickname");
			String userid = request.getParameter("id");
			String useremail = request.getParameter("userid");
			String emailDomain = request.getParameter("emailDomain");
			String otherDomain = request.getParameter("otherDomain");
			String password = request.getParameter("password");

			String email = otherDomain != null && !otherDomain.isEmpty() ? useremail + "@" + otherDomain
					: useremail + "@" + emailDomain;

			UserVO uvo = new UserVO();
			uvo.setUserid(userid);
			uvo.setUsername(nickname);
			uvo.setPassword(password);
			uvo.setUseremail(email);

			int result = userDAO.userInsert(uvo);

			if (result > 0) {
				response.sendRedirect("login.jsp");
			} else {
				response.sendRedirect("register.jsp");
			}
		} else if ("login".equals(pagecode)) {
			String userid = request.getParameter("userid");
			String password = request.getParameter("password");

			UserVO user = userDAO.login(userid, password);

			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				response.sendRedirect("index.jsp");
			} else {
				response.sendRedirect("login.jsp?error=1");
			}
		} else if ("update".equals(pagecode)) {
			int user_seq = Integer.parseInt(request.getParameter("seq"));
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String userid = request.getParameter("userid");

			UserVO user = new UserVO();
			user.setUser_seq(user_seq);
			user.setUsername(username);
			user.setUseremail(email);
			user.setPassword(password);
			user.setUserid(userid);

			int result = userDAO.userUpdate(user);

			if (result > 0) {
				response.sendRedirect("mypage.jsp?update=success");
			} else {
				response.sendRedirect("mypage.jsp?update=failure");
			}
		}
	}
}
