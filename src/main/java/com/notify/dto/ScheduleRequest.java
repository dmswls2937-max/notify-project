package com.notify.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;

public class ScheduleRequest {
    @NotBlank
    private String title;
    private String content;
    @NotNull
    private LocalDateTime startDatetime;
    private LocalDateTime endDatetime;
    private LocalDateTime alarmDatetime;

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
}
