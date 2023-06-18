<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../_inc/inc_head.jsp" %>
<%
String args = "";
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
	#box { width:1100px; height:800px; margin:0px auto 0; border:1px solid black; font-size:15px; }
	</style>
	<div id="box">
	<br>
	&nbsp;&nbsp;제목
	&nbsp;&nbsp;<input type="text" style="width: 1000px; height: 30px;" value="">
	<br><br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" style="width: 1000px; height: 600px;" value="">
	<br><br><br>
	<div align="right">
	<input type="button" value="확인" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='ad_notice_form.jsp?kind=up<%=args%>'">
	<input type="button" value="취소" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="history.back();">
	</div>	
		
	</div>
<%@ include file="../_inc/inc_foot.jsp" %>