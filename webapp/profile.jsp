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
	// posts.forEach(st -> System.out.println("arrData : " + st));
%>
<!DOCTYPE html>
<html>
<head>
    <title>나의 프로필</title>
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
    <fieldset>
    <h2>프로필</h2>
    <p>유저 이름 : <%= user.getUserName() %></p>
    <p>주소  : <%= user.getUserAddress() %></p>
    </fieldset><br>
    
    <fieldset width=90%>
            	<legend>나의 게시글</legend>
            	<br>
            	<table border="1", align='center'>
                <tr>
                    <th width=7%>ID</th>
                    <th>제목</th>
                    <th width=15%>작성자</th>
                    <th width=13%>작성일</th>
                    <th width=5%>삭제</th>
                </tr>
                
    <%
    	request.setCharacterEncoding("utf-8");
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
        				<input type="submit" value="삭제">
    					</form>
    				</td>
                
                
            		<%
                }
            }
        }
    %>
            	</tr>
                </table>
               <br>
	</fieldset>
    <a href="main.jsp">Back to Main</a>
</body>
</html>
