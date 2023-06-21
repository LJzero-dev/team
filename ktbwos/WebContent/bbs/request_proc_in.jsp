<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
if (!isLogin) {
	out.println("<script>");
	out.println("alert('로그인 후 이용 부탁드립니다.'); history.back();");
	out.println("</script>");	
	out.close();
}
request.setCharacterEncoding("utf-8");
String rl_reply_write = "";
String rl_ctgr = request.getParameter("rl_ctgr");
String rl_title = getRequest(request.getParameter("rl_title"));
String rl_name = request.getParameter("rl_name");
String rl_writer = loginInfo.getMi_nick();
String rl_write = request.getParameter("rl_write");
String rl_reply_use = request.getParameter("rl_reply_use");
String rl_content = getRequest(request.getParameter("rl_content"));
if (rl_reply_use.equals("y"))
	rl_reply_write = request.getParameter("rl_reply_write");
try {
	stmt = conn.createStatement();
	sql = "update t_member_info set mi_count = mi_count +1 where mi_nick = '" + rl_writer + "' ";
	stmt.executeUpdate(sql);
	
	sql = "insert into t_request_list (rl_ctgr, rl_title, rl_name, rl_writer, rl_write, rl_reply_use, rl_reply_write, rl_content) values (?, ?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, rl_ctgr);
	pstmt.setString(2, rl_title);
	pstmt.setString(3, rl_name);
	pstmt.setString(4, loginInfo.getMi_nick());
	pstmt.setString(5, rl_write);
	pstmt.setString(6, rl_reply_use);
	pstmt.setString(7, rl_reply_write);
	pstmt.setString(8, rl_content);
	
	int result = pstmt.executeUpdate();
	if (result == 1 ) {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select max(rl_idx) from t_request_list");
		rs.next();
		int idx = rs.getInt(1);
		response.sendRedirect("request_view.jsp?cpage=1&idx=" + idx);
	} else {
		out.println("<script>");
		out.println("alert('요청 게시판 글 등록에 실패했습니다.\n다시 시도하세요');");
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