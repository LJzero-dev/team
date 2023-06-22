<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
/* 회원가입 처리 파일
1. 회원이 입력한 아이디, 비밀번호, 이메일, 닉네임 받아와서 DB에 insert
*/

request.setCharacterEncoding("utf-8");
String mi_id = request.getParameter("mi_id");
String mi_pw = request.getParameter("mi_pw");
String userEmail = request.getParameter("userEmail");
String mi_nick = request.getParameter("mi_nick");

try {
	stmt = conn.createStatement();
	
	sql = "insert into t_member_info (mi_id, mi_email, mi_nick, mi_pw, mi_reason) " + 
	"values ('" + mi_id + "', '" + userEmail + "', '" + mi_nick + "', '" + mi_pw + "', '신규가입')";
//	System.out.println(sql);
	// 자유게시판 레코드 개수(검색조건 포함)를 받아 올 쿼리
	stmt.executeUpdate(sql);
	response.sendRedirect(ROOT_URL);
	
} catch(Exception e) {
	out.println("회원등록에서 문제가 발생했습니다.");
	e.printStackTrace();
}
%>
<%@ include file="../_inc/inc_foot.jsp" %>