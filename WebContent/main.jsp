<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="dao.PostDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
		userId = "-1";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Posts</title>
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
            <%
            }
            %>
        </div>
        
       <% if (userId != "-1") { %>
       
       		 <%
        String flag = request.getParameter("error");
        if (flag != null && flag.equals("0")) {
        %>
        <script>
            alert("jpeg, jpg, png 파일만 업로드 가능합니다.");
        </script>
        <%
        }
        %>
        
        <div class="card mb-4">
            <div class="card-header">
                게시글 작성
            </div>
            <div class="card-body">
                <form name="fileForm" action="post" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="postName" class="form-label">제목</label>
                        <input type="text" class="form-control" id="postName" name="postName" required>
                    </div>
                    <div class="form-group">
                        <label for="postContent" class="form-label">내용</label>
                        <textarea class="form-control" id="postContent" name="postContent" required rows="5"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="postPhoto" class="form-label">사진</label>
                        <input type="file" class="form-control-file" id="postPhoto" name="postPhoto">
                        <small class="form-text text-muted">jpg, jpeg, png 확장자만 업로드 가능합니다.</small>
                    </div>
                    <button type="submit" class="btn btn-primary">작성</button>
                </form>
            </div>
        </div>
        <% } %>
       
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
                    request.setCharacterEncoding("utf-8");
                    List<PostBean> posts = PostDAO.getAllPosts();
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
    </div>
    
    <script>
        const ALLOWED_EXTENSIONS = ['jpeg', 'jpg', 'png'];
        
        document.getElementById('postPhoto').addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const fileName = file.name;
                const fileExtension = fileName.split('.').pop().toLowerCase();
                
                if (!ALLOWED_EXTENSIONS.includes(fileExtension)) {
                    alert('jpeg, jpg, png 파일만 업로드가 가능합니다.');
                    event.target.value = ''; // 선택한 파일을 초기화
                }
            }
        });
    </script>
</body>
</html>
