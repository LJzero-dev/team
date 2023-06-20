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
	if (form.codein.value == "") {
		alert("이메일 확인을 완료해주세요.");
		form.codein.focus();
		return false;
	}
	
	return true;
}

function userEMAIL() { 
	
	var emailid = document.getElementById("emailid").value;
	var emaildomain = document.getElementById("emaildomain").value;
	var mi_email = emailid + "@" + emaildomain;
	
	if (emailid == "" || emaildomain == "") {
		document.getElementById("yes").checked = false;
		alert("이메일을 입력해주세요.");
	} else {
		var dup = document.getElementById("dup");
		dup.src = "user_email_chk.jsp?mi_email=" + mi_email;
	}
}

function codeSending() {
	userEMAIL();
	if (document.getElementById("yes").checked == false){ // 이메일 수집동의를 누르지 않고 인증 코드를 누른 경우 
		if (!confirm("이메일 수집에 동의하시겠습니까?")) {	// 비동의
			document.getElementById("yes").checked = false;
		} else { // 동의했을 경우
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
<iframe src="" id="find" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
<h2 align="center">아이디 또는 비밀번호 찾기 폼</h2>
<div style="width:1100px; margin:0 auto;">
<form name="frmfindid" action="find_id.jsp" method="post" onsubmit="return chkValId(this);">
	<input type="hidden" name="isUser" value="n" />
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
			<input type="submit" name="send" value="인증코드 발송" onclick="codeSending();" />
		</td></tr> 
		<tr><th>인증번호 입력</th><td>
		<input type="text" id="codein" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" onclick="rightcode();" /><br />
		<input type="submit" value="아이디 찾기" /></td></tr>
	</table>
</form>

<form name="frmfindpw" action="find_pw.jsp" method="post" onsubmit="return chkValPw(this);">
	<input type="hidden" name="isUser" value="n" />
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
			<input type="submit" name="send" value="인증코드 발송" onclick="codeSending();" />
		</td></tr> 
		<tr><th>인증번호 입력</th><td>
		<input type="text" id="codein" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" value="확인" onclick="rightcode();" /><br />
		<input type="submit" value="비밀번호 찾기" /></td></tr>
	</table>
</form>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>