package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import User.UserDAO;

@WebServlet("/CheckDuplicateFieldServlet")
public class CheckDuplicateFieldServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String field = request.getParameter("field");
        String value = request.getParameter("value");

        UserDAO userDAO = new UserDAO();
        boolean isDuplicate = false;

        if ("id".equals(field)) {
            isDuplicate = userDAO.checkDuplicateId(value);
        } else if ("nickname".equals(field)) {
            isDuplicate = userDAO.checkDuplicateNickname(value);
        } else if ("email".equals(field)) {
            isDuplicate = userDAO.checkDuplicateEmail(value);
        }

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        if (isDuplicate) {
            response.getWriter().write("DUPLICATE");
        } else {
            response.getWriter().write("AVAILABLE");
        }
    }
}
