<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/*
1. 아이디 4~20자 (중복검사)
2. 비밀번호 8~20자 (비밀번호와 비밀번호 확인 값이 동일한지 확인)
3. 이메일 입력 : 이메일 아이디 @ 이메일 도메인선택
	naver, nate, gmail, 직접입력
4. 이메일 중복검사
5. 이메일 수집동의 체크
	- 인증코드 발송 버튼을 누르면 입력한 이메일로 인증코드 메일이 감 
		이메일 수집동의를 체크하지 않고 인증코드 발송을 눌렀을 경우 alert창('이메일 수집동의를 체크해주세요.')+ 커서이동?
	- 인증코드 발송 후, 해당 인증코드를 쿠키에 저장해 두었다가 제한 시간(05:00)내에 옳게 입력할 경우 유효성 검사 통과. 
	- 그렇지 않을 경우 인증번호 재발송 필요 (DB에 인증키(authKey)를 저장하지 않음)
*/
%>
<script>
// 아이디 글자수 검사 메소드
function dupID(id) {
	if (id.length > 3) {	// 글자수가 맞을 경우 아이디 중복검사로 보냄
		var dup = document.getElementById("dup");
		dup.src = "dup_id_chk.jsp?mi_id=" + id;
	} else {	// 입력한 아이디가 4글자 미만일 경우
		var imsg = document.getElementById("imsg");
		imsg.innerHTML = "아이디는 4~20자 이내로 입력하세요.";
	}
}

// 비밀번호 글자수 검사 및 비밀번호 와 비밀번호 확인 값이 같은지 확인
function comparePW(pw) {
	var pw1 = document.getElementById("pw1").value;
	var pmsg = document.getElementById("pmsg");
	if (pw.length > 7) {
		if (pw != pw1) {	// 비밀번호와 비밀번호 확인 값이 다를경우
		pmsg.innerHTML = "입력하신 비밀번호가 다릅니다.";
		} else {
		pmsg.innerHTML = "비밀번호가 확인되었습니다.";
		}
	} else {	// 입력한 비밀번호가 8글자 미만일 경우
		pmsg.innerHTML = "비밀번호는 8~20자 이내로 입력하세요.";
	}
}

// 이메일 도메인
function setEmailDomain(domain){
	document.getElementById("emailDomain").value = domain;
}

// 이메일 중복검사
function dupEMAIL(email) {
	var emailId = emailId.val();
}

// 닉네임 글자수검사 메소드
function dupNICK(nick) {
	if (nick.length > 1) {	// 글자수가 맞을 경우 닉네임 중복검사로 보냄
		var dup = document.getElementById("dup");
		dup.src = "dup_nick_chk.jsp?mi_nick=" + nick;
	} else {	// 입력한 아이디가 4글자 미만일 경우
		var nmsg = document.getElementById("nmsg");
		nmsg.innerHTML = "닉네임은 2~20자 이내로 입력하세요.";
	}
}

// 모든 값들이 정상적으로 입력되었는지 확인하는 메소드
function chkVal(frm) {
	// 아이디
	var isDup = frm.isDup.value;
	if (isDup == "n") {
		alert("아이디를 확인해주세요.");
		frm.mi_id.focus();
		return false;
	}
	// 비번
	var mi_pw = frm.mi_pw.value;
	if (mi_pw == "") {
		alert("비밀번호를 입력하세요.");
		frm.mi_pw.focus();
		return false;
	}
	// 이메일
	
	// 이메일 인증
	
	// 닉네임
	if (isDup == "n") {
		alert("닉네임을 확인해주세요.");
		frm.mi_nick.focus();
		return false;
	}
	
	return true;	// submit 해
}

</script>

<style>
#box { width:800px; height:350px; margin:30px auto 0; border:1px solid black; text-align:center; font-size:15px; }
td { text-align:left; }
#btm { text-align:center; }
</style>
<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
<h2 align="center">회원가입 폼</h2>
<form name="frmJoin" action="join_proc.jsp" method="post" onsubmit="return chkVal(this);">
<div id="box">
	<input type="hidden" name="isDup" value="n" />
	<!-- 중복검사 여부와 사용가능 여부를 저장할 hidden객체 -->
	<table width="800" cellpadding="5" >
	<tr>
	<th width="100">아이디</th><td><br />
		<input type="text" name="mi_id" onkeyup="dupID(this.value);" maxlength="20" /><br />
		<span id="imsg">아이디는 4~20자 이내로 입력하세요.</span>
	</td>
	</tr>
	<tr><th>비밀번호</th><td><input type="password" name="mi_pw" id="pw1" maxlength="20" /></td></tr>
	<tr><th>비밀번호 <br />확인</th><td>
		<input type="password" name="mi_pw" id="pw2" onkeyup="comparePW(this.value);" maxlength="20" /><br />
		<span id="pmsg">비밀번호는 8~20자 이내로 입력하세요.</span>
	</td></tr>
	<tr><th>이메일</th><td>
		<input type="text" id="emailId" value="" title="이메일아이디" placeholder="이메일" maxlength="18" />
		@
		<input type="text" id="emailDomain" value="" title="이메일도메인" placeholder="이메일도메인" maxlenth="18" />
		<select title="이메일 주소 선택" onclick="setEmailDomain(this.value);">
			<option value="">-선택-</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="nate.com">nate.com</option>
		</select>
	</td></tr>
	
	<!-- 이메일 수집 동의 -->
	<tr><th>이메일 수집 동의</th><td>
		<input type="checkbox" />입력하신 이메일은 인증 및 보안 코드 전송을 위해 사용됩니다.<br />
		<input type="text" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" />
		<input type="button" value="인증코드 발송" />
	
	<tr><th>닉네임</th><td>
		<input type="text" name="mi_nick" onkeyup="dupNICK(this.value);" maxlength="20" /><br />
		<span id="nmsg">닉네임은 2~20자 이내로 입력하세요.</span>
	</td>
	</tr>
	<tr><td colspan="2" id="btm">
		<input type="submit" value="회원 가입" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="reset" value="다시 입력" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="취소" onclick="location.href='../index.jsp';" />
	</td></tr>
	</table>
</div>
</form>
<%@ include file="../_inc/inc_foot.jsp" %>
