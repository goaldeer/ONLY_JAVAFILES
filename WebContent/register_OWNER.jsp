<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>사장님 회원가입</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    <style>
        .signup-container {
            background-color: white;
            padding: 30px 50px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 100%;
            margin: auto;
        }

        h2 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #343a40;
        }

        label {
            display: block;
            font-size: 1.2em;
            margin-bottom: 10px;
            text-align: left;
        }

        input[type="text"], input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }

        input[type="submit"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-top: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            font-size: 1em;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <h2>사장님 회원가입</h2>
        <form action="register" method="post">
            <input type="hidden" name="userType" value="owner" />
            <div>
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" required>
            </div>
            <div>
                <label for="userId">ID</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div>
                <label for="userPassword">Password</label>
                <input type="password" id="userPassword" name="userPassword" required>
            </div>
            <div>
                <label for="userAddress">주소</label>
                <input type="text" id="userAddress" name="userAddress">
            </div>
            <input type="submit" value="가입하기">
        </form>
    </div>
</body>
</html>
