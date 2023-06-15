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
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");	// 검색 조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage + "&idx=" + idx;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}

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


String where = "where rl_idx = " + idx;
	where += " and rl_writer = '" + loginInfo.getMi_nick() + "' ";
try {
	stmt = conn.createStatement();
	sql = "update t_request_list set rl_ctgr = '" + rl_ctgr + "' , rl_title = '" + rl_title + "' , rl_name = '" + rl_name + "', rl_write = '" + rl_write + "', rl_reply_use = '" + rl_reply_use + "', rl_reply_write = '" + rl_reply_write + "', rl_content = '" + rl_content + "' " + where;
	// System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1 ) {		
		out.println("location.replace('request_view.jsp" + args + "');");
	} else {
		out.println("alert('요청 게시판 수정에 실패했습니다.\\n다시 시도하세요');");
		out.println("history.back();");
	}	
	out.println("</script>");
} catch (Exception e) {
	out.println("요청게시판 수정 시 문제가 발생했습니다.");
	e.printStackTrace();
}finally {
	try {
		stmt.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>