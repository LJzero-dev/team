<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String caption = "등록";		// 버튼에 사용할 캡션 문자열
String action = "request_proc_in.jsp";	
String rl_ctgr = "",rl_title = "",rl_name = "",rl_writer = "",rl_write = "",rl_reply_use = "",rl_reply_write = "", rl_content = "", rl_status = "", rl_reason = "";
int idx = 0;	// 글번호를 저장할 변수로 '수정'일 경우에만 사용됨
int cpage = 1;	// 페이지번호를 저장할 변수로 '수정'일 경우에만 사용됨

String schtype = request.getParameter("schtype");	// 검색 조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}
	idx = Integer.parseInt(request.getParameter("idx"));
	cpage = Integer.parseInt(request.getParameter("cpage"));
	
	String where = " where rl_idx = " + idx;
	sql = "select * from t_request_list " + where;
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			rl_ctgr = rs.getString("rl_ctgr");
			rl_title = rs.getString("rl_title");
			rl_writer = rs.getString("rl_writer");
			rl_write = rs.getString("rl_write");
			rl_reply_use = rs.getString("rl_reply_use");
			rl_reply_write = rs.getString("rl_reply_write");
			rl_content = rs.getString("rl_content");
			rl_status = rs.getString("rl_status");
			rl_reason = rs.getString("rl_reason");
			rl_name = rs.getString("rl_name");
			if (rl_status.equals("n") && rl_name.indexOf((""+idx)) != -1) {
				rl_name = rl_name.substring(("" + idx).length(), rl_name.lastIndexOf(("" + idx)));
			}
			
		} else {
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");	
			out.close();
		}		
	} catch (Exception e) {
		out.println("게시글 보기 폼에서 문제가 발생했습니다.");
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
boolean isPms = (loginInfo != null) ? true : false ;
 String	upLink = "request_form.jsp" + args + "&kind=up&idx=" + idx;
 String	delLink = "request_proc_del.jsp?idx=" + idx;
%>		
	

<script>
	function rl_reply_use_show (rl_reply_use) {
		if (rl_reply_use == "y") {
			document.getElementById("rl_reply_write").style.display="";
			document.getElementById("rl_reply_write2").style.display="";
		} else {
			document.getElementById("rl_reply_write").style.display="none";
			document.getElementById("rl_reply_write2").style.display="none";
		}
	}
</script>

<style>
	input[type="submit"] {border:1px solid #000; width:60px; background:transparent; cursor:pointer; background:#fff;}
	input[type="button"] {border:1px solid #000; width:60px; background:transparent; cursor:pointer; background:#fff;}
	.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<div style="width:1100px; margin:0 auto;">
	<a href="/ktbwos/bbs/request_list.jsp" class="alltext">전체글</a>
	<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">요청 게시판</span>
	<form name="frmSch" style="margin-bottom:0;">
	<table width="1100" >	
		<tr>
			<td>제목</td>
			<td colspan="3"><%=rl_title %></td>
		</tr >
		<tr>
			<td width="20%">요청자</td><td width="30%"><%=rl_writer %></td><td width="20%">작성 글번호</td><td width="30%"><%=idx %></td>
		</tr>
		<tr>
			<td>분류</td>
			<td>
				<%=rl_ctgr.equals("a") ? "게임" : rl_ctgr.equals("b") ? "연예" : "스포츠" %>
			</td>
			<td>게시글 작성 권한</td>
			<td><%=(rl_write.equals("y")) ? "회원 전용" : "모두 가능" %></td>
		</tr>
		<tr>
			<td>댓글 사용 여부</td>
				<td><%=(rl_reply_use.equals("y")) ? "사용" : "미사용" %></td>
				<% if (rl_reply_use.equals("y")) { %>
			    <td>댓글 작성 권한</td>
			<td><%=(rl_reply_write.equals("y")) ? "회원 전용" : "모두 가능" %></td>
            <% } %>
		</tr>		
		<tr>
			<td>게시판 이름</td>
			<td colspan="3"><%=rl_name %></td>
		</tr>
		<tr>
			<td>요청 내용</td>
			<td colspan="3"><textarea readonly="readonly" id="rl_content" style="width:99%; height:100px" placeholder="요청 내용을 상세히 입력하세요" ><%=rl_content %></textarea></td>
		</tr>
		<% if (rl_status.equals("n")) { %>
		<tr>
			<td>미승인 사유</td>
			<td colspan="3"><%=rl_reason %></td>
		</tr>
		<% } else if (rl_status.equals("y")) { %>
		<tr><td colspan="4">승인 완료된 게시판 입니다</td></tr>
				<% } %>
		<tr>
			<td colspan="4">※ 게시판 이름 및 분류와 맞지 않거나, 요청 내용이 부적절할 경우 반려될 수 있습니다..</td>
		</tr>
		<tr>			
			<td colspan="4">※ 개설 승인, 반려는 매우 많은 시간이 필요합니다.</td>
		</tr>
	</table><br />	
	<span style="display:inline-block; float:right; margin-top:5px; margin-left:10px;">
	<%	if (isPms && rl_writer.equals(loginInfo.getMi_nick()) && rl_status.equals("a")) {  %>
	<input type="button" value="수정" onclick="location.href='<%=upLink %>';" />
<script>
function isDel() {
	if (confirm("정말 삭제하시겠습니까?\\n삭제된 글은 복구 불가합니다.")) {
		location.href = "<%=delLink %>";
	}
}
</script>
	<input type="button" value="글삭제" onclick="isDel();" />
<% } %>
		<input type="button" value="취소" onclick="history.back();">
	</span>	
</form>
</div>

<%@ include file="../_inc/inc_foot.jsp" %>