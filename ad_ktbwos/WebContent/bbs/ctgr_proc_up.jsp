<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String rl_table_name = request.getParameter("rl_table_name");
String writer = request.getParameter("writer");
String title = request.getParameter("title");
String content = request.getParameter("content");
int idx = Integer.parseInt(request.getParameter("idx"));
try {
	stmt = conn.createStatement();
	sql = "update t_" + rl_table_name + "_list set " + rl_table_name + "_title = '" + title + "', " + rl_table_name + "_content = '" + content + "' where " + rl_table_name + "_idx = " + idx;
	int result = stmt.executeUpdate(sql);
	if (result == 1) {
		response.sendRedirect("ctgr_view.jsp?cpage=" + request.getParameter("cpage") + "&idx=" + idx + "&rl_table_name=" + rl_table_name);
	} else {
		out.println("<script>");
		out.println("alert('" + rl_table_name + " 게시판 글 수정에 실패했습니다.\\n다시 시도하세요');");
		out.println("history.back();");
		out.println("</script>");	
		out.close();
		}
	
} catch (Exception e) {
	out.println(rl_table_name + "게시판 글 수정 시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>