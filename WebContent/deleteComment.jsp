<%@ page import="dao.CommentDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
request.setCharacterEncoding("UTF-8");

String commentId = request.getParameter("commentId");
String postId = request.getParameter("PID");


if (commentId != null && !commentId.trim().isEmpty()) {
    CommentDAO.deletecomment(Integer.parseInt(commentId));
}

if (postId != null) {
	response.sendRedirect("postView.jsp?postId=" + postId);
} else {
	response.sendRedirect("main.jsp");
}
%>
