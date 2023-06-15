<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/*회원 탈퇴 처리 
 - mi_status = 'c'(탈퇴회원)으로 변경 후 홈화면으로 이동
*/
request.setCharacterEncoding("utf-8");
String mi_id = request.getParameter("mi_id");

try {
	stmt = conn.createStatement();
	sql = "update t_member_info set mi_status = 'c' where mi_id = '" + loginInfo.getMi_id() + "' ";
//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);
	out.println("<script>");
	if (result == 1) {
		out.println("alert('탈퇴처리 되었습니다.');"); 
		out.println("location.replace('/ktbwos/logout.jsp');");
	} else {
		out.println("alert('회원탈퇴에 실패했습니다.\n다시 시도하세요');"); 
		out.println("history.back();");	
	}
	out.println("</script>");

} catch(Exception e) {
	out.println("회원탈퇴시 문제가 발생했습니다.");
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

