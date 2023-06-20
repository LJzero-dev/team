<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>
<%
if (isLogin) {	// 이미 로그인이 되어 있다면
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.'); history.back();");	
	out.println("</script>");
	out.close();
}
request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");
if (url == null)	url = ROOT_URL;
else				url = url.replace('~', '&');
// url의 값이 없어 null상태가 되면 아래의 hidden value에는 문자열 "null"이라는 글자가 입력되어 메인 홈이 아닌 "null"이라는 파일로 이동한다는 의미가 되어 오류가 발생한다.
// 그 오류 방지로 위와 같이 처리한다
%>
<style>

#box { width:300px; height:200px; margin:30px auto 0; border:1px solid black; text-align:center; font-size:12px; }
#login { width:245px; height:25px; }
</style>
<h2 align="center">로그인 폼</h2>
<form name="frmLogin" action="login_proc.jsp" method="post">
<div style="width:1100px; margin:0 auto;">
<div id="box">
	<input type="hidden" name="url" value="<%=url %>" />
	<br /><br />
	&nbsp;아이디  &nbsp;&nbsp;<input type="text" name="mi_id" placeholder="아이디 입력" value="test2" /><br /><br />
	비밀번호  <input type="password" name="mi_pw" placeholder="비밀번호 입력" value="2222" /><br /><br />
	<input type="submit" id="login" value="로그인" /><br /><br />
	<input type="button" value="아이디 또는 비밀번호 찾기" onclick="location.href='member/find_info.jsp';" />
	<input type="button" value="회원가입" onclick="location.href='member/join_form.jsp';" />
</div>
</form>
</div>

<%@ include file="_inc/inc_foot.jsp" %>
