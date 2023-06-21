package vo;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;


@WebServlet("/uploadPartProc")
@MultipartConfig(
	fileSizeThreshold = 0,
<<<<<<< HEAD
	location = "E:/team/ad_ktbwos/WebContent/bbs/pds_upload"
)
=======
	location = "E:/esm/projectcode/ad_ktbwos/WebContent/bbs/pds_upload"
)	
>>>>>>> origin/main
public class UploadPartProc extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UploadPartProc() { super(); }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		String pl_title = request.getParameter("pl_title");
		String pl_content = request.getParameter("pl_content");
		String pl_data1 = "";
		String pl_data2 = "";
		String driver = "com.mysql.cj.jdbc.Driver";
		String dbURL = "jdbc:mysql://localhost:3306/ktbwos?useUnicode=true&characterEncoding=UTF8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(dbURL, "root", "1234");
		} catch(Exception e) {
			e.printStackTrace();
		} 
	
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String uploadFiles = "";	// ���ε��� ���ϵ��� �̸��� �����Ͽ� ������ ����

		if (!uploadFiles.equals(""))	uploadFiles = uploadFiles.substring(2);
		
		if (kind.equals("in")) {
			// kind�� "in"�� ���� ó���� �߰� 
		    
			for (Part part : request.getParts()) {
				// getParts() : ����ڰ� ���� ������(��Ʈ��)���� Collection<Part>�� ��� ����
				// getParts()�� �޾ƿ� Part��ü���� �ϳ��� Part�� �ν��Ͻ� part�� ��� ������ ��
				if (part.getName().startsWith("pl_data")) {
					String cd =  part.getHeader("content-disposition");
					// ��) form-data; name="file1"; filename="���ε��ϴ����ϸ�.Ȯ����"
					// file ��ü�� ������� from-data; name="file1"; filename=""
					String uploadName = getUploadFileName(cd);
					if (!uploadName.equals("")) {
					// ���ε��� ������ ������
						uploadFiles += ", " + uploadName;
						if (pl_data1.equals("")) { 
		                    pl_data1 = uploadName;  // ù ��° ���� ����
		                } else {
		                    pl_data2 = uploadName;  // �� ��° ���� ����
		                }
		                part.write(uploadName);
					}
					
				}
					
			}
	        request.setAttribute("pl_data1", pl_data1);
	        request.setAttribute("pl_data2", pl_data2);
	        
	        try {
	        	stmt = conn.createStatement();
	        	int idx = 1;
	        	sql = "select max(pl_idx) + 1 from t_pds_list";
	        	rs = stmt.executeQuery(sql);
	        	if (rs.next())	idx = rs.getInt(1);
	        	
	        	sql = "insert into t_pds_list (ai_idx, pl_title, pl_content, pl_data1, pl_data2) values (?, ?, ?, ?, ?)";
	        			
	        	System.out.println(sql);
	        	
	        	PreparedStatement pstmt = conn.prepareStatement(sql);
	        	pstmt.setInt(1, 1);
	        	pstmt.setString(2, pl_title);
	        	pstmt.setString(3, pl_content);
	        	pstmt.setString(4, pl_data1);
	        	pstmt.setString(5, pl_data2);

	        	int result = pstmt.executeUpdate();
	        	 
	        	if (result == 1) {
	        		response.sendRedirect("/ad_ktbwos/bbs/ad_pds_view.jsp?cpage=1&idx=" + idx);
	        	} else {
	        		out.println("<script>");
	        		out.println("alert('�Խñ�  ��Ͽ� �����߽��ϴ�.\\n�ٽ� �õ��ϼ���.');");
	        		out.println("history.back();");
	        		out.println("</script>");
	        		out.close();
	        	}
	        	
	        } catch (Exception e) {
	        	out.println("�Խñ� ��Ͻ� ������ �߻��߽��ϴ�.");
	        	e.printStackTrace();
	        } finally {
	        	try {
	        		rs.close();		stmt.close();
	        	} catch(Exception e) {
	        		e.printStackTrace();
	        	}
	        }

	        
		} else if (kind.equals("up")) {
		    // ���� ���� ���� ���� �߰�
		    String deleteFile1 = request.getParameter("deleteFile1");
		    String deleteFile2 = request.getParameter("deleteFile2");
		    
		    if (deleteFile1 != null && !deleteFile1.isEmpty()) {
		        deleteFile("E:/lhn/web/ad_ktbwos/WebContent/bbs/pds_upload/" + deleteFile1);
		        pl_data1 = "";
		    }
		    
		    if (deleteFile2 != null && !deleteFile2.isEmpty()) {
		        deleteFile("E:/lhn/web/ad_ktbwos/WebContent/bbs/pds_upload/" + deleteFile2);
		        pl_data2 = "";
		    }
		    
			for (Part part : request.getParts()) {
				if (part.getName().startsWith("pl_data")) {
					String cd =  part.getHeader("content-disposition");
					String uploadName = getUploadFileName(cd);
					if (!uploadName.equals("")) {
						uploadFiles += ", " + uploadName;
						if (pl_data1.equals("")) { 
		                    pl_data1 = uploadName;  // ù ��° ���� ����
		                } else {
		                    pl_data2 = uploadName;  // �� ��° ���� ����
		                }
		                part.write(uploadName);
					}
					
				}
			}
	        request.setAttribute("pl_data1", pl_data1);
	        request.setAttribute("pl_data2", pl_data2);
	        
	        try {
	        	stmt = conn.createStatement();
	        	int cpage = Integer.parseInt(request.getParameter("cpage"));
	        	int idx = Integer.parseInt(request.getParameter("idx"));
	        	String args = "?cpage=" + cpage + "&idx=" + idx; 
	        	sql = "update t_pds_list set " + "pl_title = '" + pl_title	+ "', pl_content = '" + pl_content + "', pl_data1 = '" + pl_data1 + "', pl_data2 = '" + pl_data2 + "' " + " where pl_idx = " + idx;
	        	System.out.println(sql);
	        	
	        	int result = stmt.executeUpdate(sql);
	        	out.println("<script>");
	        	if (result == 1) {
	        		out.println("location.replace('bbs/ad_pds_view.jsp" + args + "');");
	        	} else {
	        		out.println("alert('�Խñ� ������ �����߽��ϴ�.\\n�ٽ� �õ��ϼ���.');");
	        		out.println("history.back();");
	        	}
	        	out.println("</script>");
	        	
	        } catch(Exception e) {
	        	out.println("�Խñ� ������ ������ �߻��߽��ϴ�.");
	        	e.printStackTrace();
	        } finally {
	        	try {
	        		stmt.close();
	        	} catch(Exception e) {
	        		e.printStackTrace();
	        	}
	        }
	  
		}
		
	}
	private String getUploadFileName(String cd) {
		String uploadName = null;
		String[] arrContent = cd.split(";");
		
		int fIdx = arrContent[2].indexOf("\"");
		int sIdx = arrContent[2].lastIndexOf("\"");
		
		uploadName = arrContent[2].substring(fIdx + 1, sIdx);
		return uploadName;
	}
	
	private void deleteFile(String filePath) {
	    File file = new File(filePath);
	    if (file.exists()) {
	        file.delete();
	    }
	}
}