<%@page import="model.BbsDTO"%>
<%@page import="model.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../common/boardHead.jsp" />
<body>
<div class="container">
	<jsp:include page="../common/boardTop.jsp" />
	<div class="row">		
		<jsp:include page="../common/boardLeft.jsp" />
		<div class="col-9 pt-3">
			<h3>자료실 - <small>View(상세보기)</small></h3>
				<table border=1 width=90%>
				<colgroup>
					<col width="20%"/>
					<col width="30%"/>
					<col width="20%"/>
					<col width="30%"/>
				</colgroup>
					<tr>
						<th>작성자</th>
						<td>${dto.name }</td>
						<th>작성일</th>
						<td>${dto.postdate }</td>
					</tr>
					<tr>
						<th>다운로드수</th>
						<td>${dto.downcount }</td>
						<th>조회수</th>
						<td>${dto.visitcount }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${dto.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3" style="height:150px;">
						${dto.content }
						</td>
					</tr>
					<tr>
					<th>첨부파일</th>
						<td colspan="3">
						<c:if test="${not empty dto.attachedfile }">
						${dto.attachedfile }
						</c:if>
						<a href="./Download?filename=${dto.attachedfile }&idx=${dto.idx}">[다운로드]</a>
						</td>
					</tr>
						<tr>
				</tbody>
				</table>
			</div>
		<button type="button" onclick="location.href='./DataPassword?idx=${param.idx}&mode=edit&nowPage=${param.nowPage }';">수정하기</button>

 		<button type="button"
			onclick="location.href='../DataRoom/DataPassword?idx=${dto.idx}&mode=delete&nowPage=${param.nowPage }';">삭제하기</button>

		<button type="button" onclick="location.href='./DataList?nowPage=${param.nowPage}';">리스트보기</button>
	</div>	
</div>
<!-- 
게시물삭제의 경우 로그인 된 상태이므로 해당 게시물의 일련번호만
서버로 전송하면 된다. 이때 hidden폼을 사용하고, JS의 submit()
함수를 이용해서 폼값을 전송한다. 해당 form태그는 HTML문서 어디든지
위치할 수 있다.  
 -->
<form name="deleteFrm">
	<input type="hidden" name="num" value="" />
</form>

		</div>
	</div>
	<jsp:include page="../common/boardBottom.jsp" />
</div>
</body>
</html>

<!-- 
	<i class='fas fa-edit' style='font-size:20px'></i>
	<i class='fa fa-cogs' style='font-size:20px'></i>
	<i class='fas fa-sign-in-alt' style='font-size:20px'></i>
	<i class='fas fa-sign-out-alt' style='font-size:20px'></i>
	<i class='far fa-edit' style='font-size:20px'></i>
	<i class='fas fa-id-card-alt' style='font-size:20px'></i>
	<i class='fas fa-id-card' style='font-size:20px'></i>
	<i class='fas fa-id-card' style='font-size:20px'></i>
	<i class='fas fa-pen' style='font-size:20px'></i>
	<i class='fas fa-pen-alt' style='font-size:20px'></i>
	<i class='fas fa-pen-fancy' style='font-size:20px'></i>
	<i class='fas fa-pen-nib' style='font-size:20px'></i>
	<i class='fas fa-pen-square' style='font-size:20px'></i>
	<i class='fas fa-pencil-alt' style='font-size:20px'></i>
	<i class='fas fa-pencil-ruler' style='font-size:20px'></i>
	<i class='fa fa-cog' style='font-size:20px'></i>

	아~~~~힘들다...ㅋ
 -->