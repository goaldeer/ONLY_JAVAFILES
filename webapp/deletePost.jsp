<%@ page import="dao.PostDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
request.setCharacterEncoding("UTF-8");

String postId = request.getParameter("postId");
if (postId != null && !postId.trim().isEmpty()) {
    PostDAO.deletePost(Integer.parseInt(postId));
}

response.sendRedirect("main.jsp");
%>
