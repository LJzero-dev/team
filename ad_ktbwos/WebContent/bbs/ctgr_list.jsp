<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%

request.setCharacterEncoding("utf-8");
int cpage = 1, psize = 3, bsize = 3, rcnt = 0, pcnt = 0;

if (request.getParameter("cpage") != null) cpage = Integer.parseInt(request.getParameter("cpage"));

String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String schargs = "";
String where =" where rl_status = 'y' ";

if (schtype == null || schtype.equals("") || keyword == null || keyword.equals("")) {			// 검색을 하지 않은 경우
	schtype = "";	keyword = "";
} else {
	keyword = getRequest(keyword);
	URLEncoder.encode(keyword, "UTF-8");	// 쿼리스트링으로 주고 받는 검색어가 한글일 경우 IE에서 문제가 발생할 수도 있으므로 유니코드로 변환
	

	if (schtype.equals("all")) {	// 검색조건이 '제목 + 내용'일 경우
		where += " and (rl_name like '%" + keyword + "%' " + " or rl_ctgr = '" + (keyword.equals("게임") ? "a" : keyword.equals("연예") ? "b" : "c") + "') ";	
	} else if (schtype.equals("a")) {	// 검색조건이 '분류'일 경우
		where += " and rl_ctgr = '" + (keyword.equals("게임") ? "a" : keyword.equals("연예") ? "b" : keyword.equals("스포츠") ? "c" : "") + "' ";
	} else {					// 검색조건이 '게시판 이름'일경우
		where += " and rl_name like '%" + keyword + "%' ";
	}
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;	//	검색조건이 있을 경우 링크의 url에 붙일 쿼리스트링 완성
}

try {
	stmt = conn.createStatement();
	sql = "select count(*) from t_request_list " + where;	// 자유게시판 레코드의 개수(검색조건 포함)를 받아 올 쿼리
	rs = stmt.executeQuery(sql);
	if (rs.next()) rcnt = rs.getInt(1);	
	
	pcnt = rcnt / psize;
	if (rcnt % psize > 0) pcnt++;
	
	int start = (cpage -1) * psize;
	sql = "select rl_idx, rl_ctgr, rl_name, rl_content, rl_status, rl_table_name from t_request_list " + where + "  order by rl_idx desc limit " + start + " , " + psize;
	rs = stmt.executeQuery(sql);
} catch (Exception e) {
	out.println("자유게시판 목록에서 문제가 발생했습니다");
	e.printStackTrace();
}
%>






	
<style>
	input[type="submit"] {border:1px solid #000; width:60px; background:transparent; cursor:pointer; background:#fff;}
	.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<div style="width:1100px; margin:0 auto;">
	<a href="/ad_ktbwos/bbs/ctgr_list.jsp" class="alltext">전체글</a>
	<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">카테고리 게시판</span>
	<form name="frmSch" style="margin-bottom:0;">
		<fieldset style=" width:335px; margin-left:737px; background:#d3d3d3;">
			<select name="schtype">
			<option value="all" <% if (schtype.equals("all")) { %>selected="selected"<% } %>>전체</option>
			<option value="a" <% if (schtype.equals("a")) { %>selected="selected"<% } %>>분류</option>
			<option value="b" <% if (schtype.equals("b")) { %>selected="selected"<% } %>>게시판</option>
			</select>
		<input type="text" name="keyword" value="<%=keyword %>" />
		<input type="submit" value="검색" />&nbsp;&nbsp;&nbsp;&nbsp;
		</fieldset>
	</form>
	<table width="1100" border="0" cellpadding="0" cellspacing="0" id="list">
		<tr>
			<th width="7%">번호</th>
			<th width="7%">분류</th>
			<th width="*">게시판 이름</th>
			<th width="50%">상세설명</th>
		</tr>
<%
if (rs.next()) {
	int num = rcnt - (cpage - 1) * psize;
	do {		
		String idx = rs.getString(1);
		String ctgr = rs.getString("rl_ctgr").equals("a") ? "게임" : rs.getString("rl_ctgr").equals("b") ? "연예" : "스포츠";
		String name = "<a href='table_list.jsp?rl_table_name=" + rs.getString("rl_table_name") + "'>" + rs.getString("rl_name") + "</a>";
		String rl_content = rs.getString("rl_content");
%>
<tr>
<td><%=num %></td>
<td><%=ctgr %></td>
<td><%=name %></td>
<td align="left"><%=rl_content %></td>
</tr>
<% 
	num--;
	} while(rs.next());
}else {
		out.print("<tr height='30'><td colspan='7'>검색결과가 없습니다.</td></tr>");
} %>
</table>
<br />	
</div>
<br />
<table width="1100" align="center">
</table>
<div width="1100" align="center">
<%
if (rcnt > 0) {	// 게시글이 있으면
	String link = "ctgr_list.jsp?cpage=";
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='" + link + "1" + schargs + "'>[처음]</a>&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + link + (cpage-1) + schargs + "'>[이전]</a>&nbsp;&nbsp;");
	}
	
	int spage = (cpage -1) / bsize * bsize +1;	// 블록 시작 페이지 번호
	for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {	// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수 j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 할 변수
		if (j == cpage) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.println("&nbsp;<a href='" + link + j + schargs + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("<a href='" + link + (cpage+1) + schargs + "'>[다음]</a>&nbsp;&nbsp;");
		out.println("<a href='" + link + pcnt + schargs + "'>[마지막]</a>&nbsp;&nbsp;&nbsp;");
	}
}
%>
</div>

<%@ include file="../_inc/inc_foot.jsp" %>