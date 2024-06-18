package servlets;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import beans.UserBean;
import dao.UserDAO;

@WebServlet("/changeLocation")
public class ChangeLocationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	
        String userId = (String) request.getSession().getAttribute("userId");
        
        if (userId != null) {
        	String userAddress = request.getParameter("userAddress");
            String userLocation = request.getParameter("userLocation");
            System.out.println(userId + " " + userAddress + " " + userLocation);
            try {

            	UserDAO.setUserAddressById(userId, userAddress, userLocation);
            	response.sendRedirect("profile.jsp");
                
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
        	
        	request.getSession().setAttribute("userLocation", request.getParameter("userLocation"));
        	response.sendRedirect("main.jsp");
        }
        
        
        
    }
}
