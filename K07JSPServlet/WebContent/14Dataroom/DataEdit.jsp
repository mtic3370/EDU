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
			<h3>게시판 - <small>Edit(수정)</small></h3>
<script>
	//유기명함수
	function checkValidate(frm){		
		if(frm.name.value==""){
			alert("이름을 입력하세요.");//경고창 띄움
			frm.name.focus();//입력란으로 포커스 이동
			return false;//전송되지 않도록 이벤트리스너로 false반환
		}
		if(frm.pass.value==""){
			alert("비밀번호을 입력하세요.");//경고창 띄움
			frm.pass.focus();//입력란으로 포커스 이동
			return false;//전송되지 않도록 이벤트리스너로 false반환
			}
		if(frm.title.value==""){
			alert("제목을 입력하세요.");//경고창 띄움
			frm.title.focus();//입력란으로 포커스 이동
			return false;//전송되지 않도록 이벤트리스너로 false반환
		}
		if(frm.content.value==""){
			alert("내용을 입력하세요.");//경고창 띄움
			frm.content.focus();//입력란으로 포커스 이동
			return false;//전송되지 않도록 이벤트리스너로 false반환
		}
	}	
/* 	//무기명함수
	var checkValidate2 = function(frm){		
		//실행부는 유기명함수와 동일함
	}	 */
</script>			
	<div class="row mt-3 mr-1">
<table class="table table-bordered table-striped">
<!-- 
파일 업로드를 위해서는 반드시 enctype을 선언해야 한다. 그렇지 않으면 파일은 서버로 전송되지 않는다.
 -->
<form name="writeFrm" method="post" action="../DataRoom/DataEdit"
	enctype="multipart/form-data"  onsubmit="return checkValidate(this);">

<input type="hidden" name="idx" value="${dto.idx }"/>
<input type="hidden" name="nowPage" value="${param.nowPage }"/>
<input type="hidden" name="originalfile" value="${dto.attachedfile }"/>	

<table border=1 width=800>
<colgroup>
	<col width="25%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center align-middle">작성자</th>
		<td>
			<input type="text" class="form-control"	style="width:100px;"
				name="name" value="${dto.name }" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">패스워드</th>
		<td>
			<input type="password" class="form-control" style="width:200px;"
				name="pass" value="${dto.pass }" />
		</td>
	</tr>
	<tr>
		<th class="text-center"
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" class="form-control" 
				name="title" value="${dto.title }" />
		</td>
	</tr>
	<tr>
		<th class="text-center"
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea rows="10" 
				class="form-control" name="content">${dto.content }</textarea>
		</td>
	</tr>
	<tr>
		<th class="text-center"
			style="vertical-align:middle;">첨부파일</th>
		<td>
			첨부파일 : ${dto.attachedfile }
			<input type="file" class="form-control" style="width:80%;" name="attachedfile" />
		</td>
	</tr>
</tbody>
</table>	
			</div>
<!-- 샘소스 오류~ -->			<div class="row mb-3">
				<div class="col text-right">					
					<button type="submit" class="btn btn-danger">전송하기</button>
					<button type="reset" class="btn btn-dark">Reset</button>
					<button type="button" class="btn btn-warning" onclick="location.href='../DataRoom/DataList';">리스트보기</button>
<!-- ~샘소스 오류 -->				</div>
</form>
	<jsp:include page="../common/boardBottom.jsp" />
</body>
</html>