-- ============================================================================
-- 金融财务分析系统 - 损益预测存储过程
-- 说明: 系统默认使用 Java 实现(兼容 H2 与 MySQL)。本存储过程为 MySQL 版本实现，
--       对应《项目特色》中"复杂的逻辑运算、存储过程(如损益预测)"。
--       在 Navicat / mysql 命令行中执行本脚本即可创建存储过程。
-- 调用示例: CALL p_profit_forecast(1, '2026-09', 3);
-- ============================================================================
DROP PROCEDURE IF EXISTS p_profit_forecast;

DELIMITER $$
CREATE PROCEDURE p_profit_forecast(
    IN p_org_id BIGINT,
    IN p_end_month VARCHAR(20),
    IN p_periods INT
)
BEGIN
    DECLARE v_n INT DEFAULT 0;
    DECLARE v_sum_x DECIMAL(24,6) DEFAULT 0;
    DECLARE v_sum_y DECIMAL(24,6) DEFAULT 0;
    DECLARE v_sum_xy DECIMAL(24,6) DEFAULT 0;
    DECLARE v_sum_xx DECIMAL(24,6) DEFAULT 0;
    DECLARE v_b DECIMAL(24,6) DEFAULT 0;
    DECLARE v_a DECIMAL(24,6) DEFAULT 0;
    DECLARE v_i INT DEFAULT 0;
    DECLARE v_month VARCHAR(20);
    DECLARE v_value DECIMAL(24,4);
    DECLARE v_batch VARCHAR(40);
    DECLARE v_start VARCHAR(20);

    SET v_batch = CONCAT('PROC', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));
    SET v_start = DATE_FORMAT(DATE_SUB(STR_TO_DATE(CONCAT(p_end_month, '-01'), '%Y-%m-%d'), INTERVAL 5 MONTH), '%Y-%m');

    -- 取近 6 个月净利润(编码 P021, 本期金额)做最小二乘线性回归
    SELECT COUNT(1), SUM(rn), SUM(result_value), SUM(rn * result_value), SUM(rn * rn)
      INTO v_n, v_sum_x, v_sum_y, v_sum_xy, v_sum_xx
      FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY kjyear_month) AS rn, result_value
          FROM t_report_result
         WHERE org_id = p_org_id AND code = 'P021' AND value_type = 'BJ'
           AND kjyear_month BETWEEN v_start AND p_end_month
      ) t;

    IF v_n >= 2 AND (v_n * v_sum_xx - v_sum_x * v_sum_x) <> 0 THEN
        SET v_b = (v_n * v_sum_xy - v_sum_x * v_sum_y) / (v_n * v_sum_xx - v_sum_x * v_sum_x);
        SET v_a = (v_sum_y - v_b * v_sum_x) / v_n;
    ELSE
        SET v_b = 0;
        SET v_a = IFNULL(v_sum_y, 0);
    END IF;

    -- 清理历史预测结果
    DELETE FROM t_report_result
     WHERE org_id = p_org_id AND report_type = 'PREDICT' AND data_source = 'PROC';

    -- 写入未来 p_periods 期预测值
    WHILE v_i < p_periods DO
        SET v_i = v_i + 1;
        SET v_month = DATE_FORMAT(DATE_ADD(STR_TO_DATE(CONCAT(p_end_month, '-01'), '%Y-%m-%d'), INTERVAL v_i MONTH), '%Y-%m');
        SET v_value = ROUND(v_a + v_b * (v_n + v_i), 4);

        INSERT INTO t_report_result
            (batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time)
        VALUES
            (v_batch, p_org_id, SUBSTRING(v_month, 1, 4), SUBSTRING(v_month, 6, 2), v_month, 'PREDICT', 'F101', 'QM', v_value, 'PROC', NOW());
    END WHILE;

    SELECT v_batch AS batch_id, v_a AS intercept, v_b AS slope, p_periods AS periods,
           '损益预测存储过程执行完成' AS message;
END$$

DELIMITER ;
