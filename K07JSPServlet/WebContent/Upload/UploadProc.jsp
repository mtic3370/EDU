<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
//파일업로드 처리하기

//한글깨짐처리
request.setCharacterEncoding("UTF-8");
//1.파일을 업로드할 서버의 물리적경로 가져오기
/*
운영체제별로 서버의 물리적인 경로는 달라질수 있으므로 파일이 업로드
되는 정확한 위치를 알기 위해서는 반드시 필요하다. 
*/
String saveDirectory = application.getRealPath("/Upload");
//2.업로드할 파일의 최대용량 설정(바이트단위)
/*
만약 파일을 여러개 업로드 하려면 각각의 용량을 합친 용량이 최대 용량이 됨.
Ex) 500Kb * 2개 = 1000Kb
*/
int maxPostSize = 1024 * 5000;
//4.인코딩 타입 설정
String encoding = "UTF-8";
//5.파일명 중복처리
/*
파일명이 중복되는 경우 자동 인덱스를 부여하여 파일명을 수정해 준다.
Ex)apple.png, apple1.png, apple2.png와 같이 각자의 이름을 부여한다.
*/
FileRenamePolicy policy = new DefaultFileRenamePolicy();

//전송된 폼값을 저장하기 위한 변수생성
MultipartRequest mr = null;
String name = null;
String title = null;
StringBuffer inter = new StringBuffer();

//저장된 파일명을 변경하기 위한 객체생성
File oldFile = null;
File newFile = null;
String realFileName = null;

try{
	/*
	1~4번까지 준비한 인자를 이용하여 MultyRequest객체를 생성함.
	객체가 정상적으로 생성되면 파일업로드는 완료된다.
	만약 예외가 발생한다면 주로 최대 용량 초과 혹은 디렉토리 경로가 잘못된 경우가 대부분임.
	*/
	mr = new MultipartRequest(request, saveDirectory, maxPostSize,
			encoding, policy);
	//파일을 제외한 나머지 폼값을 받아옴.
	/*
	폼값은 request내장 객체를 통해서가 아니라 MultyRequest객체를 통해 받는다.
	*/
	
	
	//서버에 저장된 파일명 가져오기
	String fileName = mr.getFilesystemName("chumFile1");
	//파일명 변경을 위해 현재시간 가져오기
	/*
	아래 서식문자중 대문자 S는 초를 1/1000단위로 가져오는 것임.(0~999)
	*/
	String nowTime = new SimpleDateFormat("yyyy_MM_dd_H_m_s_S")
			.format(new Date());
	
	//파일의 확장자를 따내서 위에서 설정한 파일명과 합쳐준다. 
	int idx = -1;
	/* 파일명 사이에 .(닷)이 여러개 들어갈수 있으므로 lastIndexOf()를
	이용해서 마지막에 있는 .(닷)을 찾아온다. */
	idx = fileName.lastIndexOf(".");
	realFileName = nowTime + fileName.substring(idx, fileName.length());
	
	/*
	서버의 물리적경로와 생성된 파일명을 통해 파일객체를 생성한다. 
	※파일객체.separator : 파일경로를 나타낼때 윈도우는 \(역슬러쉬), 
		리눅스는 /(슬러쉬)를 사용하게되는데, OS에 따라 구분기호를
		자동으로 변환하여 설정해주는 역할을 한다. 
	*/	
	oldFile = new File(saveDirectory+oldFile.separator+fileName);
	newFile = new File(saveDirectory+oldFile.separator+realFileName);
	
	//저장된 파일명을 변경한다. 
	oldFile.renameTo(newFile);
		
	//7.파일 이외에 나머지 폼값 받기
	/*
	폼값을 받을때는 request객체를 통해서가 아니라 MultipartRequest객체를
	통해서 받는다. 
	*/
	name = mr.getParameter("name");
	title = mr.getParameter("title");
	String[] interArr = mr.getParameterValues("inter");
	for(String s : interArr){
		inter.append(s +",&nbsp;");
	}	
}
catch(Exception e){
	request.setAttribute("errorMessage", "파일업로드오류");
	request.getRequestDispatcher("FileUploadMain.jsp")
		.forward(request, response);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>파일 업로드 결과</h2>
	<ul>
		<li>
			작성자 : <%=name %>
		</li>
		<li>
			제목 : <%=title %>
		</li>
		<li>
			관심사항 : <%=inter %>
		</li>
	</ul>
	
	<h2>첨부파일1</h2>
	<ul>
		<li>원본파일명 : 
			<%=mr.getOriginalFileName("chumFile1") %></li>		
		<li>서버에저장된파일명(old) : 
			<%=mr.getFilesystemName("chumFile1") %></li>		
		<li>서버에 저장된 파일명(new) : <%=realFileName %></li>
		
		<li>컨텐츠타입 : <%=mr.getContentType("chumFile1") %></li>
		<li>파일크기 : <%=(int)Math.ceil(newFile.length()/1024.0) %>Kb
		</li>
		<li>이미지표현 : 
		<img src="../Upload/<%=realFileName %>" width="200" /></li>
	</ul>
	
	
	<h2>첨부파일2</h2>
	<ul>
		<li>원본파일명 : 
		<%=mr.getOriginalFileName("chumFile2") %></li>
		<li>서버에저장된파일명 : 
		<%=mr.getFilesystemName("chumFile2") %></li>
		<li>컨텐츠타입 :
		<%=mr.getContentType("chumFile2") %></li>
		<li>파일크기 : <%=(int)Math.ceil(mr.getFile("chumFile2")
			.length() / 1024.0) %> Kb
		</li>
		<li>이미지표현 : 
		<img src="../Upload/<%=mr.getFilesystemName("chumFile2") %>"
			width="200" /></li>
	</ul>	
	
	<a href="FileList.jsp">파일목록 바로가기</a>	
	
</body>
</html>