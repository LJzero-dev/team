<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%

request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String caption = "등록";		// 버튼에 사용할 캡션 문자열
String action = "ad_notice_proc_in.jsp";
String nl_title = "", nl_content = "", nl_isview = "n";

int idx = 0;	// 글 번호를 저장할 변수로 '수정'일 경우에만 사용됨
int cpage = 1; 	// 페이지 번호를 저장할 변수로 '수정'일 경우에만 사용됨
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args = "&schtype=" + schtype + "&keyword=" + keyword;
}	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌

if (kind.equals("up")) {	// 공지글 수정 폼일 경우
	caption = "수정";
	cpage = Integer.parseInt(request.getParameter("cpage"));
	idx = Integer.parseInt(request.getParameter("idx"));
	action = "ad_notice_proc_up.jsp";
	
	try {
		stmt = conn.createStatement();
		sql = "select * from t_notice_list where nl_isview = 'y' and nl_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			nl_content = rs.getString("nl_content");	nl_title = rs.getString("nl_title");	nl_isview = rs.getString("nl_isview");	
		} else {
			out.println("<script>");
			out.println("alert('존재하지 않는 게시물입니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	} catch(Exception e) {
		out.println("공지사항 글수정폼에서 문제가 발생했습니다.");
		e.printStackTrace();
	} finally {
		try { rs.close();	stmt.close(); } 
		catch(Exception e) {e.printStackTrace();}
	}
}

%>
<div style="width:1100px; margin:0 auto;">  <!--목록화면 인클루드랑 간격 맞추기  -->
<style>
	.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<div style="width:1100px; margin:0 auto;">
	<a href="/ad_ktbwos/bbs/ad_notice_list.jsp" class="alltext">전체글</a>
	<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">공지사항관리</span> <!--  현재 게시판 위치 표시  -->
<br><br><br>
	<style>
	#box { width:1100px; height:600px; margin:0px auto 0; border:1px solid black; font-size:15px; }
	</style>
	<div id="box">	
		<form name="frm" action="<%=action %>" method="post">
		<% if (kind.equals("up")) {%>
		<input type="hidden" name="idx" value="<%=idx %>">
		<input type="hidden" name="cpage" value="<%=cpage %>">
		<% if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) { %>
		<input type="hidden" name="schtype" value="<%=schtype %>">
		<input type="hidden" name="keyword" value="<%=keyword %>">
		<%
			}
		}
		%>
			<div>
			<br />
				&nbsp;&nbsp;<span>제목</span>
				<input type="text" name="nl_title" size="100" value="<%=nl_title%>">
			</div>
			<script>
			var title = document.getElementById("title");
			
			title.addEventListener("click", function() {
			  this.value = "";
			});
			</script>
			<br />&nbsp;&nbsp;&nbsp;
			<textarea name="nl_content" rows="30" cols="80"><%=nl_content%></textarea><br>
			<br>
	<div align = "right">
		<input type="submit" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" value="<%=caption %>">
	</div>
		</form>
	</div>
	<br />
</div>



<%@ include file="../_inc/inc_foot.jsp" %>