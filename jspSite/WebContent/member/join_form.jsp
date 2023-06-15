<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../_inc/inc_head.jsp" %>
<%
	
%>
<script>
function dupID(id) {
	if (id.length > 3) {
		var msg = document.getElementById("msg");
		var dup = document.getElementById("dup");
		dup.src = "dup_id_chk.jsp?mi_id=" + id;
	} else {	// 입력한 아이디가 4글자 미만일 경우
		var msg = document.getElementById("msg");
		msg.innerHTML = "아이디는 4~20자 이내로 입력하세요.";
	}
}
function chkVal(frm) {
	var isDup = frm.isDup.value;
	if (isDup == "n") {
		alert("아이디 중복확인을 하세요.");
		frm.mi_id.focus();
		return false;
	}
	var mi_pw = frm.mi_pw1.value;
	if (mi_pw == "") {
		alert("비밀번호를 입력하세요.");
		frm.mi_pw1.focus();
		return false;
	}
	return true;
}
</script>
<iframe src="" id="dup" style="width:500px; height:200px; border:1px black solid; display:block;"></iframe>
<form name="frmJoin" action="join_proc.jsp" method="post" onsubmit="return chkVal(this);">
	<input type="hidden" name="isDup" value="n" />	<!-- 중복검사 여부와 사용가능 여부를 저장할 hidden -->
	<table width="600" cellpadding="5">
		<tr>
			<th width="100">아이디</th>
			<td width="*"><input type="text" name="mi_id" onkeyup="dupID(this.value);" maxlength="20" /><br />
			<span id="msg">아이디는 4~20자 이내로 입력하세요.</span>
			</td>
		</tr>	
		<tr><th>비밀번호</th><td><input type="password" name="mi_pw1" /></td></tr>
		<tr><th>비밀번호 확인</th><td><input type="password" name="mi_pw2" onkeyup="chkPw();" /><br />
			<span id="msg2"></span></td></tr>
		<tr><th>이름</th><td><input type="text" name="mi_name" /></td></tr>
		<tr><td colspan="2">
			<input type="submit" value="회원 가입" />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" value="다시 입력" />
		</td></tr>	
	</table>
</form>
<%@ include file="../_inc/inc_foot.jsp" %>













