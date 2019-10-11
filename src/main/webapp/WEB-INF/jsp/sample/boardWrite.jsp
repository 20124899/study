<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
</head>
<body>
	<form id="frm" name="frm" enctype="multipart/form-data">
		<table class="board_view">
			<colgroup>
				<col width="15%">
				<col width="*" />
			</colgroup>
			<caption><h2>게시글 작성</h2></caption>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td><input type="text" id="TITLE" name="TITLE" class="wdp_90"></input></td>
					<td>
						<select required="required" style="height: 28px; border: 0; border-bottom: dotted 1px #000;" id="category" name="category" class="need">
							<option value="">카테고리 선택</option>
							<option value="관광지">관광지</option>
							<option value="음식점">음식점</option>
							<option value="숙박">숙박</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="view_text"><textarea rows="20"
							cols="100" title="내용" id="CONTENTS" name="CONTENTS"></textarea></td>
				</tr>				
				<th>주소</th><td><input type="text" id="sample5_address" class="wdp_90" name="address" onclick="onclick_addr();" readonly ></td>
				<td><input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"></td><br>
			</tbody>
			<input type="hidden" id="lat" name="lat">
			<input type="hidden" id="lon" name="lon">
		</table>
		<div id="map" style="width:500px;height:300px;margin-top:10px;display:none"></div>
		<div id="fileDiv">
			<p>
				<input type="file" id="file" name="file_0"> 
				<a href="#this" class="btn" id="delete" name="delete">삭제</a>
			</p>
		</div>
		<br /> <br /> 
		<a href="#this" class="btn" id="addFile">파일 추가</a> 
		<a href="#this" class="btn" id="write">작성하기</a> 
		<a href="#this" class="btn" id="list">목록으로</a>
	</form>
	<%@ include file="/WEB-INF/include/include-body.jspf"%>
	<script type="text/javascript">
		function onclick_addr() {
			alert("주소 검색 기능을 사용해 주세요!");
		}
	
		var gfv_count = 1;
		$(document).ready(function() {
			$("#list").on("click", function(e) { //목록으로 버튼 
				e.preventDefault();
				fn_openBoardList();
			});
			$("#write").on("click", function(e) { //작성하기 버튼
				e.preventDefault();
				fn_insertBoard();
			});
			$("#addFile").on("click", function(e) { //파일 추가 버튼 
				e.preventDefault();
				fn_addFile();
			});
			$("a[name='delete']").on("click", function(e) { //삭제 버튼 
				e.preventDefault();
				fn_deleteFile($(this));
			});
		});
		
		function fn_openBoardList() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
			comSubmit.submit();
		}

		function fn_insertBoard() {
			
			if($("#TITLE").val() == "") {
				alert("제목을 입력해주세요!");
				return;
			}
			
			if($("#CONTENTS").val() == "") {
				alert("내용을 입력해주세요!");
				return;
			}
			
			if($("#category").val() == "") {
				alert("카테고리를 입력해주세요!");
				return;
			}
			
			if($("#sample5_address").val() == "") {
				alert("주소를 입력해주세요!");
				return;
			}
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/sample/insertBoard.do' />");
			comSubmit.submit();
		}

		function fn_addFile() {
			var str = "<p><input type='file' name='file_" + (gfv_count++)
					+ "'><a href='#this' class='btn' name='delete'>삭제</a></p>";
			$("#fileDiv").append(str);
			$("a[name='delete']").on("click", function(e) { //삭제 버튼 
				e.preventDefault();
				fn_deleteFile($(this));
			});
		}

		function fn_deleteFile(obj) {
			obj.parent().remove();
		}
	</script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=440eef5ded46cfa12898e098116eaa7a&libraries=services"></script>

<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용
                        
                        // 위,경도를 입력받아서
                        var lat = result.y;
						var lon = result.x;
						
						// 위,경도를 input에 넣고(form 전송을 위해서)
						$("#lat").val(lat);
						$("#lon").val(lon);
						
                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(lat, lon);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
</body>
</html>
