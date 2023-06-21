<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int fl_idx = Integer.parseInt(request.getParameter("idx"));
int fr_idx = Integer.parseInt(request.getParameter("fr_idx"));
String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String action = "free_reply_proc_del.jsp";

try {
	stmt = conn.createStatement();
	sql = "select 1 from t_free_reply where fr_isview = 'y' and fr_ismem = 'n' and fr_idx = " + fr_idx;
	rs = stmt.executeQuery(sql);
	
	System.out.println(sql);	
	if (!rs.next()) {	// rs에 데이터가 없으면(idx에 해당하는 게시글이 비회원이 아니면)
		out.println("<script>");
		out.println("alert('잘못된 경로로 들어오셨습니다.'); history.back();");
		out.println("</script>");
		out.close();
	}
	
} catch(Exception e) {
	out.print("댓글 관련 문제가 발생하였습니다");
	e.printStackTrace();
} finally {
	try { stmt.close();} 
	
	catch(Exception e) {
		e.printStackTrace();
	}
}
%>
<style>
#box {width:200px; height:100px; margin:30px auto 0; border:1px solid #000; text-align:center; font-size:12px;}
</style>

<h2 align="center">비밀번호 입력 폼</h2>
<form name="frm" action="<%=action %>" method="post">
<input type="hidden" name="fr_ismem" value="n" />
<input type="hidden" name="fl_idx" value="<%=fl_idx %>" />
<input type="hidden" name="fr_idx" value="<%=fr_idx %>" />
<input type="hidden" name="kind" value="<%=kind %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<% 	if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) { %>
<input type="hidden" name="schtype" value="<%=schtype %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<% } %>
<div id="box">
	<p>비밀번호를 입력하세요.</p>
	<input type="password" name="fr_pw" style="margin-bottom:10px;" /><br />
	<input type="button" value="취 소" onclick="history.back();" />
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" value="확 인" />
</div>
</form>
<script>
	document.frm.fr_pw.focus();
</script>
<%@ include file="../_inc/inc_foot.jsp" %>