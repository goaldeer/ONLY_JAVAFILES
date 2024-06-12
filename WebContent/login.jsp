<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String flag = request.getParameter("error");

if(flag != null) {
	if(flag.equals("1")) {
		%>
		<script> alert("로그인 정보를 확인해 주세요."); </script>
		<%
	}
}
%>
<head>
    <title>로그인</title>
</head>
<body>
    <h2>로그인</h2>
    <form action="login" method="post">
        <label>아이디:</label><input type="text" name="userId" required><br>
        <label>비밀번호:</label><input type="password" name="userPassword" required><br>
        <input type="submit" value="로그인">
    </form>
    <a href="register.jsp">Register</a>
</body>
</html>
