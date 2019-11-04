<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게시물 리스트</title>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
<style type="text/css">
.container {
	width: 500px;
	margin: 0 auto;
}

ul.tabs {
	margin: 0px;
	padding: 0px;
	list-style: none;
}

ul.tabs li {
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current {
	background: #ededed;
	color: #222;
}

.tab-content {
	display: none;
	padding: 15px;
}

.tab-content.current {
	display: inherit;
}
</style>
</head>
<body>

    <div class="display">
    	<span class="icon"><img id="we_img" src="/travel/img/icon/icon_weather_02.jpg" alt="날씨 아이콘"></span>    
        <div class='we_img'></div>
    <div id="display"></div> <br />
        <div class="weather"></div>
    </div>
    
	<ul class="tabs">
		<li id="zero" class="tab-link  <c:if test="${category eq 'tab-0' }"> current</c:if>" data-tab="tab-0">전체</li>
		<li id="one" class="tab-link <c:if test="${category eq 'tab-1' }"> current</c:if>"" data-tab="tab-1">관광지</li>
		<li id="two" class="tab-link <c:if test="${category eq 'tab-2' }"> current</c:if>""  data-tab="tab-2">음식점</li>
		<li id="three " class="tab-link <c:if test="${category eq 'tab-3' }"> current</c:if>"" data-tab="tab-3">숙박</li>
	</ul>

	<div id="tab-0" class="tab-content  <c:if test="${category eq 'tab-0' or empty category }"> current</c:if>">
		<table class="board_list">
			<colgroup>
				<col width="5%">
				<col width="50%">
				<col width="5%">
				<col width="15%">
				<col width="15%">
			</colgroup>
			<caption>
				<h2>게시판</h2>
			</caption>

			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>Hit</th>
					<th>작성자</th>
					<th>작성시간</th>
				</tr>
			</thead>
			<tbody id="list_body">
				<c:choose>
					<c:when test="${fn:length(list)>0}">
						<c:forEach items="${list }" var="con">
							<tr>
								<td>${con.IDX }</td>
								<td id="data-category" data-category="${con.category}"><input type="hidden" id="IDX" value="${con.IDX }">
								<a href="#this" name="TITLE">${con.TITLE }</a></td>
								<td>${con.HIT_CNT }</td>
								<td>${con.CREA_ID }</td>
								<td>${con.CREA_DTM }</td>
							</tr>
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
	<br />
	<div id="tab-1" class="tab-content  <c:if test="${category eq 'tab-1' }"> current</c:if>">
		<table class="board_list">
			<colgroup>
				<col width="5%">
				<col width="50%">
				<col width="5%">
				<col width="15%">
				<col width="15%">
			</colgroup>
			<caption>
				<h2>게시판</h2>
			</caption>

			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>Hit</th>
					<th>작성자</th>
					<th>작성시간</th>
				</tr>
			</thead>
			<tbody id="list_body">
				<c:choose>
					<c:when test="${fn:length(list)>0}">
						<c:forEach items="${list }" var="con">
							<c:if test="${con.category eq '관광지'}">
								<tr>
									<td>${con.IDX }</td>
									<td id="data-category" data-category="${con.category}"><input type="hidden" id="IDX" value="${con.IDX }">
									<a href="#this" name="TITLE">${con.TITLE }</a></td>
									<td>${con.HIT_CNT }</td>
									<td>${con.CREA_ID }</td>
									<td>${con.CREA_DTM }</td>
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
	<br />

	<div id="tab-2" class="tab-content <c:if test="${category eq 'tab-2' }"> current</c:if>">
		<table class="board_list">
			<colgroup>
				<col width="5%">
				<col width="50%">
				<col width="5%">
				<col width="15%">
				<col width="15%">
			</colgroup>
			<caption>
				<h2>게시판</h2>
			</caption>

			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>Hit</th>
					<th>작성자</th>
					<th>작성시간</th>
				</tr>
			</thead>
			<tbody id="list_body">
				<c:choose>
					<c:when test="${fn:length(list)>0}">
						<c:forEach items="${list }" var="con">
							<c:if test="${con.category eq '음식점'}">
								<tr>
									<td>${con.IDX }</td>
									<td id="data-category" data-category="${con.category}"><input type="hidden" id="IDX" value="${con.IDX }">
									<a href="#this" name="TITLE">${con.TITLE }</a></td>
									<td>${con.HIT_CNT }</td>
									<td>${con.CREA_ID }</td>
									<td>${con.CREA_DTM }</td>
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
	<br />


	<div id="tab-3" class="tab-content <c:if test="${category eq 'tab-3' }"> current</c:if>">
		<table class="board_list">
			<colgroup>
				<col width="5%">
				<col width="50%">
				<col width="5%">
				<col width="15%">
				<col width="15%">
			</colgroup>
			<caption>
				<h2>게시판</h2>
			</caption>

			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>Hit</th>
					<th>작성자</th>
					<th>작성시간</th>
				</tr>
			</thead>
			<tbody id="list_body">
				<c:choose>
					<c:when test="${fn:length(list)>0}">
						<c:forEach items="${list }" var="con">
							<c:if test="${con.category eq '숙박'}">
								<tr>
									<td>${con.IDX }</td>
									<td id="data-category" data-category="${con.category}"><input type="hidden" id="IDX" value="${con.IDX }">
									<a href="#this" name="TITLE">${con.TITLE }</a></td>
									<td>${con.HIT_CNT }</td>
									<td>${con.CREA_ID }</td>
									<td>${con.CREA_DTM }</td>
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
	<br />
	
		
	<c:if test="${not empty paginationInfo}">
			<ui:pagination paginationInfo="${paginationInfo}" type="text"
				jsFunction="fn_search" />
		</c:if>
		<input type="hidden" id="currentPageNo" name="currentPageNo" />
	<a href="#this" class="btn" id="write">글쓰기</a>

	<%@ include file="/WEB-INF/include/include-body.jspf"%>

	<script type="text/javascript">
		$(document).ready(function() {

			$('ul.tabs li').click(function() {
				var tab_id = $(this).attr('data-tab');
				
				$("#category_id").val(tab_id);
				fn_search(1);
				$('ul.tabs li').removeClass('current');
				$('.tab-content').removeClass('current');

				$(this).addClass('current');
				$("#" + tab_id).addClass('current');
			});
		});
		

		$(document).ready(function() {
			$("#write").on("click", function(e) {
				e.preventDefault();
				fn_openBoardWrite();
			})
			$("a[name='TITLE']").on("click", function(e) {
				e.preventDefault();
				fn_openBoardDetail($(this));
			})
				      				
			var apiURI = "";
			apiURI += "https://api.openweathermap.org/data/2.5/weather?lat=35.7316575&lon=126.733423&appid=e5799cbefe2fe84bbfe2c2936d4816f4";
			$.ajax({
			    url: apiURI,
			    dataType: "json",
			    type: "GET",
			    async: "false",
			    success: function(resp) {
			        var html = ""
			        html += "<div class='ingtemp'>" + parseInt(resp.main.temp - 273.15) + "˚</div>";
			        html += "</div>";
			        
			        if ((resp.weather[0].main).toString() == "Rain" || (resp.weather[0].main).toString() == "Drizzle" || (resp.weather[0].main).toString() == "Thunderstorm") {
			        	$("#we_img").attr("src", "WEB-INF/include/ing_rain.png");
                    } else if ((resp.weather[0].main).toString() == "Snow") {
			        	$("#we_img").attr("src", "WEB-INF/include/ing_show.png");
                    } else if ((resp.weather[0].main).toString() == "Clear") {
			        	$("#we_img").attr("src", "WEB-INF/include/ing_sun.png");
                    } else if ((resp.weather[0].main).toString() == "Clouds") {
			        	$("#we_img").attr("src", "WEB-INF/include/ing_cloud.png");
                    } else {
			        	$("#we_img").attr("src", "WEB-INF/include/ing_mist.png");
                    }
			        $("#display").append(html);
			    } // success                    
			}); //ajax            			       
		}); // document.ready
		
		function fn_openBoardWrite() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do'/>");
			comSubmit.submit();
		}
		function fn_openBoardDetail(val) {
			var comSubmit = new ComSubmit();				
			var cate = val.parent().data('category'); // 클릭한 글의 카테고리를 검색해서
			
 			comSubmit.addParam("IDX", val.parent().find("#IDX").val()); // 선택한 글의 IDX 값을 보내서 submit
			
			if(cate == "관광지") { // 카테고리가 관광지면
				comSubmit.setUrl("<c:url value='/sample/openBoardDetailtour.do'/>"); // openBoardDetailtour 호출
			} else if(cate == "음식점") { // 음식점이면
				comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do'/>");				
			} else if(cate == "숙박") { // 숙박이면
				comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do'/>");									
			}
			comSubmit.submit();
		}
		function fn_search(pageNo) {
			var comSubmit = new ComSubmit();
			var url = "/first/sample/openBoardList.do";
			
			comSubmit.setUrl("<c:url value='"+url+"' />");
			comSubmit.addParam("currentPageNo", pageNo);
			comSubmit.submit();
		}
	</script>
</body>
</html>