package com.qst.finance.common;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.Map;

public class ApiResult implements Serializable {
    private static final long serialVersionUID = 1L;

    private int code;
    private String message;
    private Object data;
    private long timestamp = System.currentTimeMillis();

    public ApiResult() {
    }

    public ApiResult(int code, String message, Object data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public static ApiResult ok(Object data) {
        return new ApiResult(200, "success", data);
    }

    public static ApiResult ok(String message, Object data) {
        return new ApiResult(200, message, data);
    }

    public static ApiResult fail(String message) {
        return new ApiResult(500, message, null);
    }

    public static ApiResult fail(int code, String message) {
        return new ApiResult(code, message, null);
    }

    public static Map<String, Object> map(Object... values) {
        Map<String, Object> map = new LinkedHashMap<String, Object>();
        for (int i = 0; i + 1 < values.length; i += 2) {
            map.put(String.valueOf(values[i]), values[i + 1]);
        }
        return map;
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

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }
}
