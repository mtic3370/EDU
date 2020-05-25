<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JQ02Get.jsp</title>
<script src="../common/jquery/jquery-3.5.1.js"></script>
<script>
/*
$.get()메소드
	: HTTP Get방식을 통해 서버로부터 데이터를 받을때 
	사용하는 메소드
	
사용법
 	$.get(url, param, success(data));
 	-url : 정보를 요청할 url
 	-param : 서버로 전송할 파라미터(JSON형식)
 	-success(data) : 요청이 성공했을때 실행될 
 		callback(콜백) 함수. 콜백함수이 호출될때 전달되는
 		파라미터를 통해 성공 혹은 실패여부를 판단할수 
 		있다. 
 		
※$.get() 메소드와 $.post() 메소드는 사용법이 동일하다.
※서버로 요청시 전송할값(파라미터)이 없는경우에는 생략이
가능하다.
*/
$(function(){

	$('#btnXml').click(function(){			
		$.get(
			'./common/02NameCard.xml', 
			function(data){
				//alert(data);
				$(data).find("명함").each(function(){
					var html = "<div>이름:"+
							$(this).find("성명").attr("이름")
						+"</div>";
					html += "<div>주소:"+
							$(this).find("주소").text()
						+"</div>";
					html += "<div>직위:"+
							$(this).find("직위").text()
						+"</div>";
					html += "<div>이메일:"+
							$(this).find("e-mail").text()
						+"</div>";
					html += "<div>핸드폰:"+
							$(this).find("Mobile").text()
						+"</div>";
					html += "<div>전화번호:"+
							$(this).find("TEL").text()
						+"</div>";
					html += "<div>카피라이트:"+
							$(this).find("copyright").text()
						+"</div>";
					
					//$('#xmlDisplay').html(html);
					
					/*
					해당 영역을 empty()로 비워준후 append()로 추가한다.
					아래 두개의 메소드는 위 html()메소드로 대체
					가능하다.
					*/
					$('#xmlDisplay').empty();
					$('#xmlDisplay').append(html);
				});
			}
		);
	});
	
	
	//JSP파일에서 읽어오기
	$('#btnJSP').click(function(){		
		$.get(
			'./common/02PrintToday.jsp',
			{
				'msg' : $(this).text(),
				'varStr' : 'jQuery좋아효'				
			},
			function(data){
				alert(data);
				$('#jspDisplay').html(data);
			}
		);		
	});		
	
	/*
	파라미터 조립하기 : $.get()이나 $.post()를 통해 서버로 요청하는 경우 
	파라미터를 전송할때는 항상JSON으로 조립해야 함.
	하지만 폼값이 많아서 조립이 힘든경우 serialize()를 사용함.
	
	$.(폼이름).serialize()
	->해당 메소드를 이용하면 form하위의 모든 요소에
	대해 {'키1':'값1','키2':'값2'} 와 같이 JSON형태로
	조립된다. 단, input 요소의 name속성값이 '키'로 
	사용된다는것에 주의하자. 
	*/
});

//전달된 URL을 새창으로 띄워준다.
function locationGo(link){
	window.open(link, '', 'width=500,height=500');
}
</script>
</head>
<body>
<div class="container">	
	<h2>$.get() 메소드 사용하기</h2>
	
	<h3>xml파일 읽어오기</h3>
	<button class="btn" 
		onclick="locationGo('./common/02NameCard.xml');">
		NameCard.xml바로가기
	</button>
	
	<button class="btn btn-info" id="btnXml">
		XML데이터 읽어오기
	</button>
	
	<div class="displayDiv" id="xmlDisplay">
		XML데이터 정보를 디스플레이합니다.
	</div>
	
	
	<h3>jsp파일에서 읽어오기</h3>
	<button class="btn btn-warning" 
		onclick="locationGo('common/02PrintToday.jsp?msg=안녕하세요&varStr=jQuery조아효');">
		PrintToday.jsp바로가기
	</button>
	<button class="btn btn-success" id="btnJSP">
		JSP결과 읽어오기
	</button>
	<div class="disDisplay" id="jspDisplay">
		JSP결과를 디스플레이 합니다.
	</div>
	
</div>
</body>
</html>