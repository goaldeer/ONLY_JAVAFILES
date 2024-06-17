<%@ page import="dao.UserDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
request.setCharacterEncoding("UTF-8");

String userId = (String) session.getAttribute("userId");
if (userId != null) {
    UserDAO.deleteUserById(userId);
}

session.invalidate();

response.sendRedirect("login.jsp");
%>
