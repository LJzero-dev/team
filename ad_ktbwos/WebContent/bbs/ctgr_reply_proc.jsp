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
	if (kind.equals("in")) {			// 댓글 등록일 경우
		sql = "update t_" + rl_table_name + "_list set " + rl_table_name + "_reply = " + rl_table_name + "_reply + 1 where " + rl_table_name + "_idx = " + idx;
		stmt.executeUpdate(sql);		// 게시글의 댓글 수 증가 쿼리 실행 
		sql = "insert into t_" + rl_table_name + "_reply (" + rl_table_name + "_idx, " + rl_table_name + "r_ismem, " + rl_table_name + "r_writer, " + rl_table_name + "r_pw, " + rl_table_name + 
				"r_content, " + rl_table_name + "r_ip) values (" + idx + ",'" + (isLogin ? "y" : "n") + "','" + (isLogin ? loginInfo.getMi_nick() : request.getParameter("writer")) + "','" + request.getParameter("pw") +
				"','" + request.getParameter("content") + "', '" + request.getLocalAddr() + "')";
	} else if (kind.equals("del")) {	// 댓글 삭제일 경우
		sql = "update t_" + rl_table_name + "_list set " + rl_table_name + "_reply = " + rl_table_name + "_reply - 1 where " + rl_table_name + "_idx = " + idx; 
		stmt.executeUpdate(sql);		// 게시글의 댓글 수 감소 쿼리 실행
		sql = "update t_" + rl_table_name + "_reply set " + rl_table_name + "r_isview = 'n' where " + rl_table_name + "r_idx = " + request.getParameter(rl_table_name + "r_idx");
	} else {
		out.println("<script>");
		out.println("history.back();");
		out.println("</script>");
	}
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1) {
		out.println("location.replace('ctgr_view.jsp" + args + "');");
	} else {		
		out.println("alert('댓글 관리에 실패했습니다.\\n다시시도하세요');");
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