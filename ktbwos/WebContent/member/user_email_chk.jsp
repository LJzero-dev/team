<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/*
1. 사용자가 입력한 아이디를 받아옴
2. 받아온 아이디와 동일한 아이디가 회원 테이블에 있는지 여부를 검사하기 위해 쿼리 생성 후 실행
3. 중복여부를 현 파일을 포함하고 있는 join_form.jsp로 표시해줌
*/
request.setCharacterEncoding("utf-8");
String mi_email = request.getParameter("mi_email");

try {
	sql = "select 1 from t_member_info where mi_email = '" + mi_email + "'";
//	System.out.println(sql);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
%>
<script>
	var isUser = parent.frmfindid.isUser;
<%	if (rs.next()){	%>
	isUser.value = "y";
<%	} else {	%>
	alert("유효하지 않은 회원이메일입니다.");
	isUser.value = "n";
<%	}	%>

</script>
<% } catch(Exception e) {
	out.println("이메일 유저여부 검사에서 문제가 생겼습니다.");
	e.printStackTrace();
} finally {
	try { rs.close(); stmt.close(); }
	catch(Exception e) { e.printStackTrace(); }
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
