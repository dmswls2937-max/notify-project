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

        System.out.println("[SCHEDULER] now=" + now + ", targets=" + targets.size());

        for (Schedule schedule : targets) {
            try {
                User user = userMapper.findById(schedule.getUserId());
                if (user == null) {
                    System.out.println("[SCHEDULER] user not found. scheduleId=" + schedule.getScheduleId());
                    continue;
                }

                mailService.sendScheduleAlarm(user, schedule);
                scheduleService.markAlarmSent(schedule.getScheduleId(), now);
            } catch (Exception e) {
                System.out.println("[SCHEDULER ERROR] scheduleId=" + schedule.getScheduleId());
                e.printStackTrace();
            }
        }
    }
}