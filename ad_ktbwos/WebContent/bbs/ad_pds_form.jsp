<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String kind = request.getParameter("kind");
String caption = "등록";	
String action = "/ad_ktbwos/uploadPartProc?kind=in";	
String pl_title = "", pl_content = "", pl_date = "", pl_data1 = "", pl_data2 = "";

int idx = 0;	// 글번호를 저장할 변수로 '수정'일 경우에만 사용됨
int cpage = 1;	// 페이지 번호를 저장할 변수로 '수정'일 경우에만 사용됨
String schtype = request.getParameter("schtype");	// 검색조건
String keyword = request.getParameter("keyword");	// 검색어
String args = "";
if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}	// 링크에 검색 관련 값들을 쿼리스트링으로 연결해줌

if (kind.equals("up")) {
	caption = "수정";
	action = "/ad_ktbwos/uploadPartProc?kind=up";	
	
	idx = Integer.parseInt(request.getParameter("idx"));
	cpage = Integer.parseInt(request.getParameter("cpage"));
	
	sql = "select * from t_pds_list where pl_isview = 'y' and pl_idx = " + idx;
	
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if (rs.next()) {	// 게시글이 있으면
			pl_title = rs.getString("pl_title");
			pl_content = rs.getString("pl_content");
			pl_date = rs.getString("pl_date").substring(0, 10);
			pl_data1 = rs.getString("pl_data1");
			pl_data2 = rs.getString("pl_data2");
	
		} else {
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	} catch(Exception e) {
		out.println("게시글 수정폼에서 문제가 발생했습니다.");
		e.printStackTrace();
	} finally {
		try { rs.close();	stmt.close(); } 
		catch(Exception e) { e.printStackTrace(); }
	} 
	
}
%>

<form action="<%=action %>" method="post" enctype="multipart/form-data">
<% if (kind.equals("up")) { %>
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="cpage" value="<%=cpage %>" />

<% 	if (schtype != null && !schtype.equals("") && keyword != null && !keyword.equals("")) { %>
<input type="hidden" name="schtype" value="<%=schtype %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />
<%	
	} 
}
%>
<div style="width:1100px; margin:0 auto;">
	<table width="1100" cellpadding="5">
		<tr>
			<th width="60">제목</th>
			<td colspan="3"><input type="text" name="pl_title" size="60" value="<%=pl_title %>" style="width:100%; height:30px; border:0;" placeholder="제목을 입력해주세요." ></td>
		</tr>
		<tr>
			<th>글내용</th>
			<td colspan="3"><textarea name="pl_content" style="width:100%; height:600px;"><%=pl_content %></textarea></td>
		</tr>
		<tr>
			<th>파일1</th>
			<td style="text-align:left;">
				<input  type="file" id="input_file1" value="<%=pl_data1 %>" name="pl_data1" style="display:none"/>
				<label for="input_file1" id="label_file1">파일선택1 <%=pl_data1 %></label>
			</td>
		</tr>
		<tr>
			<th>파일2</th>
			<td style="text-align:left;">
				<input type="file" id="input_file2" value="<%=pl_data2 %>" name="pl_data2" style="display:none"/>
				<label for="input_file2" id="label_file2">파일선택2 <%=pl_data2 %></label>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="text-align:right;">
				<input type="submit" value="<%=caption %>" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" />&nbsp;
				<input type="reset" value="취소" style="background-color: white; border: 1px solid black; border-radius: 1px; cursor: pointer;" onclick="location.href='ad_pds_list.jsp?cpage=<%=cpage + args %>';" />
			</td>
		</tr>
	</table>
</div>
</form>
<script>
  function displayFileName(inputId, labelId) {
    var input = document.getElementById(inputId);
    var label = document.getElementById(labelId);
    
    input.addEventListener('change', function() {
      if (input.files.length > 0) {
        label.innerHTML = input.files[0].name;
      } else {
        label.innerHTML = '';
      }
    });
  }
  
  // 예시: 파일 1 선택 시 라벨 변경
  displayFileName('input_file1', 'label_file1');
  
  // 예시: 파일 2 선택 시 라벨 변경
  displayFileName('input_file2', 'label_file2');
</script>
<%@ include file="../_inc/inc_foot.jsp" %>