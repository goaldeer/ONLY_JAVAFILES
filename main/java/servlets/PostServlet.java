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
	private static final String[] ALLOWED_EXTENSIONS = { "jpeg", "jpg", "png" };
	
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
        String fileElementName = (String) files.nextElement();
        String uploadedFileName = multi.getFilesystemName(fileElementName);
        
        PostBean post = new PostBean();
        post.setPostName(postName);
        post.setPostContent(postContent);
        post.setPostUser(postUser);
        //post.setPostPhoto(postPhoto);
        
        
        

        try {
            /*PostDAO.addPost(post);

            List<PostBean> lastPost = PostDAO.getAllPosts();

            if (lastPost.isEmpty()) {
                throw new ServletException("No posts found after insertion");
            }

            int postId = lastPost.get(0).getPostId();

            if (uploadedFileName != null && !uploadedFileName.isEmpty()) {
                String extension = uploadedFileName.substring(uploadedFileName.lastIndexOf(".") + 1).toLowerCase();
                String postPhoto = postId + "." + extension;

                File uploadedFile = new File(uploadPath, uploadedFileName);
                File newFile = new File(uploadPath, postPhoto);
                uploadedFile.renameTo(newFile);

            }*/
        	
        	if (uploadedFileName != null && !uploadedFileName.isEmpty()) {
                File uploadedFile = new File(uploadPath, uploadedFileName);
                String extension = uploadedFileName.substring(uploadedFileName.lastIndexOf(".") + 1).toLowerCase();

                if (!extension.equals("jpg") && !extension.equals("jpeg") && !extension.equals("png")) {
                    throw new ServletException("Invalid file extension");
                }

                // 파일을 바이트 배열로 읽기
                byte[] fileData = null;
                try (InputStream inputStream = new FileInputStream(uploadedFile)) {
                    fileData = new byte[(int) uploadedFile.length()];
                    inputStream.read(fileData);
                }

                post.setPostPhoto(fileData); // 파일 데이터를 설정
                post.setPostPhotoExtension(extension); // 확장자를 설정

                PostDAO.addPost(post); // 데이터베이스에 저장

                uploadedFile.delete(); // 임시 파일 삭제
            } else {
                PostDAO.addPost(post); // 파일이 없을 경우 기본 정보만 저장
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
