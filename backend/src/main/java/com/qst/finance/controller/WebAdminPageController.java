package com.qst.finance.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebAdminPageController {
    @GetMapping({"/web", "/web/"})
    public String index() {
        return "redirect:/web/index.html";
    }
}
