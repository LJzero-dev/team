<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>

<% if (isLogin) { %>
<%=loginInfo.getMi_id() %>(<%=loginInfo.getMi_name() %>)님 환영합니다.<br />
<%=loginInfo.getMi_id() %>님이 보유하신 포인트는 현재 총 <%=loginInfo.getMi_point() %>point 입니다.<br />
<a href="logout.jsp">로그아웃</a>
<% } else { %>
<a href="login_form.jsp">로그인</a><br /><hr />
<a href="/jspSite/member/join_form.jsp">회원가입</a>
<% } %>
<hr />
<a href="bbs/notice_list.jsp">공지 사항</a>
<hr />
<a href="bbs/free_list.jsp">자유게시판</a>
<%@ include file="_inc/inc_foot.jsp" %>