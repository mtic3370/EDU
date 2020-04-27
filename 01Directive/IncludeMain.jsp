<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ include file="./IncludePage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IncludeMain.jsp</title>
<link rel="stylesheet" href="./css/div_layout.css" />
</head>
<body>
<div class="AllWrap">
	<div class="header">
	<!-- GNB(Global Navigation Bar)영역 - 전체 공통 메뉴-->
	<%@ include file="../common/Top.jsp" %>
	</div>
	
	<div class="body">
	<div class="left_menu">
	<!-- LNB영역(Local Navigation Bar) -->
	<%@ include file="../common/Left.jsp" %>
	</div>

	<div class="contents">
		<!-- contents영역 -->
		<!-- 해당변수는 외부파일에 선언하여 본문소에 include처리되었다.
		include는 문서 자체를 포함시키는 개념임으로 에러 발생이 되지 않는다. -->

		<h2>오늘일자 : <%=todayStr %></h2>
		<br><br>
		<h2>코로나19 자가격리자 3만9천740명…격리지침 위반 286명·45명은 기소의견 송치</h2>
		
		(서울=연합뉴스) 신선미 기자 = 신종 코로나바이러스 감염증(코로나19) 자가격리 위반자를 대상으로 한 전자손목밴드(안심밴드) 착용이 27일 시행에 들어갔다. 정부는 '인권침해'를 최소화하겠다는 입장이다.
<br><br>
박종현 범정부대책지원본부 홍보관리팀장은 27일 정부세종청사에서 열린 정례 브리핑에서 "이날 0시부터 자가격리자 중 격리수칙을 위반한 사람 중 착용에 동의한 사람만 안심밴드 착용을 하게 된다"면서 "인권침해 논란을 최소화하려고 한다"고 말했다.

앞서 자가격리자의 수칙 위반 사례가 잇따르자 정부는 코로나19의 확산을 우려해 이달 11일 안심밴드 도입 계획을 밝힌 바 있다. 착용 대상은 격리지를 무단 이탈하거나 확인 전화를 받지 않는 등 격리 지침을 위반한 사람들이다. 안심밴드는 블루투스를 통해 휴대전화에 설치된 '자가격리자 안전보호 앱'과 연계해 구동된다. 일정 거리를 이탈하거나 밴드를 훼손, 절단하면 전담 관리자에게 자동으로 통보되는 방식으로 운영된다.
		
	</div>
	</div>
	<div class="copyright">
	<!-- Copyright -->
		<%@ include file="../common/Copyright.jsp" %>
	</div>
</div>
</body>
</html>