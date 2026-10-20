package com.qst.finance.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class WebAdminPageController {
    @GetMapping({"/web", "/web/", "/web/index.html"})
    public String index() {
        return "redirect:/admin/pc/login";
    }

    @GetMapping({"/console", "/console/", "/console/index.html", "/web-vue", "/web-vue/"})
    public void console(HttpServletResponse response) throws IOException {
        response.sendRedirect("/static/web/index.html");
    }
}
