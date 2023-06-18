<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/*
1. 사용자가 입력한 비밀번호를 받아옴
2. 사용자가 입력한 비밀번호가 확인 비번과 동일 해야 함
3. 동일여부를 현 파일을 포함하고 있는 join_form.jsp로 표시해줌
*/
request.setCharacterEncoding("utf-8");

%>
<script>
	var pw1 = parent.document.getElementById("pw1").value;
	var pw2 = parent.document.getElementById("pw2").value;
	var pmsg = parent.document.getElementById("pmsg");
	var isDup = parent.frmJoin.isDup;
	
	if (pw1 != pw2){
		var tmp = "<span style='color:red; font-weight:bold;'>" + "입력하신 비밀번호가 다릅니다.</span>";
		isDup.value = "n";
	} else {
		var tmp = "<span style='color:blue; font-weight:bold;'>" + "비밀번호가 확인되었습니다.</span>";
		isDup.value = "y";
	}
	pmsg.innerHTML = tmp;
</script>

<%@ include file="../_inc/inc_foot.jsp" %>
