<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>

<%
/* 회원정보 상세보기
1. 아이디 / 이메일 / 닉네임 / 상태 / 가입일 / 최종로그인  / 작성한 게시글 수 / QnA작성 수
*/

request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}	// 링크에 검색관련 값들을 쿼리스트링으로 연결해줌
// view 화면에서 보여줄 게시글의 정보들을 저장할 변수들
String mi_id = "", mi_email = "", mi_nick = "", mi_status = "", mi_date = "", milastlogin = "";
int mi_idx = 0, mi_count = 0, qlidx = 0;

try {
	stmt = conn.createStatement();
	
	sql = "select a.mi_idx, a.mi_id, a.mi_email, a.mi_nick, a.mi_status, a.mi_date, a.mi_count, ifnull(a.mi_lastlogin, '로그인 내역 없음....') milastlogin, count(b.ql_idx) qlidx " + 
	"from t_member_info a left join t_qna_list b on a.mi_idx = b.mi_idx where a.mi_idx = " + idx;
	rs = stmt.executeQuery(sql);
	if (rs.next()) {
		mi_idx = rs.getInt("mi_idx");
		mi_id = rs.getString("mi_id");
		mi_email = rs.getString("mi_email");
		mi_nick = rs.getString("mi_nick");
		mi_status = rs.getString("mi_status");
		mi_date = rs.getString("mi_date");
		milastlogin = rs.getString("milastlogin");
		mi_count = rs.getInt("mi_count");
		qlidx = rs.getInt("qlidx");
		
		
		
	} else {
		out.println("<script>");
		out.println("alert('존재하지 않는 회원입니다.');"); 
		out.println("history.back();");	
		out.println("</script>");
		out.close();
	}
	
} catch(Exception e) {
	out.println("회원 상세정보 보기시 문제가 발생했습니다.");
	e.printStackTrace();
} 
%>
<style>
	.alltext {display:inline-block; float:left; width:80px; margin-bottom:10px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>
<div style="width:1100px; margin:0 auto;">
<a href="/ad_ktbwos/ad_mi_list.jsp" class="alltext">목록</a>
<h2 align="center">회원 정보 보기</h2>
<table width="1100" border="0" cellpadding="5" cellspacing="0" id="list">
<tr height="30">
<th width="15%">아이디</th>
<th><%=rs.getString("mi_id") %></th>
<th width="*">이메일</th>
<th><%=rs.getString("mi_email") %></th>
<th width="10%">가입일</th>
<th><%=rs.getString("mi_date").substring(0, 10) %></th>
</tr>
<tr height="30">
<th width="10%">상태</th>
<%
String mistatus = rs.getString("mi_status");
if (mistatus.equals("a")) {
	mistatus = "정상";
} else if (mistatus.equals("b")) {
	mistatus = "휴면";
} else 
	mistatus = "탈퇴";
%>
<th><%=mistatus %></th>
<th width="15%">닉네임</th>
<th><%=rs.getString("mi_nick") %></th>
<th width="10%">최종로그인</th>
<th><%=rs.getString("milastlogin").substring(0, 10) %></th>
</tr>
<tr height="30">
<th width="10%">작성한 게시글 수</th>
<th><%=rs.getInt("mi_count") %></th>
<th width="10%">QnA등록횟수</th>
<th><%=rs.getInt("qlidx") %></th>
<th></th>
</tr>


<%@ include file="../_inc/inc_foot.jsp" %>

