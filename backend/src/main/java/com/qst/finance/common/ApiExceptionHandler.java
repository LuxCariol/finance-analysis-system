package com.qst.finance.common;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ApiExceptionHandler {
    @ExceptionHandler(ApiAuthException.class)
    public ApiResult auth(ApiAuthException ex) {
        return ApiResult.fail(401, ex.getMessage());
    }

    @ExceptionHandler(Exception.class)
    public ApiResult error(Exception ex) {
        return ApiResult.fail(500, "服务处理失败: " + ex.getMessage());
    }
}
