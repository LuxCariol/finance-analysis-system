package com.qst.finance;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.qst.finance.config.AppProperties;

/**
 * 金融财务分析系统 启动类
 *
 * 数据流：金蝶K8导出Excel -> 数据导入(基础表) -> ETL编码映射(数据仓库结果表) -> 算法模型计算 -> 报告/分析/预测展示
 */
@SpringBootApplication
@EnableTransactionManagement
@MapperScan("com.qst.finance.mapper")
@EnableConfigurationProperties(AppProperties.class)
public class FinanceApplication {

    public static void main(String[] args) {
        SpringApplication.run(FinanceApplication.class, args);
        System.out.println("\n========================================================\n"
                + "  金融财务分析系统 启动成功\n"
                + "  后台管理端: http://localhost:8080/web/login.html\n"
                + "  默认账号  : root / 123456\n"
                + "========================================================\n");
    }
}
