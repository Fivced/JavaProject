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
		this.message = "<div style=\"font-family: Arial, sans-serif; font-size: 14px; color: #333; padding: 20px; max-width: 400px;\">" +
				"<h3 style=\"color: #2e7d32; margin-bottom: 16px;\">🍕 Farina Pizza 訂位成功通知</h3>" +
				"<table style=\"width: 100%; border-collapse: collapse;\">" +
					"<tr>" +
						"<td style=\"width: 90px; padding: 4px 8px; text-align: right; font-weight: bold; vertical-align: top;\">門市：</td>" +
						"<td style=\"padding: 4px 8px; color: #750000;\">" + branch + "</td>" +
					"</tr>" +
					"<tr>" +
						"<td style=\"padding: 4px 8px; text-align: right; font-weight: bold;\">日期：</td>" +
						"<td style=\"padding: 4px 8px; color: #750000;\">" + date + "</td>" +
					"</tr>" +
					"<tr>" +
						"<td style=\"padding: 4px 8px; text-align: right; font-weight: bold;\">時間：</td>" +
						"<td style=\"padding: 4px 8px; color: #750000;\">" + time + "</td>" +
					"</tr>" +
					"<tr>" +
						"<td style=\"padding: 4px 8px; text-align: right; font-weight: bold;\">人數：</td>" +
						"<td style=\"padding: 4px 8px; color: #750000;\">" + people + "</td>" +
					"</tr>" +
					"<tr>" +
						"<td style=\"padding: 4px 8px; text-align: right; font-weight: bold;\">備註：</td>" +
						"<td style=\"padding: 4px 8px; color: #750000;\">" + note + "</td>" +
					"</tr>" +
				"</table>" +
				"<p style=\"margin-top: 16px; color: red; font-size: 13px; font-weight: bold;\">" +
					"※ 餐廳訂位只保留 10 分鐘，請準時抵達，謝謝您的配合！" +
				"</p>" +
			"</div>";
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
