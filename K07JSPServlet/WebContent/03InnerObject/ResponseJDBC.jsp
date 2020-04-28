<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ResponseJDBC.jsp</title>
</head>
<body>
<%
//오라클 드라이버와 URL이용하여 DB연결
/* String driver = "oracle.jdbc.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:orcl"; */


//application객체를 이용하여 web.xml에 설정된 컨텍스트 초기화
//파라미터 읽어오기
String driver = application.getInitParameter("JDBCDriver");
String url = application.getInitParameter("ConnectionURL");


MemberDAO dao = new MemberDAO(driver, url);

//로그인 페이지에서 전송한 아이디, 패스워드 폼값받아 저장.
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pwd");

//저장된 변수를 isMember()메소드의 파라미터로 전달
boolean memberFlag = dao.isMember(id, pw);
if(memberFlag==true){
	//회원인증에 성공하면 true반환
	System.out.println("회원입니다.");	
	response.sendRedirect("../common/Welcome.jsp");
}
else{
	//실패하면 false반환
	System.out.println("회원이 아닙니다.");
	
	String jsAlert = "<script>";
	jsAlert += "alert('회원이 아닙니다');";
	jsAlert += "history.go(-1);";
	jsAlert += "</script>";
	
	out.println(jsAlert);
}
%>
</body>
</html>



