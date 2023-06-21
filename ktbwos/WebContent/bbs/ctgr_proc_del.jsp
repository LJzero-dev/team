<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String rl_table_name = request.getParameter("rl_table_name");
int idx = Integer.parseInt(request.getParameter("idx"));
try {
	stmt = conn.createStatement();
	sql = "update t_" + rl_table_name + "_list set " + rl_table_name + "_isview = 'n' where " + rl_table_name + "_idx = " + idx;
	int result = stmt.executeUpdate(sql);
	if (result == 1) {
	rs = stmt.executeQuery("select " + rl_table_name + "_read, " + rl_table_name + "_date from t_" + rl_table_name + "_list where " + rl_table_name + "_idx = " + idx);	rs.next();
	
	stmt.executeUpdate("update t_best_list set bl_count = bl_count - " + rs.getInt(1) + " where bl_table_name = '" + rl_table_name + "' and date(bl_date) = date('" + rs.getString(2) + "')");
		response.sendRedirect("table_list.jsp?rl_table_name=" + rl_table_name);
	} else {
		out.println("<script>");
		out.println("alert('" + rl_table_name + " 게시판 글 삭제에 실패했습니다.\\n다시 시도하세요');");
		out.println("history.back();");
		out.println("</script>");	
		out.close();
		}
	
} catch (Exception e) {
	out.println(rl_table_name + "게시판 글 삭제 시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>