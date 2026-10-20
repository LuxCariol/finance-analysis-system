package com.qst.finance.config;

import com.qst.finance.common.SecurityUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        String uri = request.getRequestURI();
        if (uri.startsWith("/static/") || uri.equals("/favicon.ico")
                || uri.equals("/admin/pc/login") || uri.startsWith("/api/")
                || uri.startsWith("/web") || uri.startsWith("/console")
                || uri.startsWith("/web-vue")) {
            return true;
        }
        Object user = request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/admin/pc/login");
            return false;
        }
        return true;
    }
}
