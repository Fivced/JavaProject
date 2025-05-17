package javaMail;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class Sendmail {
	private final String account = "kenny199611081158@gmail.com";
	private final String password = "wvum xayu fhwx cagi";
	
	private String host = "smtp.gmail.com";
	private int port = 587;
	
	private String message;
	
	public void setMessage(int num) {
		this.message = "<p><b>驗證碼：</b></p><p><span style=\"font-size:24px; color:#000000; font-weight:bold; font-family:Arial;\">" + num + "</span></p>";
	}
	
	public void setMessage(String branch, String date, String time, String people, String note) {
		this.message = "<p><b>Farina Pizza：</b></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">餐廳門市："
				+ "<span style=\"color:#750000;\">"+branch
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">日期："
				+ "<span style=\"color:#750000;\">"+date
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">時間："
				+ "<span style=\"color:#750000;\">"+time
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">人數："
				+ "<span style=\"color:#750000;\">"+people
				+ "</span></p><p style=\"font-size:12px; color:#000000; font-weight:bold; font-family:Arial;\">備註："
				+ "<span style=\"color:#750000;\">"+note
				+"</span></p></p><p style=\"font-size:12px; color:red; font-weight:bold; font-family:Arial;\">餐廳訂位只保留10分鐘，請顧客們準時抵達，謝謝~";
	}
     
	public String send( String email ) {
		
		String result = "";
		Properties props = new Properties();
		props.put("mail.smtp.host",host);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		try {
			Session s = Session.getInstance(props,new Authenticator(){
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(account,password);
				}
			});
			
		 	MimeMessage msg= new MimeMessage(s);
		 	
		 	msg.setFrom(new InternetAddress(account, "Farina Pizza"));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			msg.setSubject("訂位資訊");
			msg.setSentDate(new Date());
			
		 	MimeBodyPart htmlPart = new MimeBodyPart();
			htmlPart.setContent(message,"text/html;charset=UTF-8");
			
			Multipart multiPart = new MimeMultipart();	
			multiPart.addBodyPart(htmlPart);
			
			msg.setContent(multiPart); 
			
			Transport.send(msg); 
			
			result = "success";
		}
		catch ( Exception e ) {
			result = "error：" + e.getMessage();
	        e.printStackTrace();
		}
		return result;
	}	
}
