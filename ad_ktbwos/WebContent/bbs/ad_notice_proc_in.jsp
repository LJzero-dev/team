<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
if (!isLogin) {	// 로그인이 되어 있지 않다면
	out.println("<script>");
	out.println("alert('로그인 후 다시 시도해주세요.');"); 
	out.println("location.href='../login_form.jsp;");
	out.println("</script>");
	out.close();
}

request.setCharacterEncoding("utf-8");

String nl_title = getRequest(request.getParameter("nl_title"));
String nl_content = getRequest(request.getParameter("nl_content"));
try {
	stmt = conn.createStatement();
	int idx = 1;
	sql = "select max(nl_idx) from t_notice_list";
	rs = stmt.executeQuery(sql);
	if (rs.next()) idx = rs.getInt(1) +1;
	
	sql = "insert into t_notice_list (ai_idx ,nl_title, nl_content) values (1,'" + nl_title + "','" + nl_content + "')";
	int result = stmt.executeUpdate(sql);
	if (result == 1) {
		response.sendRedirect("ad_notice_view.jsp?cpage=1&idx=" + idx);
	}else {
		out.println("<script>");
		out.println("alert('공지 글 등록에 실패했습니다.\n다시 시도하세요.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}
	
} catch(Exception e) {
	out.println("공지사항 등록시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		rs.close();	stmt.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>