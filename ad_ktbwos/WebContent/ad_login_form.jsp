<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
String driver = "com.mysql.cj.jdbc.Driver";
String dbURL = "jdbc:mysql://localhost:3306/ktbwos?useUnicode=true&characterEncoding=UTF8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(dbURL, "root", "1234");
} catch (Exception e) {
	out.println("DB연결에 문제가 발생했습니다.");
	e.printStackTrace();
}

final String ROOT_URL = "/ad_ktbwos/ad_mi_list.jsp"; 
boolean isLogin = false;
AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
if (loginInfo != null) isLogin = true;


String loginUrl = request.getRequestURI();
if (request.getQueryString() != null)
	loginUrl += "?" + URLEncoder.encode(request.getQueryString().replace('&', '~'), "UTF-8");	// 현재 화면의 url로 로그인 폼 등에서 사용할 값
%>
<script>
function isDel(link) {
   if (confirm("정말 삭제하시겠습니까?\n삭제된 내용은 복구 불가합니다.")) {
      location.href = "'" + link + "''";
   }
}
</script>
<style>
	a:link { color:black; text-decoration:none; }
	a:visited { color:black; text-decoration:none; }
	a:hover { color:black; text-decoration:underline; }
	table, th, td {
	border:2px solid black;
	border-collapse : collapse;
	}
	tr { height:30px;}
	th { background-color:#5B9BD5; color:white;}
	td { text-align:center;}
</style>
<title>1석2조</title>
</head>
<body>
<%
if (isLogin) {	// 이미 로그인이 되어 있다면
	response.sendRedirect("/ad_ktbwos/ad_mi_list.jsp");
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
<h2 align="center">관리자 로그인</h2>
<form name="frmLogin" action="ad_login_proc.jsp" method="post">
<div style="width:1100px; margin:0 auto;">
<div id="box">
	<input type="hidden" name="url" value="<%=url %>" />
	<br /><br />
	&nbsp;아이디  &nbsp;&nbsp;<input type="text" name="ai_id" placeholder="아이디 입력" value="test1" /><br /><br />
	비밀번호  <input type="password" name="ai_pw" placeholder="비밀번호 입력" value="1234" /><br /><br />
	<input type="submit" id="login" value="로그인" /><br /><br />
</div>
</form>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>