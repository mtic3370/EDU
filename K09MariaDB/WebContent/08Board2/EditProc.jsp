<%@page import="model.BbsDAO"%>
<%@page import="model.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 파일명 : EditProc.jsp --%>
<!-- 게시물 수정처리를 위해 가장먼저 회원인증을 확인한다. 비 로그인 상태라면 
로그인후 진입할수 있도록 처리한다.  -->
<%@ include file="../common/isLogin.jsp" %>

<!-- 해당파일 내에서 bname에 대한 폼값을 받고 있음. -->
<%@ include file="../common/isFlag.jsp" %>

<%
request.setCharacterEncoding("UTF-8");

//폼값받기
//String bname = request.getParameter("bname");
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");

//폼값을 DTO객체에 저장
BbsDTO dto = new BbsDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

//DAO객체 생성 및 DB연결
BbsDAO dao = new BbsDAO(application);

//DTO객체를 DAO로 전달하여 게시물 업데이트(수정)
int affected = dao.updateEdit(dto); 
if(affected==1){
	//정상적으로 수정되었다면 수정된 내용의 확인을 위해 상세보기로 이동
	response.sendRedirect("BoardView.jsp?bname=" +bname+ "&num="+dto.getNum());
}
else{
	//수정중 문제가 발생하였다면 수정하기 페이지로 돌아간다.
%>
	<script>
		alert("수정하기에 실패하였습니다.");
		history.go(-1);
	</script>
<%	
}
%>