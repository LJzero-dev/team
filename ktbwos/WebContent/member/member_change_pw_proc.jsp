<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 비밀번호 변경 처리
 - 4~20자 확인
 - 조건에 맞지 않을 시 변경 불가 /chage_pw.jsp로 이동
 - 변경 처리 후 홈 화면으로 이동
*/

request.setCharacterEncoding("utf-8");
String pw = request.getParameter("pw");
String cpw1 = request.getParameter("cpw1");

try {
	stmt = conn.createStatement();
	sql = "update t_member_info set mi_pw = '" + cpw1 + "' where mi_id = '" + loginInfo.getMi_id() + "' ";
//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);

	out.println("<script>");
	if (result == 1)
		out.println("location.href='/ktbwos/index.jsp';");
	else {
		out.println("alert('비밀번호 변경에 실패했습니다.\\n다시 시도하세요');"); 
		out.println("location.href='/ktbwos/member/change_pw.jsp';");	
	}
	out.println("</script>");

} catch(Exception e) {
	out.println("비밀번호 변경시 문제가 발생했습니다.");
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
