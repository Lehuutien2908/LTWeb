package vn.edu.hcmuaf.fit.projectltw.service;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.InputStream;

public class EmailService {
    private static final String PROP_FILE = "email.properties";

    private static Session getSession(Properties props) {
        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(
                        props.getProperty("mail.smtp.username"),
                        props.getProperty("mail.smtp.password")
                );
            }
        });
    }

    public static void sendWelcomeEmail(String to, String name) {
        Properties props = new Properties();
        try (InputStream input = EmailService.class.getClassLoader().getResourceAsStream(PROP_FILE)) {
            if (input == null) return;
            props.load(input);

            Session session = getSession(props);
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(props.getProperty("mail.smtp.username"), "Flagship Global"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Chào mừng bạn đến với Flagship Global", "UTF-8");

            String htmlContent = "<div style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>"
                    + "<h3>Chào mừng " + name + " đến với Flagship Global!</h3>"
                    + "<p>Chúc mừng bạn đã đăng ký tài khoản thành công. Giờ đây bạn có thể khám phá và mua sắm những sản phẩm công nghệ đỉnh cao nhất.</p>"
                    + "<p>Nếu bạn có bất kỳ thắc mắc nào, đừng ngần ngại liên hệ với đội ngũ hỗ trợ của chúng tôi.</p>"
                    + "<br><p>Trân trọng,</p>"
                    + "<p><strong>Flagship Global Team</strong></p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void sendPasswordEmail(String to, String name, String newPassword) {
        Properties props = new Properties();
        try (InputStream input = EmailService.class.getClassLoader().getResourceAsStream(PROP_FILE)) {
            if (input == null) return;
            props.load(input);

            Session session = getSession(props);
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(props.getProperty("mail.smtp.username"), "Flagship Global"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Mật khẩu mới của bạn - Flagship Global", "UTF-8");

            String htmlContent = "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
                    + "<h3>Xin chào " + name + ",</h3>"
                    + "<p>Chúng tôi đã nhận được yêu cầu khôi phục mật khẩu của bạn.</p>"
                    + "<p>Mật khẩu mới của bạn là: <strong style='color: #dc3545; font-size: 18px;'>" + newPassword + "</strong></p>"
                    + "<p>Vui lòng đăng nhập và đổi lại mật khẩu ngay để đảm bảo an toàn.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}