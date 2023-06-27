package vo;

import javax.mail.*;

public class NaverAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
	
	public NaverAuthentication() {
		passAuth = new PasswordAuthentication("solmi2012", "password");
	}
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
