<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");	// 검색 조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage + "&idx=" + idx;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}

String fl_pw = request.getParameter("fl_pw");
String fl_ismem = request.getParameter("fl_ismem");
String fl_title = getRequest(request.getParameter("fl_title"));
String fl_content = getRequest(request.getParameter("fl_content"));

String where = "where fl_idx = " + idx;
if (fl_ismem.equals("n"))	// 비회원글 수정일 경우
	where += " and fl_pw = '" + fl_pw + "' ";
else 						// 회원글 수정 일 경우
	where += " and fl_writer = '" + loginInfo.getMi_id() + "' ";
try {
	stmt = conn.createStatement();
	sql = "update t_free_list set fl_title = '" + fl_title + "', fl_content = '" + fl_content + "' " + where;
	// System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1 ) {		
		out.println("location.replace('free_view.jsp" + args + "');");
	} else {
		out.println("alert('공지 글 수정에 실패했습니다.\\n다시 시도하세요');");
		out.println("history.back();");
	}	
	out.println("</script>");
} catch (Exception e) {
	out.println("공지사항 수정 시 문제가 발생했습니다.");
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