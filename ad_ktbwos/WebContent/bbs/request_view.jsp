<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String action = "ad_request_proc_appr.jsp";
String rl_ctgr = "",rl_title = "",rl_name = "",rl_writer = "",rl_write = "",rl_reply_use = "",rl_reply_write = "", rl_content = "", rl_status = "", rl_table_name = "", rl_reason = "";
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
			rl_table_name = rs.getString("rl_table_name");
			rl_reason = rs.getString("rl_reason");
			rl_name = rs.getString("rl_name");
			rl_writer = rs.getString("rl_writer");
			rl_write = rs.getString("rl_write");
			rl_reply_use = rs.getString("rl_reply_use");
			rl_reply_write = rs.getString("rl_reply_write");
			rl_content = rs.getString("rl_content");
			rl_status = rs.getString("rl_status");
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
%>		
	

<script>
function rl_statusChk (rl_status) {
	if (rl_status == "y") {
		document.getElementById("rl_table_name").style.display="";
		document.getElementById("rl_table_name_chk").style.display="";
		document.getElementById("rl_reason").style.display="none";		
		document.frmSch.rl_reason.value = "";
	} else {
		document.getElementById("rl_table_name").style.display="none";
		document.getElementById("rl_table_name_chk").style.display="none";
		document.getElementById("rl_reason").style.display="";
		document.frmSch.rl_table_name.value = "";
	}
}
function isDel() {
	if (document.frmSch.rl_status.value == "n") {
		if (document.frmSch.rl_reason.value == "") {
			alert("미승인 사유를 입력 해주세요.");
			document.frmSch.rl_reason.focus();
		} else {
			if (confirm("정말 미승인하시겠습니까?")) {	
			document.frmSch.action = "ad_request_proc_del.jsp";
			document.frmSch.submit();
			}
		}
	} else {
		alert("미승인 하시려면 미승인 사유를 선택해주세요");
	}
}
function isAppr() {
	if (document.frmSch.rl_status.value == "y") {
		if (document.frmSch.rl_table_name.value == "") {
			alert("테이블 이름을 확인해주세요");
			document.frmSch.rl_table_name.focus();
		} else {
			document.frmSch.action = "ad_request_proc_appr.jsp";
			document.frmSch.submit();
		}
	} else {
		alert("승인 하시려면 테이블 이름을 선택해주세요");
	}	
}
function dupTableName(table) {
	document.getElementById("dup").src = "dup_table_name_chk.jsp?rl_table_name=" + table;
}
</script>

<style>
	input[type="submit"] {border:1px solid #000; width:60px; background:transparent; cursor:pointer; background:#fff;}
	input[type="button"] {border:1px solid #000; width:60px; background:transparent; cursor:pointer; background:#fff;}
	.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>
<iframe src="" id="dup" style="width:500px;  height:200px border:1px black solid; display:none;"></iframe>
<div style="width:1100px; margin:0 auto;">
	<a href="/ad_ktbwos/bbs/request_list.jsp" class="alltext">전체글</a>
	<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">요청 게시판</span>
	<form name="frmSch" style="margin-bottom:0;" action="<%=action %>" method="post" >
	<input type="hidden" name="cpage" value="<%=cpage %>">
	<input type="hidden" name="schtype" value="<%=schtype %>">
	<input type="hidden" name="keyword" value="<%=keyword %>">
	<input type="hidden" name="idx" value="<%=idx %>">
	<input type="hidden" name="rl_name" value="<%=rl_name %>">
	<input type="hidden" name="isDup" value="n">
	<table width="1100" >	
		<tr>
			<td>제목</td>
			<td colspan="3"><%=rl_title %></td>
		</tr >
		<tr>
			<td width="25%">요청자</td><td width="25%"><%=rl_writer %></td><td width="20%">작성 글번호</td><td width="30%"><%=idx %></td>
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
			<td colspan="3"><%=rl_status.equals("n") ? rl_name.substring((""+idx).length(),rl_name.lastIndexOf((""+idx))) : rl_name %></td>
		</tr>		
		<tr>
			<td>요청 내용</td>
			<td colspan="3"><%=rl_content %></td>
		</tr>
		<tr>
			<% if (rl_status.equals("y")) { %>
			<td>테이블 이름</td>
			<td colspan="3" id="rl_table_name"><%=rl_table_name %></td>
			<% } else if(rl_status.equals("n")) { %>
			<td>미승인 사유</td>
			<td colspan="3" id="rl_reason"><%=rl_reason %></td>
			<% } else { %>
			<td>
				<label>테이블 이름<input type="radio" name="rl_status" value="y" onclick="rl_statusChk(this.value)" checked="checked"/></label>
				<label>미승인 사유<input type="radio" name="rl_status" value="n" onclick="rl_statusChk(this.value)" /></label>
            </td>
			<td colspan="2" id="rl_table_name"><input name="rl_table_name"  type="text" placeholder="테이블 이름을 입력 해주세요" onkeyup="dupTableName(this.value);" style="width:450px;" ></td><td id="rl_table_name_chk"><span id="msg">테이블 이름은 영문으로 입력 부탁드립니다</span></td>
			<td colspan="3" id="rl_reason" style="display:none;"><input name="rl_reason"  type="text" placeholder="미승인 사유를 입력해주세요" style="width:800px; "></td>						
			<% } %>
		</tr>
	</table><br />
	
	
	<span style="display:inline-block; float:right; margin-top:5px; margin-left:10px;">
<% if (rl_status.equals("a")){ %>
	<input type="button" value="승인" onclick="isAppr();"/>
	<input type="button" value="미승인" onclick="isDel();" />
<% } %>
		<input type="button" value="뒤로" onclick="history.back();">
	</span>	
</form>
</div>

<%@ include file="../_inc/inc_foot.jsp" %>