package servlets;

import beans.CommentBean;
import dao.CommentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/add_comment")
public class AddCommentServlet extends HttpServlet {
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String postId = request.getParameter("postId");
        String author = (String) request.getSession().getAttribute("userId");
        String content = request.getParameter("content");

        CommentBean comment = new CommentBean();
        comment.setPostId(Integer.parseInt(postId));
        comment.setAuthor(author);
        comment.setContent(content);

        try {
            CommentDAO.addComment(comment);
            response.sendRedirect("postView.jsp?postId=" + postId);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
