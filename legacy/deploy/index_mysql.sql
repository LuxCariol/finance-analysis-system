-- ============================================================================
-- 金融财务分析系统 - MySQL 索引优化脚本(对应《数据库设计》第7章 优化)
-- 说明: MySQL 不支持 CREATE INDEX IF NOT EXISTS, 该脚本在同一库中只需执行一次
-- ============================================================================

-- 数据仓库结果表: 分析、报表、趋势查询的核心索引
CREATE INDEX idx_result_month ON t_report_result (org_id, kjyear_month, report_type);
CREATE INDEX idx_result_code ON t_report_result (org_id, code, value_type, kjyear_month);
CREATE INDEX idx_result_source ON t_report_result (org_id, kjyear_month, data_source);

-- 基础表: 按公司与会计年月查询 / 覆盖删除
CREATE INDEX idx_bs_month ON t_basi_assets_and_liabilities (org_id, kjyear_month);
CREATE INDEX idx_pl_month ON t_basi_profit (org_id, kjyear_month);
CREATE INDEX idx_cf_month ON t_basi_cash_flow (org_id, kjyear_month);
CREATE INDEX idx_kmye_month ON t_kmye (org_id, kjyear_month, subject_code);
CREATE INDEX idx_aging_month ON t_age_analysis (org_id, kjyear_month, aging_type);

-- 配置表与权限表
CREATE INDEX idx_property_type ON t_report_property (report_type, is_active);
CREATE INDEX idx_mapper_source ON t_code_mapper (source_table, report_type, is_active);
CREATE INDEX idx_mode_type ON t_mode (mode_type, is_active);
CREATE INDEX idx_user_role_user ON t_sys_user_role (user_id);
CREATE INDEX idx_role_action_role ON t_sys_role_action (role_id);
CREATE INDEX idx_warn_month ON t_warn_record (org_id, kjyear_month, warn_level);
CREATE INDEX idx_log_time ON t_import_log (report_type, start_time);
