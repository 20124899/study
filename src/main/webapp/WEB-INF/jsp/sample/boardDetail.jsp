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
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3"><c:forEach var="row" items="${list }">
						<input type="hidden" id="IDX" value="${row.IDX }">
						<a href="#this" name="file">${row.ORIGINAL_FILE_NAME }</a> (${row.FILE_SIZE }kb) 
				</c:forEach></td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td colspan="3">${map.category }</td>
			</tr>
		</tbody>
	</table>
	<br />
	<a href="#this" class="btn" id="list">목록으로</a>
	<a href="#this" class="btn" id="update">수정하기</a>

	<br />
	<br />
	<ul class="tabs">
	    <li id="one" class="tab-link current" data-tab="tab-1">관광지</li>
	    <li id="two" class="tab-link" data-tab="tab-2">음식점</li>
	    <li id="three"class="tab-link" data-tab="tab-3">숙박</li>
	  </ul>
	  
	<div id="map" style="width: 700px; height: 400px;"></div>
    
    <div id="tab-1" class="tab-content current">  
	<table class="board_list" style="width: 350px; margin-left: 750px; margin-top: -400px;">
       <!-- 전체 리스트를 가져옴 -->
        <tbody>
            <c:choose>
                <c:when test="${fn:length(list2)>0}">
                    <c:forEach items="${list2 }" var="con" >
                      <c:if test="${con.category eq '관광지'}">                           
      				    <tr>              
                            <td><input type="hidden" id="IDX" value="${con.IDX }">${con.TITLE }</td>
                        </tr>
                       </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td>게시물이 존재하지 않습니다.</td>
                    </tr>
                </c:otherwise>            
            </c:choose>
        </tbody>
    </table>  	 
  </div>        
   
   <div id="tab-2" class="tab-content">  
	<table class="board_list" style="width: 350px; margin-left: 750px; margin-top: -400px;">
       <!-- 전체 리스트를 가져옴 -->
        <tbody>
            <c:choose>
                <c:when test="${fn:length(list2)>0}">
                    <c:forEach items="${list2 }" var="con" >
                      <c:if test="${con.category eq '음식점'}">
                                             
      				    <tr>              
                            <td><input type="hidden" id="IDX" value="${con.IDX }">${con.TITLE }</td>
                        </tr>
                       </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td>게시물이 존재하지 않습니다.</td>
                    </tr>
                </c:otherwise>            
            </c:choose>
        </tbody>
    </table>  	 
  </div>       
   
   <div id="tab-3" class="tab-content">  
	<table class="board_list" style="width: 350px; margin-left: 750px; margin-top: -400px;">
       <!-- 전체 리스트를 가져옴 -->
        <tbody>
            <c:choose>
                <c:when test="${fn:length(list2)>0}">
                    <c:forEach items="${list2 }" var="con" >
                      <c:if test="${con.category eq '숙박'}">                           
      				    <tr>              
                            <td><input type="hidden" id="IDX" value="${con.IDX }">${con.TITLE }</td>
                        </tr>
                       </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td>게시물이 존재하지 않습니다.</td>
                    </tr>
                </c:otherwise>            
            </c:choose>
        </tbody>
    </table>  	 
  </div>        
               
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=440eef5ded46cfa12898e098116eaa7a&libraries=services"></script>
	<script>
	
	$(document).ready(function(){
		  $('ul.tabs li').click(function(){
		    var tab_id = $(this).attr('data-tab');
		 
		    $('ul.tabs li').removeClass('current');
		    $('.tab-content').removeClass('current');
		 
		    $(this).addClass('current');
		    $("#"+tab_id).addClass('current');
		    marker();
		  });
		  marker();
		});
		
	
	function marker() {

		var lat = '<c:out value="${map.lat}"/>';
		var lon = '<c:out value="${map.lon}"/>';
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
	        level: 6 // 지도의 확대 레벨
	    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다	
	 
	var one_id = $('#one').attr('class');
	var two_id = $('#two').attr('class');	
	var three_id = $('#three').attr('class');
	
	if(one_id == 'tab-link current') {		
	// 마커를 표시할 위치와 title 객체 배열입니다 
	var positions = [	   
	    <c:forEach items="${list2 }" var="con" >	    
	        <c:if test="${con.category eq '관광지'}"> 
		        {		        	
		        <c:if test="${con.lat ne map.lat && con.lon ne map.lon}">
		        title: '${con.TITLE}', 
	        	latlng: new kakao.maps.LatLng("${con.lat}", "${con.lon}")
		        </c:if>
		        },
			 </c:if>
		</c:forEach>
	];
	
	} else if(two_id == 'tab-link current') {
		// 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [
		    <c:forEach items="${list2 }" var="con" >	    
		        <c:if test="${con.category eq '음식점'}"> 
		       		{		        	
			        <c:if test="${con.lat ne map.lat && con.lon ne map.lon}">
			        title: '${con.TITLE}', 
		        	latlng: new kakao.maps.LatLng("${con.lat}", "${con.lon}")
			        </c:if>
			        },
				 </c:if>
			</c:forEach>
		];
				
	} else if(three_id == 'tab-link current') {	
		// 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [
		    <c:forEach items="${list2 }" var="con" >	    
		        <c:if test="${con.category eq '숙박'}"> 
		        	{		        	
			        <c:if test="${con.lat ne map.lat && con.lon ne map.lon}">
			        title: '${con.TITLE}', 
		        	latlng: new kakao.maps.LatLng("${con.lat}", "${con.lon}")
			        </c:if>
			        },
				 </c:if>
			</c:forEach>
		];		
	}

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
	    });
	}	

	// 현재 글의 마커를 표시
			
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(lat, lon);
	
	// 마커를 생성합니다
	var marker2 = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	marker2.setMap(map);
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
