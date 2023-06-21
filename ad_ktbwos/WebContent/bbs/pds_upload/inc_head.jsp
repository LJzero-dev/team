<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%!	// 공용으로 사용할 메소드 선언 및 정의 영역
public String getRequest(String req) {
	return req.trim().replace("<", "&lt");	
}
%>
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

final String ROOT_URL = "/ktbwos/index.jsp"; 
boolean isLogin = false;
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
if (loginInfo != null) isLogin = true;


String loginUrl = request.getRequestURI();
if (request.getQueryString() != null)
	loginUrl += "?" + URLEncoder.encode(request.getQueryString().replace('&', '~'), "UTF-8");	// 현재 화면의 url로 로그인 폼 등에서 사용할 값
%>
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
<div width="1100" style="margin-left:400px;">
<a href="<%=ROOT_URL %>"><img style="width:200px" src="/ktbwos/img/ktbwos.png"></a>
<% if (isLogin) { %>
<a style="display:inline-block; margin-top:50px; margin-left:700px;  position:fixed;" href="/ktbwos/logout.jsp">로그아웃 </a>
<a style="display:inline-block; margin-top:50px; margin-left:800px;  position:fixed;" href="/ktbwos/member_info.jsp">회원 정보</a>
<% } else { %>
<a style="display:inline-block; margin-top:50px; margin-left:700px;  position:fixed;" href="/ktbwos/login_form.jsp">로그인 </a>
<% } %>
</div>
<br />


<table width="1100" align="center">
	<tr>
		<th><a style="color:white;" href="/ktbwos/bbs/notice_list.jsp">공지사항</a></th>
		<th><a style="color:white;" href="/ktbwos/bbs/free_list.jsp">자유게시판</a></th>
		<th><a style="color:white;" href="/ktbwos/bbs/pds_list.jsp">자료실</a></th>
		<th><a style="color:white;" href="/ktbwos/bbs/request_list.jsp">게시판 요청</a></th>
		<th><a style="color:white;" href="/ktbwos/bbs/ctgr_list.jsp">카테고리 게시판</a></th>
		<th><a style="color:white;" href="/ktbwos/bbs/qna_list.jsp">QnA</a></th>
	</tr>
</table>

<br />