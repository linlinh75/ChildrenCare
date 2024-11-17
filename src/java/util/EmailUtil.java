package util;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailUtil {
    
    public static void sendPasswordEmail(String toEmail, String password) throws MessagingException {
        // Email configuration
        String from = "childrencaresystemse1874@gmail.com"; // Replace with your email
        final String username = "childrencaresystemse1874@gmail.com"; // Replace with your email
        final String appPassword = "your-app-password"; // Replace with your app password
        
        // Setup mail server
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        
        // Create session
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, appPassword);
            }
        });
        
        try {
            // Create message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Your Children Care System Account Password");
            
            // Create HTML content
            String htmlContent = String.format("""
                <html>
                    <body style="font-family: Arial, sans-serif; padding: 20px;">
                        <div style="max-width: 600px; margin: 0 auto; background-color: #f9f9f9; padding: 20px; border-radius: 10px;">
                            <h2 style="color: #2c3e50; text-align: center;">Welcome to Children Care System</h2>
                            <p>Your account has been created successfully.</p>
                            <div style="background-color: #ffffff; padding: 15px; border-radius: 5px; margin: 20px 0;">
                                <p style="margin: 0;">Your login credentials:</p>
                                <p style="margin: 10px 0;"><strong>Email:</strong> %s</p>
                                <p style="margin: 10px 0;"><strong>Password:</strong> %s</p>
                            </div>
                            <p style="color: #e74c3c;"><strong>Important:</strong> Please change your password after logging in for security purposes.</p>
                            <p style="text-align: center; margin-top: 30px; color: #7f8c8d;">
                                If you didn't request this account, please contact our support team.
                            </p>
                        </div>
                    </body>
                </html>
                """, toEmail, password);
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            // Send message
            Transport.send(message);
            
            System.out.println("Password email sent successfully to " + toEmail);
            
        } catch (MessagingException e) {
            System.out.println("Failed to send password email: " + e.getMessage());
            throw e;
        }
    }
} 