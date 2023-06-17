<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
try {
	stmt = conn.createStatement();
	rs = stmt.executeQuery("select 1 from t_request_list where rl_table_name = '" + request.getParameter("rl_table_name") + "'");
%>
<script>
	var msg = parent.document.getElementById("msg");
	var isDup = parent.frmSch.isDup;
<%	if (rs.next()) { %>
		var tmp = "<span style='color:red; font-weight:bold;'>이미 사용중인 게시판 이름 입니다.</ span>";
		isDup.value = "n";
<%	} else { %>
		var tmp = "<span style='color:blue; font-weight:bold;'>사용할 수 있는 게시판 이름 입니다.</ span>";
		isDup.value = "y";
<%	} %>
	msg.innerHTML = tmp;
</script>
<%	
} catch (Exception e) {
	out.println("테이블 이름 중복 검사 처리시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		rs.close();
		stmt.close();
	} catch (Exception e) {
		e.printStackTrace();	
	}
}	
%>
<%@ include file="../_inc/inc_foot.jsp" %>