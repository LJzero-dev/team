<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String action = "ctgr_proc_in.jsp";
String rl_table_name = request.getParameter("rl_table_name");
String fl_writer = "", fl_date = "", fl_title = "", fl_content = "";

int idx = 0;	// 글번호를 저장할 변수로 '수정'일 경우에만 사용됨
int cpage = 1;	// 페이지 번호를 저장할 변수로 '수정'일 경우에만 사용됨
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌

%>

<form name="frm" action="<%=action %>" method="post">
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
	<td colspan="3"><input type="text" name="title" size="60" style="width:100%; height:30px; border:0;" placeholder="제목을 입력해주세요." ></td>
	</tr>
	<tr>
	<th>내용</th>
	<td colspan="3"><textarea name="content" style="width:99%; height:200px" placeholder="내용을 입력하세요" ></textarea></td>
	</tr>
<% } %>

</table>
	<span style="display:inline-block; float:right; margin-top:5px; margin-left:10px;">
	<input type="submit" value="작성" />
	<input type="button" value="뒤로" onclick="history.back();">
	</span>	
</div>
</form>

<%@ include file="../_inc/inc_foot.jsp" %>