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

try {
	stmt = conn.createStatement();
	sql = "update t_request_list set rl_status = 'n', rl_name = '" + idx + request.getParameter("rl_name") + idx + "', rl_reason = '" + request.getParameter("rl_reason") + "' where rl_idx = " + idx;
	int result = stmt.executeUpdate(sql);
	if (result == 1 ) {
		out.println("<script>");
		out.println("location.replace('request_view.jsp" + args + "');");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('게시판 제작에 실패했습니다.\n다시 시도하세요');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}
} catch (Exception e) {
	out.println("요청 게시판 제작시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>