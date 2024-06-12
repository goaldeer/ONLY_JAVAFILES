<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
</head>
<body>
    <h2>이용자 회원가입</h2>
    <form action="register" method="post">
        <input type="hidden" name="userType" value="user" /><br>
        <label>이름:</label><input type="text" name="userName" required><br>
        <label>ID:</label><input type="text" name="userId" required><br>
        <label>Password:</label><input type="password" name="userPassword" required><br>
        <input type="hidden" name="userAddress" value="user" />
        <input type="submit" value="Register">
    </form>
</body>
</html>
