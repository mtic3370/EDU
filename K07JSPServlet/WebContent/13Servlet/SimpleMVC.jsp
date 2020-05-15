<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SimpleMVC</title>
</head>
<body>
	<h2>간단한 MVC패턴 만들기</h2>	
	<!-- 
	서블릿 호출을 위한 순서
	1. 요청명 결정.
	 -->
	<ul>
		<li>
			<a href="SimpleMVC">
				SimpleMVC?type=
			</a>		
		</li>
		<li>
			<a href="SimpleMVC?type=greeting&id=kosmo&pw=1234">
				SimpleMVC?type=greeting&id=kosmo&pw=1234
			</a>		
		</li>
		<li>
			<a href="SimpleMVC?type=date">
				SimpleMVC?type=date
			</a>		
		</li>
		<li>
			<a href="SimpleMVC?type=noparam">
				SimpleMVC?type=noparam
			</a>		
		</li>
	</ul>	
	
	<h3>요청결과</h3>
	<span style="color:red; font-size:2em;">
		${result }
	</span>

	<!-- 
		요청명을 결정할때는 View의 경로와 동일한 Depth(깊이)로 설정하는것이 좋다.
		이미지의 경로JS, CSS파일을 링크할때 경로가 깨지는 경우가 발생하기 때문.
		아래 이미지는 요청명이 "13Servlet/SimpleMVC"일때 정상적으로 출력되지만
		"/SimpleMVC"일때는 이미지가 출력되지 않는다.
	 -->
	<h3>이미지와 요청명</h3>
	<img src="../images/3.jpg" alt="구름하트" />
</body>
</html>