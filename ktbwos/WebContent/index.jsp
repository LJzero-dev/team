<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>
<%
int num = 0;
%>

<div style="width:1100px; height:800px; margin:0 auto; border:1px solid white; ">
		<table style="width:700px; float:left; margin-top: 30px;" >
		<tr>
			<td width="15%"><h3>순위</h3></td><td width="20%"><h3>유형</h3></td><td width="*"><h3>이 달의 인기 게시판</h3></td>
		</tr>
		<% rs = conn.createStatement().executeQuery("select a.rl_ctgr, a.rl_name, a.rl_table_name from t_request_list a inner join t_best_list b on a.rl_table_name = b.bl_table_name " +
		"where a.rl_status = 'y' and date(b.bl_date) > date_add(date(now()), interval -30 day) group by a.rl_ctgr, a.rl_name, a.rl_table_name order by sum(b.bl_count) desc"); 
		while (rs.next()) {num++;%>
		<tr>
			<td><%=num %> 등</td><td><%=rs.getString(1).equals("a") ? "게임" : rs.getString(1).equals("b") ? "연예" : "스포츠"%></td><td><a href="bbs/table_list.jsp?rl_table_name=<%=rs.getString(3) %>"><%=rs.getString(2) %></a></td>
		</tr>
		<% } %>
		</table>
		
		<table style="width:700px; height:20px; float:left; border:1px solid black; margin-top: 30px;" >
			<tr>
				<td width="25%"><h3>번호</h3></td><td width="*"><h3>공지사항</h3></td><td width="25%"><h3>작성일</h3></td>
			</tr>
			<% rs = conn.createStatement().executeQuery("select nl_idx, nl_title, date(nl_date) from t_notice_list order by nl_idx desc limit 3"); 
		while (rs.next()) { %>
		<tr>
			<td><%=rs.getInt(1) %></td><td><a href="bbs/notice_view.jsp?idx=1&cpage=<%=rs.getString(1) %>"><%=rs.getString(2)%></a></td><td><%=rs.getString(3) %></td>
		</tr>
		<% } %>
		</table>		
		<table style="width:300px; border:1px solid black; float:inherit; margin: 0 auto; margin-top: 150px; ">
			<tr>
				<td width="25%"><h4>유형</h4></td><td><h4>최근 생성된 게시판</h4></td>
			</tr>
			<% rs = conn.createStatement().executeQuery("select rl_ctgr, rl_name, rl_table_name from t_request_list where rl_status = 'y' order by rl_idx desc limit 10"); 
		while (rs.next()) { %>
		<tr>
			<td><%=rs.getString(1).equals("a") ? "게임" : rs.getString(1).equals("b") ? "연예" : "스포츠"%></td><td><a href="bbs/table_list.jsp?rl_table_name=<%=rs.getString(3) %>"><%=rs.getString(2) %></a></td>
		</tr>
		<% } %>
		</table>
</div>
<%@ include file="_inc/inc_foot.jsp" %>