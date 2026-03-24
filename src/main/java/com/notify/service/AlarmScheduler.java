package com.notify.service;

import com.notify.domain.Schedule;
import com.notify.domain.User;
import com.notify.mapper.UserMapper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

@Component
public class AlarmScheduler {

    private final ScheduleService scheduleService;
    private final UserMapper userMapper;
    private final MailService mailService;

    public AlarmScheduler(ScheduleService scheduleService, UserMapper userMapper, MailService mailService) {
        this.scheduleService = scheduleService;
        this.userMapper = userMapper;
        this.mailService = mailService;
    }

    @Scheduled(fixedDelay = 60000)
    public void sendAlarmMails() {
        LocalDateTime now = LocalDateTime.now();
        List<Schedule> targets = scheduleService.getAlarmTargets(now);

        for (Schedule schedule : targets) {
            User user = userMapper.findById(schedule.getUserId());
            if (user == null) {
                continue;
            }
            mailService.sendScheduleAlarm(user, schedule);
            scheduleService.markAlarmSent(schedule.getScheduleId(), now);
        }
    }
}
