package com.qst.finance.controller;

import com.qst.finance.common.SecurityUtils;
import com.qst.finance.service.AuthService;
import com.qst.finance.service.LoginUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class AuthController {
    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/")
    public String root(HttpServletRequest request) {
        return request.getSession().getAttribute(SecurityUtils.SESSION_USER) == null
                ? "redirect:/admin/pc/login" : "redirect:/admin/pc/index";
    }

    @GetMapping("/admin/pc/login")
    public String loginPage() {
        return "admin/jsp/login";
    }

    @PostMapping("/admin/pc/login")
    public String login(@RequestParam("accountName") String accountName,
                        @RequestParam("password") String password,
                        HttpServletRequest request) {
        LoginUser user = authService.login(accountName, password);
        if (user == null) {
            request.setAttribute("message", "账号或密码错误，或账号已被锁定");
            return "admin/jsp/login";
        }
        request.getSession().setAttribute(SecurityUtils.SESSION_USER, user);
        return "redirect:/admin/pc/index";
    }

    @RequestMapping("/admin/pc/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().invalidate();
        return "redirect:/admin/pc/login";
    }
}
