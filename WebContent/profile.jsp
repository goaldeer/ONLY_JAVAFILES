<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.UserBean" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="beans.PostBean" %>
<%@ page import="dao.PostDAO" %>
<%

    String userId = request.getParameter("userId");
    if (userId == null) {
        userId = (String) session.getAttribute("userId");
    }
    
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    UserBean user = UserDAO.getUserById(userId);
    List<PostBean> posts = PostDAO.getAllPosts();
    String address = user.getUserAddress();
    
%>
<!DOCTYPE html>
<html>
<head>
    <title>쩝쩝박사 : 프로필</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>
    <div class="container">
    <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <h2>나의 프로필</h2><br>
        <div class="profile-info">
            <p>유저 이름 : <%= user.getUserName() %></p>
            <% if(user.getUserType().equals("owner")) { %>
            <p>주소 : <%= address %></p><br>
            
	            <div id="map" style="width:500px;height:400px;"></div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=464462342b9bb3ab97ca0ec2e6f70047&libraries=services"></script>
				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    	mapOption = {
			        	center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			        	level: 3 // 지도의 확대 레벨
			    	};  

					// 지도를 생성합니다    
					var map = new kakao.maps.Map(mapContainer, mapOption); 

					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();
					
					// 주소로 좌표를 검색합니다
					geocoder.addressSearch("<%= address %>", function(result, status) {

			    	// 정상적으로 검색이 완료됐으면 
			     	if (status === kakao.maps.services.Status.OK) {

			        	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        	// 결과값으로 받은 위치를 마커로 표시합니다
			        	var marker = new kakao.maps.Marker({
			            	map: map,
			            	position: coords
			        	});

			        	// 인포윈도우로 장소에 대한 설명을 표시합니다
			        	var infowindow = new kakao.maps.InfoWindow({
			            	content: '<div style="width:150px;text-align:center;padding:6px 0;">우리가게</div>'
			       		});
			        	infowindow.open(map, marker);

			        	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        	map.setCenter(coords);
			    	} 
				});    
				</script>
	           
            <% } %>
            
        </div>

        <fieldset class="mb-4">
            <legend>나의 게시글</legend>
            <table class="table table-bordered">
                <tr>
                    <th width="7%">ID</th>
                    <th>제목</th>
                    <th width="15%">작성자</th>
                    <th width="13%">작성일</th>
                    <th width="10%">삭제</th>
                </tr>
                <%
                if (posts != null) {
                    for (PostBean post : posts) {
                        if (post.getPostUser().equals(userId)) {
                %>
                    <tr>
                        <td onclick="location.href='postView.jsp?postId=<%= post.getPostId() %>'" style="cursor:pointer;"><%= post.getPostId() %></td>
                        <td onclick="location.href='postView.jsp?postId=<%= post.getPostId() %>'" style="cursor:pointer;"><%= post.getPostName() %></td>
                        <td onclick="location.href='profile.jsp?userId=<%= post.getPostUser() %>'" style="cursor:pointer;"><%= post.getPostUser() %></td>
                        <td><%= post.getPostTime() %></td>
                        <td>
                            <form action="deletePost.jsp" method="post">
                                <input type="hidden" name="postId" value="<%= post.getPostId() %>" />
                                <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    }
                }
                %>
            </table>
        </fieldset>
        
        <div class="text-center">
            <a href="main.jsp" class="btn btn-outline-primary">메인으로 돌아가기</a>
        </div>
    </div>
</body>
</html>
