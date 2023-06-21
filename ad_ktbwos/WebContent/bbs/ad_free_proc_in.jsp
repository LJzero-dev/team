<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String pl_title = getRequest(request.getParameter("pl_title"));
String pl_content = getRequest(request.getParameter("pl_title"));
String pl_ip = request.getRemoteAddr();


try {
	stmt = conn.createStatement();
	int idx = 1;
	sql = "select max(fl_idx) + 1 from t_free_list";
	rs = stmt.executeQuery(sql);
	if (rs.next())	idx = rs.getInt(1);
	
	sql = "insert into t_free_list (ai_idx, pl_title, pl_content, pl_data1, pl_data2) values (?, ?, ?, ?, ?)";
	
	System.out.println(sql);
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, idx);
	pstmt.setString(2, pl_title);
	pstmt.setString(3, pl_content);

	int result = pstmt.executeUpdate();
	
	if (result == 1) {
		response.sendRedirect("ad_free_view.jsp?cpage=1&idx=" + idx);
	} else {
		out.println("<script>");
		out.println("alert('게시글  등록에 실패했습니다.\\n다시 시도하세요.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}
	
} catch (Exception e) {
	out.println("게시글 등록시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		rs.close();		stmt.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}



%>
<%@ include file="../_inc/inc_foot.jsp" %>