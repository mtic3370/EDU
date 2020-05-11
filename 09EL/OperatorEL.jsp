<%@page import="java.util.Vector"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OperatorEL.jsp</title>
</head>
<body>

	<h2>EL의 연산자들</h2>
	<h3>EL에서의 null연산</h3>
	<%
	/*
	Java코드에서는 null과 연산을 수행하거나 출력은 불가능하다. 
	하지만 EL에서는 Null이 0으로 간주되어 계산된다. 따라서 NullPointerException
	이 발생하지 않는다. 
	*/
	//int a = null + 10; <- null과의 연산이므로 에러발생됨
	%>
	
	<!-- 산술연산에서 null은 0으로 간주되어 계산된다.  -->
	\${null+10 } : ${null+10 }<br><!-- 결과 : 10-->
	\${param.myNumber+10 } : ${param.myNumber+10 } <br>
	<!-- 파라미터가 없을때 결과 10,파라미터가 있을때 해당값을 읽어와서 연산함. 
	만약
		해당 페이지?myNumber=20인경우 30이 출력됨
		해당 페이지?myNumber=인경우 0으로 간주되어 10출력됨
		해당 페이지?myNumber=삼 인경우 문자는 숫자로 변경불가함으로 에러 발생됨
		-->
	<br />
	
	<!-- null값과 비교연산에서는 무조건 false값을 반환한다.
	산술연산에서는 0으로 간주한후 연산을 진행하지만, 비교연산은
	null가의 비교자체가 불가하기 때문.  -->
	/${param.myNum>10 } : ${param.myNum>10 }<br>
	/${param.myNum<10 } : ${param.myNum<10 }<br>
	<br>
	
	<h3>JSTL로 EL에서 사용할 변수 선언</h3>
	<!--
		EL식에서는 JSP의 스크립팅 요소에서 선언한 변수를 직접 사용할수 없다. 
		값이 출력되지 않고 null로 인식하게된다.
		JSP의 변수를 EL로 사용할수 없는 이유는 EL은 4가지 영역에 저장된 속성들만 
		사용하기 때문이다.JSTL도 동일한 특성을 가지고 있다.  
	 -->
	<% 
	String varScriptLet = "스크립트렛안에서 변수 선언";
	%>
	<!-- NULLL값으로 ㅣ인식됨으로 0으로 간주됨. 결과는 100출력 -->
	\${varScriptLet+100 } : ${varScriptLet+100 }<br>
	<!-- 
	JSP코드에서 선ㅇ너한 변수를 EL에서 사용해야 할경우는 JSTL의 set태그를 이용해서
	변수를 선언함.JSP에서 즉시 선언하려면 영역에 저장한다.
	-->
	<c:set var="elVar" value="<%=varScriptLet %>" />
	\${elVar } : ${elVar } <!-- 결과 : 문자열 출력됨 -->
	
	<!-- tomcat8.0부터는 EL변수에서 변수 할당이 가능해졌다. 하지만 개발시에는 
	실제 서비스할 웹서버의 버전을 확인후 사용여부를 결정한다.
	EL은 전통적으로 값을 표현하는 용도로 사용되어 졌음으로 표현용으로 사용하는것이 좋다. -->
	<h3>EL변수에 값 할당</h3>
	<c:set var="fnum" value="9" />
	<c:set var="snum" value="5" />
	\${fnum=99 } : ${fnum=99 } <!-- 99로 재할당되어 99출력됨 -->
	
	<h3>EL의 산술연산자</h3>
	<!-- 
		EL에서는 정수와 정수를 연산하더라도 '실수'의 결과가 나올수 있다.
		즉 자동형변환되어 출력된다. 
		나눗셈을 위한 /연산자 대신 div를 사용할수 있다.
		%대신 mod를 사용할수 있다.
	 -->
	<ul>
		<li>\${fnum+snum } : ${fnum+snum }</li>
		<li>\${fnum/snum } : ${fnum/snum }</li>
		<li>\${fnum div snum } : ${fnum div snum }</li><!-- / 연산과 동일함 -->
	
		<li>\${fnum % snum } : ${fnum % snum }</li>
		<li>\${fnum mod snum } : ${fnum mod snum }</li><!-- % 연산과 동일함 -->
	
	<!-- 
		EL에서는 +연산자는 덧셈의 용도로만 사용된다.
		문자열을 연결하기 위한 용도로는 사용할수 없다. 
	-->
		<li>\${"100"+100 } : ${"100"+100 }</li><!-- 결과 : 200 -->
		<li>\${"Hello~"+"EL~" } : \${"Hello!"+"EL~" }</li>
		<li>\${"일"+2 } : \${"일"+2 }</li>
	</ul>


	<!-- 비교연산자를 이용한 비교시 변수의 값을 모두 문자열로 인식하여 String 클래스의 
		compareTO()메소드와 같은 방식으로 비교한다.
		즉, 첫번째 문자부터 하나씩 비교해 나간다. 
		단, 실제숫자 비교시에는 일반적인 숫자비교가 이루어진다. 
	 -->	
	<h3>EL의 비교연산자</h3>
	<c:set var="fnum" value="100" />
	<c:set var="snum" value="90" />
	<ul>
		<!-- 
			문자열 형태로 비교하기때문에 문자9와 문자1의 아스키코드값을 통한 
			비교가 진행되어 false가 반환된다. 
		-->
		<li>\${fnum > snum } : ${fnum > snum }</li><!-- false -->
		<li>\${100 > 90 } : ${100 > 90 }</li><!-- true -->
		
		<!-- 
			Java에서는 문자열을 비교할때 equals() 메소드를 통해 비교하지만, 
			EL에서는 == 형태로 비교한다. 
		 -->
		<li>\${"JAVA"=='JAVA' } : ${"JAVA"=='JAVA' }</li><!-- true -->
		<li>\${"Java"=='JAVA' } : ${"Java"=='JAVA' }</li><!-- false -->
	</ul>
	
	<!-- 
		EL의 논리연산자
		> : Greater Then
		>= 	: Greater then Equal
		< 	: Less Then
		<= 	: Less then Equal
		== 	: EQual
		!= 	: Not Equal
		&& 	: And
		|| 	: Or
	 -->
	<h3>EL의 논리연산자</h3>
	<ul>
		<li>\${5>=5 && 10!=10 } : <!-- 참 and 거짓 => 거짓 -->
				${5 ge 5 and 10 ne 10 }</li>
		<li>\${5>6 || 10<100 } : <!-- 거짓 or 참 => 참 -->
				${5 gt 6 or 10 lt 100 }</li>
	</ul>
	
	
	<h3>EL의 삼항연산자</h3>
	\${10 gt 9 ? "참이닷" : "거짓이닷" }
		: ${10 gt 9 ? "참이닷" : "거짓이닷" }
	
	
	<!--
	null이거나 ""(빈문자열)일때
		혹은 배열인 경우 길이가 0일때
		혹은 컬렉션인 경우 size가 0일때
		=> true를 반환하는 연산자이다. 
	 -->
	<h3>EL의 empty 연산자 : null일때 true를 반환하는 연산자</h3>
	<%
		String nullStr = null;
		String emptyStr = "";
		Integer[] lengthZero = new Integer[0];
		Collection sizeZero = new Vector();
	%>
	<!-- EL에서 사용할 변수를 JSTL에서 선언함 -->
	<c:set var="elnullStr" value="<%=nullStr %>" />
	<c:set var="elemptyStr" value="<%=emptyStr %>" />
	<c:set var="ellengthZero" value="<%=lengthZero %>"/>
	<c:set var="elsizeZero" value="<%=sizeZero %>" />
	<ul>
		<li>\${empty elnullStr } : ${empty elnullStr }</li>
		<li>\${not empty elemptyStr } : ${not empty elemptyStr }</li>
		<li>${empty ellengthZero ? 
				"배열크기가0임" : "배열크기가0이아님" }</li>
		<li>${not empty elsizeZero ?
				"컬렉션에 저장된 객체있음" : 
				"컬렉션에 저장된 객체없음" }</li>
	</ul>
</body>
</html>