<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="dao.PostDAO" %>
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

<style>
        table {
            width: 90%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .post-id, .post-date {
            width: 5%;
            white-space: nowrap;
        }
        .post-title {
            width: 70%;
        }
        .post-author {
            width: 20%;
        }
    </style>

<body>
    <h2>게시판</h2>
    <a href="profile.jsp">내 프로필</a> | <a href="logout.jsp">로그아웃</a><br><br>
    
    <%-- <form action="post" method="post" enctype="multipart/form-data"> --%>
    <fieldset>
    <legend>게시글 작성</legend>
    <form action="post" method="post">
        <label>Title:</label><input type="text" name="postName" required><br>
        <label>Content:</label><textarea name="postContent" required rows="10" cols="30"></textarea><br>
        <%-- <label>Photo:</label><input type="file" name="postPhoto"><br> --%>
        <input type="submit" value="Post">
    </form>
    </fieldset>
    
    <br>
    
    <fieldset width=90%>
            	<legend>게시판</legend>
            	<br>
            	<table border="1", align='center'>
                <tr>
                    <th width=7%>ID</th>
                    <th>제목</th>
                    <th width=15%>작성자</th>
                    <th width=13%>작성일</th>
                </tr>
                
    <%
    	request.setCharacterEncoding("utf-8");
    	List<PostBean> posts = PostDAO.getAllPosts();
        if (posts != null) {
            for (PostBean post : posts) {
            	%>
            	
                <tr>
                    <td onclick="location.href='postView.jsp?postId=<%= post.getPostId() %>'" style="cursor:pointer;"><%= post.getPostId() %></td>
                    <td onclick="location.href='postView.jsp?postId=<%= post.getPostId() %>'" style="cursor:pointer;"><%= post.getPostName() %></td>
                    <td onclick="location.href='profile.jsp?userId=<%= post.getPostUser() %>'" style="cursor:pointer;"><%= post.getPostUser() %></td>
                    <td><%= post.getPostTime() %></td>
                
            <%
            }
        }
            %>
            	</tr>
                </table>
               <br>
	</fieldset>
                
</body>
</html>
