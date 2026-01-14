package vn.edu.hcmuaf.fit.projectltw.service;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.InputStream;

public class EmailService {
    private static final String PROP_FILE = "email.properties";

    public static void sendPasswordEmail(String to, String name, String newPassword) {
        Properties props = new Properties();
        try (InputStream input = EmailService.class.getClassLoader().getResourceAsStream(PROP_FILE)) {
            if (input == null) {
                System.out.println("Không tìm thấy file " + PROP_FILE);
                return;
            }
            props.load(input);

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    // Đọc từ file .properties
                    return new PasswordAuthentication(props.getProperty("mail.smtp.username"),
                            props.getProperty("mail.smtp.password"));
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(props.getProperty("mail.smtp.username")));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Mật khẩu mới của bạn - ProjectLTW");
            message.setText("Chào " + name + ",\n\nMật khẩu mới của bạn là: " + newPassword);

            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}