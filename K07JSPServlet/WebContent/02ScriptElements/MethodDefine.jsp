<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
//start에서 end사이의 baesu의 합을 구하는 메소드
public int getBaesu(int start, int end, int baesu){	
	//누적합 저장용 변수
	int sum = 0;
	//start에서 end까지 반복한다.
	for(int i=start ; i<=end ; i++){
		//baesu를 통해 배수를 구한다. 
		if(i%baesu==0){
			sum += i;
		}
	}
	return sum;
}
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MethodDefine.jsp</title>
</head>
<body>
	<h2>선언부에서 메소드 정의</h2>
	<h3>스크립트렛에서 결과값 출력</h3>
	<%
	/*연습문제] 1부터 100사이의 숫자중 3의배수의 합을 
	반환하는 함수를 선언후 결과를 출력하시오.
	함수명 : getBaesu()*/
	int hapResult = getBaesu(1, 100, 3);
	out.println("1~100사이의 3의 배수의 합:"+hapResult);
	%>
	<h3>표현식에서 결과값 출력</h3>
	1~200사잉의 숫자중 5의 배수의 합?
		<%=getBaesu(1, 200, 5) %>
</body>
</html>