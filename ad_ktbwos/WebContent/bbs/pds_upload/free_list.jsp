<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = 1, psize = 10, bsize = 10,rcnt = 0, pcnt = 0;

if (request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));

String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String schargs = "";

%>

<style>
	input[type="submit"] {border:1px solid #000; width:60px; background:transparent; cursor:pointer; background:#fff;}
	.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
</style>

<div style="width:1100px; margin:0 auto;">
	<a href="/ktbwos/bbs/free_list.jsp" class="alltext">전체글</a>
	<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">자유게시판</span>
	<form name="frmSch" style="margin-bottom:0;">
		<fieldset style=" width:335px; margin-left:737px; background:#1E4B79;">
			<select name="schtype">
				<option>전체</option>
				<option>제목</option>
				<option>내용</option>
				<option>작성자</option>
			</select>
			<input type="text" name="keyword" value="" />
			<input type="submit" value="검색" />&nbsp;&nbsp;&nbsp;&nbsp;
		</fieldset>
	</form>
	<table width="1100" border="0" cellpadding="0" cellspacing="0" id="list">
		<tr height="30">
			<th width="10%">번호</th>
			<th width="*">제목</th>
			<th width="15%">작성자</th>
			<th width="15%">작성일</th>
			<th width="10%">조회수</th>
		</tr>
		<tr>
			<td><b>22</b></td>
			<td><a href="javascript:void(0);">자유게시판 글 입니다.</a></td>
			<td>홍길동</td>
			<td>2023-06-03</td>
			<td>20</td>
		</tr>
	</table>
	<table style="width:1100px; border:0;">
		<tr>
			<td style="width:900px; border:0;">
			</td>
			<td width="*" style="text-align:right; border:0;">
				<input type="button" value="글등록" onclick="location.href='free_form.jsp?kind=in';" />
			</td>
		</tr>
	</table>
</div>
<%@ include file="../_inc/inc_foot.jsp" %>