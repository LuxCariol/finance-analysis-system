package com.qst.finance.config;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.qst.finance.common.Constants;
import com.qst.finance.common.Result;
import com.qst.finance.model.SysUser;

/**
 * 登录拦截器: 未登录访问 /api/** 时返回 401
 */
@Component
public class LoginInterceptor implements HandlerInterceptor {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            return true;
        }
        HttpSession session = request.getSession(false);
        Object user = session == null ? null : session.getAttribute(Constants.SESSION_USER);
        if (user instanceof SysUser) {
            request.setAttribute(Constants.SESSION_USER, user);
            return true;
        }
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write(objectMapper.writeValueAsString(Result.fail(401, "登录已过期，请重新登录")));
        writer.flush();
        return false;
    }
}
