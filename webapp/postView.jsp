<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="dao.PostDAO" %>
<%
    String userId = (String) session.getAttribute("userId");
    
    String postId = request.getParameter("postId");
	PostBean post = PostDAO.getPostById(Integer.parseInt(postId)); // getPostById 메소드는 해당 ID의 게시글 정보를 반환해야 합니다.
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
    </style>
</head>

<body>
	<br>
    <a href="main.jsp">게시판으로</a>
    <br><br><br><br>
    
    <fieldset width=90%>
            	<br>
            	<table border="1", align='center'>
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
            	<td align="center" colspan=4> <%= post.getPostContent().replaceAll("\n", "<br/>") %> </td>
            </tr>
            
            <%
            System.out.println(userId + " " + post.getPostUser());
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
               <br>
	</fieldset>
                
</body>
</html>
