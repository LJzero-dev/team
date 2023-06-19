<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String rl_table_name = request.getParameter("rl_table_name");
String args = "?cpage=" + cpage + "&idx=" + idx+ "&rl_table_name=" + rl_table_name;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}
String content = request.getParameter("content");

try {
	stmt = conn.createStatement();		
	sql = "update t_" + rl_table_name + "_reply set " + rl_table_name + "r_isview = 'n' where " + rl_table_name + "r_idx = " + request.getParameter("idx2") + " and " + rl_table_name + "r_pw = '" + request.getParameter("pw") + "'";
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1) {
		out.println("location.replace('ctgr_view.jsp" + args + "');");
		stmt.executeUpdate("update t_" + rl_table_name + "_list set " + rl_table_name + "_reply = " + rl_table_name + "_reply - 1 where " + rl_table_name + "_idx = " + idx);
	} else {		
		out.println("alert('암호가 틀렸습니다.\\n다시시도하세요');");
		out.println("history.back();");		
	}
	out.println("</script>");
	
} catch (Exception e) {
	out.println("댓글 관련 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		stmt.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>