package com.notify.domain;

import java.time.LocalDateTime;

public class Schedule {
    private Long scheduleId;
    private Long userId;
    private String title;
    private String content;
    private LocalDateTime startDatetime;
    private LocalDateTime endDatetime;
    private LocalDateTime alarmDatetime;
    private String alarmSentYn;
    private LocalDateTime alarmSentAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Long getScheduleId() { return scheduleId; }
    public void setScheduleId(Long scheduleId) { this.scheduleId = scheduleId; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public LocalDateTime getStartDatetime() { return startDatetime; }
    public void setStartDatetime(LocalDateTime startDatetime) { this.startDatetime = startDatetime; }
    public LocalDateTime getEndDatetime() { return endDatetime; }
    public void setEndDatetime(LocalDateTime endDatetime) { this.endDatetime = endDatetime; }
    public LocalDateTime getAlarmDatetime() { return alarmDatetime; }
    public void setAlarmDatetime(LocalDateTime alarmDatetime) { this.alarmDatetime = alarmDatetime; }
    public String getAlarmSentYn() { return alarmSentYn; }
    public void setAlarmSentYn(String alarmSentYn) { this.alarmSentYn = alarmSentYn; }
    public LocalDateTime getAlarmSentAt() { return alarmSentAt; }
    public void setAlarmSentAt(LocalDateTime alarmSentAt) { this.alarmSentAt = alarmSentAt; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
