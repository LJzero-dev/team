<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%

String userEmail = request.getParameter("userEmail");
String mi_id = request.getParameter("mi_id");


try {
	stmt = conn.createStatement();
	
	sql = "select * from t_member_info where mi_status <> 'c' and mi_email = '" + userEmail + "' and mi_id = '" + mi_id + "'";
	rs = stmt.executeQuery(sql);
//	System.out.println(sql);
	if (rs.next()) {
		mi_id = rs.getString("mi_id");
	} else {
		out.println("<script>");
		out.println("alert('존재하지 않는 회원입니다.');"); 
		out.println("history.back();");	
		out.println("</script>");
		out.close();
	}
	
} catch(Exception e) {
	out.println("회원 아이디 보기시 문제가 발생했습니다.");
	e.printStackTrace();
} 
%>
<script>
function pwCheck(form) {
	
	if(form.cpw1.value == "") {
		alert("새로운 비밀번호를 입력해 주세요.");
		form.cpw1.focus();
		return;
	}
	
	if(form.cpw2.value == "") {
		alert("새로운 비밀번호 확인를 입력해 주세요.");
		form.cpw2.focus();
		return;
	}
	
	if(form.cpw1.value != form.cpw2.value) {
		alert("새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		form.cpw1.value = "";
		form.cpw2.value = "";
		form.cpw1.focus();
		return;
	}
	
	form.method="POST";
	form.action="find_change_pw_proc.jsp";
	form.submit();
	alert("비밀번호 재설정이 완료되었습니다.");
	
}
</script>
<style>

#box { width:800px; height:400px; margin:30px auto 0; border:1px solid black; font-size:15px; text-align:center; }
.alltext {display:inline-block; float:center; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<h2 align="center">비밀번호 재설정 화면</h2>
<div style="width:1100px; margin:0 auto;">
<div id="box">
	<br /><br />
	(<%=mi_id%>)님의 비밀번호를<br />
	재설정 부탁드립니다<br />
	<br /><br />
<form name="frmpw">
	&nbsp;비밀번호&nbsp;&nbsp;<input type="password" name="cpw1" placeholder="비밀번호 입력" value="" maxlength="8" /><br /><br />
	&nbsp;비밀번호 확인&nbsp;&nbsp;<input type="password" name="cpw2" placeholder="비밀번호 확인" value="" maxlength="8" /><br /><br />
	<input type="hidden" name="mi_id" value="<%=mi_id %>" />
	<input type="button" onclick="pwCheck(form);" value="비밀번호 변경" />
</form>
</div>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>
