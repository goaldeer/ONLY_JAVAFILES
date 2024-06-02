package servlets;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String userPassword = request.getParameter("userPassword");

        try {
            if (UserDAO.validateUser(userId, userPassword)) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                response.sendRedirect("main.jsp");
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
