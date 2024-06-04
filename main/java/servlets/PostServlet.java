package servlets;

import beans.PostBean;
import dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/post")
public class PostServlet extends HttpServlet {
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postName = request.getParameter("postName");
        String postContent = request.getParameter("postContent");
        String postUser = (String) request.getSession().getAttribute("userId");

        Part filePart = request.getPart("postPhoto");
        byte[] postPhoto = null;
        if (filePart != null) {
            postPhoto = new byte[(int) filePart.getSize()];
            filePart.getInputStream().read(postPhoto);
        }

        PostBean post = new PostBean();
        post.setPostName(postName);
        post.setPostContent(postContent);
        post.setPostUser(postUser);
        post.setPostPhoto(postPhoto);

        try {
            PostDAO.addPost(post);
            response.sendRedirect("main.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<PostBean> posts = PostDAO.getAllPosts();
            request.setAttribute("posts", posts);
            request.getRequestDispatcher("main.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
