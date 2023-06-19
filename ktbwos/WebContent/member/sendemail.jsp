<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>

<script>
//이메일 도메인
function setEmailDomain(domain) {
	document.getElementById("emaildomain").value = domain;
}

//이메일 수집동의 체크시 이메일 중복검사로 보냄
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
				send();
			}
		}
	} else {
		send();
	}
}

function send() {
	var iscode = parent.frmJoin.iscode;
	const code = Math.floor(Math.random() * 89999) + 10000;
	frmmail.content.value = code;
	sessionStorage.setItem("codeSession", code);
}


</script>
<form id="frmmail" action="mailSend" method="post">	<!-- mailSend는 서블릿 -->
<table>
<tr><th>이메일</th><td>
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
	
	<!-- 이메일 수집 동의 -->
	<tr><th>이메일 수집 동의 및 중복 검사</th><td>
		<input type="checkbox" id="yes" onclick="dupEMAIL();" />입력하신 이메일은 인증 및 보안 코드 전송을 위해 사용됩니다.<br />
		<input type="hidden" name="sender" value="solmi2012@naver.com" />
		<input type="hidden" name="receiver" value="" />
		<input type="hidden" name="title" value="일석이조 사이트 회원가입 이메일 인증 코드입니다. 아래의 인증코드를 인증코드 확인란에 입력해주세요." />
		<input type="hidden" name="content" value="" />
		<input type="submit" name="send" value="인증코드 발송" onclick="codeSending();" />
</table>
</form>

<%@ include file="../_inc/inc_foot.jsp" %>