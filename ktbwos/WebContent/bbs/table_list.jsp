<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = 1, psize = 10, bsize = 10,rcnt = 0, pcnt = 0;

if (request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));

String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String schargs = "";
String rl_table_name = request.getParameter("rl_table_name");
String where = " where " + rl_table_name + "_isview = 'y' ";
String rl_write = "";
String table_name = "";
if (schtype == null || schtype.equals("") || keyword == null || keyword.equals("")) {
	schtype = "";	keyword = "";
	
} else {
	keyword = getRequest(keyword);
	URLEncoder.encode(keyword, "UTF-8");
	
	if (schtype.equals("total")) {
		where += " and (" + rl_table_name + "_title like '%" + keyword + "%' or " + rl_table_name + "_content like '%" + keyword + "%' or " + rl_table_name + "_writer = '" + keyword + "') ";
	} else if (schtype.equals("writer")) { // 검색조건이 '작성자' 일 경우
		where += " and " + rl_table_name + "_writer = '" + keyword + "' ";
	} else { // 검색조건이 '제목'이거나 '내용'일 경우
		where += " and " + rl_table_name + "_" + schtype + " like '%" + keyword + "%' ";  
	}
	schargs = "&schtype=" + schtype + "&keyword=" + keyword;
}

try {
	stmt = conn.createStatement();
	rs = stmt.executeQuery("select rl_write from t_request_list where rl_table_name = '" + rl_table_name + "'");
	if (rs.next())	rl_write = rs.getString(1);
	
	rs = stmt.executeQuery("select rl_name from t_request_list where rl_table_name = '" + rl_table_name + "'");
	rs.next(); table_name = rs.getString(1);
	
	sql = "select count(*) from t_" + rl_table_name + "_list" + where;
	rs = stmt.executeQuery(sql);
	if (rs.next())	rcnt = rs.getInt(1);
	
	
	pcnt = rcnt / psize;
	if (rcnt % psize > 0)	pcnt++;
	
	int start = (cpage - 1) * psize;
	sql = "select " + rl_table_name + "_idx, " + rl_table_name + "_ismem, " + rl_table_name + "_ip, " + rl_table_name + "_writer, " + rl_table_name + "_reply, " + rl_table_name + "_title, " + rl_table_name + "_read, if(curdate() = date(" + rl_table_name + "_date), time(" + rl_table_name + "_date), replace(mid(" + rl_table_name + "_date, 3, 8), '-', '.')) " + rl_table_name + "date from t_" + rl_table_name + "_list" + where + 
			"order by " + rl_table_name + "_idx desc limit " + start + ", " + psize;
	rs = stmt.executeQuery(sql);
} catch(Exception e) {
	out.println("자유게시판 목록에서 문제가 발생했습니다.");
	e.printStackTrace();
}

%>

