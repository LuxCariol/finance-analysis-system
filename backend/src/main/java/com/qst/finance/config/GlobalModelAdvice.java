package com.qst.finance.config;

import com.qst.finance.common.SecurityUtils;
import com.qst.finance.service.LoginUser;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalModelAdvice {
    @ModelAttribute("PCUserToken")
    public LoginUser currentUser(HttpServletRequest request) {
        Object user = request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        return user instanceof LoginUser ? (LoginUser) user : null;
    }
}
