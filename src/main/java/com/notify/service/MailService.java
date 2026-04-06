package com.notify.service;

import com.notify.domain.Schedule;
import com.notify.domain.User;
import com.resend.Resend;
import com.resend.core.exception.ResendException;
import com.resend.services.emails.model.CreateEmailOptions;
import com.resend.services.emails.model.CreateEmailResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class MailService {

    @Value("${mail.enabled:false}")
    private boolean mailEnabled;

    @Value("${RESEND_API_KEY:}")
    private String resendApiKey;

    @Value("${RESEND_FROM_EMAIL:}")
    private String fromEmail;

    public void sendScheduleAlarm(User user, Schedule schedule) {
        if (!mailEnabled) {
            System.out.println("[MAIL SKIPPED] mail.enabled=false, to=" + user.getEmail());
            return;
        }

        if (resendApiKey == null || resendApiKey.isBlank()) {
            throw new RuntimeException("RESEND_API_KEY가 설정되지 않았습니다.");
        }

        if (fromEmail == null || fromEmail.isBlank()) {
            throw new RuntimeException("RESEND_FROM_EMAIL이 설정되지 않았습니다.");
        }

        try {
            Resend resend = new Resend(resendApiKey);

            CreateEmailOptions params = CreateEmailOptions.builder()
                    .from("Notify 알림 서비스 <" + fromEmail + ">")
                    .to(user.getEmail())
                    .subject("[Notify] 일정 알림 - " + safe(schedule.getTitle()))
                    .html(buildHtmlContent(schedule))
                    .text(buildTextContent(schedule))
                    .build();

            CreateEmailResponse response = resend.emails().send(params);

            System.out.println("[MAIL SENT] to=" + user.getEmail()
                    + ", scheduleId=" + schedule.getScheduleId()
                    + ", resendId=" + response.getId());

        } catch (ResendException e) {
            e.printStackTrace();
            throw new RuntimeException("Resend 메일 발송 실패", e);
        }
    }

    private String buildHtmlContent(Schedule schedule) {
        String title = escapeHtml(safe(schedule.getTitle()));
        String content = schedule.getContent() == null || schedule.getContent().trim().isEmpty()
                ? "없음"
                : escapeHtml(schedule.getContent()).replace("\n", "<br>");

        String startDatetime = formatDateTime(schedule.getStartDatetime());
        String endDatetime = schedule.getEndDatetime() == null ? "미설정" : formatDateTime(schedule.getEndDatetime());
        String alarmDatetime = schedule.getAlarmDatetime() == null ? "미설정" : formatDateTime(schedule.getAlarmDatetime());

        return ""
                + "<!DOCTYPE html>"
                + "<html lang='ko'>"
                + "<head><meta charset='UTF-8'></head>"
                + "<body style='margin:0;padding:0;background:#f4f7fb;font-family:Arial,sans-serif;'>"
                + "  <div style='max-width:640px;margin:40px auto;background:#ffffff;border-radius:20px;overflow:hidden;"
                + "box-shadow:0 8px 24px rgba(15,23,42,0.08);'>"
                + "    <div style='background:linear-gradient(135deg,#0f172a 0%,#1d4ed8 100%);padding:28px 32px;color:#fff;'>"
                + "      <h1 style='margin:0;font-size:24px;'>Notify</h1>"
                + "      <p style='margin:8px 0 0;font-size:14px;opacity:0.9;'>일정 알림 안내 메일입니다.</p>"
                + "    </div>"
                + "    <div style='padding:32px;'>"
                + "      <p style='margin:0 0 20px;font-size:15px;color:#334155;'>안녕하세요.<br>등록하신 일정 알림을 안내드립니다.</p>"
                + "      <div style='border:1px solid #e2e8f0;border-radius:16px;overflow:hidden;'>"
                + "        <div style='padding:16px 20px;background:#f8fafc;border-bottom:1px solid #e2e8f0;'>"
                + "          <div style='font-size:13px;color:#64748b;margin-bottom:6px;'>일정 제목</div>"
                + "          <div style='font-size:18px;font-weight:700;color:#0f172a;'>" + title + "</div>"
                + "        </div>"
                + "        <div style='padding:16px 20px;border-bottom:1px solid #e2e8f0;'>"
                + "          <div style='font-size:13px;color:#64748b;margin-bottom:6px;'>일정 내용</div>"
                + "          <div style='font-size:14px;color:#334155;line-height:1.7;'>" + content + "</div>"
                + "        </div>"
                + "        <div style='padding:16px 20px;border-bottom:1px solid #e2e8f0;'>"
                + "          <div style='font-size:13px;color:#64748b;margin-bottom:6px;'>시작 일시</div>"
                + "          <div style='font-size:14px;color:#0f172a;font-weight:600;'>" + startDatetime + "</div>"
                + "        </div>"
                + "        <div style='padding:16px 20px;border-bottom:1px solid #e2e8f0;'>"
                + "          <div style='font-size:13px;color:#64748b;margin-bottom:6px;'>종료 일시</div>"
                + "          <div style='font-size:14px;color:#0f172a;font-weight:600;'>" + endDatetime + "</div>"
                + "        </div>"
                + "        <div style='padding:16px 20px;'>"
                + "          <div style='font-size:13px;color:#64748b;margin-bottom:6px;'>알림 일시</div>"
                + "          <div style='font-size:14px;color:#1d4ed8;font-weight:700;'>" + alarmDatetime + "</div>"
                + "        </div>"
                + "      </div>"
                + "      <p style='margin:24px 0 0;font-size:12px;color:#94a3b8;'>본 메일은 Notify 프로젝트에서 자동 발송되었습니다.</p>"
                + "    </div>"
                + "  </div>"
                + "</body>"
                + "</html>";
    }

    private String buildTextContent(Schedule schedule) {
        return "안녕하세요.\n"
                + "등록하신 일정 알림을 안내드립니다.\n\n"
                + "일정 제목: " + safe(schedule.getTitle()) + "\n"
                + "일정 내용: " + safeContent(schedule.getContent()) + "\n"
                + "시작 일시: " + formatDateTime(schedule.getStartDatetime()) + "\n"
                + "종료 일시: " + (schedule.getEndDatetime() == null ? "미설정" : formatDateTime(schedule.getEndDatetime())) + "\n"
                + "알림 일시: " + (schedule.getAlarmDatetime() == null ? "미설정" : formatDateTime(schedule.getAlarmDatetime())) + "\n";
    }

    private String formatDateTime(LocalDateTime dateTime) {
        if (dateTime == null) {
            return "미설정";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dateTime.format(formatter);
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }

    private String safeContent(String value) {
        return value == null || value.trim().isEmpty() ? "없음" : value;
    }

    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}