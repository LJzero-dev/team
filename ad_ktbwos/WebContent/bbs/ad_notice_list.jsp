<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = 1, psize = 5, bsize = 10, rcnt = 0, pcnt = 0;
// 페이지번호,  페이지 크기,  블록크기,  레코드(게시글),  페이지개수 등을 저장할 변수


if (request.getParameter("cpage") != null) 
	cpage = Integer.parseInt(request.getParameter("cpage"));
// cpage 값이 있으면 int형으로 형변환하여받음(보안상의 이유와 산술연산을 해야하기 때문)

String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String schargs = ""; 	// 검색관련 쿼리스트링을 저장할 변수
String where = " where nl_isview = 'y' "; 		// 검색조건이 있을 경우 where절을 저장할 변수

if (schtype == null || schtype.equals("") || keyword == null || keyword.equals("")) {
	// 검색을 하지 않는 경우
	schtype = "";	keyword = "";
} else {
	keyword = getRequest(keyword);
	URLEncoder.encode(keyword, "UTF-8");
	// 쿼리스트링으로 주고받는 검색어가 한글일 경우 IE에서 문제가 발생할 수도 있으므로 유니코드로 변환
	if (schtype.equals("tc")) {	// 검색조건이 '제목 +내용' 일 경우
		where += " and (nl_title like '%" + keyword + "%' or nl_content like '%" + keyword + "%')";
	} else { // 검색 조건이 '제목'이거나 '내용'일 경우
		where += " and nl_" + schtype + " like '%" + keyword + "%' ";
	}
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
	// 검색조건이 있을 경우 링크의 url에 붙일 쿼리스트링 완성
}

try {
	stmt = conn.createStatement();
	
	sql = "select count(*) from t_notice_list " + where;
	// 검색된 레코드의 총 개수를 구하는 쿼리 : 페이지 개수를 구하기 위해
	rs = stmt.executeQuery(sql);
	if (rs.next()) rcnt = rs.getInt(1);
	// count() 함수를 사용하므로 ResultSet 안의 데이터 유무를 검사할 필요는 없음
	
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)	pcnt++;	// 전체 페이지 수
	
	int start = (cpage -1) * psize;
	sql = "select a.nl_idx, a.nl_title, b.ai_id, a.nl_date " +
			" from t_notice_list a inner join t_admin_info b on a.ai_idx = b.ai_idx" + 
		where +	" order by nl_idx desc limit " + start + ", " + psize;
	// System.out.println(sql);
	rs = stmt.executeQuery(sql);
	
	
} catch(Exception e) {
	out.println("공지사항 목록에서 문제가 발생했습니다.");
	e.printStackTrace();
}
%>

<div style="width:1100px; margin:0 auto;">  <!--목록화면 인클루드랑 간격 맞추기  -->
<style>
	input[type="submit"] {border:1px solid #000; width:60px; background:transparent; cursor:pointer; background:#fff;}
	.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<div style="width:1100px; margin:0 auto;">
	<a href="/ad_ktbwos/bbs/ad_notice_list.jsp" class="alltext">전체글</a>
	<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">공지사항관리</span> <!--  현재 게시판 위치 표시  -->
	<form name="frmSch" style="margin-bottom:0;">
		<fieldset style=" width:335px; margin-left:737px; background:#d3d3d3;"> <!--  게시판 내 검색창 -->
			<select name="schtype">
				<option>전체</option>
				<option>제목</option>
				<option>내용</option>
			</select>
			<input type="text" name="keyword" value="" />
			<input type="submit" value="검색" />&nbsp;&nbsp;&nbsp;&nbsp;
		</fieldset>
	</form>

<table width="1100" border="0" cellpadding="0" cellspacing="0" id="list">
<tr height="30">
<th width="10%" style="background-color: #d3d3d3;">번호</th><th width="*" style="background-color: #d3d3d3;">제목</th>
<th width="10%" style="background-color: #d3d3d3;">작성자</th><th width="15%" style="background-color: #d3d3d3;">작성일</th>
</tr>

<%
if (rs.next()) {
	int num = rcnt - ((cpage -1) * psize);
	do {
		String title = rs.getString("nl_title");
		String allTitle = null, title2 = "";
		if (title.length() > 23) {	
			allTitle = title;
			title = title.substring(0, 22) + "...";
		}
		title2 = "<a href='ad_notice_view.jsp?idx=" + rs.getInt("nl_idx") + "&cpage=" + cpage + schargs + "'";
		if (allTitle != null) title2 += " title='" + allTitle + "'";
		title2 += ">" + title + "</a>";
		// title에 링크걸기 테이블안에서도 할수있지만 복잡함
%>
<tr height="30" align="center">
<td><%=num %></td>
<td align="left"><%=title2 %></td>
<td><%=rs.getString("ai_id") %></td>
<td><%=rs.getString("nl_date").substring(0, 10) %></td>
</tr>
<% 
	num--;
	} while (rs.next());
	
} else {	// 보여줄 게시글이 없을 경우
	out.println("<tr height='30'><td colspan=;5; align='center'>");
	out.println("검색결과가 없습니다.</td></tr>");
}
%>
</table>
<br>
<table style="width:1100px; border:0;">  <!--  글등록 버튼 -->
	<tr>
		<td style="width:900px; border:0;">
		</td>
		<td width="*" style="text-align:right; border:0;">
		<input type="button" value="글등록" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='ad_notice_form.jsp?kind=in';" />
		</td>
		</tr>
</table>
<br>
<div align="center"> <!--  페이지 테이블 -->
<table width="1100" border="0" cellpadding="5">
<tr align="center">
<%
if (rcnt > 0) {
	String link = "notice_list.jsp?cpage=";
	if (cpage == 1) {
		out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
	} else {
		out.println("<a href='" + link + "1" + schargs + "'>[처음]</a>");
		out.println("&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + link + (cpage -1) + schargs + "'>[처음]</a>");
		out.println("&nbsp;&nbsp;");
	}
	
	int spage = (cpage -1) / bsize * bsize +1;	// 블록 시작페이지번호
	for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++) {
	// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
	// j : 실체 출력할 페이지 번호로 전체 페이지 개수(마지막페이지번호)를 넘지 않게 할 변수
		if (j == cpage) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.println("&nbsp;<a href='" + link + j + schargs + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[다음]&nbsp;&nbsp;&nbsp;[마지막]");
	} else {
		out.println("&nbsp;&nbsp;");
		out.println("<a href='" + link + (cpage + 1) + schargs + "'>[다음]</a>");
		out.println("&nbsp;&nbsp;&nbsp;");
		out.println("<a href='" + link + pcnt + schargs + "'>[마지막]</a>");
	}
}
%>
</tr>
</table>
</div>




<%@ include file="../_inc/inc_foot.jsp" %>