package com.qst.finance.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.UUID;

public final class SecurityUtils {
    public static final String SESSION_USER = "loginUser";
    public static final String API_TOKEN = "apiToken";

    private SecurityUtils() {
    }

    public static String md5(String value) {
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            byte[] bytes = digest.digest(value.getBytes(StandardCharsets.UTF_8));
            StringBuilder result = new StringBuilder();
            for (byte b : bytes) {
                result.append(String.format("%02X", b & 0xff));
            }
            return result.toString();
        } catch (Exception ex) {
            throw new IllegalStateException(ex);
        }
    }

    public static String token() {
        return UUID.randomUUID().toString().replace("-", "");
    }

    public static String token(HttpServletRequest request) {
        String token = request.getHeader("X-Token");
        if (token == null || token.isEmpty()) {
            token = request.getHeader("token");
        }
        if (token == null || token.isEmpty()) {
            token = request.getParameter("token");
        }
        return token;
    }

    public static HttpSession session(HttpServletRequest request) {
        return request.getSession(true);
    }
}
