<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int fl_idx = Integer.parseInt(request.getParameter("fl_idx"));
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage + "&idx=" + fl_idx;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}

int fr_idx = 0;
String fr_content = request.getParameter("fr_content");
String fr_writer = request.getParameter("fr_writer");
String fr_ismem = "n";
String fr_pw = request.getParameter("fr_pw");
String fl_ip = request.getRemoteAddr();
if (!kind.equals("in")) {	// 댓글 등록이 아닐 경우
	fr_idx = Integer.parseInt(request.getParameter("fr_idx"));
}


if (isLogin) {
	fr_ismem = "y";
	fr_writer = loginInfo.getMi_nick();
} else {
	fr_writer = getRequest(fr_writer);
	fr_pw = getRequest(fr_pw);
}

try {
	stmt = conn.createStatement();
	if (kind.equals("in")) {	// 댓글 등록일 경우
		sql = "update t_free_list set fl_reply = fl_reply + 1 where fl_idx = " + fl_idx;
		stmt.executeUpdate(sql);	// 게시글의 댓글 수 증가 쿼리 실행
		
		sql = "insert into t_free_reply (fl_idx, fr_ismem, fr_writer, fr_pw, fr_content, fr_ip) values" + "(" + fl_idx + ", '" + fr_ismem + "', '" + fr_writer + "', '" + fr_pw + "', '" + fr_content + "', '" + fl_ip + "')" ;
		
		System.out.println(sql);
	} else if (kind.equals("del")) {	// 댓글 삭제일 경우 
		sql = "update t_free_list set fl_reply = fl_reply - 1 where fl_idx = " + fl_idx;
		stmt.executeUpdate(sql);	// 게시글의 댓글 수 감소 쿼리 실행

		sql = "update t_free_reply set fr_isview = 'n' where fr_writer = '" + fr_writer  + "' and fr_idx = " + fr_idx; 
		
		System.out.println(sql);
	}
	int result = stmt.executeUpdate(sql);
	
	out.println("<script>");
	if (result == 1) {
		out.println("location.replace('free_view.jsp" + args + "');");
	} else {
		out.println("alert('댓글 등록에 실패했습니다.\\n다시 시도하세요.');");
		out.println("history.back();");
	}
	out.println("</script>");
	out.close();

} catch(Exception e) {
	out.print("댓글 관련 문제가 발생하였습니다");
	e.printStackTrace();
} finally {
	try { stmt.close();} 
	
	catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
