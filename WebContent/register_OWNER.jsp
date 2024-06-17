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

        input[type="submit"], input[type="button"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            font-size: 1em;
            cursor: pointer;
        }

        input[type="submit"]:hover, input[type="button"]:hover {
            background-color: #0056b3;
        }
    </style>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function openPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    document.getElementById("userAddress").value = data.address;
                }
            }).open();
        }

        function checkUserExists() {
            var userId = document.getElementById("userId").value;
            var userName = document.getElementById("userName").value;

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "CheckUserServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = xhr.responseText;
                    console.log("Response:", response);
                    if (response === "ID_EXISTS") {
                        alert("이미 존재하는 ID 입니다.");
                    } else if (response === "NAME_EXISTS") {
                        alert("이미 존재하는 이름 입니다.");
                    } else if (response === "ID_NAME_EXISTS") {
                        alert("이미 존재하는 아이디와 이름입니다.");
                    } else {
                        document.getElementById("signupForm").submit();
                    }
                }
            };
            xhr.send("userId=" + encodeURIComponent(userId) + "&userName=" + encodeURIComponent(userName));
        }
    </script>
</head>
<body>
    <div class="signup-container">
        <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <h2>사장님 회원가입</h2>
        <form id="signupForm" action="register" method="post">
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
                <input type="text" id="userAddress" name="userAddress" readonly>
                <input type="button" id="postcodeButton" value="주소 검색" onclick="openPostcode()">
            </div>
            <input type="button" value="가입하기" onclick="checkUserExists()">
        </form>
    </div>
</body>
</html>
