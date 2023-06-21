<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int fl_idx = Integer.parseInt(request.getParameter("fl_idx"));
int fr_idx = Integer.parseInt(request.getParameter("fr_idx"));
String schtype = request.getParameter("schtype"); // 검색조건
String keyword = request.getParameter("keyword"); // 검색어
String args = "?cpage=" + cpage + "&idx=" + fl_idx;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
    args += "&schtype=" + schtype + "&keyword=" + keyword;
}

String fr_content = request.getParameter("fr_content");
String fr_writer = request.getParameter("fr_writer");

try {
	stmt = conn.createStatement();
    sql = "update t_free_reply set fr_content = '관리자가 삭제한 댓글입니다.' where fr_idx = " + fr_idx;
    
    System.out.println(sql);

    int result = stmt.executeUpdate(sql);

    if (result == 1) {
        response.sendRedirect("ad_free_view.jsp" + args);
    } else {
        out.println("<script>");
        out.println("alert('댓글 삭제에 실패했습니다.\\n다시 시도하세요.');");
        out.println("history.back();");
        out.println("</script>");
    }
} catch(Exception e) {
    out.println("댓글 관련 문제가 발생하였습니다");
    e.printStackTrace();
} finally {
    try {
        if (stmt != null) {
            stmt.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>