<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%-- 파일명 : 03PostLogin.jsp --%>
<%
//폼값을 받음
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

//jsp에서JSON을 사용하기 위해 확장 라이브러리 설치후 객체를 생성함.
JSONObject jsonObj = new JSONObject();

if(user_id.equals("kosmo") && user_pw.equals("1234"))
{
/*
JSONObj객체를 통해 Key, Value를 입력함.
사용법은 Map컬렉션과 동일. 아래와 같이 하면 JSON객체가 생성됨.
*/
	jsonObj.put("user_id", user_id);
	jsonObj.put("user_name", "홍길동");
	jsonObj.put("user_pw", user_pw);
	jsonObj.put("result", 1);	
}
else{
	//아이디/패스워드가 일치하지 않는 경우 result는 0을 반환함.
	jsonObj.put("result", 0);
}
//JSON객체를String타입으로 형변환후 화면에 내용
String jsonTxt = jsonObj.toJSONString();
out.println(jsonTxt);
%>