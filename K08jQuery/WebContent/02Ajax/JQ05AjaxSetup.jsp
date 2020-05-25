<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JQ05AjaxSetup.jsp</title>
<link rel="stylesheet" href="../common/bootstrap4.4.1/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.2.1.js"></script>
<script>
/*
 ajaxSetup(): 동일하게 반복되는 $.ajax()의 인자를 설정하여 
 반복되는 인자를 생략하게 해주는 메소드
 
 url, type, data, datatype등의 속성은 기본적으로 사용됨으로 묶어주는데 편함.
 */
$(function(){

	//setup()에서 url과 datatype을 설정함.
	$.ajaxSetup({
		url : './common/05JSONData.json',
		dataType : "json",

		}),
		
	//위에서 미리 정의했음으로 콜백메소드만 정의함.
	$('#btn').click(function(){
		$.ajax({
			succes : function(responseData) {
				/*
				콜백되는 JSON배열 데이터를 each()로 읽어서 배열의 갯수만큼 반복.
				이대 각 반복된 JSON객체를 파싱하게 됨.
				파싱할때는.(점)[](배열)두가지 형태를 사용할수 있다.
				*/
				$.each(responseData, function(index,value){
					var htmlStr = "<tr>";
					htmlStr += " <td>"+(index+1)+"</td>";
					htmlStr += " <td>"+value.name+"</td>";
					htmlStr += " <td>"+value["age"]+"</td>";
					htmlStr += " <td>"+value["주소"]+"</td>";
					htmlStr += "   </tr>";		
					//해당 요소 뒷부분에 컨텐츠를 추가함.
					$('#tbl1').append(htmlStr);
				});
			},
			error:errFunc
		});
	});	
});

function errFunc(errData){
	alert("실패:"+errData.status+":"+errData.statusText);
}
</script>
</head>
<body>
<div class="container">
	<h2>$.ajaxSetup() 메소드 사용하기</h2>
	
	<table class="table table-bordered" id="tbl1">
		<tr>
			<td>NO</td>
			<td>이름</td>
			<td>나이</td>
			<td>출신지역</td>
		</tr>
	</table>
	
	<button id="btn">JSON데이터 가져오기</button>	
</div>
</body>

</html>