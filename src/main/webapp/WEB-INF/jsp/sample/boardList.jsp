<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>게시물 리스트</title>
    <%@ include file="/WEB-INF/include/include-header.jspf" %>
<style type="text/css">    
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
	  <ul class="tabs">
	    <li id="one" class="tab-link current" data-tab="tab-1">관광지</li>
	    <li id="two" class="tab-link" data-tab="tab-2">음식점</li>
	    <li id="three"class="tab-link" data-tab="tab-3">숙박</li>
	  </ul>
	  
	<div id="tab-1" class="tab-content current">  
    <table class="board_list">
        <colgroup>
            <col width="5%">
            <col width="50%">
            <col width="5%">
            <col width="15%">
            <col width="15%">
        </colgroup>
        <caption><h2>게시판</h2></caption>    
             
        <thead>
            <tr>
                <th>No.</th>
                <th>제목</th>
                <th>Hit</th>
                <th>작성자</th>
                <th>작성시간</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(list)>0}">
                    <c:forEach items="${list }" var="con" >
      				    <tr>              
      				   <c:if test="${con.category eq '관광지'}">      
                            <td>${con.IDX }</td>
                            <td><input type="hidden" id="IDX" value="${con.IDX }"><a href="#this" name="TITLE">${con.TITLE }</a></td>
                            <td>${con.HIT_CNT }</td>
                            <td>${con.CREA_ID }</td>
                            <td>${con.CREA_DTM }</td>
                          </c:if>
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
   	</div><br/>
   	
   	<div id="tab-2" class="tab-content">  
    <table class="board_list">
        <colgroup>
            <col width="5%">
            <col width="50%">
            <col width="5%">
            <col width="15%">
            <col width="15%">
        </colgroup>
        <caption><h2>게시판</h2></caption>    
             
        <thead>
            <tr>
                <th>No.</th>
                <th>제목</th>
                <th>Hit</th>
                <th>작성자</th>
                <th>작성시간</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(list)>0}">
                    <c:forEach items="${list }" var="con" >
      				    <tr>
      				     <c:if test="${con.category eq '음식점'}"> 
                            <td>${con.IDX }</td>
                            <td><input type="hidden" id="IDX" value="${con.IDX }"><a href="#this" name="TITLE">${con.TITLE }</a></td>
                            <td>${con.HIT_CNT }</td>
                            <td>${con.CREA_ID }</td>
                            <td>${con.CREA_DTM }</td>
                          </c:if>
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
   	</div><br/>
 
 
 <div id="tab-3" class="tab-content">  
    <table class="board_list">
        <colgroup>
            <col width="5%">
            <col width="50%">
            <col width="5%">
            <col width="15%">
            <col width="15%">
        </colgroup>
        <caption><h2>게시판</h2></caption>    
             
        <thead>
            <tr>
                <th>No.</th>
                <th>제목</th>
                <th>Hit</th>
                <th>작성자</th>
                <th>작성시간</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(list)>0}">
                    <c:forEach items="${list }" var="con" >
      				    <tr>
      				     <c:if test="${con.category eq '숙박'}"> 
                            <td>${con.IDX }</td>
                            <td><input type="hidden" id="IDX" value="${con.IDX }"><a href="#this" name="TITLE">${con.TITLE }</a></td>
                            <td>${con.HIT_CNT }</td>
                            <td>${con.CREA_ID }</td>
                            <td>${con.CREA_DTM }</td>
                          </c:if>
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
   	</div> <br/>
 
    <c:if test="${not empty paginationInfo}">
         <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
    </c:if>
    <input type="hidden" id="currentPageNo" name="currentPageNo"/>
     
    <a href="#this" class="btn" id="write">글쓰기</a>
     
    <%@ include file="/WEB-INF/include/include-body.jspf" %>
     
    <script type="text/javascript">

	$(document).ready(function(){
	   
	  $('ul.tabs li').click(function(){
	    var tab_id = $(this).attr('data-tab');
	 
	    $('ul.tabs li').removeClass('current');
	    $('.tab-content').removeClass('current');
	 
	    $(this).addClass('current');
	    $("#"+tab_id).addClass('current');
	  });	 
	});    
        $(document).ready(function(){
            $("#write").on("click",function(e){
                e.preventDefault();
                fn_openBoardWrite();
            })
            $("a[name='TITLE']").on("click",function(e){
                e.preventDefault();
                fn_openBoardDetail($(this));
            })
        })
          
        function fn_openBoardWrite(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do'/>");
            comSubmit.submit();
        }
        function fn_openBoardDetail(val){
            var comSubmit = new ComSubmit();
            comSubmit.addParam("IDX",val.parent().find("#IDX").val());
            comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do'/>");
            comSubmit.submit();
        }
        function fn_search(pageNo){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
            comSubmit.addParam("currentPageNo", pageNo);
            comSubmit.submit();
        }
 
    </script>
</body>
</html>