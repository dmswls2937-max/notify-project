package com.notify.mapper;

import com.notify.domain.Schedule;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface ScheduleMapper {
    int insert(Schedule schedule);
    int update(Schedule schedule);
    int delete(@Param("scheduleId") Long scheduleId, @Param("userId") Long userId);
    Schedule findById(@Param("scheduleId") Long scheduleId, @Param("userId") Long userId);
    List<Schedule> findAllByUserId(@Param("userId") Long userId);
    List<Schedule> findAlarmTargets(@Param("now") LocalDateTime now);
    int markAlarmSent(@Param("scheduleId") Long scheduleId, @Param("alarmSentAt") LocalDateTime alarmSentAt);
    List<Schedule> findAlarmTargets();
}
