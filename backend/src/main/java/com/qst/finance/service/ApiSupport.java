package com.qst.finance.service;

import com.qst.finance.common.ApiAuthException;
import com.qst.finance.common.SecurityUtils;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public class ApiSupport {
    private final TokenStore tokenStore;

    public ApiSupport(TokenStore tokenStore) {
        this.tokenStore = tokenStore;
    }

    public LoginUser require(HttpServletRequest request) {
        LoginUser user = tokenStore.get(SecurityUtils.token(request));
        if (user == null) {
            throw new ApiAuthException("登录已失效，请重新登录");
        }
        return user;
    }

    public LoginUser optional(HttpServletRequest request) {
        return tokenStore.get(SecurityUtils.token(request));
    }
}
