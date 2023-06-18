<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String writer = request.getParameter("writer");
String rl_table_name = request.getParameter("rl_table_name");
String pw = request.getParameter("pw");
String title = request.getParameter("title");
String content = request.getParameter("content");
String ip = request.getRemoteAddr();
try {
	stmt = conn.createStatement();
	if (isLogin) {
	sql = "update t_member_info set mi_count = mi_count +1 where mi_nick = '" + writer + "' ";
	stmt.executeUpdate(sql);
	writer = loginInfo.getMi_nick();
	}
	rs = stmt.executeQuery("select rl_idx, rl_ctgr from t_request_list where rl_table_name = '" + rl_table_name + "'");
	rs.next();
	String rl_idx = rs.getString(1);
	String rl_ctgr = rs.getString(2);
	sql = "insert into t_" + rl_table_name + "_list (rl_idx, " + rl_table_name + "_ctgr, " + rl_table_name + "_ismem, " + rl_table_name + "_writer, " + rl_table_name +
			"_pw, " + rl_table_name + "_title, " + rl_table_name + "_content, " + rl_table_name + "_ip) values (" +
			rl_idx + ",'" + rl_ctgr + "','" + (isLogin ? "y" : "n") + "','" + writer + "','" + pw + "','" + title + "','" + content + "','" + ip +"')";
	int result = stmt.executeUpdate(sql);
	if (result == 1 ) {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select max(" + rl_table_name + "_idx) from t_" + rl_table_name + "_list");
		rs.next();
		int idx = rs.getInt(1);
		response.sendRedirect("ctgr_view.jsp?cpage=1&idx=" + idx + "&rl_table_name=" + rl_table_name);
	} else {
		out.println("<script>");
		out.println("alert('" + rl_table_name + " 게시판 글 등록에 실패했습니다.\\n다시 시도하세요');");
		out.println("history.back();");
		out.println("</script>");	
		out.close();
	}	
} catch (Exception e) {
	out.println("요청 게시판 등록시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>