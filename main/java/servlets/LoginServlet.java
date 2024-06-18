package servlets;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import beans.UserBean;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        String userId = request.getParameter("userId");
        String userPassword = request.getParameter("userPassword");
        UserBean user = null;
		try {
			user = UserDAO.getUserById(userId);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        String userLocation = null;
        
        if (user.getUserType().equals("owner")) {
        	userLocation = user.getUserLocation();
        }
        
        try {
        	
            if (UserDAO.validateUser(userId, userPassword)) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("userLocation", userLocation);
                response.sendRedirect("main.jsp");
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
