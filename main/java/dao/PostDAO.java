package dao;

import beans.PostBean;
import utils.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    public static void addPost(PostBean post) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO posts (postName, postTime, postId, postUser, postContent, postPhoto, postPhotoExtension) VALUES (?, SYSDATE, post_seq.NEXTVAL, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, post.getPostName());
            pstmt.setString(2, post.getPostUser());
            pstmt.setString(3, post.getPostContent());
            pstmt.setBytes(4, post.getPostPhoto());
            pstmt.setString(5, post.getPostPhotoExtension());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public static List<PostBean> getAllPosts() throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<PostBean> posts = new ArrayList<>();
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM posts ORDER BY postTime DESC");
            while (rs.next()) {
                PostBean post = new PostBean();
                post.setPostName(rs.getString("postName"));
                post.setPostTime(rs.getDate("postTime"));
                post.setPostId(rs.getInt("postId"));
                post.setPostUser(rs.getString("postUser"));
                post.setPostContent(rs.getString("postContent"));
                post.setPostPhoto(rs.getBytes("postPhoto"));
                post.setPostPhotoExtension(rs.getString("postPhotoExtension"));
                posts.add(post);
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
        return posts;
    }
    
    public static List<PostBean> getPostsByPage(int page, int pageSize) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<PostBean> posts = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        int limit = page * pageSize;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM ("
                       + "SELECT a.*, ROWNUM rnum FROM ("
                       + "SELECT * FROM posts ORDER BY postTime DESC"
                       + ") a WHERE ROWNUM <= ?"
                       + ") WHERE rnum > ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                PostBean post = new PostBean();
                post.setPostName(rs.getString("postName"));
                post.setPostTime(rs.getDate("postTime"));
                post.setPostId(rs.getInt("postId"));
                post.setPostUser(rs.getString("postUser"));
                post.setPostContent(rs.getString("postContent"));
                post.setPostPhoto(rs.getBytes("postPhoto"));
                post.setPostPhotoExtension(rs.getString("postPhotoExtension"));
                posts.add(post);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return posts;
    }

    public static int getPostCount() throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        int count = 0;
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT COUNT(*) FROM posts");
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
        return count;
    }
    
    public static List<PostBean> getPostsByPageWithLocation(int page, int pageSize, String Location) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<PostBean> posts = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        int limit = page * pageSize;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM ("
                    + "SELECT a.*, ROWNUM rnum FROM ("
                    + "SELECT p.* FROM posts p "
                    + "JOIN users u ON p.postUser = u.userId "
                    + "WHERE u.userLocation = ? "
                    + "ORDER BY p.postTime DESC"
                    + ") a WHERE ROWNUM <= ?"
                    + ") WHERE rnum > ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, Location);
            pstmt.setInt(2, limit);
            pstmt.setInt(3, offset);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                PostBean post = new PostBean();
                post.setPostName(rs.getString("postName"));
                post.setPostTime(rs.getDate("postTime"));
                post.setPostId(rs.getInt("postId"));
                post.setPostUser(rs.getString("postUser"));
                post.setPostContent(rs.getString("postContent"));
                post.setPostPhoto(rs.getBytes("postPhoto"));
                post.setPostPhotoExtension(rs.getString("postPhotoExtension"));
                posts.add(post);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return posts;
    }

    public static int getPostCountWithLocation(String userLocation) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) "
                       + "FROM posts p "
                       + "JOIN users u ON p.postUser = u.userId "
                       + "WHERE u.userLocation = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userLocation);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return count;
    }

    
    public static PostBean getPostById(int postId) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PostBean post = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM posts WHERE postId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                post = new PostBean();
                post.setPostName(rs.getString("postName"));
                post.setPostTime(rs.getDate("postTime"));
                post.setPostId(rs.getInt("postId"));
                post.setPostUser(rs.getString("postUser"));
                post.setPostContent(rs.getString("postContent"));
                post.setPostPhoto(rs.getBytes("postPhoto"));
                post.setPostPhotoExtension(rs.getString("postPhotoExtension"));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return post;
    }

    public static void deletePost(int postId) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM posts WHERE postId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
}
