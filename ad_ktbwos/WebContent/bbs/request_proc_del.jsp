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
int idx = Integer.parseInt(request.getParameter("idx"));
String where = "where rl_idx = " + idx;
	where += " and rl_writer = '" + loginInfo.getMi_nick() + "' ";
try {
	stmt = conn.createStatement();
	sql = "delete from t_request_list " + where;
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1 ) {	
		out.println("alert('요청 게시판 삭제에 성공했습니다.');");
		out.println("location.replace('request_list.jsp');");
	} else {
		out.println("alert('요청 게시판 삭제에 실패했습니다.\n다시 시도하세요');");
		out.println("history.back();");
	}	
	out.println("</script>");
} catch (Exception e) {
	out.println("요청게시판 삭제 시 문제가 발생했습니다.");
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