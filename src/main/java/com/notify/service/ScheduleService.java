package com.notify.service;

import com.notify.domain.Schedule;
import com.notify.dto.ScheduleRequest;
import com.notify.mapper.ScheduleMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ScheduleService {

    private final ScheduleMapper scheduleMapper;

    public ScheduleService(ScheduleMapper scheduleMapper) {
        this.scheduleMapper = scheduleMapper;
    }

    @Transactional
    public Long create(Long userId, ScheduleRequest request) {
        validateTime(request);

        Schedule schedule = new Schedule();
        schedule.setUserId(userId);
        schedule.setTitle(request.getTitle());
        schedule.setContent(request.getContent());
        schedule.setStartDatetime(request.getStartDatetime());
        schedule.setEndDatetime(request.getEndDatetime());
        schedule.setAlarmDatetime(request.getAlarmDatetime());
        schedule.setAlarmSentYn("N");
        scheduleMapper.insert(schedule);
        return schedule.getScheduleId();
    }

    @Transactional
    public void update(Long scheduleId, Long userId, ScheduleRequest request) {
        validateTime(request);
        Schedule exists = getOwnedSchedule(scheduleId, userId);
        exists.setTitle(request.getTitle());
        exists.setContent(request.getContent());
        exists.setStartDatetime(request.getStartDatetime());
        exists.setEndDatetime(request.getEndDatetime());
        exists.setAlarmDatetime(request.getAlarmDatetime());
        exists.setAlarmSentYn("N");
        exists.setAlarmSentAt(null);
        scheduleMapper.update(exists);
    }

    @Transactional
    public void delete(Long scheduleId, Long userId) {
        int deleted = scheduleMapper.delete(scheduleId, userId);
        if (deleted == 0) {
            throw new IllegalArgumentException("삭제할 일정을 찾을 수 없습니다.");
        }
    }

    public Schedule getOwnedSchedule(Long scheduleId, Long userId) {
        Schedule schedule = scheduleMapper.findById(scheduleId, userId);
        if (schedule == null) {
            throw new IllegalArgumentException("일정을 찾을 수 없습니다.");
        }
        return schedule;
    }

    public List<Schedule> getSchedules(Long userId) {
        return scheduleMapper.findByUserId(userId);
    }

    public List<Schedule> getAlarmTargets(LocalDateTime now) {
        return scheduleMapper.findAlarmTargets(now);
    }

    @Transactional
    public void markAlarmSent(Long scheduleId, LocalDateTime alarmSentAt) {
        scheduleMapper.markAlarmSent(scheduleId, alarmSentAt);
    }

    private void validateTime(ScheduleRequest request) {
        if (request.getEndDatetime() != null && request.getEndDatetime().isBefore(request.getStartDatetime())) {
            throw new IllegalArgumentException("종료일시는 시작일시보다 빠를 수 없습니다.");
        }

        if (request.getAlarmDatetime() != null
                && request.getEndDatetime() != null
                && request.getAlarmDatetime().isAfter(request.getEndDatetime())) {
            throw new IllegalArgumentException("알림일시는 종료일시보다 늦을 수 없습니다.");
        }
    }
}
