<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
</head>
<body>
    <h2>사장님 회원가입</h2>
    <form action="register" method="post">
        <input type="hidden" name="userType" value="owner" /><br><br>
        <label>이름:</label><input type="text" name="userName" required><br>
        <label>ID:</label><input type="text" name="userId" required><br>
        <label>Password:</label><input type="password" name="userPassword" required><br>
        <label>주소:</label><input type="text" name="userAddress"><br>
        <input type="submit" value="Register">
    </form>
</body>
</html>
