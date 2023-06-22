<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 비밀번호 변경 폼 
1. 현재 비밀번호를 입력 받음
2. 변경할 비밀번호를 입력 받고 이를 재입력 받음
3. 수정완료 버튼을 눌렀을 때 조건에 합당하면 수정이 완료된 후 홈으로 이동함 /member_change_pw_proc.jsp으로 이동
4. 조건에 합당하지 않을 경우 메시지를 출력함
*/
request.setCharacterEncoding("utf-8");

%>
<style>

#box { width:300px; height:200px; margin:30px auto 0; border:1px solid black; text-align:center; font-size:12px; }
</style>
<script>
// 현재비밀번호 확인
function pwCheck(form) {
	if(form.pw.value == "") {
		alert("현재 비밀번호를 입력해 주세요.");
		form.pw.focus();
		return;
	}
	
	if(form.cpw1.value == "") {
		alert("새로운 비밀번호를 입력해 주세요.");
		form.cpw1.focus();
		return;
	}
	
	if(form.cpw2.value == "") {
		alert("새로운 비밀번호 확인를 입력해 주세요.");
		form.cpw2.focus();
		return;
	}
	
	if(form.cpw1.value != form.cpw2.value) {
		alert("새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		form.cpw1.value = "";
		form.cpw2.value = "";
		form.cpw1.focus();
		return;
	}
	
	form.method="POST";
	form.action="member_change_pw_proc.jsp";
	form.submit();
	alert("비밀번호 변경이 완료되었습니다.");
	
}
</script>
<h2 align="center">비밀번호 변경 폼</h2>
<form name="frmpw">
<div style="width:1100px; margin:0 auto;">
<div id="box">
<br />
	&nbsp;현재 비밀번호&nbsp;&nbsp;<input type="password" name="pw" placeholder="현재비밀번호 입력" value="" maxlength="8" /><br /><br />
	&nbsp;비밀번호 변경&nbsp;&nbsp;<input type="password" name="cpw1" placeholder="비밀번호 입력" value="" maxlength="8" /><br /><br />
	&nbsp;비밀번호 변경 확인&nbsp;&nbsp;<input type="password" name="cpw2" placeholder="비밀번호 확인" value="" maxlength="8" /><br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비밀번호는 4자~20자 이내로 입력해주세요.
	<input type="button" onclick="pwCheck(form);" value="수정완료" />
	<input type="button" value="취소" onclick="history.back();" />
</div>
</form>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>