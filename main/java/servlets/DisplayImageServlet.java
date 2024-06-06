package servlets;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import beans.PostBean;
import dao.PostDAO;

@WebServlet("/displayImage")
public class DisplayImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        
        
        try {
            PostBean post = PostDAO.getPostById(postId);
            if (post != null && post.getPostPhoto() != null && post.getPostPhotoExtension() != null) {
                response.setContentType("image/" + post.getPostPhotoExtension());
                OutputStream out = response.getOutputStream();
                out.write(post.getPostPhoto());
                out.close();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // Image not found
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

}
