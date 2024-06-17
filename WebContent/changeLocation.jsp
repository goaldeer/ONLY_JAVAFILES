<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>상권 변경</title>
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
        function openPostcode(element) {
            new daum.Postcode({
                oncomplete: function(data) {
                    document.getElementById(element).value = data.address;
                   	if (element === "userAddress") {
                   		initializeMap(data.address);
                   	}
                }
            }).open();
        }
    </script>
</head>
<body>
    <div class="signup-container">
        <h1><a href="main.jsp" style="text-decoration: none; color: inherit;">쩝쩝박사</a></h1>
        <h2>상권 변경</h2>
        <form action="changeLocation" method="post" onsubmit="return validateForm()">
            <div>
                <label for="userAddress">주소</label>
                <input type="text" id="userAddress" name="userAddress" readonly required>
                <input type="button" id="postcodeButton" value="주소 검색" onclick="openPostcode('userAddress')">
            </div>
            <div>
                <label for="userLocation">상권 학교 주소</label>
                <input type="text" id="userLocation" name="userLocation" readonly required>
            </div>
            
            <div id="map" style="width:100%;height:350px;"></div><br>
            
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=464462342b9bb3ab97ca0ec2e6f70047&libraries=services"></script>
            <script>
            function initializeMap(address) {
                var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
                var mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                    level: 7 // 지도의 확대 레벨
                };  

                // 지도를 생성합니다    
                var map = new kakao.maps.Map(mapContainer, mapOption); 

                // 주소-좌표 변환 객체를 생성합니다
                var geocoder = new kakao.maps.services.Geocoder();
                
                // 주소로 좌표를 검색합니다
                geocoder.addressSearch(address, function(result, status) {
                    // 정상적으로 검색이 완료됐으면 
                    if (status === kakao.maps.services.Status.OK) {
                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                        map.setCenter(coords);
                    }

                    // 장소 검색 객체를 생성합니다
                    var ps = new kakao.maps.services.Places(map); 

                    // 카테고리로 학교를 검색합니다
                    ps.categorySearch('SC4', placesSearchCB, {useMapBounds:true}); 

                    // 키워드 검색 완료 시 호출되는 콜백함수 입니다
                    function placesSearchCB (data, status, pagination) {
                        if (status === kakao.maps.services.Status.OK) {
                            for (var i=0; i<data.length; i++) {
                                displayMarker(data[i]);    
                            }       
                        }
                    }

                    // 지도에 마커를 표시하는 함수입니다
                    function displayMarker(place) {
                        // 마커를 생성하고 지도에 표시합니다
                        var marker = new kakao.maps.Marker({
                            map: map,
                            position: new kakao.maps.LatLng(place.y, place.x) 
                        });

                        // 마커에 클릭이벤트를 등록합니다
                        kakao.maps.event.addListener(marker, 'click', function() {
                            document.getElementById("userLocation").value = place.place_name;
                        });
                    }
                });
            }
            
            function validateForm() {
                const userAddress = document.getElementById('userAddress').value;
                const userLocation = document.getElementById('userLocation').value;
                if (!userAddress || !userLocation) {
                    alert('주소를 선택해 주세요.');
                    return false; // 폼 제출 중단
                }
                return true; // 폼 제출 진행
            }
            
            </script>
            <input type="submit" value="변경하기">
        </form>
    </div>
</body>
</html>
