<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<style>
	#box { width:500px; height:300px; margin:30px auto 0; border:1px solid black; text-align:center; font-size:12px; }
	.alltext {display:inline-block; float:center; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<div id="box">
<h2 align="center"><%=loginInfo.getMi_nick() %>님의</h2> <br /><br />
<img style="width:200px" src="/ktbwos/img/ktbwos.png">
<h2 align="center">회원가입을 축하드립니다.</h2>
<a href="/ktbwos/login_form.jsp" class="alltext">로그인</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="/ktbwos/index.jsp" class="alltext">홈 화면</a>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>