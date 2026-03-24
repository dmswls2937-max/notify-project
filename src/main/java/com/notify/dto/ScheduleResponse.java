package com.notify.dto;

import java.time.LocalDateTime;

public record ScheduleResponse(
        Long scheduleId,
        String title,
        String content,
        LocalDateTime startDatetime,
        LocalDateTime endDatetime,
        LocalDateTime alarmDatetime,
        String alarmSentYn
) {
}
