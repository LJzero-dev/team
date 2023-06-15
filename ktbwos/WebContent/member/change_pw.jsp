<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
%>
<style>

#box { width:300px; height:200px; margin:30px auto 0; border:1px solid black; text-align:center; font-size:12px; }
</style>
<h2 align="center">비밀번호 변경 폼</h2>
<form name="frmpw" action="member_change_pw_proc.jsp" method="post">
<div style="width:1100px; margin:0 auto;">
<div id="box">
	&nbsp;현재 비밀번호&nbsp;&nbsp;<input type="text" name="mi_pw" placeholder="현재비밀번호 입력" value="" /><br /><br />
	&nbsp;현재 비밀번호&nbsp;&nbsp;<input type="text" name="mi_pw" placeholder="현재비밀번호 입력" value="" /><br /><br />
	&nbsp;현재 비밀번호&nbsp;&nbsp;<input type="text" name="mi_pw" placeholder="현재비밀번호 입력" value="" /><br /><br />
	비밀번호  <input type="password" name="mi_pw" placeholder="비밀번호 입력" value="2222" /><br /><br />
	<input type="submit" id="login" value="로그인" /><br /><br />
	<input type="button" value="아이디 또는 비밀번호 찾기" onclick="location.href='find_info.jsp';" />
	<input type="button" value="회원가입" onclick="location.href='member/join_form.jsp';" />
</div>
</form>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>