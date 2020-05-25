<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JQ03PostOracle.jsp</title>
<link rel="stylesheet" href="../common/bootstrap4.4.1/css/bootstrap.css" / >
<script src="../common/jquery/jquery-3.2.1.js"></script>
<script>
$(function(){
	
	$('#btnLogin2').click(function(){
		
		var s_url = "./common/03PostLoginOracle.jsp";
		var s_params = $('#loginFrm').serialize();
		
		$.post(
			s_url,
			s_params,
			function(resData){
				var d = JSON.parse(resData);
				if(d.result==1){
					alert(d.message);
					$('#loginFrm').html(d.html);
					$('#btnLogin2').hide();
				}
				else{
					alert(d.message);
				}
				
				$('#jsonDisplay').text(resData);
			}
		);		
	});
});

function checkFrm(){
	var f = document.getElementById("loginFrm");
	f.method = "post";
	f.action = "./common/03PostLoginOracle.jsp";
}
</script>

</head>
<body>
<div class="container">
	<h2>$.post() 메소드 사용하기</h2>
	
	<h3>로그인 구현하기 - Oracle 연동O(오라클연결)</h3>
	<div class="row" id="loginTable">
		<form id="loginFrm" onsubmit="return checkFrm();">
			<table class="table table-bordered">
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" id="user_id" 
							name="user_id" value="kosmo" />
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td>
						<input type="password" id="user_pw" 
							name="user_pw" value="1234" />
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-danger" 
				id="btnLogin1">
				로그인하기(HTML의submit사용)</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-success" 
				id="btnLogin2">
				로그인하기(jQuery의 $.post()사용)</button>
		</form>
	</div>
	<br/>
	<div class="row" id="jsonDisplay">
		JSON 데이터를 뿌려봅시다
	</div>
</div>	
</body>
</html>