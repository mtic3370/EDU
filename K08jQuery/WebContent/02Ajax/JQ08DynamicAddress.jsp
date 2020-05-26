<%@page import="java.util.ArrayList"%>
<%@page import="controller.ZipcodeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
	uri="http://java.sun.com/jsp/jstl/core" %>
<%
ZipcodeDAO dao = new ZipcodeDAO();
//DAO에서 sido를 select한 결과를 컬렉션으로 반환
ArrayList<String> sidoList = dao.getSido();
//JSTL에서 사용하기 위해 페이지 영역에 저장
//set태그를 이용해도 동일한 결과임.
pageContext.setAttribute("sidoList", sidoList);
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JQ08DynamicAddress.jsp</title>

<link rel="stylesheet" href="../common/bootstrap4.4.1/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$('#sido').change(function(){		
		//alert($('#sido').val() +" 선택됨");
		$.ajax({
			url : "./common/08GugunOption.jsp",
			type : "get",
			data : {
				sido : $('#sido option:selected').val()
			},
			dataType : "json",
			contentType : "text/html;charset:utf-8;",
			success:function(d){
				//alert(d);
				
				var optionStr = "";
				optionStr += "<option value=''>";
				optionStr += "-구군을 선택하세요-";
				optionStr += "</option>";
				$.each(d, function(index, data){
					optionStr += '<option value="'+data+'">';
					optionStr += data;
					optionStr += '</option>';
				});
				/*
				콜백받은 JSON배열을 갯수만큼 반복하기 위해 $.each()메소드를 사용함.
				이때 배열에 저장된 순서대로 매새변수 data로 출력됨.
				*/
				
				$('#gugun').html(optionStr);
			},
			error:function(e){
				alert("오류발생:"+e.status+":"+
						e.statusText);
			}
		});		
	});
	
	//구군을 선택하면...
	$('#gugun').change(function(){
		
		var s = $('#sido option:selected').val();
		var g = $('#gugun').val();
		
		alert("선택한 시도:"+s+",구군:"+g);		
	});
});
</script>
</head>
<body>
<div class="container">
	<div class="row">
		<h2>우편번호DB를 이용한 시도/구군 동적셀렉트 구현</h2>
	</div>
	<div class="row">
		<form id="zipFrm">
			시/도:
			<select id="sido" class="form-control">
				<option value="">-시/도선택하삼-</option>
				<c:forEach items="${sidoList }" var="sidoStr">
					<option value="${sidoStr }">${sidoStr }</option>
				</c:forEach>
			</select>
			<br />
			구/군:
			<select id="gugun" class="form-control">
				<option value="">-구/군선택하삼-</option>
			</select>		
		</form>
	</div>
</div>
</div>
</body>
</html>