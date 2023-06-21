<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌


String nl_title = "", nl_content = "", nl_date = "", ai_id = "";
int ai_idx = 0;

try {
	stmt = conn.createStatement();
	sql = "select b.ai_idx, b.ai_id, a.nl_title, a.nl_content, a.nl_date, a.nl_isview " +
			" from t_notice_list a inner join t_admin_info b on a.ai_idx = b.ai_idx where nl_idx = " + idx;
	
	rs = stmt.executeQuery(sql);
	if (rs.next()) {
		nl_content = rs.getString("nl_content").replace("\r\n", "<br>");
		// 엔터(\r\n)를 <br> 태그로 변경하여 nl_content변수에 저장
		nl_title = rs.getString("nl_title");	nl_date = rs.getString("nl_date").substring(0, 10);
		ai_idx = rs.getInt("ai_idx");			ai_id = rs.getString("ai_id"); 
	} else {
		out.println("<script>");
		out.println("alert('존재하지 않는 게시물입니다.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}
	
} catch(Exception e) {
	out.println("공지사항 글보기시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try { rs.close();	stmt.close(); } 
	catch(Exception e) {e.printStackTrace();}
}

%>


<div style="width:1100px; margin:0 auto;">
		<style>
			.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
			input[type="submit"] {border:1px solid #000; width:75px; padding:50px 0; font-size:15px; background:transparent; cursor:pointer; background:#fff;}
			table, td {border:0;}
			.btnbox {display:flex; justify-content:flex-end; padding:10px 0; border-top:1px solid #000;}
			.btn {display: block; margin-left:10px; background-color: white; border: 1px solid black; border-radius: 1px; width: 52px; cursor: pointer; padding: 3px; text-align: center;}
			.txt {width:700px; height:120px;}
		</style>
		<a href="/ad_ktbwos/bbs/ad_notice_list.jsp" class="alltext">전체글</a>
		<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">공지사항관리</span> <!--  현재 게시판 위치 표시  -->
	<br><br><br>
	<!--  <style>
	#box { width:1100px; height:600px; margin:0px auto 0; border:1px solid black; font-size:15px; }
	</style> -->
	<!--   <div id="box"> -->
		<br>
		<div style="float : left;">&nbsp;&nbsp;<%=ai_id %></div>
		<div style="float : right;"><%=nl_date %>&nbsp;&nbsp;</div>
		<br><br><hr>	
		<h4>&nbsp;&nbsp;<%=nl_title %></h4>
		<hr>
		<%=nl_content %>	
		<br>
		<hr>
	<div align="right">
	<input type="button" value="글목록" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='ad_notice_list.jsp<%=args%>'">
	<input type="button" value="글수정" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='ad_notice_form.jsp<%=args%>&kind=up&idx=<%=idx %>'">

	<script>
		function isDel() {
			if (confirm("정말 삭제하시겠습니까?")) {
				location.href = "ad_notice_proc_del.jsp?idx=<%=idx%>";
			} 
		}
	</script>
	<input type="button" value="삭제" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="isDel();">

	<!--   </div> -->	
</div>


<%@ include file="../_inc/inc_foot.jsp" %>