package com.qst.finance.service;

import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class TokenStore {
    private final Map<String, LoginUser> tokens = new ConcurrentHashMap<String, LoginUser>();

    public void put(String token, LoginUser user) {
        user.setToken(token);
        tokens.put(token, user);
    }

    public LoginUser get(String token) {
        return token == null ? null : tokens.get(token);
    }

    public void remove(String token) {
        if (token != null) {
            tokens.remove(token);
        }
    }
}
