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
	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}

String fl_ismem = "", fl_writer = "", fl_title = "", fl_content = "", fl_ip = "", fl_date = "", nwriter = "";
int fl_read = 0,  fl_reply = 0;

try {
	stmt = conn.createStatement();
	sql = "update t_free_list set fl_read = fl_read + 1 where fl_idx = " + idx;
	stmt.executeUpdate(sql);	// 조회수 증가 쿼리 실행
	
	sql = "select * from t_free_list where fl_idx = " + idx;
	rs = stmt.executeQuery(sql);
	if (rs.next()) {
		fl_ismem = rs.getString("fl_ismem");
		fl_writer = rs.getString("fl_writer");
		fl_title = rs.getString("fl_title");
		fl_content = rs.getString("fl_content").replace("\r\n", "<br />");;
		fl_ip =	rs.getString("fl_ip");
		fl_date = rs.getString("fl_date").substring(0, 10);
		fl_read = rs.getInt("fl_read");
		fl_reply = rs.getInt("fl_reply");
		fl_ip = rs.getString("fl_ip");
		fl_ip = fl_ip.replace(":", "-");
		fl_ip = fl_ip.replace(".", "-");
		String[] iparr = fl_ip.split("-");
		if (fl_ismem.equals("n"))
			nwriter = fl_writer + " (" + iparr[0] + "." + iparr[1] + ")";
		

		
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
			<td width="60%" style="text-align:left;"><b><%=fl_ismem.equals("y") ? fl_writer : nwriter %></b></td>
			<td width="*"><b><%=fl_date %></b></td>
			<td width="10%"><b>조회수 : <%=fl_read %></b></td>
		</tr>
		<tr style="height:50px; border-top:1px solid #000; border-bottom:1px solid #000;">
			<td colspan="3" width="60%" style="text-align:left;"><%=fl_title %></td>
		</tr>
		<tr style="height:80px; border-top:1px solid #000; vertical-align:text-top;">
			<td colspan="3" width="60%" style="text-align:left;"><%=fl_content %></td>
		</tr>
	</table>
	<%
	String delLink = "";	// 수정과 삭제용 링크를 저장할 변수
	
	delLink = "ad_free_proc_del.jsp?idx=" + idx;

	%>
	<div class="btnbox">
		<a href="ad_free_list.jsp<%=args %>" class="btn">목록</a>
		<script>
			function isDel() {
				if (confirm("정말 삭제하시겠습니까?\n삭제된 글은 되살릴 수 없습니다.")) {
					location.href = "<%=delLink %>";
				}
			}
		</script>
		<a href="javascript:isDel();" class="btn delbtn">삭제</a>
	</div>

	
	<!-- 댓글 목록 영역 시작 -->
	<div id="replyBox" style="width:700px; text-align:center;">
		
		<table width="1100" cellpadding="5">
			<tr style="height:50px; border-top:1px solid #000; border-bottom:1px solid #000;">
				<td colspan="3" width="60%" style="text-align:left;">댓글 <%=fl_reply %>개</td>
			</tr>
			<%
			sql = "select * from t_free_reply where fr_isview = 'y' and fl_idx = " + idx;
			
			
			try {
				rs = stmt.executeQuery(sql);
				if (rs.next()) {	// 해당 게시글에 댓글이 있을 경우
					do {
			%>
			<%
			String delLink2 = "";	// 수정과 삭제용 링크를 저장할 변수
			
			delLink2 = "ad_free_reply_proc_del.jsp" + args + "&fl_idx=" + idx + "&fr_idx=" + rs.getInt("fr_idx");
			%>
			<tr>
				<td style="width:370px; padding: 6px;"><%=rs.getString("fr_writer") %></td>
				<td style="padding:14px 10px 14px 54px; text-align:left; vertical-align:text-top;" rowspan="2">
					<span style="display: block; width: 647px; overflow: hidden; word-wrap: break-word;"><%=rs.getString("fr_content").replace("\r\n", "<br />") %></span>
				</td>
				
				<td width="*" valign="top" rowspan="2">
					<script>
						function replyDel() {
							if (confirm("정말 삭제하시겠습니까?")) {
								location.href = "<%=delLink2 %>";
							}
						}
						
					</script>
					<button class="btn" onclick="replyDel();">삭제</button>
				</td>
			</tr>
			<tr><td><%=fl_date %></td></tr>
			<%
				
					} while(rs.next());
				} else {	// 해당 게시글에 댓글이 없을 경우
					out.println("<tr><td align='center'>댓글이 없습니다.</td></tr>");
				}
			} catch(Exception e) {
				out.println("댓글 목록에서 문제가 생겼습니다.");
				e.printStackTrace();
			} finally {
				try { rs.close();	stmt.close(); } 
				catch(Exception e) { e.printStackTrace(); }
			}  
			%>
		</table>
	</div>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>
