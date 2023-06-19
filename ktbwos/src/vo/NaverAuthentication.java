package vo;

import javax.mail.*;

public class NaverAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
	
	public NaverAuthentication() {
		passAuth = new PasswordAuthentication("solmi2012", "8301425a!");
	}
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
