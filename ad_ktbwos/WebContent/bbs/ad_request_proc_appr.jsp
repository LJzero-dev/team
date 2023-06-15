<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
if (!isLogin) {
	out.println("<script>");
	out.println("alert('로그인 후 이용 부탁드립니다.'); history.back();");
	out.println("</script>");	
	out.close();
}
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");	// 검색 조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "?cpage=" + cpage + "&idx=" + idx;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌
}






String rl_table_name = request.getParameter("rl_table_name");




try {
	int count = 0, count2 = 0;
	
	stmt = conn.createStatement();
	rs = stmt.executeQuery("show tables");
	while (rs.next()) count++;
	
	rs = stmt.executeQuery("select * from t_request_list where rl_idx = " + idx);
	rs.next();

	String rl_idx = rs.getString("rl_idx");
	String rl_ctgr = rs.getString("rl_ctgr");
	String rl_title = rs.getString("rl_title");
	String rl_name = rs.getString("rl_name");
	String rl_writer = rs.getString("rl_writer");
	String rl_write = rs.getString("rl_write");
	String rl_reply_use = rs.getString("rl_reply_use");
	String rl_reply_write = rs.getString("rl_reply_write");
	String rl_isview = rs.getString("rl_isview");
	String rl_date = rs.getString("rl_date");
	
	sql = "create table t_" + rl_table_name + "_list (" +
			rl_table_name + "_idx int primary key auto_increment,rl_idx int not null,"+
			rl_table_name + "_ctgr char(1) not null,"+
			rl_table_name + "_ismem char(1) default 'y',"+
			rl_table_name + "_writer varchar(20) not null,"+
			rl_table_name + "_pw varchar(20),"+
			rl_table_name + "_title varchar(100) not null,"+
			rl_table_name + "_content text not null,"+
			rl_table_name + "_reply int default 0,"+
			rl_table_name + "_read int default 0,"+
			rl_table_name + "_ip varchar(15) not null,"+
			rl_table_name + "_isview char(1) default 'y',"+
			rl_table_name + "_date datetime default now(),"+
		"constraint fk_t_" + rl_table_name + "_list_rl_idx foreign key(rl_idx) references t_request_list(rl_idx))";	
	stmt.executeUpdate(sql);
	
	sql = "update t_request_list set rl_table_name = '" + rl_table_name + "', rl_status = 'y' where rl_idx = " + idx;	
		stmt.executeUpdate(sql);
	
	
	if (rl_reply_use.equals("y")) {
		sql = "create table t_"+ rl_table_name + "_reply (" +
		rl_table_name + "r_idx int primary key auto_increment,"+
		rl_table_name + "_idx int not null," +
		rl_table_name + "r_ismem char(1) default 'y'," +
		rl_table_name + "r_writer varchar(20) not null," +
		rl_table_name + "r_pw varchar(20)," +
		rl_table_name + "r_content varchar(200) not null," +
		rl_table_name + "r_ip varchar(15) not null," +
		rl_table_name + "r_isview char(1) default 'y'," +
		rl_table_name + "r_date datetime default now()," +
	    "constraint " + rl_table_name + "_idx foreign key(" + rl_table_name + "_idx) references t_"+ rl_table_name + "_list(" + rl_table_name + "_idx))";
		stmt.executeUpdate(sql);
	}
	rs = stmt.executeQuery("show tables");
	while (rs.next()) count2++;			
	if (count != count2 ) {
		out.println("<script>");
		out.println("location.replace('request_view.jsp" + args + "');");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('게시판 제작에 실패했습니다.\n다시 시도하세요');");
		out.println("history.back();");
		out.println("</script>");
		out.close();
	}	
} catch (Exception e) {
	out.println("요청 게시판 제작시 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>