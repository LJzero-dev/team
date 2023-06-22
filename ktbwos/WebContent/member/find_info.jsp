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

function chkValId(form) {
	if (document.frmfindid.codein.value == "") {
		alert("이메일 확인을 완료해주세요.");
		return false;
	}
	
	return true;
}

function chkValPw(form) {
	if (document.frmfindpw.codein.value == "") {
		alert("이메일 확인을 완료해주세요.");
		return false;
	}
	
	if (document.frmfindpw.mi_id.value == "") {
		alert("아이디를 입력해주세요.");
		return false;
	} else {
		var isuser = document.frmfindpw.isuser;
		isuser.src = "isuser_id.jsp?mi_id=" + mi_id;
	}
	
	if (document.frmfindpw.isUser.value == "n") {
		alert("유효하지 않은 회원 아이디입니다.");
		form.mi_id.focus();
		return false;
	}
	
	return true;
}

function rightcodei() {	// 입력 받은 인증코드가 이메일로 보낸 인증코드와 같은지 확인하는 메소드
	var codein = document.frmfindid.codein.value;
	var ok = sessionStorage.getItem("codeSession");
	if (codein != ok) {
		alert("인증번호를 다시 확인해주세요.");
		codein.value = "";
	} else {
		alert("인증번호가 확인되었습니다.");
		document.getElementById("codein").disabled = true;
	}
}

function rightcodep() {	// 입력 받은 인증코드가 이메일로 보낸 인증코드와 같은지 확인하는 메소드
	var codein = document.frmfindpw.codein.value;
	var ok = sessionStorage.getItem("codeSession");
	if (codein != ok) {
		alert("인증번호를 다시 확인해주세요.");
		codein.value = "";
	} else {
		alert("인증번호가 확인되었습니다.");
		document.frmfindpw.codein.disabled = true;
	}
}

</script>
<h2 align="center">아이디 또는 비밀번호 찾기 폼</h2>
<div style="width:1100px; margin:0 auto;">
<form name="frmfindid" action="find_id.jsp" method="post" onsubmit="return chkValId(this.value);">
	<div class="alltext">아이디 찾기</div>	
	<iframe src="sendemail_findid.jsp" id="codeok" style="width:1100px; height:59px; " marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
		<input type="hidden" name="userEmail" value="user" />
	<table width="1100" cellpadding="5" >
		<tr><th>인증번호 입력</th><td>
		<input type="text" id="codein" value="" title="인증코드 입력" placeholder="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" onclick="rightcodei();" /><br />
		<input type="submit" value="아이디 찾기" /></td></tr>
	</table>
</form>

<form name="frmfindpw" action="find_pw.jsp" method="post" onsubmit="return chkValPw(this.value);">
	<div class="alltext">비밀번호 찾기</div>	
	<iframe src="sendemail_findpw.jsp" id="codeok" style="width:1100px; height:59px; " marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
		<input type="hidden" name="userEmail" value="user" />
	<table width="1100" cellpadding="5" >
		<tr><th>인증번호 입력</th><td>
		<input type="text" id="codein" value="" title="인증코드 입력" placeholder="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" onclick="rightcodep();" /><br />
	<iframe src="" id="isuser" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
			<input type="hidden" name="isUser" value="n" />
		<tr><th>아이디 입력</th><td>
		<input type="text" name="mi_id" id="mi_id" value="" placeholder="아이디" maxlength="20" /><br />
		<input type="submit" value="비밀번호 재설정" /></td></tr>
	</table>
</form>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>