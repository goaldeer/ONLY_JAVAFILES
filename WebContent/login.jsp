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
<meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    <style>
        .login-container {
            background-color: white;
            padding: 30px 50px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 100%;
            margin:0 auto;
        }

        h1 {
            font-family: 'PyeongChangPeace-Bold';
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #343a40;
        }

        h2 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #343a40;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            text-align: left;
        }

        input[type="text"], input[type="password"] {
            width: calc(100% - 20px);
            padding: 12px;
            margin-bottom: 25px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            color: white;
            font-size: 1em;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        a {
            display: inline-block;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <h2>로그인</h2>
        <form action="login" method="post">
            <div>
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div>
                <label for="userPassword">비밀번호</label>
                <input type="password" id="userPassword" name="userPassword" required>
            </div>
            <input type="submit" value="로그인">
        </form>
        <a href="register.jsp">회원가입</a>
    </div>
</body>
</html>
