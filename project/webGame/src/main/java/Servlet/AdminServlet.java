package Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import User.UserDAO;
import User.UserVO;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");

		if (user == null || !user.getUserid().contains("admin")) {
			response.sendRedirect("index.jsp");
			return;
		}

		if ("adminpage".equals(action)) {
			try {
				UserDAO userDAO = new UserDAO();
				List<UserVO> allUsers = userDAO.userSelectAll();
				request.setAttribute("allUsers", allUsers);
				request.getRequestDispatcher("adminpage.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("index.jsp");
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}
}
