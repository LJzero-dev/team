<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 아이디 또는 비번 찾기
1. 아이디 찾기
	- 이메일 인증
2. 비번 찾기
	- 아이디 확인
	- 이메일 인증
*/
request.setCharacterEncoding("utf-8");

%>
<style>

#box { width:300px; height:200px; margin:30px auto 0; border:1px solid black; text-align:center; font-size:12px; }
</style>
<script>

</script>
<iframe src="" id="find" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
<h2 align="center">아이디 또는 비밀번호 찾기 폼</h2>
<form name="frmfind" action="join_proc.jsp" method="post" onsubmit="return chkVal(this);">

<div style="width:1100px; margin:0 auto;">
	<input type="hidden" name="isDup" value="n" />
	<!-- 중복검사 여부와 사용가능 여부를 저장할 hidden객체 -->
	<table width="1100" cellpadding="5" >
	<tr>
	<th>아이디</th><td>
		<input type="text" name="mi_id" onkeyup="dupID(this.value);" maxlength="20" /><br />
		<span id="imsg">아이디는 4~20자 이내로 입력하세요.</span>
	</td>
	</tr>
	
	<tr><th>비밀번호</th><td><input type="password" id="pw1" maxlength="20" /></td></tr>
	<tr><th>비밀번호 <br />확인</th><td>
		<input type="password" name="mi_pw" id="pw2" onkeyup="comparePW(this.value);" maxlength="20" /><br />
		<span id="pmsg">비밀번호는 4~20자 이내로 입력하세요.</span>
	</td></tr>
	</table>
<iframe src="sendemail.jsp" id="codeok" style="width:1100px; height:100px; margin:0 auto; frameborder:0;" scrolling="no" ></iframe>
<input type="hidden" name= "iscode" value="n" />

	<table width="1100" cellpadding="5" >
		<tr><th>인증번호 입력</th><td>
		<input type="text" id="codein" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" onclick="rightcode();" /></td></tr>
	<tr><th>닉네임</th><td>
		<input type="text" name="mi_nick" onkeyup="dupNICK(this.value);" maxlength="20" /><br />
		<span id="nmsg">닉네임은 2~20자 이내로 입력하세요.</span>
	</td>
	</tr>
	<tr><td colspan="2" id="btm">
		<input type="submit" value="회원가입" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="취소" onclick="history.back();" />
	</td></tr>

	</table>
</form>
</div >
<%@ include file="../_inc/inc_foot.jsp" %>