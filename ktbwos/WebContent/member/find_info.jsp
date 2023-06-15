<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>
<%
/* 아이디 또는 비밀번호 찾기
1. 아이디 찾기
	- 이메일 입력 받음 
	- 이메일로 인증코드 발송하고 제대로된 인증코드를 입력받으면
	- 아이디 확인 화면으로 이동 /find_id.jsp
2. 비밀번호 찾기
	- 아이디와 이메일 입력받음
	- 이메일로 인증코드 발송하고 제대로된 인증코드를 입력받으면
	- 비밀번호 재설정화면으로 이동 /find_pw.jsp
*/
%>
<%@ include file="_inc/inc_foot.jsp" %>