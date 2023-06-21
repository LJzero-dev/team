<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int ql_idx = Integer.parseInt(request.getParameter("ql_idx"));
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage + "&idx=" + ql_idx;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}
String ql_answer = request.getParameter("ql_answer");

try {
	stmt = conn.createStatement();
	sql = "update t_qna_list set ql_adate = now(), ql_isanswer = 'y', ai_idx = 1, ql_answer = '" + ql_answer + "' where ql_idx = " + ql_idx;
	
//	System.out.println(sql);

	int result = stmt.executeUpdate(sql);
	
	out.println("<script>");
	if (result == 1) {
		out.println("location.replace('ad_qna_view.jsp" + args + "');");
	} else {
		out.println("alert('답변 등록에 실패했습니다.\\n다시 시도하세요.');");
		out.println("history.back();");
	}
	out.println("</script>");
	out.close();

} catch(Exception e) {
	out.print("답변 관련 문제가 발생하였습니다");
	e.printStackTrace();
} finally {
	try { stmt.close();} 
	
	catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
