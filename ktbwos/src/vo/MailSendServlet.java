package vo;

import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/member/mailSend")
public class MailSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MailSendServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		String emailid = request.getParameter("emailid");
		String emaildomain = request.getParameter("emaildomain");
		String email = emailid + "@" + emaildomain;
		
		String sender = request.getParameter("sender");
		String receiver = email;
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.naver.com");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "587");
			
			Authenticator auth = new NaverAuthentication();
			Session s = Session.getDefaultInstance(properties, auth);
			Message msg = new MimeMessage(s);
			Address senderAddr = new InternetAddress(sender);
			Address receiverAddr = new InternetAddress(receiver);
			
			msg.setHeader("content-type", "text/html; charset=utf-8");
			msg.setFrom(senderAddr);
			msg.addRecipient(Message.RecipientType.TO, receiverAddr);
			msg.setSubject(title);
			msg.setContent(content, "text/html; charset=utf-8");
			msg.setSentDate(new java.util.Date());
			
			Transport.send(msg);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.println("<script>");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}
