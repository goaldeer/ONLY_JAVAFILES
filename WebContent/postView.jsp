<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="beans.CommentBean" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="dao.CommentDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
    String postId = request.getParameter("postId");
    
    if (postId == null) {
    	response.sendRedirect("main.jsp");
    }
    
    PostBean post = PostDAO.getPostById(Integer.parseInt(postId));
    List<CommentBean> comments = CommentDAO.getCommentsByPostId(Integer.parseInt(postId));
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= post.getPostName() %></title>
    <meta charset="UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>
    <div class="container">
        <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <div class="text-right mb-3">
            <a href="main.jsp" class="btn btn-outline-primary">게시판으로</a>
            
            <% if(userId == null) { %>
            <a href="login.jsp" class="btn btn-outline-primary">로그인</a>
            <% } else { %>
            <a href="profile.jsp" class="btn btn-outline-primary">내 프로필</a>
            <a href="logout.jsp" class="btn btn-outline-danger">로그아웃</a>
            <%
            }
            %>
        </div>
        
        <fieldset class="mb-4">
            <legend>게시글</legend>
            <table class="table table-bordered">
                <tr>
                    <th width="7%">ID</th>
                    <th>제목</th>
                    <th width="15%">작성자</th>
                    <th width="13%">작성일</th>
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
                        <td colspan="4">
                        <br>
                            <%
                            if (post.getPostPhoto() != null) {
                            %>
                                <img class="img-fluid" src="<%= request.getContextPath() %>/displayImage?postId=<%= post.getPostId() %>" alt=""><br>
                            <%
                            }
                            %>
                            <%= post.getPostContent().replaceAll("\n", "<br/>") %>
                        <br>
                        </td>
                    </tr>
                    <%
                    if ( userId != null && userId.equals(post.getPostUser())) {
                    %>
                    <tr>
                        <td colspan="4" class="text-right">
                            <form action="deletePost.jsp" method="post">
                                <input type="hidden" name="postId" value="<%= post.getPostId() %>" />
                                <button type="submit" class="btn btn-danger">삭제</button>
                            </form>
                        </td>
                    </tr>
                    <%
                    }
                }
                %>
            </table>
        </fieldset>
        
        <% if(userId != null) { %>
        <fieldset class="mb-4">
            <legend>댓글 작성</legend>
            <form action="add_comment" method="post">
                <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                <div class="form-group">
                    <label for="content" class="form-label">댓글 내용</label>
                    <textarea class="form-control" name="content" id="content" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">댓글 추가</button>
            </form>
        </fieldset>
        <% } %>
        
        <fieldset class="comment-section">
            <legend>댓글</legend>
            <%
            if (!comments.isEmpty()) {
                for (CommentBean comment : comments) {
            %>
                <div class="comment">
                    <p><strong><%= comment.getAuthor() %></strong> <em><%= comment.getCreatedAt() %></em></p>
                    <p><%= comment.getContent().replaceAll("\n", "<br/>") %></p>
                    <% if (userId != null) {%>
                    <%
                    if (comment.getAuthor().equals(userId)) {
                    %>
                        <form action="deleteComment.jsp" method="post" class="text-right">
                            <input type="hidden" name="commentId" value="<%=comment.getcommentId()%>" >
                            <input type="hidden" name="postId" value="<%=post.getPostId()%>" >
                            <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                        </form>
                    <%
                    }
                    %>
                    <%
                    }
                    %>
                </div>
            <%
                }
            } else {
            %>
                <p>댓글이 없습니다.</p>
            <%
            }
            %>
        </fieldset>
    </div>
</body>
</html>
