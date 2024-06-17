<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="dao.PostDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        userId = "-1";
    }

    int currentPage = 1; // 변수 이름을 변경
    int pageSize = 15;
    int totalPosts = PostDAO.getPostCount();
    int totalPages = (int) Math.ceil(totalPosts / (double) pageSize);
    String pageStr = request.getParameter("page");
    if (pageStr != null) {
        currentPage = Integer.parseInt(pageStr);
    }

    List<PostBean> posts = PostDAO.getPostsByPage(currentPage, pageSize);
%>
<!DOCTYPE html>
<html>
<head>
    <title>쩝쩝박사</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>
    <div class="container">
        <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <div class="text-right mb-3">
            <% if(userId.equals("-1")) { %>
            <a href="login.jsp" class="btn btn-outline-primary">로그인</a>
            <% } else { %>
            <a href="profile.jsp" class="btn btn-outline-primary">내 프로필</a>
            <a href="logout.jsp" class="btn btn-outline-danger">로그아웃</a>
            <% } %>
        </div>
        
        <div class="card">
            <div class="card-header">
                게시판
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th width="7%">ID</th>
                            <th>제목</th>
                            <th width="15%">작성자</th>
                            <th width="13%">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    if (posts != null) {
                        for (PostBean post : posts) {
                    %>
                        <tr onclick="location.href='postView.jsp?postId=<%= post.getPostId() %>'" style="cursor:pointer;">
                            <td><%= post.getPostId() %></td>
                            <td><%= post.getPostName() %></td>
                            <td onclick="location.href='profile.jsp?userId=<%= post.getPostUser() %>'" style="cursor:pointer;"><%= post.getPostUser() %></td>
                            <td><%= post.getPostTime() %></td>
                        </tr>
                    <%
                        }
                    }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <nav>
            <ul class="pagination justify-content-center mt-3">
                <%
                int startPage = Math.max(1, currentPage - 5);
                int endPage = Math.min(totalPages, currentPage + 4);
                if (startPage > 1) {
                %>
                <li class="page-item">
                    <a class="page-link" href="main.jsp?page=<%= startPage - 1 %>">&lt;</a>
                </li>
                <%
                }
                for (int i = startPage; i <= endPage; i++) {
                %>
                <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                    <a class="page-link" href="main.jsp?page=<%= i %>"><%= i %></a>
                </li>
                <%
                }
                if (endPage < totalPages) {
                %>
                <li class="page-item">
                    <a class="page-link" href="main.jsp?page=<%= endPage + 1 %>">&gt;</a>
                </li>
                <%
                }
                %>
            </ul>
        </nav>

        <div class="text-right mt-3">
            <% if(!userId.equals("-1")) { %>
            <a href="doPosting.jsp" class="btn btn-outline-primary">게시글 작성</a>
            <% } %>
        </div>
    </div>
</body>
</html>
