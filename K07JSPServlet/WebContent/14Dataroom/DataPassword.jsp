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
			<h3>게시판 - <small>Password(패스워드검증)</small></h3>
<script>
	//유기명함수
	
		
		function checkValidate(frm){		
			if(frm.pass.value==""){
				alert("비밀번호을 입력하세요.");//경고창 띄움
				frm.pass.focus();//입력란으로 포커스 이동
				return false;//전송되지 않도록 이벤트리스너로 false반환
			}
		}
	 	
</script>			
			<div class="row mt-3 mr-1">
<table class="table table-bordered table-striped">
<!-- 
패스워드 검증폼은 첨부파일을 전송하지 않음으로 enctype선언부를 삭제해야 한다.
 -->
<form name="writeFrm" method="post" action="../DataRoom/DataPassword"
onsubmit="return checkValidate(this);">

<!-- idx의 경우 영역에 저장하지 않고, EL의 param내장객체를 통해서
	바로 읽어온다. View(jsp파일)에서 바로 사용하는경우에는 EL식으로
	즉시 읽어오는것이 편리하다. -->
<input type="hid den" name="idx" value="${param.idx }" />
<input type="hid den" name="mode" value="${mode }" />
<input type="hid den" name="nowPage" value="${param.nowPage }" />
	
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">패스워드</th>
		<td>
			<input type="password" class="form-control"
				style="width:200px;" name="pass"/>
		</td>
	</tr>

</tbody>
</table>
			</div>
			<div class="row mb-3">
				<div class="col text-right">
					<!-- 각종 버튼 부분 -->
					<!-- <button type="button" class="btn">Basic</button> -->
					<!-- <button type="button" class="btn btn-primary" 
						onclick="location.href='BoardWrite.jsp';">글쓰기</button> -->
					<!-- <button type="button" class="btn btn-secondary">수정하기</button>
					<button type="button" class="btn btn-success">삭제하기</button>
					<button type="button" class="btn btn-info">답글쓰기</button>
					<button type="button" class="btn btn-light">Light</button>
					<button type="button" class="btn btn-link">Link</button> -->
					<button type="submit" class="btn btn-danger">전송하기</button>
					<button type="reset" class="btn btn-dark">Reset</button>
					<button type="button" class="btn btn-warning" onclick="location.href='BoardList.jsp';">리스트보기</button>
				</div>
				</form>
			</div>
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