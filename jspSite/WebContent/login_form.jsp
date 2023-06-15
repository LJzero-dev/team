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
%>
<h2>로그인 폼</h2>
<form name="frmLogin" action="login_proc.jsp" method="post">
<input type="hidden" name="url" value="<%=url %>" />
아이디 : <input tyep="text" name="mi_id" placeholder="아이디 입력" value="test1" /><br />
비밀번호 : <input type="password" name="mi_pw" placeholder="비밀번호 입력" value="1234" /><br />
<input type="submit" value="로그인" />
</form>

<%@ include file="_inc/inc_foot.jsp" %>