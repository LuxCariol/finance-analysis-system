package com.qst.finance.common;

import java.io.Serializable;

/**
 * 统一返回结果: code=0 表示成功 (与《概要设计》内部接口约定一致)
 */
public class Result<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    private int code;
    private String message;
    private T data;

    public Result() {
    }

    public Result(int code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public static <T> Result<T> ok() {
        return new Result<T>(0, "操作成功", null);
    }

    public static <T> Result<T> ok(T data) {
        return new Result<T>(0, "操作成功", data);
    }

    public static <T> Result<T> ok(String message, T data) {
        return new Result<T>(0, message, data);
    }

    public static <T> Result<T> fail(String message) {
        return new Result<T>(500, message, null);
    }

    public static <T> Result<T> fail(int code, String message) {
        return new Result<T>(code, message, null);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
