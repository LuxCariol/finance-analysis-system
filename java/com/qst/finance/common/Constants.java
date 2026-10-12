package com.qst.finance.common;

/**
 * 系统常量
 */
public final class Constants {

    private Constants() {
    }

    /** 登录用户存放的 Session Key */
    public static final String SESSION_USER = "LOGIN_USER";

    /** 报表类型 */
    public static final String REPORT_BALANCE = "BALANCE";
    public static final String REPORT_PROFIT = "PROFIT";
    public static final String REPORT_CASHFLOW = "CASHFLOW";
    public static final String REPORT_KMYE = "KMYE";
    public static final String REPORT_AGING = "AGING";
    public static final String REPORT_RATIO = "RATIO";
    public static final String REPORT_DUPONT = "DUPONT";
    public static final String REPORT_WARN = "WARN";
    public static final String REPORT_PREDICT = "PREDICT";

    /** 取数类型 */
    public static final String VALUE_NC = "NC";
    public static final String VALUE_QM = "QM";
    public static final String VALUE_BJ = "BJ";
    public static final String VALUE_SQ = "SQ";

    /** 转换标识 */
    public static final String FLAG_N = "N";
    public static final String FLAG_Y = "Y";

    /** 账号类型 */
    public static final int ACCOUNT_ROOT = 0;
    public static final int ACCOUNT_USER = 1;

    /** 超级管理员角色ID */
    public static final long ROLE_ROOT = 1L;
}
