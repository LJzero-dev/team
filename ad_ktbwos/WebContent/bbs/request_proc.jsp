<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String rl_ctgr = request.getParameter("rl_ctgr");
	String rl_title = request.getParameter("rl_title");
	String rl_name = request.getParameter("rl_name");
	String mi_id = request.getParameter("mi_id");
	String rl_write = request.getParameter("rl_write");
	String rl_reply_use = request.getParameter("rl_reply_use");
	String rl_reply_write = request.getParameter("rl_reply_write");
	String rl_table_name = "";

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


try {
	
	stmt = conn.createStatement();
	sql = "insert into t_request_list (rl_ctgr, rl_title, rl_name, mi_nick, rl_write, rl_reply_use, rl_reply_write) values ('a', '홍길동 키우기 게시판 요청합니다', '홍길동 키우기', '홍길동', 'y', 'y', 'y')";
	// System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1 ) {		
		out.println("location.replace('notice_list.jsp');");
	} else {
		out.println("alert('게시판 요청 글 등록에 실패했습니다.\n다시 시도하세요');");
		out.println("history.back();");
	}	
	out.println("</script>");
} catch (Exception e) {
	out.println("공지사항 삭제 시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		stmt.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try {
	conn.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>	
</body>
</html>