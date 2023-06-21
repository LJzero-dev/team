<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%

String userEmail = request.getParameter("userEmail");

String mi_id = "";

try {
	stmt = conn.createStatement();
	
	sql = "select * from t_member_info where mi_status <> 'c' and mi_email = '" + userEmail + "'";
	rs = stmt.executeQuery(sql);
//	System.out.println(sql);
	if (rs.next()) {
		mi_id = rs.getString("mi_id");
	} else {
		out.println("<script>");
		out.println("alert('존재하지 않는 회원입니다. 다시 확인해주세요.');"); 
		out.println("history.back();");	
		out.println("</script>");
		out.close();
	}
	
} catch(Exception e) {
	out.println("회원 아이디 보기시 문제가 발생했습니다.");
	e.printStackTrace();
} 
%>

<style>

#box { width:800px; height:400px; margin:30px auto 0; border:1px solid black; font-size:15px; text-align:center; }
.alltext {display:inline-block; float:center; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<h2 align="center">닉네임 확인 화면</h2>
<div style="width:1100px; margin:0 auto;">
<div id="box">
	<br /><br />
	회원님의 아이디는<br />
	(<%=mi_id%>)<br />
	입니다
	<br /><br />
	<a href="/ktbwos/index.jsp" class="alltext">홈화면</a>
	<a href="/ktbwos/login_form.jsp" class="alltext">로그인</a>
	
</div>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>
