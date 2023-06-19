<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 사용자 이메일로 인증코드 보내기
1. 입력받은 사용자 이메일 값 불러옴
2. 운영자 메일주소 설정
3. 사용자 이메일로 인증코드 발송
	- 제목 : "일석이조 사이트 회원가입 이메일 인증 코드입니다."
	- 내용 : "아래의 인증코드를 인증코드 확인란에 입력해주세요."
	- 난수로 인증 코드 생성해서 보내고 그 난수값을 세션에 저장하기
*/
request.setCharacterEncoding("utf-8");
%>
<script>
	var useremail = parent.document.getElementById("email");
	
	
</script>

<%@ include file="../_inc/inc_foot.jsp" %>
