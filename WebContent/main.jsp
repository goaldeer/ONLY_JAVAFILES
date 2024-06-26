<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="beans.UserBean" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="dao.UserDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
	String userLocation = (String) session.getAttribute("userLocation");
	
	String userType = null;
	
	if (userId != null) {
		try {
			UserBean user = UserDAO.getUserById(userId);
			userType = user.getUserType();
			
		} catch (Exception e) {}
	}
	
	
    int currentPage = 1; // 변수 이름을 변경
    int pageSize = 15;
    int totalPages = 0;
    
    if (userLocation == null) {

        userLocation = "국립부경대학교 대연캠퍼스";
    }
    
    if (session.getAttribute("userLocation") == null) {
        
    	int totalPosts = PostDAO.getPostCountWithLocation(userLocation);
        totalPages = (int) Math.ceil(totalPosts / (double) pageSize);
        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            currentPage = Integer.parseInt(pageStr);
        }

    } else if (userId != null) {
    	
    	try {
    		UserBean user = UserDAO.getUserById(userId);
            userLocation = user.getUserLocation();
    	} catch (Exception e) {}
        
    	int totalPosts = PostDAO.getPostCountWithLocation(userLocation);
        totalPages = (int) Math.ceil(totalPosts / (double) pageSize);
        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            currentPage = Integer.parseInt(pageStr);
        }

        
    } /*else {
    	int totalPosts = PostDAO.getPostCount();
	    int totalPages = (int) Math.ceil(totalPosts / (double) pageSize);
	    String pageStr = request.getParameter("page");
	    if (pageStr != null) {
	        currentPage = Integer.parseInt(pageStr);
	    }

	    List<PostBean> posts = PostDAO.getPostsByPage(currentPage, pageSize);
    }*/
    
    List<PostBean> posts = PostDAO.getPostsByPageWithLocation(currentPage, pageSize, userLocation);
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
        <div class="d-flex justify-content-between mb-3">
        <%
        if (userId == null || userType.equals("user")) {
        	%>
        	<a href="changeLocation.jsp" class="btn btn-outline-secondary">상권 변경</a>
        	<%
        }
        %>
        <div>현재 상권 : <%= userLocation %></div>
        <div>
            <% if(userId == null) { %>
            <a href="login.jsp" class="btn btn-outline-primary">로그인</a>
            <% } else { %>
            <a href="profile.jsp" class="btn btn-outline-primary">내 프로필</a>
            <a href="logout.jsp" class="btn btn-outline-danger">로그아웃</a>
            <% } %>
        </div>
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
            <% if(userId != null) { %>
            <a href="doPosting.jsp" class="btn btn-outline-primary">게시글 작성</a>
            <% } %>
        </div>
    </div>
</body>
</html>
