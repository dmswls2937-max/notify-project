package com.notify.controller;

import com.notify.common.LoginUser;
import com.notify.common.SessionConst;
import jakarta.servlet.http.HttpServletRequest;
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
    public String calendarPage(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        if (session == null) {
            return "redirect:/login";
        }

        Object sessionUser = session.getAttribute(SessionConst.LOGIN_USER);
        if (!(sessionUser instanceof LoginUser)) {
            return "redirect:/login";
        }

        LoginUser loginUser = (LoginUser) sessionUser;
        model.addAttribute("loginUser", loginUser);
        return "calendar";
    }
}