<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 닉네임 변경 처리
 - 2~20자 확인과 중복검사
 - 조건에 맞지 않을 시 변경 불가
 - 변경 처리 후 회원정보보기 화면으로 이동
*/

request.setCharacterEncoding("utf-8");
String mi_nick = request.getParameter("mi_nick");

try {
	stmt = conn.createStatement();
	sql = "update t_member_info set mi_nick = '" + mi_nick + "' where mi_id = '" + loginInfo.getMi_id() + "' ";
//	System.out.println(sql);
	int result = stmt.executeUpdate(sql);

	out.println("<script>");
	if (result == 1)
		out.println("location.href='/ktbwos/member/member_info.jsp';");
	else {
		out.println("alert('닉네임 변경에 실패했습니다.\\n다시 시도하세요');"); 
		out.println("history.back();");	
	}
	
	sql = "select * from t_member_info where mi_status <> 'c' and mi_id = '" + loginInfo.getMi_id() + "' and mi_pw = '" + loginInfo.getMi_pw() + "'";
//	System.out.println(sql);
	rs = stmt.executeQuery(sql);
	
	if (rs.next()) {	// 로그인 성공시
		MemberInfo mi = new MemberInfo();
		// 로그인한 회원의 정보들을 저장할 인스턴스 생성
		mi.setMi_nick(rs.getString("mi_nick"));		
		session.setAttribute("loginInfo", mi);				
	}
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
