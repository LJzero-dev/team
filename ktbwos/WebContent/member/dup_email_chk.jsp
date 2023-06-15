<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/*
1. 사용자가 입력한 이메일을 받아옴
2. 받아온 이메일과 동일한 이메일가 회원 테이블에 있는지 여부를 검사하기 위해 쿼리 생성 후 실행
3. 중복여부를 현 파일을 포함하고 있는 join_form.jsp로 표시해줌
*/
request.setCharacterEncoding("utf-8");
String email = request.getParameter("email");

try {
	sql = "select 1 from t_member_info where mi_email = '" + email + "'";
	System.out.println(sql);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
%>
<script>
	
	var emsg = parent.document.getElementById("emsg");
	var isDup = parent.frmJoin.isDup;
<%	if (rs.next()){	%>
	var tmp = "<span style='color:red; font-weight:bold;'>" + "이미 사용중인 이메일 입니다.</span>";
	isDup.value = "n";
<%	} else {	%>
	var tmp = "<span style='color:blue; font-weight:bold;'>" + "사용할 수 있는 이메일 입니다.</span>";
	isDup.value = "y";
<%	}	%>
	emsg.innerHTML = tmp;
</script>
<% } catch(Exception e) {
	out.println("아이디 중복 검사에서 문제가 생겼습니다.");
	e.printStackTrace();
} finally {
	try { rs.close(); stmt.close(); }
	catch(Exception e) { e.printStackTrace(); }
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>
