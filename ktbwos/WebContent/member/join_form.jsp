<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 회원가입 폼
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
request.setCharacterEncoding("utf-8");

%>
<style>

#box { width:300px; height:200px; margin:30px auto 0; border:1px solid black; text-align:center; font-size:12px; }
</style>
<script>
// 현재비밀번호 확인
function chkVal(form) {
	if (form.isDup.value == "n") {
		alert("아이디를 입력해주세요.");
		form.id.focus();
		return false;	// submit 하지마	(return을 하면 함수를 끝냄)
	}
	
	if(form.pw1.value == "") {
		alert("비밀번호를 입력해 주세요.");
		form.pw1.focus();
		return false;
	}
	
	if(form.pw2.value == "") {
		alert("비밀번호 확인를 입력해 주세요.");
		form.pw2.focus();
		return false;
	}
	
	if(form.emailid.value == "" || form.emaildomain.value == "") {
		alert("이메일을 입력해주세요");
		form.emailid.focus();
		return false;
	} 
	
	if(form.codein.value == "") {
		alert("이메일인증을 완료해주세요.");
		form.codein.focus();
		return false;
	}
	
	if(form.nick.value == "") {
		alert("닉네임을 입력해주세요.");
		form.nick.focus();
		return false;
	}

	return true;
	
}



// 아이디 중복검사
function dupID(id) {
	if (id.length > 3) {	// 글자수가 맞을 경우 아이디 중복검사로 보냄
		var dup = document.getElementById("dup");
		dup.src = "dup_id_chk.jsp?mi_id=" + id;
	} else {	// 입력한 아이디가 4글자 미만일 경우
		var imsg = document.getElementById("imsg");
		imsg.innerHTML = "아이디는 4~20자 이내로 입력하세요.";
	}
}

// 비번 검사
function comparePW(pw) {
    if(pw.length > 3) {	// 글자수가 맞을 경우 비밀번호 검사로 보냄
		var dup = document.getElementById("dup");
		dup.src = "pw_chk.jsp?mi_pw=" + pw;
    } else {
    	var pmsg = document.getElementById("pmsg");
    	pmsg.innerHTML = "비밀번호는 4~20자 이내로 입력하세요.";
    }
}

// 닉네임 중복검사
function dupNICK(nick) {
	if (nick.length > 1) {	// 글자수가 맞을 경우 닉네임 중복검사로 보냄
		var dup = document.getElementById("dup");
		dup.src = "dup_nick_chk.jsp?mi_nick=" + nick;
	} else {	// 입력한 닉네임이 2글자 미만일 경우
		var nmsg = document.getElementById("nmsg");
		nmsg.innerHTML = "닉네임은 2~20자 이내로 입력하세요.";
	}
}

//이메일 도메인
function setEmailDomain(domain) {
	document.getElementById("emaildomain").value = domain;
}

// 이메일 수집동의 체크시 이메일 중복검사로 보냄
function dupEMAIL() { 
	var emailid = document.getElementById("emailid").value;
	var emaildomain = document.getElementById("emaildomain").value;
	var email = emailid + "@" + emaildomain
	
	if (emailid == "" || emaildomain == "") {
		document.getElementById("yes").checked = false;
		alert("이메일을 입력해주세요.");
	} else {
		var dup = document.getElementById("dup");
		dup.src = "dup_email_chk.jsp?mi_email=" + email;
	}
}

function codeSending() {
	if (document.getElementById("yes").checked == false){ // 이메일 수집동의를 누르지 않고 인증 코드를 누른 경우 
		if (!confirm("이메일 수집에 동의하시겠습니까?")) {	// 비동의
			document.getElementById("yes").checked = false;
		} else { // 동의했을 경우
			var emailid = document.getElementById("emailid").value;
			var emaildomain = document.getElementById("emaildomain").value;
			if (emailid == "" || emaildomain == "") {
				document.getElementById("yes").checked = false;
				alert("이메일을 입력해주세요.");
			} else {	// 동의 시킨 후 인증코드 발송
				document.getElementById("yes").checked = true;
				location.href="/ktbwos/member/send_code.jsp";
			}
		}
	} else {	// 인증코드 발송
		location.href="/ktbwos/member/send_code.jsp";
	}
}
</script>
<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
<h2 align="center">회원가입 폼</h2>
<form name="frmJoin" action="join_proc.jsp" method="post" onsubmit="return chkVal(this);">
<div style="width:1100px; margin:0 auto;">
	<input type="hidden" name="isDup" value="n" />
	<!-- 중복검사 여부와 사용가능 여부를 저장할 hidden객체 -->
	<table width="1100" cellpadding="5" >
	<tr>
	<th>아이디</th><td>
		<input type="text" name="id" onkeyup="dupID(this.value);" maxlength="20" /><br />
		<span id="imsg">아이디는 4~20자 이내로 입력하세요.</span>
	</td>
	</tr>
	
<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
	<tr><th>비밀번호</th><td><input type="password" id="pw1" maxlength="20" /></td></tr>
	<tr><th>비밀번호 <br />확인</th><td>
		<input type="password" id="pw2" onkeyup="comparePW(this.value);" maxlength="20" /><br />
		<span id="pmsg">비밀번호는 4~20자 이내로 입력하세요.</span>
	</td></tr>


<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
	<tr><th>이메일</th><td>
		<input type="text" id="emailid" value="" title="이메일아이디" placeholder="이메일" maxlength="18" />
		@
		<input type="text" id="emaildomain" id="emaildomain" value="" title="이메일도메인" placeholder="이메일도메인" maxlength="18" />
		<select title="이메일 주소 선택" onclick="setEmailDomain(this.value);">
			<option value="">직접입력</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="nate.com">nate.com</option>
		</select><br />
	</td></tr>
	
	<!-- 이메일 수집 동의 -->
	<tr><th>이메일 수집 동의 및 중복 검사</th><td>
		<input type="checkbox" id="yes" onclick="dupEMAIL();" />입력하신 이메일은 인증 및 보안 코드 전송을 위해 사용됩니다.<br />
		<input type="text" name="codein" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" />
		<input type="button" name="send" value="인증코드 발송" onclick="codeSending();" />
	
	
<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
	<tr><th>닉네임</th><td>
		<input type="text" name="nick" onkeyup="dupNICK(this.value);" maxlength="20" /><br />
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