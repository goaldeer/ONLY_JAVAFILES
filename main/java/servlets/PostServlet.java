package servlets;

import beans.PostBean;
import dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.SQLException;
import java.util.List;
import java.util.Enumeration;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;


@WebServlet("/post")
public class PostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	
        //String postName = request.getParameter("postName");
        //String postContent = request.getParameter("postContent");
        String postUser = (String) request.getSession().getAttribute("userId");
        
        
        /*Part filePart = request.getPart("postPhoto");
        byte[] postPhoto = null;
        if (filePart != null) {
            postPhoto = new byte[(int) filePart.getSize()];
            filePart.getInputStream().read(postPhoto);
        }*/
        String uploadPath = getServletContext().getRealPath("/assets");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        MultipartRequest multi = new MultipartRequest(request, uploadPath, 5 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
	
		String postName = multi.getParameter("postName");
		String postContent = multi.getParameter("postContent");
		
		Enumeration files = multi.getFileNames();
		
        
        PostBean post = new PostBean();
        post.setPostName(postName);
        post.setPostContent(postContent);
        post.setPostUser(postUser);
        //post.setPostPhoto(postPhoto);

        try {
            //String postPhoto = String.valueOf(post.getPostId());
            //String postPhotoName = multi.getFilesystemName(postPhoto);
            PostDAO.addPost(post);
            int postId = post.getPostId();
            String postPhoto = String.valueOf(postId);
            String uploadedFileName = multi.getFilesystemName(String.valueOf(post.getPostId()));

            if (uploadedFileName != null) {
                File uploadedFile = new File(uploadPath, uploadedFileName);
                File newFile = new File(uploadPath, postPhoto);
                uploadedFile.renameTo(newFile);
            }
            
            response.sendRedirect("main.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<PostBean> posts = PostDAO.getAllPosts();
            request.setCharacterEncoding("utf-8");
            request.setAttribute("posts", posts);
            request.getRequestDispatcher("main.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
