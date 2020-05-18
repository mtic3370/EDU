<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- Message.jsp --%>
<c:choose>
	<c:when test="${WHEREIS=='UPDATE' }">
		<c:set var="sucmsg" value="수정성공함" />
		<c:set var="failmsg" value="수정실패함" />
		<c:set var="sucurl" 
		value="/DataRoom/DataView?idx=${idx}&nowPage=${nowPage}" />
	</c:when>
	<c:otherwise>
		<c:set var="sucmsg" value="삭제성공함" />
		<c:set var="failmsg" value="삭제실패함" />
		<c:set var="sucurl" 
		value="/DataRoom/DataList?nowPage=${nowPage }" />	
	</c:otherwise>
</c:choose>

<%--
수정 성공한 경우 상세보기 페이지로 이동.
삭제 성공한 경우 리스프 페이지로 로케이션 됨.
 --%>
<script>
<c:choose>
	<c:when test="${SUC_FAIL==1 }">
		alert("${sucmsg }");
		location.href="<c:url value='${sucurl }' />";
	</c:when>
	<c:when test="${SUC_FAIL==0 }">
		alert("${failmsg }");
		history.back();
	</c:when>
	<c:otherwise>
		alert('파일용량을 초과했습니다');
		history.back();
	</c:otherwise>
</c:choose>
</script>
