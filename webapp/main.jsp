<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Posts</title>
</head>
<body>
    <h2>Posts</h2>
    <a href="profile.jsp">Profile</a> | <a href="logout.jsp">Logout</a>
    <form action="post" method="post" enctype="multipart/form-data">
        <label>Title:</label><input type="text" name="postName" required><br>
        <label>Content:</label><textarea name="postContent" required></textarea><br>
        <label>Photo:</label><input type="file" name="postPhoto"><br>
        <input type="submit" value="Post">
    </form>
    <%
        List<PostBean> posts = (List<PostBean>) request.getAttribute("posts");
        if (posts != null) {
            for (PostBean post : posts) {
                out.println("<div>");
                out.println("<h3>" + post.getPostName() + "</h3>");
                out.println("<p>" + post.getPostContent() + "</p>");
                out.println("<p>Author: " + post.getPostUser() + "</p>");
                out.println("<p>Date: " + post.getPostTime() + "</p>");
                out.println("</div>");
            }
        }
    %>
</body>
</html>
