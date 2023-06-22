<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 회원정보 확인
1. 이메일 / 아이디 보여줌 (변경 불가)
2. 닉네임 (바로 수정 가능)(중복검사, 2~20자)
3. 회원 가입일
4. 비밀번호 변경 
 - 비밀번호 변경 폼으로 이동 /change_pw.jsp
5. 수정완료
 - 닉네임 변경 처리 /member_nick_proc.jsp
 - 홈으로 이동
6. 회원탈퇴 
 - confirm창('정말로 탈퇴하시겠습니까?')
 - 확인 누르면 /member_proc_del.jsp 으로 이동
*/
%>
<script>
function memDel() {
	if (confirm('정말 탈퇴하시겠습니까?')) {
		location.href = "/ktbwos/member/member_proc_del.jsp";
	}
}
</script>
<style>

#box { width:800px; height:400px; margin:30px auto 0; border:1px solid black; font-size:15px; text-align:center; }
.alltext {display:inline-block; float:center; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<h2 align="center">회원 정보 보기 화면</h2>
<div style="width:1100px; margin:0 auto;">
<div id="box">
	<br /><br />
	<form name="frmInfo" action="member_nick_proc.jsp" method="post">
	&nbsp;이메일  &nbsp;&nbsp;<%=loginInfo.getMi_email() %><br /><br />
	&nbsp;아이디  &nbsp;&nbsp;<%=loginInfo.getMi_id() %><br /><br />
	&nbsp;닉네임  &nbsp;&nbsp;<input type="text" name="mi_nick" value="<%=loginInfo.getMi_nick() %>">
	&nbsp;&nbsp;<input type="submit" value="변경" /><br /><br />
	<%-- &nbsp;회원가입일  &nbsp;&nbsp;<%=loginInfo.getMi_date().substring(0, 10) %><br /><br /> --%>
	&nbsp;<a href="/ktbwos/member/change_pw.jsp">비밀번호 변경하기</a><br /><br />
	<a href="/ktbwos/index.jsp" class="alltext">확인</a>
	<input type="button"  style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" value="회원탈퇴" onclick="memDel();"  />
	</form>
	
</div>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>
