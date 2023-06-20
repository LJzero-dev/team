<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
/* 닉네임 변경 처리
 - 2~20자 확인과 중복검사
 - 조건에 맞지 않을 시 변경 불가
 - 변경 처리 후 회원정보보기 화면으로 이동
*/


String mi_nick = request.getParameter("mi_nick");


System.out.println("1");

try {
	stmt = conn.createStatement();
	sql = "update t_member_info set mi_nick = '" + mi_nick + "' where mi_id = '" + loginInfo.getMi_id() + "' ";
//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);

	String mi_id = loginInfo.getMi_id();
	String mi_pw = loginInfo.getMi_pw();
	
	session.invalidate();

	System.out.println("2");
	
	out.println("<script>");
	
	
	sql = "select * from t_member_info where mi_status <> 'c' and mi_id = '" + mi_id + "' and mi_pw = '" + mi_pw + "'";
//	System.out.println(sql);
	rs = stmt.executeQuery(sql);

	System.out.println(mi_id);
	System.out.println(mi_pw);
	if (rs.next()) {	
		System.out.println(rs.getString("mi_email"));
		MemberInfo mi = new MemberInfo();
		mi.setMi_id(mi_id);
		mi.setMi_pw(mi_pw);
		mi.setMi_email(rs.getString("mi_email"));
		mi.setMi_nick(rs.getString("mi_nick"));
		mi.setMi_status(rs.getString("mi_status"));
		mi.setMi_count(rs.getInt("mi_count"));
		mi.setMi_date(rs.getString("mi_date"));
		mi.setMi_lastlogin(rs.getString("mi_lastlogin"));			
	}
	if (result == 1)
		out.println("location.href='/ktbwos/member/member_info.jsp';");
	else {
		out.println("alert('닉네임 변경에 실패했습니다.\\n다시 시도하세요');"); 
		out.println("history.back();");	
	}

	System.out.println("5");
	out.println("</script>");

} catch(Exception e) {
	out.println("닉네임 변경시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		stmt.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>

<%@ include file="../_inc/inc_foot.jsp" %>
