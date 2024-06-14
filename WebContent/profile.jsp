<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.UserBean" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="dao.PostDAO" %>
<%

    String userId = request.getParameter("userId");
    if (userId == null) {
        userId = (String) session.getAttribute("userId");
    }
    
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
    <title>나의 프로필</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>
    <div class="container">
    <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <h2>프로필</h2>
        <div class="profile-info">
            <p>유저 이름 : <%= user.getUserName() %></p>
            <% if(user.getUserType().equals("owner")) { %>
            <p>주소 : <%= user.getUserAddress() %></p>
            <% } %>
        </div>

        <fieldset class="mb-4">
            <legend>나의 게시글</legend>
            <table class="table table-bordered">
                <tr>
                    <th width="7%">ID</th>
                    <th>제목</th>
                    <th width="15%">작성자</th>
                    <th width="13%">작성일</th>
                    <th>삭제</th>
                </tr>
                <%
                if (posts != null) {
                    for (PostBean post : posts) {
                        if (post.getPostUser().equals(userId)) {
                %>
                    <tr>
                        <td onclick="location.href='postView.jsp?postId=<%= post.getPostId() %>'" style="cursor:pointer;"><%= post.getPostId() %></td>
                        <td onclick="location.href='postView.jsp?postId=<%= post.getPostId() %>'" style="cursor:pointer;"><%= post.getPostName() %></td>
                        <td onclick="location.href='profile.jsp?userId=<%= post.getPostUser() %>'" style="cursor:pointer;"><%= post.getPostUser() %></td>
                        <td><%= post.getPostTime() %></td>
                        <td>
                            <form action="deletePost.jsp" method="post">
                                <input type="hidden" name="postId" value="<%= post.getPostId() %>" />
                                <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    }
                }
                %>
            </table>
        </fieldset>
        
        <div class="text-center">
            <a href="main.jsp" class="btn btn-outline-primary">Back to Main</a>
        </div>
    </div>
</body>
</html>
