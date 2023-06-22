<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String caption = "등록";	
String action = "free_proc_in.jsp";
String fl_writer = "", fl_date = "", fl_title = "", fl_content = "";

int idx = 0;	// 글번호를 저장할 변수로 '수정'일 경우에만 사용됨
int cpage = 1;	// 페이지 번호를 저장할 변수로 '수정'일 경우에만 사용됨
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌

String fl_ismem = request.getParameter("fl_ismem");
//현재 수정상태이면서 해당 글이 비회원 글일 경우에만 'n'의 값이 있음
if (fl_ismem == null)	fl_ismem = "y";
String fl_pw = request.getParameter("fl_pw");

if (kind.equals("up")) {
	caption = "수정";
	action = "free_proc_up.jsp";
	
	idx = Integer.parseInt(request.getParameter("idx"));
	cpage = Integer.parseInt(request.getParameter("cpage"));
	
	String where = " where fl_isview = 'y' and fl_idx = " + idx + " and fl_ismem = '" + fl_ismem + "' ";
	
	if (fl_ismem.equals("n")) {	// 비회원 글 일 경우
		where += " and fl_pw = '" + fl_pw + "' ";	
	} else {
		where += " and fl_writer = '" + loginInfo.getMi_nick() + "' ";
	}
	sql = "select * from t_free_list " + where;
	
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);	

		if (rs.next()) {	// 게시글이 있으면
			fl_writer = rs.getString("fl_writer");
			fl_date = rs.getString("fl_date").substring(0, 10);
			fl_title = rs.getString("fl_title");
			fl_content = rs.getString("fl_content");
	
		} else {
			out.println("<script>");
			if (fl_ismem.equals("n"))			
				out.println("alert('암호가 틀렸습니다.\\n다시 시도하세요.');");
			else 
				out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	} catch(Exception e) {
		out.println("게시글 수정폼에서 문제가 발생했습니다.");
		e.printStackTrace();
	} finally {
		try { rs.close();	stmt.close(); } 
		catch(Exception e) { e.printStackTrace(); }
	} 
}
%>
<script>
	function checkform() {
		var writer = document.forms["frm"]["fl_writer"].value;
		var pw = document.forms["frm"]["fl_pw"].value;
		var title = document.forms["frm"]["fl_title"].value;
		var content = document.forms["frm"]["fl_content"].value;
		
		if (writer === "" || writer.trim() === "") {
		  	alert("작성자를 입력해주세요.");
		 		return false;
		} else if (pw === "" || pw.trim() === "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		}  else if (title === "" || title.trim() === "") {
			alert("제목을 입력해주세요.");
			return false;
		} else if (content === "" || content.trim() === "") {
			alert("내용을 입력해주세요.");
			return false;
		}
	}
</script>
<form name="frm" action="<%=action %>" method="post">
<% if (kind.equals("up")) { %>
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />
<input type="hidden" name="fl_pw" value="<%=fl_pw %>" />
<input type="hidden" name="fl_ismem" value="<%=fl_ismem %>" />

<% 	if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) { %>
<input type="hidden" name="schtype" value="<%=schtype %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<%	
	} 
}
%>
<div style="width:1100px; margin:0 auto;">
<table width="1100" cellpadding="5">

<% 
if (kind.equals("in")) { 
	if (!isLogin) {
%>
<tr>
	<th width="15%">작성자</th>
	<td width="35%"><input type="text" name="fl_writer" style="width:100%; height:30px; border:0;" placeholder="작성자를 입력해주세요."/></td>
	<th width="15%">비밀번호</th>
	<td width="35%"><input type="password" name="fl_pw" style="width:100%; height:30px; border:0;" placeholder="비밀번호를 입력해주세요." /></td>
</tr>
<% 
	} 
} else if (kind.equals("up")){
	if (!isLogin) {
%>
<tr>
	<th width="15%">작성자</th>
	<td width="35%"><%=fl_writer %></td>
	<th width="15%">작성일</th>
	<td width="35%"><%=fl_date %></td>
</tr>
<% 
	} 
}
%>

<tr>
	<th>글제목</th>
	<td colspan="3"><input type="text" name="fl_title" size="60" value="<%=fl_title %>" style="width:100%; height:30px; border:0;" placeholder="제목을 입력해주세요." ></td>
</tr>
<tr>
	<th>글내용</th>
	<td colspan="3"><textarea name="fl_content" style="width:100%; height:600px;"><%=fl_content %></textarea></td>
</tr>
<tr>
	<td colspan="4" style="text-align:right;">
		<input type="submit" value="<%=caption %>" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="return checkform();" />&nbsp;
		<input type="reset" value="취소" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='free_list.jsp?cpage=<%=cpage + args %>';" />
	</td>
</tr>
</table>
</div>
</form>

<%@ include file="../_inc/inc_foot.jsp" %>