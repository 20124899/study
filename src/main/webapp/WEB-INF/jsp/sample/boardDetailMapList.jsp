<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach items="${resultList }" var="con" >
<tr>              
	<td data-lat="${con.lat}" data-lon="${con.lon}" data-name="${con.TITLE }"><input type="hidden" id="IDX" value="${con.IDX }">${con.TITLE }</td>
</tr>
</c:forEach>
