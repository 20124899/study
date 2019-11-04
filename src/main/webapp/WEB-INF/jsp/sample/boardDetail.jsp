<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
<style>
.container{
	width: 500px;
	margin: 0 auto;
}

ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}

ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #ededed;
	color: #222;
}

.tab-content{
	display: none;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}
</style>
</head>
<body>
	<table class="board_view">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="35%" />
		</colgroup>
		<caption>게시글 상세</caption>
		<tbody>
			<tr>
				<th scope="row">글 번호</th>
				<td>${map.IDX }</td>
				<th scope="row">조회수</th>
				<td>${map.HIT_CNT }</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${map.CREA_ID }</td>
				<th scope="row">작성시간</th>
				<td>${map.CREA_DTM }</td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3">${map.TITLE }</td>
			</tr>
			<tr>
				<td colspan="4">${map.CONTENTS }</td>
			</tr>
			<c:if test="${map.category eq '관광지'}">
			<tr>
				<th scope="row">주차장</th>
				<td>${map.parking }</td>
			
				<th scope="row">이용료</th>
				<td>${map.fee }</td>
			</tr>
			<tr>
				<th scope="row">이용시간</th>
				<td>${map.use_time }</td>		
				<th scope="row">휴무일</th>
				<td>${map.closed_day }</td>
			</tr>
			</c:if>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3"><c:forEach var="row" items="${list }">
						<input type="hidden" id="IDX" value="${row.IDX }">
						<a href="#this" name="file">${row.ORIGINAL_FILE_NAME }</a> (${row.FILE_SIZE }kb) 
				</c:forEach></td>
			</tr>
		</tbody>
	</table>
	<br />
	<a href="#this" class="btn" id="list">목록으로</a>
	<a href="#this" class="btn" id="update">수정하기</a>

	<br />
	<br />
	<ul class="tabs">
	    <li id="one" class="tab-link current" data-tab="tab-1" value="관광지">관광지</li>
	    <li id="two" class="tab-link" data-tab="tab-2" value="음식점">음식점</li>
	    <li id="three"class="tab-link" data-tab="tab-3" value="숙박">숙박</li>
	  </ul>
	  
	<div id="map" style="width: 700px; height: 400px;"></div>
    
    <table class="board_list" style="width: 350px; margin-left: 750px; margin-top: -400px;">
       <!-- 전체 리스트를 가져옴 -->
       <tbody id="list_body">
       </tbody>
     </table>    
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=440eef5ded46cfa12898e098116eaa7a&libraries=services"></script>
	<script>
	var positions = [];
	var markers = [];
	
	$(document).ready(function(){
		  $('ul.tabs li').click(function(){
		    var tab_id = $(this).attr('data-tab');
		 
		    $('ul.tabs li').removeClass('current');
		    $('.tab-content').removeClass('current');
		 
		    $(this).addClass('current');
		    $("#"+tab_id).addClass('current');
			hideMarkers();	
		    map_onclick();
		  });
		  map_onclick();
		});
		
	function map_onclick() {
		var one_id = $('#one').attr('class');
		var two_id = $('#two').attr('class');	
		var three_id = $('#three').attr('class');
		
		var category_val = null;
		if(one_id == 'tab-link current') {	
			category_val = '관광지'
		} else if(two_id == 'tab-link current') {	
			category_val = '음식점'
		} else if(three_id == 'tab-link current') {
			category_val = '숙박'			
		}
		    $.ajax({
		        type: 'post',
		        url: 'openBoardDetailMap.do',
		        data: {
		        	lat: '${map.lat}',
		        	lon: '${map.lon}',
		            category: category_val				
		        },
		        success: function(data) {
		            if (data) {
		            	$("#list_body").html(data);
		            	marker_fn();
		            } else {
		                alert('지도 호출에 실패했습니다.');
		            }
		        },
		        error: function(req, text) {
		            alert(text + ": " + req.status);
		        }
		    });		
		}
	
	function marker_fn() {
		var lat = '<c:out value="${map.lat}"/>';
		var lon = '<c:out value="${map.lon}"/>';
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
	        level: 7 // 지도의 확대 레벨
	    };

	map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다	
	 	
	// 마커를 표시할 위치와 title 객체 배열입니다 
		$("#list_body").find("td").each(function(){
		var lat = $(this).data("lat");
		var lon = $(this).data("lon");
		var name = $(this).data("name");
		
		positions.push({title:name, latlng: new kakao.maps.LatLng(lat, lon)}); // 여긴 좌표만 입력받음
	});
	
	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		    
	for (var i = 0; i < positions.length; i++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    marker = new kakao.maps.Marker({
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
	    });
	    marker.setMap(map);	    
	    markers.push(marker);

	    setMarkers(map);
	}	

	// 현재 글의 마커를 표시
			
	// 마커가 표시될 위치입니다 
	var markerPosition = new kakao.maps.LatLng(lat, lon);
	
	// 마커를 생성합니다
	marker2 = new kakao.maps.Marker({
	    position: markerPosition
	});
	
		marker2.setMap(map);
	}
	
	function setMarkers(map) {
	    for (var i = 0; i < markers.length; i++) {
	        markers[i].setMap(map);
	    }            
	}
	
	function hideMarkers() {
		for (var i = 0; i < markers.length; i++) {
	        markers[i].setMap(null);
	    }
		// 마커, 포지션 초기화
		markers = [];
		positions = [];				
	}
	
	</script>


	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#list").on("click", function(e) { // 목록으로 버튼 
				e.preventDefault();
				fn_openBoardList();
			});
			$("#update").on("click", function(e) { //수정하기 버튼
				e.preventDefault();
				fn_openBoardUpdate();
			});
			$("a[name='file']").on("click", function(e) { //파일 이름
				e.preventDefault();
				fn_downloadFile($(this));
			});
		});

		function fn_openBoardList() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
			comSubmit.submit();
		}

		function fn_openBoardUpdate() {
			var idx = "${map.IDX}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardUpdate.do' />");
			comSubmit.addParam("IDX", idx);
			comSubmit.submit();
		}

		function fn_downloadFile(obj) {
			var idx = obj.parent().find("#IDX").val();
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/common/downloadFile.do' />");
			comSubmit.addParam("IDX", idx);
			comSubmit.submit();
		}
	</script>
</body>
</html>
