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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	a:link { color:black; text-decoration:none; }
	a:visited { color:black; text-decoration:none; }
	a:hover { color:black; text-decoration:underline; }
	table, th, td {
	border:2px solid black;
	border-collapse : collapse;
	}
	tr { height:30px;}
	th { background-color:#ffffff; color:black;}
	td { text-align:center;}
</style>
<title>일석2조</title>
</head>
<body>
<div style="width:1100px; margin:0 auto;">
<a style="display:inline-block; margin-top:50px; margin-left:700px;  position:fixed;" href="/ad_ktbwos/bbs/request_list.jsp">승인 대기중인 게시판 : <% rs = conn.createStatement().executeQuery("select count(*) from t_request_list where rl_status = 'a'"); rs.next(); out.print(rs.getInt(1)); %></a>
<a style="display:inline-block; margin-top:50px; margin-left:500px;  position:fixed;" href="/ad_ktbwos/bbs/ad_qna_list.jsp">답변 대기중인 QnA : <% rs = conn.createStatement().executeQuery("select count(*) from t_qna_list where ql_isanswer = 'n' and ql_isview = 'y'"); rs.next(); out.print(rs.getInt(1)); %></a>
<a href="<%=ROOT_URL %>"><img style="width:200px" src="/ad_ktbwos/img/ktbwos.png"></a>
<% if (isLogin) { %>
<a style="display:inline-block; margin-top:50px; margin-left:700px;  position:fixed;" href="/ad_ktbwos/ad_logout.jsp">로그아웃 </a>
<% } else { response.sendRedirect("/ad_ktbwos/ad_login_form.jsp"); } %>
</div>
<br />


<table width="1100" align="center">
	<tr>
      <th><a href="/ad_ktbwos/bbs/ad_notice_list.jsp">공지사항 관리</a></th>
      <th><a href="/ad_ktbwos/bbs/ad_free_list.jsp">자유게시판 관리</a></th>
      <th><a href="/ad_ktbwos/bbs/ad_pds_list.jsp">자료실 관리</a></th>
      <th><a href="/ad_ktbwos/bbs/request_list.jsp">게시판 요청 관리</a></th>
      <th><a href="/ad_ktbwos/bbs/ctgr_list.jsp">카테고리 게시판 관리</a></th>
      <th><a href="/ad_ktbwos/bbs/ad_qna_list.jsp">QnA 관리</a></th>
      <th><a href="/ad_ktbwos/ad_mi_list.jsp">회원 관리</a></th>
	</tr>
</table>

<br />