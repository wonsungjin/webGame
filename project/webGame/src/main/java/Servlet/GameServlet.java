package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import GameTable.GameTableDAO;
import GameTable.GameTableVO;
import Reply.ReplyDAO;
import Reply.ReplyVO;
import User.UserDAO;
import User.UserVO;

@WebServlet("/GameServlet")
public class GameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GameServlet() {
		super();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String webGLName = request.getParameter("webGLName");
		 HttpSession session = request.getSession();
         UserVO user = (UserVO) session.getAttribute("user");
		UserDAO udao = new UserDAO();
		ReplyDAO rdao = new ReplyDAO();
		if(user != null) {
		    UserVO uvo = udao.userSelectOne(user.getUser_seq());
		    ArrayList<ReplyVO> rvoList = rdao.replyUserSelect(webGLName);
		    request.setAttribute("KEY_userVO", uvo);
		    request.setAttribute("KEY_webGLName", webGLName);
		    request.setAttribute("KEY_replyVOList", rvoList);
		    RequestDispatcher rd = request.getRequestDispatcher("community.jsp");
		    rd.forward(request, response);
		} else {
		    response.sendRedirect("login.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String webGLName = request.getParameter("webGLName");
		String pagecode = request.getParameter("pagecode");
		ReplyDAO rdao = new ReplyDAO();
		Gson gson = new Gson();
		if(pagecode.equals("replyUpdate"))
		{
			String updatedDate = request.getParameter("updatedDate");
	        String userSeq = request.getParameter("userSeq");
	        String replySeq = request.getParameter("replySeq");
	        String createdDate = request.getParameter("createdDate");
	        String replyContent = request.getParameter("replyContent");
	        
			ReplyVO rvo = new ReplyVO();
			rvo.setReply(replyContent);
			rvo.setUser_seq(Integer.parseInt(userSeq));
			rvo.setReply_seq(Integer.parseInt(replySeq));
			rvo.setCreated_date(createdDate);
			rdao.replyUpdate(rvo);
			
			ArrayList<ReplyVO> rvoList = rdao.replyUserSelect(webGLName);
			String gsonString = gson.toJson(rvoList);   
			
			PrintWriter out = response.getWriter();
			out.print(gsonString);
		}
		else if(pagecode.equals("replyDelete"))
		{
			String replySeq = request.getParameter("replySeq");
			rdao.replyDelete(Integer.parseInt(replySeq));
			
			ArrayList<ReplyVO> rvoList = rdao.replyUserSelect(webGLName);
			String gsonString = gson.toJson(rvoList);   
			
			PrintWriter out = response.getWriter();
			out.print(gsonString);
		}
		
		else if(pagecode.equals("replyInsert"))
		{
	        String userSeq = request.getParameter("userSeq");
	        String replyContent = request.getParameter("replyContent");
	        
			ReplyVO rvo = new ReplyVO();
			rvo.setReply(replyContent);
			rvo.setUser_seq(Integer.parseInt(userSeq));
			rvo.setWebGL(webGLName);
			rdao.replyInsert(rvo);
			
			ArrayList<ReplyVO> rvoList = rdao.replyUserSelect(webGLName);
			String gsonString = gson.toJson(rvoList);   
			
			PrintWriter out = response.getWriter();
			out.print(gsonString);
		}
		else if(pagecode.equals("gameTableAll"))
		{
			GameTableDAO gdao= new GameTableDAO();
			ArrayList<GameTableVO> gvolist =  gdao.GameTableSelectAll();
			
			String gsonString = gson.toJson(gvolist);
			PrintWriter out = response.getWriter();
			out.print(gsonString);
		}
		}

}