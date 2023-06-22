<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	int cpage = Integer.parseInt(request.getParameter("cpage"));
	int idx = Integer.parseInt(request.getParameter("idx"));
	String schtype = request.getParameter("schtype"); // 검색조건
	String keyword = request.getParameter("keyword"); // 검색어
	String rl_table_name = request.getParameter("rl_table_name");
	String rl_reply_use = "", rl_reply_write = "";
	String args = "?cpage=" + cpage;
	if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
		args += "&schtype=" + schtype + "&keyword=" + keyword;
		// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
	}
	String delLink = "ctgr_proc_del.jsp?idx=" + idx + "&rl_table_name=" + rl_table_name;

	String ismem = "", writer = "", title = "", content = "", ip = "", date = "", nwriter = "";
	int read = 0, reply = 0;

	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select rl_reply_use, rl_reply_write from t_request_list where rl_table_name = '"
				+ rl_table_name + "' ");
		rs.next();
		rl_reply_use = rs.getString(1);
		rl_reply_write = rs.getString(2);

		sql = "update t_" + rl_table_name + "_list set " + rl_table_name + "_read = " + rl_table_name
				+ "_read + 1 where " + rl_table_name + "_idx = " + idx;
		stmt.executeUpdate(sql); // 조회수 증가 쿼리 실행

		sql = "select * from t_" + rl_table_name + "_list where " + rl_table_name + "_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if (rs.next()) {
			ismem = rs.getString(rl_table_name + "_ismem");
			writer = rs.getString(rl_table_name + "_writer");
			title = rs.getString(rl_table_name + "_title");
			content = rs.getString(rl_table_name + "_content").replace("\r\n", "<br />");;
			date = rs.getString(rl_table_name + "_date").substring(0, 10);
			read = rs.getInt(rl_table_name + "_read");
			reply = rs.getInt(rl_table_name + "_reply");

			ip = rs.getString(rl_table_name + "_ip");
			ip = ip.replace(":", "-");
			ip = ip.replace(".", "-");
			String[] iparr = ip.split("-");
			if (ismem.equals("n")) {
				nwriter = writer + " (" + iparr[0] + "." + iparr[1] + ")";
			}

		} else {
			out.println("<script>");
			out.println("alert('존재하지 않는 게시물입니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

	} catch (Exception e) {
		out.println("게시글 보기시 문제가 발생했습니다.");
		e.printStackTrace();
	}
%>
<style>
input[type="submit"] {
	border: 1px solid #000;
	width: 75px;
	padding: 50px 0;
	font-size: 15px;
	background: transparent;
	cursor: pointer;
	background: #fff;
}

.alltext {
	display: inline-block;
	float: left;
	width: 80px;
	margin-bottom: 10px;
	padding: 5px 0;
	border: 1px solid #000;
	text-align: center;
}

table, td {
	border: 0;
}

.btnbox {
	display: flex;
	justify-content: flex-end;
	padding: 10px 0;
	border-top: 1px solid #000;
}

.btn {
	display: block;
	margin-left: 10px;
	background-color: white;
	border: 1px solid black;
	border-radius: 1px;
	width: 52px;
	cursor: pointer;
	padding: 3px;
	text-align: center;
}

.txt {
	width: 700px;
	height: 120px;
}
</style>
<script>
function goLogin() {
	if (confirm("로그인이 필요합니다.\n로그인 화면으로 이동하시겠습니까?")) {
		location.href = "../login_form.jsp?";
	}
}
</script>
<div style="width: 1100px; margin: 0 auto;">
	<a href="/ad_ktbwos/bbs/table_list.jsp?rl_table_name=<%=rl_table_name%>"
		class="alltext">전체글</a>
	<table width="1100" cellpadding="5">
		<tr>
			<td width="60%" style="text-align: left;"><b><%=ismem.equals("y") ? writer : nwriter%></b></td>
			<td width="*"><b><%=date%></b></td>
			<td width="10%"><b>조회수 : <%=read%></b></td>
		</tr>
		<tr
			style="height: 50px; border-top: 1px solid #000; border-bottom: 1px solid #000;">
			<td colspan="3" width="60%" style="text-align: left;"><%=title%></td>
		</tr>
		<tr
			style="height: 80px; border-top: 1px solid #000; vertical-align: text-top;">
			<td colspan="3" width="60%" style="text-align: left;"><%=content%></td>
		</tr>
	</table>



	<div class="btnbox">
		<a href="table_list.jsp<%=args%>&rl_table_name=<%=rl_table_name%>"
			class="btn">목록</a>
		<script>
			function isDel() {
				if (confirm("정말 삭제하시겠습니까?\n삭제된 글은 되살릴 수 없습니다.")) {
					location.href = "<%=delLink%>";
				}
			}						
		</script>
		<a href="javascript:isDel();" class="btn">삭제</a>
	</div>
	<%
		if (rl_reply_use.equals("y")) {
	%>
	<!-- 댓글 목록 영역 시작 -->
	<div id="replyBox" style="width: 700px; text-align: center;">

		<table width="1100" cellpadding="5">
			<tr
				style="height: 50px; border-top: 1px solid #000; border-bottom: 1px solid #000;">
				<td colspan="3" width="60%" style="text-align: left;">댓글 <%=reply%>개
				</td>
			</tr>
			<%
				sql = "select * from t_" + rl_table_name + "_reply where " + rl_table_name + "r_isview = 'y' and "
							+ rl_table_name + "_idx = " + idx;

					try {
						rs = stmt.executeQuery(sql);
						if (rs.next()) { // 해당 게시글에 댓글이 있을 경우
							do {
			%>
			<%
				String delLink2 = "ctgr_reply_proc.jsp" + args + "&kind=del&idx=" + idx + "&"
										+ rl_table_name + "r_idx=" + rs.getInt(rl_table_name + "r_idx") + "&rl_table_name="
										+ rl_table_name;
								ip = rs.getString(rl_table_name + "r_ip");
								ip = ip.replace(":", "-");
								ip = ip.replace(".", "-");
								String[] iparr = ip.split("-");
								if (rs.getString(rl_table_name + "r_ismem").equals("n")) {
									nwriter = rs.getString(rl_table_name + "r_writer") + " (" + iparr[0] + "." + iparr[1]
											+ ")";
								}
			%>
			<tr>
				<td style="width: 370px; padding: 6px;"><%=(rs.getString(rl_table_name + "r_ismem").equals("y"))
									? rs.getString(rl_table_name + "r_writer")
									: nwriter%></td>
				<td
					style="padding: 14px 10px 14px 54px; text-align: left; vertical-align: text-top;"
					rowspan="2"><span
					style="display: block; width: 647px; overflow: hidden; word-wrap: break-word;"><%=rs.getString(rl_table_name + "r_content").replace("\r\n", "<br />")%></span>
				</td>

				<td width="*" valign="top" rowspan="2"><script>
						function replyDel() {
							if (confirm("정말 삭제하시겠습니까?")) {
								location.href = "<%=delLink2%>";
						}
					}
				</script>
					<button class="btn" onclick="replyDel();">삭제</button></td>
			</tr>
			<tr>
				<td><%=date%></td>
			</tr>
			<%
				} while (rs.next());
						} else { // 해당 게시글에 댓글이 없을 경우
							out.println("<tr><td align='center'>댓글이 없습니다.</td></tr>");
						}
					} catch (Exception e) {
						out.println("댓글 목록에서 문제가 생겼습니다.");
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
		</table>
	</div>
	<%
		}
	%>
</div>
<%@ include file="../_inc/inc_foot.jsp"%>
