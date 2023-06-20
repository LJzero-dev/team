<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>


<style>

#box { width:800px; height:400px; margin:30px auto 0; border:1px solid black; font-size:15px; text-align:center; }
.alltext {display:inline-block; float:center; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<h2 align="center">닉네임 확인 화면</h2>
<div style="width:1100px; margin:0 auto;">
<div id="box">
	<br /><br />
	&nbsp;이메일  &nbsp;&nbsp;<%=loginInfo.getMi_email() %><br /><br />
	&nbsp;아이디  &nbsp;&nbsp;<%=loginInfo.getMi_id() %><br /><br />
	&nbsp;닉네임  &nbsp;&nbsp;<input type="text" name="mi_nick" value="<%=loginInfo.getMi_nick() %>">
	&nbsp;&nbsp;<input type="submit" value="변경" /><br /><br />
	&nbsp;회원가입일  &nbsp;&nbsp;<%=loginInfo.getMi_date().substring(0, 10) %><br /><br />
	&nbsp;<a href="/ktbwos/member/change_pw.jsp">비밀번호 변경하기</a><br /><br />
	<a href="/ktbwos/index.jsp" class="alltext">홈화면</a>
	<a href="/ktbwos/login_form.jsp" class="alltext">로그인</a>
	
</div>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>
