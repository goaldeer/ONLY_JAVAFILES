<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
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

        input[type="button"] {
            width: calc(100% - 20px);
            padding: 20px;
            margin-bottom: 30px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            font-size: 1em;
            cursor: pointer;
        }

        input[type="button"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <h2>회원가입</h2>
        <input type="button" value="사장님으로 가입하기" onclick="location.href='register_OWNER.jsp'" style="cursor:pointer;">
        <input type="button" value="일반 사용자로 가입하기" onclick="location.href='register_USER.jsp'" style="cursor:pointer;">
    </div>
</body>
</html>
