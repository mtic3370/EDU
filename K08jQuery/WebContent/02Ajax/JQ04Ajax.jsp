<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JQ04Ajax.jsp</title>
<link rel="stylesheet" href="../common/bootstrap4.4.1/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.2.1.js">

$(function(){
	/*
	해당메소드는 문서의 로드가 끝난직후 js파일의 내욜ㄹ을 읽어와서
	현재 메이지에 노드됨. 
	*/
	$.ajax({
		//요청할 서버의 페이지경로(form의 action과 동일)
		url : './common/04JsData.js',
		//서버로 전송할 전송방식(get 혹은 post)
		type : 'get',		
		//응답결과의 데이터형식(json, xml, html등)
		dataType : "script",
		//요청성공시 실행되는 callback메소드(무명함수)
		success : function(resData){
			MyAlert("Hello", " AJAX");
		},
		//요청실패시 실행되는 callback메소드(외부정의)
		error : errFunc
	});	
	
	$('#ajaxBtn').click(function(){
		$.ajax({
			url : "./common/02PrintToday.jsp",
			dataType : "html",
			type : "get",
			//서버전송시의 컨텐츠 타입
			contentType : "text/html;charset:utf-8",
			//서버로 전송되는 파라미터값(JSON형식으로 만들어야 함)
			data : {
				msg : $(this).text(),
				varStr : "$.ajax()메소드 열라 짱 조아효"
			},
			//요청이 성공했을때 호출되는 콜백메소드(외부정의)
			//함수의 이름만 명시하면 응답데이터까지 같이 전달됨.
			//sucFunc(매개변수) 형태로 쓰지 않는다. 
			success : sucFunc,/*sucFunc(data)형태로 사용하지 않음*/
			error : errFunc
		});
	});	
	
});

/*
콜백메서드를 외부함수 형태로 정의함. 해당함수를 호출시 함수명만으로 호출함.
매개변수는 사용하지 않음.
 */
//$.ajax()메소드 요청 실패시 호출할 callback메소드
//(외부정의)
function errFunc(){
	alert("에러발생. 디버깅하세욤.");
}

/*
요청 성공시 호출할 메소드,외부함수로 정의되어 있고 함수명만으로 호출하더라도 
콜백데이터는 파라미터로 받을수 있다. 
*/
function sucFunc(resData){
	alert("$.ajax()메소드 요청성공");
	$('#ajaxDisplay').html(resData);
}

</script>
</head>
<body>
	<h2>$.ajax() 메소드 사용하기</h2>
	
	<button id="ajaxBtn">ajax()메소드실행하기</button>
	
	<div id="ajaxDisplay">
		ajax결과를 여기에 디스플레이
	</div>
</body>
</html>