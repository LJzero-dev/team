<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int cpage = Integer.parseInt(request.getParameter("cpage"));
int idx = Integer.parseInt(request.getParameter("idx"));
String schtype = request.getParameter("schtype");   // 검색조건
String keyword = request.getParameter("keyword");   // 검색어
String argsl = "?cpage=" + cpage;
String argsu = "?cpage=" + cpage + "&kind=up&idx=" + idx;
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
   argsl += "&schtype=" + schtype + "&keyword=" + keyword;
   argsu += "&schtype=" + schtype + "&keyword=" + keyword;
}   // 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌


String ql_title = "", ql_content = "", ql_qdate = "", mi_nick = "", ql_adate = "", ai_id = "", ql_isanswer = "", ql_answer = "";
int mi_idx = 0;


try {
   stmt = conn.createStatement();
   sql = "select b.mi_idx, b.mi_nick, a.ql_title, a.ql_content, a.ql_qdate, a.ql_isanswer, a.ql_answer, a.ql_adate" +  
         " from t_qna_list a inner join t_member_info b on a.mi_idx = b.mi_idx where ql_isview = 'y' and ql_idx =" + idx;
   rs = stmt.executeQuery(sql);
   // out.println(sql);
   if (rs.next()) {
      
      ql_content = rs.getString("ql_content").replace("\r\n", "<br>");
      // 엔터(\r\n)를 <br> 태그로 변경하여 ql_content변수에 저장
      ql_title = rs.getString("ql_title");         ql_qdate = rs.getString("ql_qdate").substring(0, 10);
      mi_idx = rs.getInt("mi_idx");               mi_nick = rs.getString("mi_nick");   
      ql_isanswer = rs.getString("ql_isanswer");      ql_answer = rs.getString("ql_answer");
      ql_adate = ql_isanswer.equals("y") ? rs.getString("ql_adate").substring(0, 10) : "";
   } else {
      out.println("<script>");
      out.println("alert('존재하지 않는 게시물입니다.');");
      out.println("history.back();");
      out.println("</script>");
      out.close();
   }
   
} catch(Exception e) {
   out.println("QnA 문제가 발생했습니다.");
   e.printStackTrace();
} finally {
   try { rs.close();   stmt.close(); } 
   catch(Exception e) {e.printStackTrace();}
}

%>


<div style="width:1100px; margin:0 auto;">
      <style>
         .alltext {display:inline-block; float:left; width:80px; padding:5px 0; border:1px solid #000; text-align:center;}
      </style>  
      <a href="/ktbwos/bbs/qna_list.jsp" class="alltext">전체글</a>
      <span style="display:inline-block; float:left; margin-top:5px; margin-left:10px;">QnA</span> <!--  현재 게시판 위치 표시  -->
   <br><br><br>
   <!-- <style>
   #box { width:1100px; height:600px; margin:0px auto 0; border:1px solid black; font-size:15px; }
   </style>  -->
   <!--  <div id="box"> -->
      <br>
      <div style="float : left;">&nbsp;&nbsp;<%=mi_nick %></div>
      <div style="float : right;"><%=ql_qdate %>&nbsp;&nbsp;</div>
      <br><br><hr>   
      <h4>&nbsp;&nbsp;<%=ql_title %></h4>
      <hr>
      <%=ql_content %>   
      <hr>
      <br>
      <%if (ql_isanswer.equals("n")) {%>
      답변대기중
      <%} else { %>
      <div style="float : left;">&nbsp;&nbsp;test1</div>
      <div style="float : right;">&nbsp;&nbsp;<%=ql_adate %></div>
      <br>
      <hr>
      <%=ql_answer %>
      <%} %>
   <!-- </div> -->
   <br><br><br>
   <div align="right">
   <input type="button" value="목록" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='qna_list.jsp<%=argsl%>'">
   <input type="button" value="수정" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='qna_form.jsp<%=argsu%>'">
   <script>
      function isDel() {
         if (confirm("정말 삭제하시겠습니까?")) {
            location.href = "qna_proc_del.jsp?idx=<%=idx%>";
         } 
      }
   </script>
   <input type="button" value="삭제" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="isDel();">

   
</div>


<%@ include file="../_inc/inc_foot.jsp" %>