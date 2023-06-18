<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 아이디 또는 비밀번호 찾기
1. 아이디 찾기
	- 이메일 입력 받음 
	- 이메일로 인증코드 발송하고 제대로된 인증코드를 입력받으면
	- 아이디 확인 화면으로 이동 /find_id.jsp
2. 비밀번호 찾기
	- 아이디와 이메일 입력받음
	- 이메일로 인증코드 발송하고 제대로된 인증코드를 입력받으면
	- 비밀번호 재설정화면으로 이동 /find_pw.jsp
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
function comparePW(pw2) {
    var pw1 = document.getElementById('pw1').value;
	var pmsg = document.getElementById("pmsg");
    
    if(pw2.length < 4) {
    	pmsg.innerHTML = "비밀번호는 4~20자 이내로 입력하세요.";
    	if(pw1 != pw2) {
        	pmsg.innerHTML = "입력하신비번이다릅니다.";
        } else {
        	pmsg.innerHTML = "비번이 확인되었습니다.";
        }
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

</script>
<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
<h2 align="center">아이디 또는 비밀번호 찾기</h2>
<form name="frmJoin" action="join_proc.jsp" method="post" onsubmit="return chkVal(this);">
<div style="width:1100px; margin:0 auto;">
	<input type="hidden" name="isDup" value="n" />
	<!-- 중복검사 여부와 사용가능 여부를 저장할 hidden객체 -->
	<table width="1100" cellpadding="5" >
	<tr>
	<th>아이디찾기</th>
	</tr>
<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
	<tr><th>이메일</th><td>
		<input type="text" name="emailid" value="" title="이메일아이디" placeholder="이메일" maxlength="18" />
		@
		<input type="text" name="emaildomain" id="emaildomain" value="" title="이메일도메인" placeholder="이메일도메인" maxlength="18" />
		<select title="이메일 주소 선택" onclick="setEmailDomain(this.value);" onkeyup="dupEMAIL(this.value);" onchange="dupEMAIL(this.value);">
			<option value="">직접입력</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="nate.com">nate.com</option>
		</select><br />
		<input type="text" name="codein" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" name="send" value="인증코드 발송" onclick="dupEMAIL();" /><br />
		<input type="button" value="아이디 찾기" />
	</td></tr>
	
	
	<tr>
	<th>비밀번호 찾기</th>
	<td>아이디
		<input type="text" name="id" onkeyup="dupID(this.value);" maxlength="20" /><br />
	</td>
	</tr>
	
<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
	<tr><th>이메일</th><td>
		<input type="text" name="emailid" value="" title="이메일아이디" placeholder="이메일" maxlength="18" />
		@
		<input type="text" name="emaildomain" id="emaildomain" value="" title="이메일도메인" placeholder="이메일도메인" maxlength="18" />
		<select title="이메일 주소 선택" onclick="setEmailDomain(this.value);" onkeyup="dupEMAIL(this.value);" onchange="dupEMAIL(this.value);">
			<option value="">직접입력</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="nate.com">nate.com</option>
		</select><br />
		<input type="text" name="codein" value="" title="인증코드 입력" maxlength="20" />
		<input type="button" name="send" value="인증코드 발송" onclick="dupEMAIL();" /><br />
		<input type="button" value="비밀번호 찾기" />
	</td></tr>
	</table>
</form>
</div >
<%@ include file="../_inc/inc_foot.jsp" %>