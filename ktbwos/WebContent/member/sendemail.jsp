<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%!	// 공용으로 사용할 메소드 선언 및 정의 영역
public String getRequest(String req) {
	return req.trim().replace("<", "&lt");	
}
%>
<%
String driver = "com.mysql.cj.jdbc.Driver";
String dbURL = "jdbc:mysql://localhost:3306/ktbwos?useUnicode=true&characterEncoding=UTF8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(dbURL, "root", "1234");
} catch (Exception e) {
	out.println("DB연결에 문제가 발생했습니다.");
	e.printStackTrace();
}

final String ROOT_URL = "/ktbwos/index.jsp"; 
boolean isLogin = false;
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
if (loginInfo != null) isLogin = true;


String loginUrl = request.getRequestURI();
if (request.getQueryString() != null)
	loginUrl += "?" + URLEncoder.encode(request.getQueryString().replace('&', '~'), "UTF-8");	// 현재 화면의 url로 로그인 폼 등에서 사용할 값
%>
<script>
function isDel(link) {
   if (confirm("정말 삭제하시겠습니까?\n삭제된 내용은 복구 불가합니다.")) {
      location.href = "'" + link + "''";
   }
}
function goLogin(link) {
   if (<%=isLogin%>) {
      confirm("로그인이 필요한 서비스 입니다. \\n 로그인 화면으로 이동하시겠습니까?") 
      location.href = "/ktbwos/login_form.jsp";
   } else {
      }
   }

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	a:link { color:black; text-decoration:none; }
	a:visited { color:black; text-decoration:none; }
	a:hover { color:black; text-decoration:underline; }
	table, th, td {
	border:2px solid black;
	border-collapse : collapse;
	}
	tr { height:30px;}
	th { background-color:#5B9BD5; color:white;}
	td { text-align:center;}
</style>
<title>1석2조</title>
</head>
<body>
<script>

//이메일 도메인
function setEmailDomain(domain) {
	document.getElementById("emaildomain").value = domain;
}

//이메일 수집동의 체크시 이메일 중복검사로 보냄
function dupEMAIL() { 
	var emailid = document.getElementById("emailid").value;
	var emaildomain = document.getElementById("emaildomain").value;
	var mi_email = emailid + "@" + emaildomain;
	
	if (emailid == "" || emaildomain == "") {
		document.getElementById("yes").checked = false;
		alert("이메일을 입력해주세요.");
	} else {
		var dup = document.getElementById("dup");
		dup.src = "dup_email_chk.jsp?mi_email=" + mi_email;
	}
}

function codeSending() {
	var emailid = document.getElementById("emailid").value;
	var emaildomain = document.getElementById("emaildomain").value;
	var email = emailid + "@" + emaildomain;
	
	var userEmail = parent.frmJoin.userEmail;
	
	if (document.getElementById("yes").checked == false){ // 이메일 수집동의를 누르지 않고 인증 코드를 누른 경우 
		if (!confirm("이메일 수집에 동의하시겠습니까?")) {	// 비동의
			document.getElementById("yes").checked = false;
		} else { // 동의했을 경우
			if (emailid == "" || emaildomain == "") {
				document.getElementById("yes").checked = false;
				alert("이메일을 입력해주세요.");
			} else {	// 동의 시킨 후 인증코드 발송
				document.getElementById("yes").checked = true;
				
				userEmail.value = email;
				send();
				alert("인증코드 발송이 완료되었습니다. ");
			}
		}
	} else {
		userEmail.value = email;
		send();
		alert("인증코드 발송이 완료되었습니다. ");
	}
}

function send() {
	var iscode = parent.frmJoin.iscode;
	const code = Math.floor(Math.random() * 89999) + 10000;
	frmmail.content.value = code;
	sessionStorage.setItem("codeSession", code);
}


</script>
<iframe src="" id="dup" style="width:300px; height:200px; border:1px black solid; display:none;" ></iframe>
<form id="frmmail" action="mailSend" method="post" >	<!-- mailSend는 서블릿 -->
<table width="1100px" cellpadding="5" >
<tr><th width="345.5px">이메일</th><td>
		<input type="text" name="emailid" id="emailid" value="" title="이메일아이디" placeholder="이메일" maxlength="18" />
		@
		<input type="text" name="emaildomain" id="emaildomain" value="" title="이메일도메인" placeholder="이메일도메인" maxlength="18" />
		
		<select title="이메일 주소 선택" onclick="setEmailDomain(this.value);">
			<option value="">직접입력</option>
			<option value="naver.com">naver.com</option>
			<option value="gmail.com">gmail.com</option>
			<option value="nate.com">nate.com</option>
		</select><br />
	</td></tr>
	
	<!-- 이메일 수집 동의 -->
	<tr><th>이메일 수집 동의 및 중복 검사</th><td>
		<input type="checkbox" id="yes" onclick="dupEMAIL();" />입력하신 이메일은 인증 및 보안 코드 전송을 위해 사용됩니다.<br />
		<input type="hidden" name="sender" value="solmi2012@naver.com" />
		<input type="hidden" name="receiver" value="" />
		<input type="hidden" name="title" value="일석이조 사이트 회원가입 이메일 인증 코드입니다. 아래의 인증코드를 인증코드 확인란에 입력해주세요." />
		<input type="hidden" name="content" value="" />
		<input type="submit" name="send" value="인증코드 발송" onclick="codeSending();" />
</table>
</form>

<%@ include file="../_inc/inc_foot.jsp" %>