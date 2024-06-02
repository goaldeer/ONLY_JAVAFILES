<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="login" method="post">
        <label>ID:</label><input type="text" name="userId" required><br>
        <label>Password:</label><input type="password" name="userPassword" required><br>
        <input type="submit" value="Login">
    </form>
    <a href="register.jsp">Register</a>
</body>
</html>
