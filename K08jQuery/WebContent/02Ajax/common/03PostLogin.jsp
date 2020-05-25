<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%-- 파일명 : 03PostLogin.jsp --%>
<%
/*
jsp에서 JSON사용하기
1.JSON관련 라이브러리를 다운로드 받는다.(다운로드 URL은
	교안참조)
2.json-simple-1.1.1.jar 파일을 lib폴더에 설치한다.
3.JSON객체를 만들때는 JSONObject()클래스를 이용한다.
4.사용법은 HashMap과 동일하게 put()메소드를 통해 추가하면
된다.
5.완성된 JSON을 화면상에 출력할때는 toJSONString()메소드로
String타입으로 변환후 출력한다. 
*/
String user_id = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");

JSONObject jsonObj = new JSONObject();

if(user_id.equals("kosmo") && user_pw.equals("1234"))
{
	jsonObj.put("user_id", user_id);
	jsonObj.put("user_name", "홍길동");
	jsonObj.put("user_pw", user_pw);
	jsonObj.put("result", 1);	
}
else
{
	jsonObj.put("result", 0);
}

String jsonTxt = jsonObj.toJSONString();
out.println(jsonTxt);
%>






