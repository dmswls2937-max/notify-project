package com.notify.controller;

import com.notify.common.LoginUser;
import com.notify.common.SessionConst;
import com.notify.domain.Schedule;
import com.notify.dto.ApiResponse;
import com.notify.dto.ScheduleRequest;
import com.notify.dto.ScheduleResponse;
import com.notify.service.ScheduleService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/schedules")
public class ScheduleController {

    private final ScheduleService scheduleService;

    public ScheduleController(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
    }

    @GetMapping
    public ApiResponse<List<ScheduleResponse>> findAll(HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);

        List<Schedule> schedules = scheduleService.getSchedules(loginUser.getUserId());
        System.out.println("schedules size = " + schedules.size());

        List<ScheduleResponse> data = schedules.stream()
                .map(schedule -> {
                    return toResponse(schedule);
                })
                .toList();

        System.out.println("response mapped size = " + data.size());

        return ApiResponse.ok(data);
    }

    @GetMapping("/{scheduleId}")
    public ApiResponse<ScheduleResponse> findOne(@PathVariable Long scheduleId, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        return ApiResponse.ok(toResponse(scheduleService.getOwnedSchedule(scheduleId, loginUser.getUserId())));
    }

    @PostMapping
    public ApiResponse<Long> create(@Valid @RequestBody ScheduleRequest request, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        return ApiResponse.ok("일정이 등록되었습니다.", scheduleService.create(loginUser.getUserId(), request));
    }

    @PutMapping("/{scheduleId}")
    public ApiResponse<Void> update(@PathVariable Long scheduleId,
                                    @Valid @RequestBody ScheduleRequest request,
                                    HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        scheduleService.update(scheduleId, loginUser.getUserId(), request);
        return ApiResponse.ok("일정이 수정되었습니다.", null);
    }

    @DeleteMapping("/{scheduleId}")
    public ApiResponse<Void> delete(@PathVariable Long scheduleId, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        scheduleService.delete(scheduleId, loginUser.getUserId());
        return ApiResponse.ok("일정이 삭제되었습니다.", null);
    }

    private ScheduleResponse toResponse(Schedule schedule) {
        return new ScheduleResponse(
                schedule.getScheduleId(),
                schedule.getTitle(),
                schedule.getContent(),
                schedule.getStartDatetime(),
                schedule.getEndDatetime(),
                schedule.getAlarmDatetime(),
                schedule.getAlarmSentYn()
        );
    }
}