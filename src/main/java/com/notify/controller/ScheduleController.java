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
        List<ScheduleResponse> data = scheduleService.getSchedules(loginUser.userId())
                .stream()
                .map(this::toResponse)
                .toList();
        return ApiResponse.ok(data);
    }

    @GetMapping("/{scheduleId}")
    public ApiResponse<ScheduleResponse> findOne(@PathVariable Long scheduleId, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        return ApiResponse.ok(toResponse(scheduleService.getOwnedSchedule(scheduleId, loginUser.userId())));
    }

    @PostMapping
    public ApiResponse<Long> create(@Valid @RequestBody ScheduleRequest request, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        return ApiResponse.ok("일정이 등록되었습니다.", scheduleService.create(loginUser.userId(), request));
    }

    @PutMapping("/{scheduleId}")
    public ApiResponse<Void> update(@PathVariable Long scheduleId,
                                    @Valid @RequestBody ScheduleRequest request,
                                    HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        scheduleService.update(scheduleId, loginUser.userId(), request);
        return ApiResponse.ok("일정이 수정되었습니다.", null);
    }

    @DeleteMapping("/{scheduleId}")
    public ApiResponse<Void> delete(@PathVariable Long scheduleId, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        scheduleService.delete(scheduleId, loginUser.userId());
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
