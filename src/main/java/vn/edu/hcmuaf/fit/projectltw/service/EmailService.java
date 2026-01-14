package vn.edu.hcmuaf.fit.projectltw.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailService {
    public static void sendPasswordEmail(String toEmail, String fullName, String password) {
        // Cấu hình SMTP của Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Đăng nhập bằng "Mật khẩu ứng dụng" (16 ký tự)
        final String user = "flagshipglobal.system32@gmail.com";
        final String pass = "mtqe qgvc lezo oosy";

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mật khẩu truy cập Flagship Global");
            message.setText("Chào " + fullName + ",\nMật khẩu của bạn là: " + password);
            Transport.send(message);
        } catch (MessagingException e) { e.printStackTrace(); }
    }
}