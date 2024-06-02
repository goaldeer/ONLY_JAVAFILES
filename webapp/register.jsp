<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    <form action="register" method="post">
        <label>User Type:</label>
        <select name="userType">
            <option value="owner">Owner</option>
            <option value="user">User</option>
        </select><br>
        <label>Name:</label><input type="text" name="userName" required><br>
        <label>ID:</label><input type="text" name="userId" required><br>
        <label>Password:</label><input type="password" name="userPassword" required><br>
        <label>Address:</label><input type="text" name="userAddress"><br>
        <input type="submit" value="Register">
    </form>
</body>
</html>
