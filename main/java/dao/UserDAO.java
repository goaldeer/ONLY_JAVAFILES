package dao;

import beans.UserBean;
import utils.DatabaseConnection;
import java.sql.*;

public class UserDAO {
    public static void addUser(UserBean user) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO users (userType, userAddress, userId, userPassword, userName, userLocation) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserType());
            pstmt.setString(2, user.getUserAddress());
            pstmt.setString(3, user.getUserId());
            pstmt.setString(4, user.getUserPassword());
            pstmt.setString(5, user.getUserName());
            pstmt.setString(6, user.getUserLocation());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public static UserBean getUserById(String userId) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        UserBean user = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE userId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new UserBean();
                user.setUserType(rs.getString("userType"));
                user.setUserAddress(rs.getString("userAddress"));
                user.setUserId(rs.getString("userId"));
                user.setUserPassword(rs.getString("userPassword"));
                user.setUserName(rs.getString("userName"));
                user.setUserLocation(rs.getString("userLocation"));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return user;
    }

    public static boolean setUserAddressById(String userId, String userAddress, String userLocation) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE users SET userAddress = ?, userLocation = ? WHERE userId = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userAddress);
            pstmt.setString(2, userLocation);
            pstmt.setString(3, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	return true;
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return true;
    }
    
    public static UserBean getUserByName(String userName) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        UserBean user = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE userName = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new UserBean();
                user.setUserType(rs.getString("userType"));
                user.setUserAddress(rs.getString("userAddress"));
                user.setUserId(rs.getString("userId"));
                user.setUserPassword(rs.getString("userPassword"));
                user.setUserName(rs.getString("userName"));
                user.setUserLocation(rs.getString("userLocation"));
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return user;
    }
    
    public static boolean validateUser(String userId, String userPassword) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isValid = false;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM users WHERE userId = ? AND userPassword = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, userPassword);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                isValid = true;
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return isValid;
    }
    
    public static boolean deleteUserById(String userId) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isDone = false;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM users WHERE userId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	isDone = true;
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
        return isDone;
    }
}
