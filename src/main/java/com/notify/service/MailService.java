package com.notify.service;

import com.notify.domain.Schedule;
import com.notify.domain.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    private final JavaMailSender mailSender;

    @Value("${mail.enabled:false}")
    private boolean mailEnabled;

    @Value("${spring.mail.username:no-reply@example.com}")
    private String fromAddress;

    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendScheduleAlarm(User user, Schedule schedule) {
        if (!mailEnabled) {
            System.out.println("[MAIL SKIPPED] to=" + user.getEmail() + ", title=" + schedule.getTitle());
            return;
        }

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromAddress);
        message.setTo(user.getEmail());
        message.setSubject("[Notify] 일정 알림: " + schedule.getTitle());
        message.setText(buildContent(schedule));
        mailSender.send(message);
    }

    private String buildContent(Schedule schedule) {
        return "일정 제목: " + schedule.getTitle() + " "
                + "일정 내용: " + (schedule.getContent() == null ? "" : schedule.getContent()) + " "
                + "시작 일시: " + schedule.getStartDatetime();
    }
}
