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

@WebServlet("/CheckUserServlet")
public class CheckUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String userName = request.getParameter("userName");

        try {
            boolean idExists = UserDAO.getUserById(userId) != null;
            boolean nameExists = UserDAO.getUserByName(userName) != null;

            if (idExists && nameExists) {
                response.getWriter().write("ID_NAME_EXISTS");
            } else if (idExists) {
                response.getWriter().write("ID_EXISTS");
            } else if (nameExists) {
                response.getWriter().write("NAME_EXISTS");
            } else {
                response.getWriter().write("OK");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }
}
