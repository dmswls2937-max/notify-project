package com.notify.controller;

import com.notify.common.LoginUser;
import com.notify.common.SessionConst;
import com.notify.domain.User;
import com.notify.dto.ApiResponse;
import com.notify.dto.LoginRequest;
import com.notify.dto.SignupRequest;
import com.notify.service.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/signup")
    public ApiResponse<Long> signup(@Valid @RequestBody SignupRequest request) {
        return ApiResponse.ok("회원가입이 완료되었습니다.", userService.signup(request));
    }

    @PostMapping("/login")
    public ApiResponse<LoginUser> login(@Valid @RequestBody LoginRequest request, HttpSession session) {
        User user = userService.login(request);
        LoginUser loginUser = new LoginUser(user.getUserId(), user.getEmail(), user.getName());
        session.setAttribute(SessionConst.LOGIN_USER, loginUser);
        return ApiResponse.ok("로그인되었습니다.", loginUser);
    }

    @PostMapping("/logout")
    public ApiResponse<Void> logout(HttpSession session) {
        session.invalidate();
        return ApiResponse.ok("로그아웃되었습니다.", null);
    }
}
