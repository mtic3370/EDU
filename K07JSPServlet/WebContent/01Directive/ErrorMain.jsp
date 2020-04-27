<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    errorPage="ErrorPage.jsp" 
    %>
<%--
	errorPage 페이지 지시어
		: 해당 페이지에서 에러(예외)가 발생되었을때 예외처리를 
		설정한 페이지에서 하겠다는 선언이다. 500에러와 같은 
		에러 페이지를 사용자에게 보여주지 않아도 되므로 사이트에 대한
		신뢰를 높일수 있다. 
--%>    
<%
//사용자가 입력하여 전송한 값을 request객체를 통해 받는다. 
String strAge = request.getParameter("age");
//JS의 document.write()와 같은 역할로 브라우저에 문자열을 출력한다. 
out.println("strAge="+ strAge);

int ageAfter10 = -1;
String errorStr = "";

/*
해당 페이지로 폼값을 전송할때 "나이" 부분을 공백상태 혹은 영문을 전송하면아래 코드에서 
에러가 발생된다. Integer.parseInt()의 인자로 숫자가 아닌 문자열이 전달되면 
NumberFormatException 예외가 발생하게 된다. 
*/
if(strAge != null){
	
	ageAfter10 = Integer.parseInt(strAge) + 10;
}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ErrorMain.jsp</title>
</head>
<body>
	<h2>에러가 발생할 페이지</h2>
	<!-- 전송방식이 지정되지 않았음으로 get방식 
	submit()되면 현재페이지로 폼값이 전송된다.
	-->
	<form action="">
		나이를 입력하세요
		<input type="text" name="age" />
		<input type="submit" value="확인" />
		<br />
		※나이를 입력하지 않거나 영문, 한글 전송하면 에러가 발생됩니다.
	</form>
	<span style="color:red; font-size:2em;">
		<% if(ageAfter10 != -1){ %>
			당신의 10년후 나이는 <%=ageAfter10 %>살 입니다.
		<% } else { %>
			<%=errorStr %>
		<% } %>
	</span>
	
	
	
	
	
	
	
	
</body>
</html>