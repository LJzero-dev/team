<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage;
String adminId = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}

String pl_title = "", pl_content = "", pl_date = "", pl_data1 = "", pl_data2 = "";
int pl_read = 0;

try {
	stmt = conn.createStatement();
	
	rs = stmt.executeQuery("select ai_name from t_admin_info where ai_idx = 1");
	rs.next();	adminId = rs.getString(1);
	
	
	sql = "update t_pds_list set pl_read = pl_read + 1 where pl_idx = " + idx;
	stmt.executeUpdate(sql);	// 조회수 증가 쿼리 실행
	
	sql = "select * from t_pds_list where pl_idx = " + idx;
	rs = stmt.executeQuery(sql);
	if (rs.next()) {
		pl_title = rs.getString("pl_title");
		pl_content = rs.getString("pl_content").replace("\r\n", "<br />");
		pl_date = rs.getString("pl_date").substring(0, 10);
		pl_read = rs.getInt("pl_read");
		pl_data1 = rs.getString("pl_data1");
		pl_data2 = rs.getString("pl_data2");

		
	} else {
		out.println("<script>");
		out.println("alert('존재하지 않는 게시물입니다.');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}
	
} catch(Exception e) {
	out.println("게시글 보기시 문제가 발생했습니다.");
	e.printStackTrace();
}


%>

<style>
	input[type="submit"] {border:1px solid #000; width:75px; padding:50px 0; font-size:15px; background:transparent; cursor:pointer; background:#fff;}
	.alltext {display:inline-block; float:left; width:80px; margin-bottom:10px; padding:5px 0; border:1px solid #000; text-align:center;}
	table, td {border:0;}
	.btnbox {display:flex; justify-content:flex-end; padding:10px 0; border-top:1px solid #000;}
	.btn {display: block; margin-left:10px; background-color: white; border: 1px solid black; border-radius: 1px; width: 52px; cursor: pointer; padding: 3px; text-align: center;}
	.txt {width:700px; height:120px;}
</style>

<div style="width:1100px; margin:0 auto;">
	<a href="/ktbwos/bbs/free_list.jsp" class="alltext">전체글</a>
	<table width="1100" cellpadding="5">
		<tr>
			<td width="60%" style="text-align:left;"><b><%=adminId %></b></td>
			<td width="*"><b><%=pl_date %></b></td>
			<td width="10%"><b>조회수 : <%=pl_read %></b></td>
		</tr>
		<tr style="height:50px; border-top:1px solid #000; border-bottom:1px solid #000;">
			<td colspan="3" width="60%" style="text-align:left;"><%=pl_title %></td>
		</tr>
		<tr style="height:80px; border-top:1px solid #000; vertical-align:text-top;">
			<td colspan="3" width="60%" style="text-align:left;"><%=pl_content %></td>
		</tr>

	</table>
	
	<div class="btnbox">
		<div class="down" style="display: flex; width: 100%;">
			<% if (!(pl_data1.equals("") || pl_data2.equals(""))) { %>
			첨부파일1 : <a href="pds_file_download.jsp?file=<%=pl_data1 %>"><span style="margin:0 10px; color:#0093ff;"> <%=pl_data1 %></span></a> 
			첨부파일2 : <a href="pds_file_download.jsp?file=<%=pl_data2 %>" style="margin-left:10px; color:#0093ff;"> <%=pl_data2 %></a>
			<% } else if (!pl_data1.equals("") && pl_data2.equals("")) { %>
			첨부파일1 : <a href="pds_file_download.jsp?file=<%=pl_data1 %>"><span style="margin:0 10px; color:#0093ff;"> <%=pl_data1 %></span></a>
			<% } else { %>
			
			<% } %>
		</div>
		<a href="ad_pds_list.jsp<%=args %>" class="btn">목록</a>

		<a href="ad_pds_form.jsp<%=args %>&kind=up&idx=<%=idx %>" class="btn">수정</a>
				<script>
			function isDel() {
				if (confirm("정말 삭제하시겠습니까?\n삭제된 글은 되살릴 수 없습니다.")) {
					location.href = "ad_pds_proc_del.jsp?idx=<%=idx %>";
				}
			}
		</script>
		<a href="javascript:isDel();" class="btn">삭제</a>
	</div>
</div>