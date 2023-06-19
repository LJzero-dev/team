<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 회원관리 목록 및 어드민 홈화면
1. 번호 / 아이디 / 이메일 / 닉네임 / 상태 / 가입일 / 최종로그인 보여줌
2. 상태 선택해서 해당 상태의 회원목록만 보기 가능 : 전체(default) / 정상 / 휴면 / 탈퇴
3. 전체 회원 수는 항상 보여주고 검색한 목록의 회원수 보여줌
4. 검색기능 : 분류(전체, 아이디, 닉네임)
*/

request.setCharacterEncoding("utf-8");
int cpage = 1, psize = 10, bsize = 5, rcnt = 0, pcnt = 0;
String status_select = "";
// 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수 등을 저장할 변수

if (request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));
if (request.getParameter("status_select") != null)
	status_select = request.getParameter("status_select");

String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String schargs = "";
String where = " ";

if (schtype == null || schtype.equals("") || keyword == null || keyword.equals("")) {	// 검색을 하지 않는 경우
	schtype = "";	keyword = "";
}
	keyword = getRequest(keyword);
	URLEncoder.encode(keyword, "UTF-8");
	// 쿼리스트링으로 주고 받는 검색어가 한글일 경우 IE에서 문제가 발생할 수도 있으므로 유니코드로 변환
	
	if (schtype.equals("id")) {	// 검색조건이 '아이디'일 경우
		where += " where mi_status = '" + status_select + "' and mi_id like '%" + keyword + "%'";
	} else if (schtype.equals("nick")) {	// 검색조건이 '닉네임'일 경우
		where += " where mi_status = '" + status_select + "' and mi_nick like '%" + keyword + "%'";
	} else if (schtype.equals("all")){	// 검색조건이 '전체'일 경우
		where += " where mi_status = '" + status_select + "' and ( mi_id like '%" + keyword + "%' or mi_nick like '" + keyword + "') ";
	} else if (!status_select.equals("")){
		where += " where mi_status = '" + status_select + "'";
	}
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
	// 검색조건이 있을 경우 링크의 url에 붙일 쿼리스트링 완성	

	if (status_select.equals("all")) where = where.replace("=", "!=");
try {
	stmt = conn.createStatement();
	
	sql = "select count(*) from t_member_info " + where;
	// 회원목록 레코드 개수(검색조건 포함)를 받아 올 쿼리
	rs = stmt.executeQuery(sql);
	if (rs.next())	rcnt = rs.getInt(1);
	
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)	pcnt++;
	
	int start = (cpage -1) * psize;
	sql = "select mi_idx, mi_id, mi_email, mi_nick, if(mi_status = 'a', '정상', if(mi_status = 'b', '휴면', '탈퇴')) mistatus , date(mi_date) midate, ifnull(date(mi_lastlogin), '내역없음') milastlogin from t_member_info " + 
	where + "order by mi_idx desc limit " + start + ", " + psize;
	rs = stmt.executeQuery(sql);
	
} catch(Exception e) {
	out.println("회원관리 목록에서 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<script>
function status (e) {
	document.frmSch.schtype.value = "all";
	document.frmSch.keyword.value = "";
	if (e == "all") {
		location.href = 'ad_mi_list.jsp?status_select=all';
	} else if (e == "a") {
		location.href = 'ad_mi_list.jsp?status_select=a';
	} else if (e == "b") {
		location.href = 'ad_mi_list.jsp?status_select=b';
	} else if (e == "c") {
		location.href = 'ad_mi_list.jsp?status_select=c';
	}
}
</script>
<h2 align="center">회원 목록</h2>
<div style="width:1100px; margin:0 auto;">
<div style="width:1100px; text-align:center;">
<form name="frmSch">
<fieldset>
	<legend></legend>
	<div style="float:left;">
	<select title="상태 선택" name="status_select" onchange="status(this.value);">
			<option value="all" <% if(status_select.equals("all")) { %>selected="selected"<% } %>>전체</option>
			<option value="a" <% if(status_select.equals("a")) { %>selected="selected"<% } %>>정상</option>
			<option value="b" <% if(status_select.equals("b")) { %>selected="selected"<% } %>>휴면</option>
			<option value="c" <% if(status_select.equals("c")) { %>selected="selected"<% } %>>탈퇴</option>
	</select>
	</div>
	<div style="float:right;">
	<select name="schtype">
		<option value="all" <% if(schtype.equals("all")) { %>selected="selected"<% } %>>전체</option>
		<option value="id" <% if(schtype.equals("id")) { %>selected="selected"<% } %>>아이디</option>
		<option value="nick" <% if(schtype.equals("nick")) { %>selected="selected"<% } %>>닉네임</option>
	</select>
	<input type="text" name="keyword" value="<%=keyword %>" />
	<input type="submit" value="검색" />&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
</fieldset>
</form>
</div>
<table width="1100" border="0" cellpadding="5" cellspacing="0" id="list">
<tr height="30">
<th width="10%">번호</th>
<th width="15%">아이디</th>
<th width="*">이메일</th>
<th width="15%">닉네임</th>
<th width="10%">상태</th>
<th width="10%">가입일</th>
<th width="10%">최종로그인</th>
</tr>
<%
if (rs.next()) {
	int num = rcnt - ((cpage - 1) * psize);	// 글번호 따로 계산해서 구함
	do {
		String id = rs.getString("mi_id");
		id = "<a href='ad_mi_view.jsp?idx=" + rs.getInt("mi_idx") + "&cpage=" + cpage + schargs + "'>" + id + "</a>";
		
%>
<tr height="30" align="center">
<td><%=num %></td>
<td><%=id %></td>
<td><%=rs.getString("mi_email") %></td>
<td><%=rs.getString("mi_nick") %></td>
<td><%=rs.getString("mistatus") %></td>
<td><%=rs.getString("midate") %></td>
<td><%=rs.getString("milastlogin") %></td>
</tr>
<% 
		num--;
	} while (rs.next());
	
} else {	// 보여줄 회원이 없을 경우
	out.println("<tr height='30'><td colspan='5' align='center'>결과가 없습니다.</td></tr>");
} 
%>
</table>
<br />
<!-- 페이징 -->
<table width="1100" border="0">
<tr>
<td width="600">
<%
if (rcnt > 0) {	// 게시글이 있으면
	String link = "ad_mi_list.jsp?cpage=";
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='" + link + "1" + schargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + link + (cpage - 1) + schargs + "'>[이전]</a>&nbsp;&nbsp;");
	}
	
	int spage = (cpage - 1) / bsize * bsize + 1;	// 블록 시작페이지 번호
	for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++){
	// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
	// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호를 넘지 않게 할 변수)
		if (j == cpage) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.println("&nbsp;<a href='" + link + j + schargs + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("&nbsp;&nbsp;<a href='" + link + (cpage + 1) + schargs + "'>[다음]</a>");
		out.println("&nbsp;&nbsp;&nbsp;<a href='" + link + pcnt + schargs + "'>[마지막]</a>");
	}
}
%>
</td>
</tr>
</table>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>