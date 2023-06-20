<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String mi_id = request.getParameter("mi_id");

try {
	sql = "select 1 from t_member_info where mi_id = '" + mi_id + "'";
//	System.out.println(sql);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
%>
<script>
	var isUser = parent.frmfindpw.isUser;
<%	if (rs.next()){	%>
	isUser.value = "y";
<%	} else {	%>
	alert("유효하지 않은 회원아이디입니다.");
	isUser.value = "n";
<%	}	%>

</script>
<% } catch(Exception e) {
	out.println("아이디 유저여부 검사에서 문제가 생겼습니다.");
	e.printStackTrace();
} finally {
	try { rs.close(); stmt.close(); }
	catch(Exception e) { e.printStackTrace(); }
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
