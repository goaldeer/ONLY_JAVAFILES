package dao;

import beans.CommentBean;
import utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
    public static void addComment(CommentBean comment) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO comments (commentid, postId, author, content, createdAt) VALUES (comment_seq.NEXTVAL, ?, ?, ?, SYSDATE)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, comment.getPostId());
            pstmt.setString(2, comment.getAuthor());
            pstmt.setString(3, comment.getContent());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public static List<CommentBean> getCommentsByPostId(int postId) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<CommentBean> comments = new ArrayList<>();
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM comments WHERE postId = ? ORDER BY createdAt DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CommentBean comment = new CommentBean();
                comment.setcommentId(rs.getInt("commentid"));
                comment.setPostId(rs.getInt("postId"));
                comment.setAuthor(rs.getString("author"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getDate("createdAt"));
                comments.add(comment);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return comments;
    }
    public static void deletecomment(int commentid) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM comments WHERE commentid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commentid);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
}
