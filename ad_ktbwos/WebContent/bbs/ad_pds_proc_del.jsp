<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("idx"));

String where = " where pl_idx = " + idx;

try {
	stmt = conn.createStatement();
	sql = "update t_pds_list set pl_isview = 'n' " + where;
	System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1) {
		out.println("location.replace('ad_pds_list.jsp');");
	} else {
		out.println("alert('게시글 삭제에 실패했습니다.\\n다시 시도하세요.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
} catch(Exception e) {
	out.println("게시글 삭제시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		stmt.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
