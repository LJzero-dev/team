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
.alltext {display:inline-block; float:left; width:110px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>
<script>
//이메일 도메인
function setEmailDomain(domain) {
	document.getElementById("emaildomain").value = domain;
}

function chkValId(form) {
	if (form.)
}
</script>
<iframe src="" id="find" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
<h2 align="center">아이디 또는 비밀번호 찾기 폼</h2>
<div style="width:1100px; margin:0 auto;">
<form name="frmfindid" action="find_id.jsp" method="post" onsubmit="return chkValId(this);">
	<table width="1100" cellpadding="5" >
		<tr>
		<div class="alltext">아이디 찾기</div>
		<th>이메일</th><td>
			<input type="text" name="emailid" id="emailid" value="" title="이메일아이디" placeholder="이메일" maxlength="18" />
			@
			<input type="text" name="emaildomain" id="emaildomain" value="" title="이메일도메인" placeholder="이메일도메인" maxlength="18" />
			
			<select title="이메일 주소 선택" onclick="setEmailDomain(this.value);">
				<option value="">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="nate.com">nate.com</option>
			</select><br />
		</td></tr> 
		<tr><th>인증번호 입력</th><td>
		<input type="text" id="codein" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" onclick="rightcode();" /><br />
		<input type="submit" value="아이디 찾기" /></td></tr>
	</table>
</form>

<form name="frmfindpw" action="find_pw.jsp" method="post" onsubmit="return chkValPw(this);">
	<table width="1100" cellpadding="5" >
		<tr>
		<div class="alltext">비밀번호 찾기</div>
		<th>아이디</th><td>
			<input type="text" id="mi_id" value="" placeholder="아이디" maxlength="20" />
		</td></tr>
		
		<tr>
		<th>이메일</th><td>
			<input type="text" name="emailid" id="emailid" value="" title="이메일아이디" placeholder="이메일" maxlength="18" />
			@
			<input type="text" name="emaildomain" id="emaildomain" value="" title="이메일도메인" placeholder="이메일도메인" maxlength="18" />
			
			<select title="이메일 주소 선택" onclick="setEmailDomain(this.value);">
				<option value="">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="nate.com">nate.com</option>
			</select><br />
		</td></tr> 
		<tr><th>인증번호 입력</th><td>
		<input type="text" id="codein" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" onclick="rightcode();" /><br />
		<input type="submit" value="비밀번호 찾기" /></td></tr>
	</table>
</form>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>