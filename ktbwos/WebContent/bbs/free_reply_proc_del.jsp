<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int fr_idx = Integer.parseInt(request.getParameter("fr_idx"));
int fl_idx = Integer.parseInt(request.getParameter("fl_idx"));

String fr_pw = request.getParameter("fr_pw");
String fr_ismem = request.getParameter("fr_ismem");
String fr_writer = request.getParameter("fr_writer");

String where = " where fr_idx = " + fr_idx;

if (fr_ismem != null && fr_ismem.equals("n")) {	// 비회원 댓글 삭제일 경우
	where += " and fr_pw = '" + fr_pw + "' ";
} else {	// 회원 댓글 삭제일 경우 
	where += " and fr_writer = '" + fr_writer + "' ";
}

try {
	stmt = conn.createStatement();
	
	
	System.out.println(sql);
	
	sql = "update t_free_reply set fr_isview = 'n' " + where;
	System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1) {
		sql = "update t_free_list set fl_reply = fl_reply - 1 where fl_idx = " + fl_idx;
		stmt.executeUpdate(sql);	// 게시글의 댓글 수 감소 쿼리 실행
		out.println("alert('댓글이 삭제되었습니다.');");
		out.println("window.history.go(-2);");
	} else {
		out.println("alert('댓글 삭제에 실패했습니다.\\n다시 시도하세요.');");
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