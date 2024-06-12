<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="beans.CommentBean" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="dao.CommentDAO" %>
<%
    String userId = (String) session.getAttribute("userId");

    String postId = request.getParameter("postId");
    PostBean post = PostDAO.getPostById(Integer.parseInt(postId));
    List<CommentBean> comments = CommentDAO.getCommentsByPostId(Integer.parseInt(postId));
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= post.getPostName() %></title>
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
        .comment-section {
            margin-top: 20px;
            width: 90%;
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #f9f9f9;
        }
        .comment {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }
        .comment:last-child {
            border-bottom: none;
        }
        .comment strong {
            color: #333;
        }
        .comment em {
            color: #666;
        }
    </style>
</head>

<body>
    <br>
    <a href="main.jsp">게시판으로</a>
    <br><br><br><br>

    <fieldset width=90%>
        <br>
        <table border="1" align='center'>
            <tr>
                <th width=7%>ID</th>
                <th>제목</th>
                <th width=15%>작성자</th>
                <th width=13%>작성일</th>
            </tr>

            <%
            if (post != null) {
            %>
                <tr>
                    <td><%= post.getPostId() %></td>
                    <td><%= post.getPostName() %></td>
                    <td onclick="location.href='profile.jsp?userId=<%= post.getPostUser() %>'" style="cursor:pointer;"><%= post.getPostUser() %></td>
                    <td><%= post.getPostTime() %></td>
                </tr>
                <tr>
                    <td align="center" colspan=4>
                    <%
                    if (post.getPostPhoto() != null) {
                    %>
                        <img class="card-img-bottom d-block" src="<%= request.getContextPath() %>/displayImage?postId=<%= post.getPostId() %>" alt=""><br>
                    <%
                    }
                    %>
                    <%= post.getPostContent().replaceAll("\n", "<br/>") %>
                    </td>
                </tr>

                <%
                if (userId.equals(post.getPostUser())) {
                %>
                <tr>
                    <td align="right" colspan=4>
                    <form action="deletePost.jsp" method="post">
                        <input type="hidden" name="postId" value="<%= post.getPostId() %>" />
                        <input type="submit" value="삭제">
                    </form>
                    </td>
                </tr>
                <%
                }
            }
            %>
        </table>
        <br><br>
    </fieldset>
    
    <%-- 댓글 작성 부분 --%>
    <fieldset> 
	    <legend>댓글 작성</legend>
        <form action="add_comment" method="post">
            <input type="hidden" name="postId" value="<%= post.getPostId() %>">
            <label for="content">댓글 내용:</label>
            <textarea name="content" id="content" required></textarea>
            <br>
            <button type="submit">댓글 추가</button>
        </form>
    </fieldset>
  
    <%-- 댓글 열람 부분 --%>
    <fieldset class="comment-section">
        <legend>댓글</legend>
        <h3>댓글 목록</h3>
        <%
        if (comments != null && !comments.isEmpty()) {
            for (CommentBean comment : comments) {
        %>
            <div class="comment">
                <p><strong><%= comment.getAuthor() %></strong> <em><%= comment.getCreatedAt() %></em></p>
                <p><%= comment.getContent().replaceAll("\n", "<br/>") %></p>
            </div>
            <% if (userId.equals(post.getPostUser())) { %>
            	<form action="deleteComment.jsp" method="post">
            	<input type="hidden" name="commentId" value="<%= comment.getcommentId() %>" />
        		<input type="submit" value="삭제">
    			</form> 
    		<% 
            }
        
            }
        } else {
        %>
            <p>댓글이 없습니다.</p>
        <%
        }
        %>
    </fieldset>
</body>
</html>
