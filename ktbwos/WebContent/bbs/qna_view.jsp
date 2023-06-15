<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>

<div style="width:1100px; margin:0 auto;">
		<style>
			.alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
		</style>
		<a href="/ktbwos/bbs/notice_list.jsp" class="alltext">전체글</a>
		<span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">공지사항</span> <!--  현재 게시판 위치 표시  -->
	<br><br><br>
	<style>
	#box { width:1100px; height:600px; margin:0px auto 0; border:1px solid black; font-size:15px; }
	</style>
	<div id="box">
		<br>
		<div style="float : left;">&nbsp;&nbsp;<%=ai_id %></div>
		<div style="float : right;"><%=nl_date %>&nbsp;&nbsp;</div>
		<br><br><hr>	
		<h4>&nbsp;&nbsp;<%=nl_title %></h4>
		<hr>
		<%=nl_content %>
		
	
		
	</div>
	<br>
	<div align="right">
<input type="button" value="글목록" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='notice_list.jsp<%=args%>'">
	</div>	
</div>


<%@ include file="_inc/inc_foot.jsp" %>