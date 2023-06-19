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

final String ROOT_URL = "/ad_ktbwos/mi_list.jsp"; 
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
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.'); history.back();");	
	out.println("</script>");
	out.close();
}
request.setCharacterEncoding("utf-8");
String ai_id = request.getParameter("ai_id").toLowerCase();
String ai_pw = request.getParameter("ai_pw");
String url = request.getParameter("url");

if (ai_id == null || ai_id.equals("") || ai_pw == null || ai_pw.equals("")) {
	out.println("<script>");
	out.println("alert('아이디와 비밀번호를 입력하세요.'); history.back();");
	out.println("</script>");
	out.close();
}

try {
	stmt = conn.createStatement();
	sql = "select * from t_admin_info where ai_use = 'y' and ai_id = '" + ai_id + "' and ai_pw = '" + ai_pw + "'";
//	System.out.println(sql);
	rs = stmt.executeQuery(sql);
	
	if (rs.next()) {	// 로그인 성공시
		AdminInfo ai = new AdminInfo();
		// 로그인한 회원의 정보들을 저장할 인스턴스 생성
		ai.setAi_id(ai_id);
		ai.setAi_pw(ai_pw);
		ai.setAi_name(rs.getString("ai_name"));
		ai.setAi_use(rs.getString("ai_use"));
		ai.setAi_date(rs.getString("ai_date"));
		ai.setAi_idx(rs.getInt("ai_idx"));
		
		// 세션에 저장
		session.setAttribute("loginInfo", ai);
		// 로그인한 회원 정보를 담은 MemberInfo형 인스턴스 mi를
		// 세션에 "loginInfo"라는 이름의 속성으로 저장
		
		response.sendRedirect(url);
		
	} else {	// 로그인 실패시
		out.println("<script>");
		out.println("alert('아이디와 비밀번호를 확인 후 다시 로그인하세요.'); history.back();");		// history.back() : 이전으로 돌아가는 것이기 때문에 따로 이동할 url을 달고 오지 않아도 됨
		out.println("</script>");
		out.close();
	}
	
} catch(Exception e) {
	out.println("로그인 처리시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		rs.close();		stmt.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="_inc/inc_foot.jsp" %>
