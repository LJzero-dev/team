<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String action = "ctgr_proc_in.jsp";
String caption = "등록";
String rl_table_name = request.getParameter("rl_table_name");
String writer = "", date = "", title = "", content = "";

int idx = 0;	// 글번호를 저장할 변수로 '수정'일 경우에만 사용됨
int cpage = 1;	// 페이지 번호를 저장할 변수로 '수정'일 경우에만 사용됨
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌

String ismem = request.getParameter("ismem"), table_name = "";		// 현재 수정상태이면서 해당 글이 비회원 글일 경우에만 'n'의 값이 있음
rs = conn.createStatement().executeQuery("select rl_name from t_request_list where rl_table_name = '" + rl_table_name + "'");	rs.next();
table_name = rs.getString(1);
if (ismem == null)	ismem = "y";
String pw = request.getParameter("pw");
if (kind.equals("up")) {	// 게시글 수정 폼일 경우
	caption = "수정";
	action = "ctgr_proc_up.jsp";

	idx = Integer.parseInt(request.getParameter("idx"));
	cpage = Integer.parseInt(request.getParameter("cpage"));
	
	String where = " where " + rl_table_name + "_isview = 'y' and " + rl_table_name + "_idx = " + idx + " and " + rl_table_name + "_ismem = '" + ismem + "' ";
	if (ismem.equals("n"))	// 비회원 글일 경우
		where += " and " + rl_table_name + "_pw = '" + pw + "' ";
	else						// 회원 글일 경우
		where += " and " + rl_table_name + "_writer = '" + loginInfo.getMi_nick() + "' ";
	sql = "select * from t_" + rl_table_name + "_list " + where;
	try {
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sql);
		if (rs.next()) {	// 게시글이 있으면
			writer = rs.getString(rl_table_name + "_writer");
			title = rs.getString(rl_table_name + "_title");
			content = rs.getString(rl_table_name + "_content");
			date = rs.getString(rl_table_name + "_date");
			
		} else {			// 게시글이 없으면
			out.println("<script>");
			if (ismem.equals("n"))
				out.println("alert('암호가 틀렸습니다.\\n다시 시도하세요.');");
			else
				out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");	
			out.close();
		}		
	} catch (Exception e) {
		out.println("게시글 수정 폼에서 문제가 발생했습니다.");
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
%>
<script>
	function chkVal (frm){
		if (frm.title.value == "") {
			alert("게시글 제목을 입력해주세요.");
			return false;
		}
		if (frm.content.value == "") {
			alert("게시글 내용을 입력해주세요.");
			return false;
		}
		<% if (!isLogin) {%>
		if (frm.writer.value == "") {
			alert("닉네임을 입력해주세요.");
			return false;
		}
		if (frm.pw.value == "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		<% } %>
		return true;
	}
</script>
<form name="frm" action="<%=action %>" method="post" onsubmit="return chkVal(this);">
<% if (kind.equals("up")) { %>
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />

<% 	if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) { %>
<input type="hidden" name="schtype" value="<%=schtype %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<%	
	} 
}
%>
<div style="width:1100px; margin:0 auto;">
<input type="hidden" name="rl_table_name" value="<%=rl_table_name %>" />
<table width="1100" cellpadding="5">
<% if (kind.equals("in")) { 
	if (isLogin) {
%>
	<tr>
	<th width="15%">작성자</th>
	<td width="*%" colspan="3"><%=loginInfo.getMi_nick() %></td>
	</tr>
<% } else { %>
	<tr>
	<th width="15%">작성자</th>
	<td width="35%"><input type="text" name="writer" style="width:100%; height:30px; border:0;" placeholder="작성자를 입력해주세요."/></td>
	<th width="15%">비밀번호</th>
	<td width="35%"><input type="password" name="pw" style="width:100%; height:30px; border:0;" placeholder="비밀번호를 입력해주세요." /></td>
	</tr>
<% } %>
	<tr>
	<th>글제목</th>
	<td width="50%"><input type="text" name="title" size="60" style="width:100%; height:30px; border:0;" placeholder="제목을 입력해주세요." ></td>
	<th width="15%">게시판 이름</th>
	<td><%=table_name  %></td>
	</tr>
	<tr>
	<th>내용</th>
	<td colspan="3"><textarea name="content" style="width:99%; height:200px" placeholder="내용을 입력하세요" ></textarea></td>
	</tr>
<% } else if (kind.equals("up")) { %>
	<tr>
	<th width="15%" >작성자</th>
	<td width="35%" colspan="3"><%=writer %></td>
	</tr>
	<tr>
	<th>글제목</th>
	<td width="50%"><input type="text" name="title" size="60" style="width:100%; height:30px; border:0;" placeholder="제목을 입력해주세요." value="<%=title %>" ></td>
	<th width="15%">게시판 이름</th>
	<td><%=table_name %></td>
	</tr>
	<tr>
	<th>내용</th>
	<td colspan="3"><textarea name="content" style="width:99%; height:200px" placeholder="내용을 입력하세요" ><%=content %></textarea></td>
	</tr>
<% } %>

</table>
	<span style="display:inline-block; float:right; margin-top:5px; margin-left:10px;">
	<input type="submit" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" value="<%=caption %>" />
	<input type="button" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" value="뒤로" onclick="history.back();">
	</span>	
</div>
</form>

<%@ include file="../_inc/inc_foot.jsp" %>