<style>
	input[type="submit"] {border:1px solid #000; width:60px; background:transparent; cursor:pointer; background:#fff;}
	.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>
<script>
function goLogin() {
	if (confirm("로그인이 필요합니다.\n로그인 화면으로 이동하시겠습니까?")) {
		location.href = "../login_form.jsp?";
	}
}
</script>
<div style="width:1100px; margin:0 auto;">
	<a href="/ktbwos/bbs/table_list.jsp?rl_table_name=<%=rl_table_name %>" class="alltext">전체글</a>
	<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;"><%=table_name %> 게시판</span>
	<form name="frmSch" style="margin-bottom:0;">
		<input type="hidden" name="rl_table_name" value="<%=rl_table_name %>">
		<fieldset style=" width:335px; margin-left:737px; background:#1E4B79;">
			<select name="schtype">
				<option value="total"<% if(schtype.equals("total")) { %>selected="selected" <% } %>>전체</option>
				<option value="title" <% if(schtype.equals("title")) { %>selected="selected" <% } %>>제목</option>
				<option value="content" <% if(schtype.equals("content")) { %>selected="selected" <% } %>>내용</option>
				<option value="writer" <% if(schtype.equals("writer")) { %>selected="selected" <% } %>>작성자</option>
			</select>
			<input type="text" name="keyword" value="<%=keyword %>" />
			<input type="submit" value="검색" />&nbsp;&nbsp;&nbsp;&nbsp;
		</fieldset>
	</form>
	<table width="1100" border="0" cellpadding="0" cellspacing="0" id="list">
		<tr height="30">
			<th width="10%">번호</th>
			<th width="*">제목</th>
			<th width="15%">작성자</th>
			<th width="15%">작성일</th>
			<th width="10%">조회수</th>
		</tr>
		<%
		if (rs.next()) {
			int num = rcnt - ((cpage -1 ) * psize);
			do {
				int titleCnt = 24;
				String reply = "",  title = rs.getString("" + rl_table_name + "_title");
				if (rs.getInt("" + rl_table_name + "_reply") > 0) {
					titleCnt = titleCnt - 3;
					reply = " [" + rs.getInt("" + rl_table_name + "_reply") + "]";
				}
				
				if (title.length() > titleCnt) {
					title = title.substring(0, titleCnt - 3) + "...";
				}
				title = "<a href='ctgr_view.jsp?idx=" + rs.getInt("" + rl_table_name + "_idx") + "&cpage=" + cpage + schargs + "&rl_table_name=" + rl_table_name + "'>" + title + "</a>" + reply;
				String writer = rs.getString(rl_table_name + "_writer");	
				String ip = rs.getString(rl_table_name + "_ip");
				
				ip = ip.replace(":", "-");		
				ip = ip.replace(".", "-");				
				String[] iparr = ip.split("-");
				if (rs.getString(rl_table_name + "_ismem").equals("n")) {
					 writer += " (" + iparr[0] + "." + iparr[1] + ")";
				}				
		%>
		<tr>
			<td><b><%=num %></b></td>
			<td align="left">&nbsp;<%=title %></td>
			<td><%=writer %></td>
			<td><%=rs.getString(rl_table_name + "date") %></td>
			<td><%=rs.getString(rl_table_name + "_read") %></td>
		</tr>
	<% 
	num--;
	} while(rs.next());
}else {
		out.print("<tr height='30'><td colspan='7'>검색결과가 없습니다.</td></tr>");
} %>
	</table>
	<table style="width:1100px; border:0;">
		<tr>
			<td style="border:0;">
			<% 
			if (rcnt > 0) { // 게시글이 있으면
				String link = rl_table_name + "_list.jsp?cpage=";
				if (cpage == 1) {
					out.println("[처음]&nbsp;&nbsp;&nbsp;[이전]&nbsp;&nbsp;");
				} else {
					out.println("<a href='" + link + "1" + schargs + "'>[처음]</a>");
					out.println("&nbsp;&nbsp;&nbsp;");
					out.println("<a href='" + link + (cpage - 1) + schargs + "'>[이전]</a>");
					out.println("&nbsp;&nbsp;");
				}
				
				int spage = (cpage - 1) / bsize * bsize + 1;	// 블록 시작페이지 번호
				for (int i = 1, j = spage; i <= bsize && j <= pcnt; i++, j++) {
				// i : 블록에서 보여줄 페이지의 개수만큼 루프를 돌릴 조건으로 사용되는 변수
				// j : 실제 출력할 페이지 번호로 전체 페이지 개수(마지막 페이지 번호)를 넘지 않게 할 변수
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
			</td>
			<% if (rl_write.equals("y") && !isLogin) { %>
			<td width="*" style="text-align:right; border:0;">
				<input type="button" value="글등록" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="goLogin();" />
			</td>
			<% } else { %>
			<td width="*" style="text-align:right; border:0;">
				<input type="button" value="글등록" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='ctgr_form.jsp?kind=in&rl_table_name=<%=rl_table_name %>&table_name=<%=table_name %>';" />
			</td>
			<% } %>
		</tr>
	</table>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>