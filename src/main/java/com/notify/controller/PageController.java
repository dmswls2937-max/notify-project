package com.notify.controller;

import com.notify.common.LoginUser;
import com.notify.common.SessionConst;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/signup")
    public String signupPage() {
        return "signup";
    }

    @GetMapping("/calendar")
    public String calendarPage(HttpSession session, Model model) {
        LoginUser loginUser = (LoginUser) session.getAttribute(SessionConst.LOGIN_USER);
        model.addAttribute("loginUser", loginUser);
        return "calendar";
    }
}
