package servlets;

import beans.UserBean;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String userAddress = request.getParameter("userAddress");
        String userId = request.getParameter("userId");
        String userPassword = request.getParameter("userPassword");
        String userName = request.getParameter("userName");

        UserBean user = new UserBean();
        user.setUserType(userType);
        user.setUserAddress(userAddress);
        user.setUserId(userId);
        user.setUserPassword(userPassword);
        user.setUserName(userName);

        try {
            UserDAO.addUser(user);
            response.sendRedirect("login.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
