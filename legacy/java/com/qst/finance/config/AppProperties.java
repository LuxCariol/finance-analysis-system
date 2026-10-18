package com.qst.finance.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * 系统业务参数（对应 application.yml 中 finance.* 配置）
 */
@ConfigurationProperties(prefix = "finance")
public class AppProperties {

    /** 密码 MD5 加盐盐值 */
    private String passwordSalt = "QST@2026#CW";

    /** 缓存类型: auto(优先Redis,不可用时降级JVM内存) / memory */
    private String cacheType = "auto";

    /** 缓存过期时间(秒) */
    private long cacheExpireSeconds = 1800L;

    /** 批量入库分片大小(每批100条) */
    private int importBatchSize = 100;

    /** Excel 最大读取行数 */
    private int excelMaxRows = 50000;

    /** 数据转换时是否自动执行算法模型 */
    private boolean autoCalcAfterTransform = true;

    /** 演示数据初始化(仅 H2 演示环境使用) */
    private boolean demoInit = false;

    public String getPasswordSalt() {
        return passwordSalt;
    }

    public void setPasswordSalt(String passwordSalt) {
        this.passwordSalt = passwordSalt;
    }

    public String getCacheType() {
        return cacheType;
    }

    public void setCacheType(String cacheType) {
        this.cacheType = cacheType;
    }

    public long getCacheExpireSeconds() {
        return cacheExpireSeconds;
    }

    public void setCacheExpireSeconds(long cacheExpireSeconds) {
        this.cacheExpireSeconds = cacheExpireSeconds;
    }

    public int getImportBatchSize() {
        return importBatchSize;
    }

    public void setImportBatchSize(int importBatchSize) {
        this.importBatchSize = importBatchSize;
    }

    public int getExcelMaxRows() {
        return excelMaxRows;
    }

    public void setExcelMaxRows(int excelMaxRows) {
        this.excelMaxRows = excelMaxRows;
    }

    public boolean isAutoCalcAfterTransform() {
        return autoCalcAfterTransform;
    }

    public void setAutoCalcAfterTransform(boolean autoCalcAfterTransform) {
        this.autoCalcAfterTransform = autoCalcAfterTransform;
    }

    public boolean isDemoInit() {
        return demoInit;
    }

    public void setDemoInit(boolean demoInit) {
        this.demoInit = demoInit;
    }
}
