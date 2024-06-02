<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.UserBean" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="dao.PostDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    UserBean user = UserDAO.getUserById(userId);
    List<PostBean> posts = PostDAO.getAllPosts(); // For simplicity, fetch all posts
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
</head>
<body>
    <h2>Profile</h2>
    <p>Name: <%= user.getUserName() %></p>
    <p>Address: <%= user.getUserAddress() %></p>
    <h3>Posts</h3>
    <%
        if (posts != null) {
            for (PostBean post : posts) {
                if (post.getPostUser().equals(userId)) {
                    out.println("<div>");
                    out.println("<h3>" + post.getPostName() + "</h3>");
                    out.println("<p>" + post.getPostContent() + "</p>");
                    out.println("<p>Date: " + post.getPostTime() + "</p>");
                    out.println("</div>");
                }
            }
        }
    %>
    <a href="main.jsp">Back to Main</a>
</body>
</html>
