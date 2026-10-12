-- ============================================================================
-- 金融财务分析系统 初始化数据
-- 账号: root/123456(系统管理员)  cwzj/123456(财务总监)  cwry/123456(财务人员)  gg/123456(公司高层)
-- ============================================================================

INSERT INTO t_sys_user (id, user_name, account_name, pwd, locked, account_type, create_user_id, description, create_time, account_port_type, chrid, chrid_type, org_id) VALUES
(1.00, '系统管理员', 'root', '283480b545fe7cc40041f52955cc0193', 0.00, 0.00, -1.00, '系统内置最高权限账号', '2026-01-01 09:00:00', 1.00, '0', NULL, 1.00),
(2.00, '财务总监', 'cwzj', 'daca0836a0d3b6fec03d15c3118f7d0a', 0.00, 1.00, 1.00, '负责财务核算与财务分析', '2026-01-05 09:00:00', 1.00, '0', NULL, 1.00),
(3.00, '财务人员', 'cwry', 'fd546822b3c20bcd1acfd90edd0a68f1', 0.00, 1.00, 1.00, '负责财务数据导入与算法配置', '2026-01-05 09:00:00', 1.00, '0', NULL, 1.00),
(4.00, '公司高层', 'gg', '741c3610d02aa9e3bb7c39d9e0a229b4', 0.00, 1.00, 1.00, '查看财务分析结果', '2026-01-06 09:00:00', 1.00, '0', NULL, 1.00);
INSERT INTO t_sys_role (id, name, user_id, description, create_time) VALUES
(1.00, '超级管理员', 1.00, '拥有系统全部功能权限', '2026-01-01 09:00:00'),
(2.00, '财务总监', 1.00, '财务数据导入、模型配置与全部分析报表', '2026-01-05 09:00:00'),
(3.00, '财务人员', 1.00, '数据导入与模型配置', '2026-01-05 09:00:00'),
(4.00, '公司高层/投资者', 1.00, '查看报告、分析与预测结果', '2026-01-06 09:00:00');
INSERT INTO t_sys_resources (id, name, parent_id, res_key, type, res_url, order_no, icon, description) VALUES
(1.00, '首页概览', 0.00, 'dashboard', '0', 'page/dashboard.html', 1.00, 'home', '系统首页与经营概览'),
(10.00, '数据导入', 0.00, 'import', '0', '', 2.00, 'import', '金蝶K8财务数据导入'),
(11.00, '三大报表导入', 10.00, 'import_report', '1', 'page/import/report.html', 1.00, 'file', '资产负债表/利润表/现金流量表导入'),
(12.00, '科目余额表导入', 10.00, 'import_kmye', '1', 'page/import/kmye.html', 2.00, 'file', '科目余额表导入'),
(13.00, '账龄分析导入', 10.00, 'import_aging', '1', 'page/import/aging.html', 3.00, 'file', '应收/应付/预付账龄分析'),
(14.00, '导入日志', 10.00, 'import_log', '1', 'page/import/log.html', 4.00, 'log', '数据导入批次日志'),
(20.00, '模型管理', 0.00, 'model', '0', '', 3.00, 'model', '配置化模型管理'),
(21.00, '报表与取值配置', 20.00, 'report_property', '1', 'page/model/property.html', 1.00, 'config', '取值版/位置版配置'),
(22.00, '编码映射', 20.00, 'code_mapper', '1', 'page/model/mapper.html', 2.00, 'config', '基础表与数据仓库编码映射'),
(23.00, '编码字典', 20.00, 'code_libr', '1', 'page/model/library.html', 3.00, 'config', '编码概要、图表与预警配置');
INSERT INTO t_sys_resources (id, name, parent_id, res_key, type, res_url, order_no, icon, description) VALUES
(24.00, '算法配置', 20.00, 'algorithm', '1', 'page/model/algorithm.html', 4.00, 'config', '财务算法模型配置'),
(25.00, '数据转换', 20.00, 'transform', '1', 'page/model/transform.html', 5.00, 'etl', 'ETL 数据抽取转换'),
(26.00, '资讯管理', 20.00, 'news', '1', 'page/model/news.html', 6.00, 'news', '财务资讯发布'),
(30.00, '财务报表', 0.00, 'report', '0', '', 4.00, 'report', '三大报表与企业经营报告'),
(31.00, '企业经营报告', 30.00, 'enterprise_report', '1', 'page/report/enterprise.html', 1.00, 'report', '经营总量概要'),
(32.00, '资产负债表', 30.00, 'balance_sheet', '1', 'page/report/balance.html', 2.00, 'report', '资产负债表报告'),
(33.00, '利润表', 30.00, 'profit_report', '1', 'page/report/profit.html', 3.00, 'report', '利润表报告'),
(34.00, '现金流量表', 30.00, 'cashflow_report', '1', 'page/report/cashflow.html', 4.00, 'report', '现金流量表报告'),
(40.00, '财务分析', 0.00, 'analysis', '0', '', 5.00, 'analysis', '比率分析/资金预警/杜邦分析'),
(41.00, '比率分析', 40.00, 'ratio', '1', 'page/analysis/ratio.html', 1.00, 'chart', '偿债/营运/盈利能力比率');
INSERT INTO t_sys_resources (id, name, parent_id, res_key, type, res_url, order_no, icon, description) VALUES
(42.00, '资金概要与预警', 40.00, 'fund', '1', 'page/analysis/fund.html', 2.00, 'warn', '资金概要、预警与调整建议'),
(43.00, '杜邦分析', 40.00, 'dupont', '1', 'page/analysis/dupont.html', 3.00, 'chart', 'ROE 因素分解'),
(44.00, '投资计算', 40.00, 'investment', '1', 'page/analysis/investment.html', 4.00, 'calc', 'NPV/IRR/回收期计算'),
(50.00, '预测', 0.00, 'predict', '0', '', 6.00, 'predict', '损益预测与投资预测'),
(51.00, '损益预测', 50.00, 'predict_profit', '1', 'page/predict/profit.html', 1.00, 'predict', '损益预测(存储过程/算法)'),
(52.00, '投资预测', 50.00, 'predict_investment', '1', 'page/predict/investment.html', 2.00, 'predict', '投资预测与报告'),
(60.00, '系统管理', 0.00, 'system', '0', '', 7.00, 'system', '用户/角色/菜单/字典/公司'),
(61.00, '用户管理', 60.00, 'sys_user', '1', 'page/sys/user.html', 1.00, 'user', '后台用户管理'),
(62.00, '角色管理', 60.00, 'sys_role', '1', 'page/sys/role.html', 2.00, 'role', '角色与权限分配'),
(63.00, '菜单管理', 60.00, 'sys_menu', '1', 'page/sys/menu.html', 3.00, 'menu', '后台菜单管理');
INSERT INTO t_sys_resources (id, name, parent_id, res_key, type, res_url, order_no, icon, description) VALUES
(64.00, '公司管理', 60.00, 'sys_org', '1', 'page/sys/org.html', 4.00, 'org', '公司(组织)管理'),
(65.00, '系统字典', 60.00, 'sys_dict', '1', 'page/sys/dict.html', 5.00, 'dict', '数据字典维护');
INSERT INTO t_sys_user_role (id, user_id, role_id) VALUES
(1.00, 1.00, 1.00),
(2.00, 2.00, 2.00),
(3.00, 3.00, 3.00),
(4.00, 4.00, 4.00);
INSERT INTO t_sys_role_action (id, res_id, role_id) VALUES
(1.00, 1.00, 1.00),
(2.00, 10.00, 1.00),
(3.00, 11.00, 1.00),
(4.00, 12.00, 1.00),
(5.00, 13.00, 1.00),
(6.00, 14.00, 1.00),
(7.00, 20.00, 1.00),
(8.00, 21.00, 1.00),
(9.00, 22.00, 1.00),
(10.00, 23.00, 1.00),
(11.00, 24.00, 1.00),
(12.00, 25.00, 1.00),
(13.00, 26.00, 1.00),
(14.00, 30.00, 1.00),
(15.00, 31.00, 1.00),
(16.00, 32.00, 1.00),
(17.00, 33.00, 1.00),
(18.00, 34.00, 1.00),
(19.00, 40.00, 1.00),
(20.00, 41.00, 1.00);
INSERT INTO t_sys_role_action (id, res_id, role_id) VALUES
(21.00, 42.00, 1.00),
(22.00, 43.00, 1.00),
(23.00, 44.00, 1.00),
(24.00, 50.00, 1.00),
(25.00, 51.00, 1.00),
(26.00, 52.00, 1.00),
(27.00, 60.00, 1.00),
(28.00, 61.00, 1.00),
(29.00, 62.00, 1.00),
(30.00, 63.00, 1.00),
(31.00, 64.00, 1.00),
(32.00, 65.00, 1.00),
(33.00, 1.00, 2.00),
(34.00, 10.00, 2.00),
(35.00, 11.00, 2.00),
(36.00, 12.00, 2.00),
(37.00, 13.00, 2.00),
(38.00, 14.00, 2.00),
(39.00, 20.00, 2.00),
(40.00, 21.00, 2.00);
INSERT INTO t_sys_role_action (id, res_id, role_id) VALUES
(41.00, 22.00, 2.00),
(42.00, 23.00, 2.00),
(43.00, 24.00, 2.00),
(44.00, 25.00, 2.00),
(45.00, 26.00, 2.00),
(46.00, 30.00, 2.00),
(47.00, 31.00, 2.00),
(48.00, 32.00, 2.00),
(49.00, 33.00, 2.00),
(50.00, 34.00, 2.00),
(51.00, 40.00, 2.00),
(52.00, 41.00, 2.00),
(53.00, 42.00, 2.00),
(54.00, 43.00, 2.00),
(55.00, 44.00, 2.00),
(56.00, 50.00, 2.00),
(57.00, 51.00, 2.00),
(58.00, 52.00, 2.00),
(59.00, 1.00, 3.00),
(60.00, 10.00, 3.00);
INSERT INTO t_sys_role_action (id, res_id, role_id) VALUES
(61.00, 11.00, 3.00),
(62.00, 12.00, 3.00),
(63.00, 13.00, 3.00),
(64.00, 14.00, 3.00),
(65.00, 20.00, 3.00),
(66.00, 21.00, 3.00),
(67.00, 23.00, 3.00),
(68.00, 25.00, 3.00),
(69.00, 30.00, 3.00),
(70.00, 31.00, 3.00),
(71.00, 32.00, 3.00),
(72.00, 33.00, 3.00),
(73.00, 34.00, 3.00),
(74.00, 40.00, 3.00),
(75.00, 41.00, 3.00),
(76.00, 42.00, 3.00),
(77.00, 43.00, 3.00),
(78.00, 44.00, 3.00),
(79.00, 50.00, 3.00),
(80.00, 51.00, 3.00);
INSERT INTO t_sys_role_action (id, res_id, role_id) VALUES
(81.00, 52.00, 3.00),
(82.00, 1.00, 4.00),
(83.00, 30.00, 4.00),
(84.00, 31.00, 4.00),
(85.00, 32.00, 4.00),
(86.00, 33.00, 4.00),
(87.00, 34.00, 4.00),
(88.00, 40.00, 4.00),
(89.00, 41.00, 4.00),
(90.00, 42.00, 4.00),
(91.00, 43.00, 4.00),
(92.00, 44.00, 4.00),
(93.00, 50.00, 4.00),
(94.00, 51.00, 4.00),
(95.00, 52.00, 4.00);
INSERT INTO t_org_info (id, org_code, org_name, parent_id, org_type, description, create_time) VALUES
(1.00, 'QST001', '青软实训科技股份有限公司', 0.00, '1', '母公司(汇总主体)', '2026-01-01 09:00:00'),
(2.00, 'QST002', '青软实训智能装备有限公司', 1.00, '2', '全资子公司', '2026-01-01 09:00:00');
INSERT INTO t_sys_dictionary (id, dict_code, dict_name, description, create_time) VALUES
(1.00, 'REPORT_TYPE', '报表类型', '财务报表分类', '2026-01-01 09:00:00'),
(2.00, 'VALUE_TYPE', '取数类型', '期初/期末/本期/上期', '2026-01-01 09:00:00'),
(3.00, 'WARN_LEVEL', '预警级别', '财务指标预警级别', '2026-01-01 09:00:00'),
(4.00, 'AGING_TYPE', '账龄类型', '往来款账龄分析类型', '2026-01-01 09:00:00'),
(5.00, 'CHART_TYPE', '图表类型', '可视化图表类型', '2026-01-01 09:00:00'),
(6.00, 'ACCOUNT_PORT_TYPE', '财务系统类别', '对接的财务软件类别', '2026-01-01 09:00:00'),
(7.00, 'MODE_TYPE', '算法模型类型', '算法模型分类', '2026-01-01 09:00:00');
INSERT INTO t_sys_dictionary_detail (id, dict_code, item_key, item_value, order_no, description) VALUES
(1.00, 'REPORT_TYPE', 'BALANCE', '资产负债表', 1.00, NULL),
(2.00, 'REPORT_TYPE', 'PROFIT', '利润表', 2.00, NULL),
(3.00, 'REPORT_TYPE', 'CASHFLOW', '现金流量表', 3.00, NULL),
(4.00, 'REPORT_TYPE', 'KMYE', '科目余额表', 4.00, NULL),
(5.00, 'REPORT_TYPE', 'AGING', '账龄分析', 5.00, NULL),
(6.00, 'VALUE_TYPE', 'NC', '年初数', 1.00, NULL),
(7.00, 'VALUE_TYPE', 'QM', '期末数', 2.00, NULL),
(8.00, 'VALUE_TYPE', 'BJ', '本期金额', 3.00, NULL),
(9.00, 'VALUE_TYPE', 'SQ', '上期金额', 4.00, NULL),
(10.00, 'WARN_LEVEL', '1', '提示(黄色)', 1.00, NULL);
INSERT INTO t_sys_dictionary_detail (id, dict_code, item_key, item_value, order_no, description) VALUES
(11.00, 'WARN_LEVEL', '2', '警告(橙色)', 2.00, NULL),
(12.00, 'WARN_LEVEL', '3', '严重(红色)', 3.00, NULL),
(13.00, 'AGING_TYPE', '1', '应付账款账龄', 1.00, NULL),
(14.00, 'AGING_TYPE', '2', '应收账款账龄', 2.00, NULL),
(15.00, 'AGING_TYPE', '3', '其他应收款账龄', 3.00, NULL),
(16.00, 'AGING_TYPE', '7', '预付账款账龄', 4.00, NULL),
(17.00, 'CHART_TYPE', 'line', '折线图', 1.00, NULL),
(18.00, 'CHART_TYPE', 'bar', '柱状图', 2.00, NULL),
(19.00, 'CHART_TYPE', 'pie', '饼图', 3.00, NULL),
(20.00, 'CHART_TYPE', 'gauge', '仪表盘', 4.00, NULL);
INSERT INTO t_sys_dictionary_detail (id, dict_code, item_key, item_value, order_no, description) VALUES
(21.00, 'ACCOUNT_PORT_TYPE', '1', '金蝶K8', 1.00, NULL),
(22.00, 'ACCOUNT_PORT_TYPE', '2', '用友', 2.00, NULL),
(23.00, 'MODE_TYPE', 'RATIO', '比率分析', 1.00, NULL),
(24.00, 'MODE_TYPE', 'DUPONT', '杜邦分析', 2.00, NULL),
(25.00, 'MODE_TYPE', 'WARN', '资金预警', 3.00, NULL),
(26.00, 'MODE_TYPE', 'PREDICT', '预测模型', 4.00, NULL);
INSERT INTO t_report_name (id, report_code, report_type, report_name, table_name, map_mode, order_no, description) VALUES
(1.00, 'BALANCE_SHEET', 'BALANCE', '资产负债表', 't_basi_assets_and_liabilities', 'WIDE', 1.00, '金蝶K8资产负债表(项目/年初余额/期末余额)'),
(2.00, 'PROFIT_SHEET', 'PROFIT', '利润表', 't_basi_profit', 'WIDE', 2.00, '金蝶K8利润表(项目/本期金额/上期金额)'),
(3.00, 'CASH_FLOW_SHEET', 'CASHFLOW', '现金流量表', 't_basi_cash_flow', 'WIDE', 3.00, '金蝶K8现金流量表(项目/本期金额/上期金额)'),
(4.00, 'SUBJECT_BALANCE', 'KMYE', '科目余额表', 't_kmye', 'LONG', 4.00, '一级/二级科目期初、本期发生、期末数据'),
(5.00, 'AGING_ANALYSIS', 'AGING', '账龄分析表', 't_age_analysis', 'LONG', 5.00, '应收/应付/预付/其他应收账龄');
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(1.00, 'BALANCE', 'BALANCE_SHEET', '货币资金', 1.00, '年初余额', 'NC_LDZC_HBZJ', 2.00, 0.00, '0.00', 1.00),
(2.00, 'BALANCE', 'BALANCE_SHEET', '货币资金', 1.00, '期末余额', 'QM_LDZC_HBZJ', 3.00, 0.00, '0.00', 2.00),
(3.00, 'BALANCE', 'BALANCE_SHEET', '交易性金融资产', 1.00, '年初余额', 'NC_LDZC_JYXJRZC', 2.00, 0.00, '0.00', 3.00),
(4.00, 'BALANCE', 'BALANCE_SHEET', '交易性金融资产', 1.00, '期末余额', 'QM_LDZC_JYXJRZC', 3.00, 0.00, '0.00', 4.00),
(5.00, 'BALANCE', 'BALANCE_SHEET', '应收票据', 1.00, '年初余额', 'NC_LDZC_YSPJ', 2.00, 0.00, '0.00', 5.00),
(6.00, 'BALANCE', 'BALANCE_SHEET', '应收票据', 1.00, '期末余额', 'QM_LDZC_YSPJ', 3.00, 0.00, '0.00', 6.00),
(7.00, 'BALANCE', 'BALANCE_SHEET', '应收账款', 1.00, '年初余额', 'NC_LDZC_YSZK', 2.00, 0.00, '0.00', 7.00),
(8.00, 'BALANCE', 'BALANCE_SHEET', '应收账款', 1.00, '期末余额', 'QM_LDZC_YSZK', 3.00, 0.00, '0.00', 8.00),
(9.00, 'BALANCE', 'BALANCE_SHEET', '预付款项', 1.00, '年初余额', 'NC_LDZC_YFZK', 2.00, 0.00, '0.00', 9.00),
(10.00, 'BALANCE', 'BALANCE_SHEET', '预付款项', 1.00, '期末余额', 'QM_LDZC_YFZK', 3.00, 0.00, '0.00', 10.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(11.00, 'BALANCE', 'BALANCE_SHEET', '应收股利', 1.00, '年初余额', 'NC_LDZC_YSFL', 2.00, 0.00, '0.00', 11.00),
(12.00, 'BALANCE', 'BALANCE_SHEET', '应收股利', 1.00, '期末余额', 'QM_LDZC_YSFL', 3.00, 0.00, '0.00', 12.00),
(13.00, 'BALANCE', 'BALANCE_SHEET', '应收利息', 1.00, '年初余额', 'NC_LDZC_YSLX', 2.00, 0.00, '0.00', 13.00),
(14.00, 'BALANCE', 'BALANCE_SHEET', '应收利息', 1.00, '期末余额', 'QM_LDZC_YSLX', 3.00, 0.00, '0.00', 14.00),
(15.00, 'BALANCE', 'BALANCE_SHEET', '其他应收款', 1.00, '年初余额', 'NC_LDZC_QTYSK', 2.00, 0.00, '0.00', 15.00),
(16.00, 'BALANCE', 'BALANCE_SHEET', '其他应收款', 1.00, '期末余额', 'QM_LDZC_QTYSK', 3.00, 0.00, '0.00', 16.00),
(17.00, 'BALANCE', 'BALANCE_SHEET', '存货', 1.00, '年初余额', 'NC_LDZC_CH', 2.00, 0.00, '0.00', 17.00),
(18.00, 'BALANCE', 'BALANCE_SHEET', '存货', 1.00, '期末余额', 'QM_LDZC_CH', 3.00, 0.00, '0.00', 18.00),
(19.00, 'BALANCE', 'BALANCE_SHEET', '待摊费用', 1.00, '年初余额', 'NC_LDZC_DTFY', 2.00, 0.00, '0.00', 19.00),
(20.00, 'BALANCE', 'BALANCE_SHEET', '待摊费用', 1.00, '期末余额', 'QM_LDZC_DTFY', 3.00, 0.00, '0.00', 20.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(21.00, 'BALANCE', 'BALANCE_SHEET', '一年内到期的非流动资产', 1.00, '年初余额', 'NC_LDZC_YNNDQCQZQTZ', 2.00, 0.00, '0.00', 21.00),
(22.00, 'BALANCE', 'BALANCE_SHEET', '一年内到期的非流动资产', 1.00, '期末余额', 'QM_LDZC_YNNDQCQZQTZ', 3.00, 0.00, '0.00', 22.00),
(23.00, 'BALANCE', 'BALANCE_SHEET', '其他流动资产', 1.00, '年初余额', 'NC_LDZC_QTLDZC', 2.00, 0.00, '0.00', 23.00),
(24.00, 'BALANCE', 'BALANCE_SHEET', '其他流动资产', 1.00, '期末余额', 'QM_LDZC_QTLDZC', 3.00, 0.00, '0.00', 24.00),
(25.00, 'BALANCE', 'BALANCE_SHEET', '流动资产合计', 1.00, '年初余额', 'NC_LDZC_HJ', 2.00, 0.00, '0.00', 25.00),
(26.00, 'BALANCE', 'BALANCE_SHEET', '流动资产合计', 1.00, '期末余额', 'QM_LDZC_HJ', 3.00, 0.00, '0.00', 26.00),
(27.00, 'BALANCE', 'BALANCE_SHEET', '可供出售金融资产', 1.00, '年初余额', 'NC_FLDZC_KGCSJRZC', 2.00, 0.00, '0.00', 27.00),
(28.00, 'BALANCE', 'BALANCE_SHEET', '可供出售金融资产', 1.00, '期末余额', 'QM_FLDZC_KGCSJRZC', 3.00, 0.00, '0.00', 28.00),
(29.00, 'BALANCE', 'BALANCE_SHEET', '持有至到期投资', 1.00, '年初余额', 'NC_FLDZC_CYZDQTZ', 2.00, 0.00, '0.00', 29.00),
(30.00, 'BALANCE', 'BALANCE_SHEET', '持有至到期投资', 1.00, '期末余额', 'QM_FLDZC_CYZDQTZ', 3.00, 0.00, '0.00', 30.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(31.00, 'BALANCE', 'BALANCE_SHEET', '长期应收款', 1.00, '年初余额', 'NC_FLDZC_CQYSK', 2.00, 0.00, '0.00', 31.00),
(32.00, 'BALANCE', 'BALANCE_SHEET', '长期应收款', 1.00, '期末余额', 'QM_FLDZC_CQYSK', 3.00, 0.00, '0.00', 32.00),
(33.00, 'BALANCE', 'BALANCE_SHEET', '长期股权投资', 1.00, '年初余额', 'NC_FLDZC_CQGQTZ', 2.00, 0.00, '0.00', 33.00),
(34.00, 'BALANCE', 'BALANCE_SHEET', '长期股权投资', 1.00, '期末余额', 'QM_FLDZC_CQGQTZ', 3.00, 0.00, '0.00', 34.00),
(35.00, 'BALANCE', 'BALANCE_SHEET', '投资性房地产', 1.00, '年初余额', 'NC_FLDZC_TZXFDC', 2.00, 0.00, '0.00', 35.00),
(36.00, 'BALANCE', 'BALANCE_SHEET', '投资性房地产', 1.00, '期末余额', 'QM_FLDZC_TZXFDC', 3.00, 0.00, '0.00', 36.00),
(37.00, 'BALANCE', 'BALANCE_SHEET', '固定资产', 1.00, '年初余额', 'NC_FLDZC_GDZC', 2.00, 0.00, '0.00', 37.00),
(38.00, 'BALANCE', 'BALANCE_SHEET', '固定资产', 1.00, '期末余额', 'QM_FLDZC_GDZC', 3.00, 0.00, '0.00', 38.00),
(39.00, 'BALANCE', 'BALANCE_SHEET', '在建工程', 1.00, '年初余额', 'NC_FLDZC_ZJGC', 2.00, 0.00, '0.00', 39.00),
(40.00, 'BALANCE', 'BALANCE_SHEET', '在建工程', 1.00, '期末余额', 'QM_FLDZC_ZJGC', 3.00, 0.00, '0.00', 40.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(41.00, 'BALANCE', 'BALANCE_SHEET', '工程物资', 1.00, '年初余额', 'NC_FLDZC_GCWZ', 2.00, 0.00, '0.00', 41.00),
(42.00, 'BALANCE', 'BALANCE_SHEET', '工程物资', 1.00, '期末余额', 'QM_FLDZC_GCWZ', 3.00, 0.00, '0.00', 42.00),
(43.00, 'BALANCE', 'BALANCE_SHEET', '固定资产清理', 1.00, '年初余额', 'NC_FLDZC_GDZCQL', 2.00, 0.00, '0.00', 43.00),
(44.00, 'BALANCE', 'BALANCE_SHEET', '固定资产清理', 1.00, '期末余额', 'QM_FLDZC_GDZCQL', 3.00, 0.00, '0.00', 44.00),
(45.00, 'BALANCE', 'BALANCE_SHEET', '生产性生物资产', 1.00, '年初余额', 'NC_FLDZC_SCXSWZC', 2.00, 0.00, '0.00', 45.00),
(46.00, 'BALANCE', 'BALANCE_SHEET', '生产性生物资产', 1.00, '期末余额', 'QM_FLDZC_SCXSWZC', 3.00, 0.00, '0.00', 46.00),
(47.00, 'BALANCE', 'BALANCE_SHEET', '油气资产', 1.00, '年初余额', 'NC_FLDZC_YQZC', 2.00, 0.00, '0.00', 47.00),
(48.00, 'BALANCE', 'BALANCE_SHEET', '油气资产', 1.00, '期末余额', 'QM_FLDZC_YQZC', 3.00, 0.00, '0.00', 48.00),
(49.00, 'BALANCE', 'BALANCE_SHEET', '无形资产', 1.00, '年初余额', 'NC_FLDZC_WXZC', 2.00, 0.00, '0.00', 49.00),
(50.00, 'BALANCE', 'BALANCE_SHEET', '无形资产', 1.00, '期末余额', 'QM_FLDZC_WXZC', 3.00, 0.00, '0.00', 50.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(51.00, 'BALANCE', 'BALANCE_SHEET', '开发支出', 1.00, '年初余额', 'NC_FLDZC_KFZC', 2.00, 0.00, '0.00', 51.00),
(52.00, 'BALANCE', 'BALANCE_SHEET', '开发支出', 1.00, '期末余额', 'QM_FLDZC_KFZC', 3.00, 0.00, '0.00', 52.00),
(53.00, 'BALANCE', 'BALANCE_SHEET', '商誉', 1.00, '年初余额', 'NC_FLDZC_SY', 2.00, 0.00, '0.00', 53.00),
(54.00, 'BALANCE', 'BALANCE_SHEET', '商誉', 1.00, '期末余额', 'QM_FLDZC_SY', 3.00, 0.00, '0.00', 54.00),
(55.00, 'BALANCE', 'BALANCE_SHEET', '长期待摊费用', 1.00, '年初余额', 'NC_FLDZC_CQDTFY', 2.00, 0.00, '0.00', 55.00),
(56.00, 'BALANCE', 'BALANCE_SHEET', '长期待摊费用', 1.00, '期末余额', 'QM_FLDZC_CQDTFY', 3.00, 0.00, '0.00', 56.00),
(57.00, 'BALANCE', 'BALANCE_SHEET', '递延所得税资产', 1.00, '年初余额', 'NC_FLDZC_DYSDSZC', 2.00, 0.00, '0.00', 57.00),
(58.00, 'BALANCE', 'BALANCE_SHEET', '递延所得税资产', 1.00, '期末余额', 'QM_FLDZC_DYSDSZC', 3.00, 0.00, '0.00', 58.00),
(59.00, 'BALANCE', 'BALANCE_SHEET', '其他非流动资产', 1.00, '年初余额', 'NC_FLDZC_QTFLDZC', 2.00, 0.00, '0.00', 59.00),
(60.00, 'BALANCE', 'BALANCE_SHEET', '其他非流动资产', 1.00, '期末余额', 'QM_FLDZC_QTFLDZC', 3.00, 0.00, '0.00', 60.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(61.00, 'BALANCE', 'BALANCE_SHEET', '非流动资产合计', 1.00, '年初余额', 'NC_FLDZC_FLDZCHJ', 2.00, 0.00, '0.00', 61.00),
(62.00, 'BALANCE', 'BALANCE_SHEET', '非流动资产合计', 1.00, '期末余额', 'QM_FLDZC_FLDZCHJ', 3.00, 0.00, '0.00', 62.00),
(63.00, 'BALANCE', 'BALANCE_SHEET', '资产总计', 1.00, '年初余额', 'NC_ZCZJ', 2.00, 0.00, '0.00', 63.00),
(64.00, 'BALANCE', 'BALANCE_SHEET', '资产总计', 1.00, '期末余额', 'QM_ZCZJ', 3.00, 0.00, '0.00', 64.00),
(65.00, 'BALANCE', 'BALANCE_SHEET', '短期借款', 1.00, '年初余额', 'NC_LDFZ_DQJK', 2.00, 0.00, '0.00', 65.00),
(66.00, 'BALANCE', 'BALANCE_SHEET', '短期借款', 1.00, '期末余额', 'QM_LDFZ_DQJK', 3.00, 0.00, '0.00', 66.00),
(67.00, 'BALANCE', 'BALANCE_SHEET', '交易性金融负债', 1.00, '年初余额', 'NC_LDFZ_JYXJRFZ', 2.00, 0.00, '0.00', 67.00),
(68.00, 'BALANCE', 'BALANCE_SHEET', '交易性金融负债', 1.00, '期末余额', 'QM_LDFZ_JYXJRFZ', 3.00, 0.00, '0.00', 68.00),
(69.00, 'BALANCE', 'BALANCE_SHEET', '应付票据', 1.00, '年初余额', 'NC_LDFZ_YFPJ', 2.00, 0.00, '0.00', 69.00),
(70.00, 'BALANCE', 'BALANCE_SHEET', '应付票据', 1.00, '期末余额', 'QM_LDFZ_YFPJ', 3.00, 0.00, '0.00', 70.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(71.00, 'BALANCE', 'BALANCE_SHEET', '应付账款', 1.00, '年初余额', 'NC_LDFZ_YFZK', 2.00, 0.00, '0.00', 71.00),
(72.00, 'BALANCE', 'BALANCE_SHEET', '应付账款', 1.00, '期末余额', 'QM_LDFZ_YFZK', 3.00, 0.00, '0.00', 72.00),
(73.00, 'BALANCE', 'BALANCE_SHEET', '预收款项', 1.00, '年初余额', 'NC_LDFZ_YSZK', 2.00, 0.00, '0.00', 73.00),
(74.00, 'BALANCE', 'BALANCE_SHEET', '预收款项', 1.00, '期末余额', 'QM_LDFZ_YSZK', 3.00, 0.00, '0.00', 74.00),
(75.00, 'BALANCE', 'BALANCE_SHEET', '应付职工薪酬', 1.00, '年初余额', 'NC_LDFZ_YFGZ', 2.00, 0.00, '0.00', 75.00),
(76.00, 'BALANCE', 'BALANCE_SHEET', '应付职工薪酬', 1.00, '期末余额', 'QM_LDFZ_YFGZ', 3.00, 0.00, '0.00', 76.00),
(77.00, 'BALANCE', 'BALANCE_SHEET', '应付福利费', 1.00, '年初余额', 'NC_LDFZ_YFFLF', 2.00, 0.00, '0.00', 77.00),
(78.00, 'BALANCE', 'BALANCE_SHEET', '应付福利费', 1.00, '期末余额', 'QM_LDFZ_YFFLF', 3.00, 0.00, '0.00', 78.00),
(79.00, 'BALANCE', 'BALANCE_SHEET', '应交税费', 1.00, '年初余额', 'NC_LDFZ_YJSJ', 2.00, 0.00, '0.00', 79.00),
(80.00, 'BALANCE', 'BALANCE_SHEET', '应交税费', 1.00, '期末余额', 'QM_LDFZ_YJSJ', 3.00, 0.00, '0.00', 80.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(81.00, 'BALANCE', 'BALANCE_SHEET', '应付利息', 1.00, '年初余额', 'NC_LDFZ_YFLX', 2.00, 0.00, '0.00', 81.00),
(82.00, 'BALANCE', 'BALANCE_SHEET', '应付利息', 1.00, '期末余额', 'QM_LDFZ_YFLX', 3.00, 0.00, '0.00', 82.00),
(83.00, 'BALANCE', 'BALANCE_SHEET', '应付股利', 1.00, '年初余额', 'NC_LDFZ_YFGL', 2.00, 0.00, '0.00', 83.00),
(84.00, 'BALANCE', 'BALANCE_SHEET', '应付股利', 1.00, '期末余额', 'QM_LDFZ_YFGL', 3.00, 0.00, '0.00', 84.00),
(85.00, 'BALANCE', 'BALANCE_SHEET', '其他应付款', 1.00, '年初余额', 'NC_LDFZ_QTYFK', 2.00, 0.00, '0.00', 85.00),
(86.00, 'BALANCE', 'BALANCE_SHEET', '其他应付款', 1.00, '期末余额', 'QM_LDFZ_QTYFK', 3.00, 0.00, '0.00', 86.00),
(87.00, 'BALANCE', 'BALANCE_SHEET', '预提费用', 1.00, '年初余额', 'NC_LDFZ_YTFY', 2.00, 0.00, '0.00', 87.00),
(88.00, 'BALANCE', 'BALANCE_SHEET', '预提费用', 1.00, '期末余额', 'QM_LDFZ_YTFY', 3.00, 0.00, '0.00', 88.00),
(89.00, 'BALANCE', 'BALANCE_SHEET', '一年内到期的非流动负债', 1.00, '年初余额', 'NC_LDFZ_YNNDQCQFZ', 2.00, 0.00, '0.00', 89.00),
(90.00, 'BALANCE', 'BALANCE_SHEET', '一年内到期的非流动负债', 1.00, '期末余额', 'QM_LDFZ_YNNDQCQFZ', 3.00, 0.00, '0.00', 90.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(91.00, 'BALANCE', 'BALANCE_SHEET', '其他流动负债', 1.00, '年初余额', 'NC_LDFZ_QTLDFZ', 2.00, 0.00, '0.00', 91.00),
(92.00, 'BALANCE', 'BALANCE_SHEET', '其他流动负债', 1.00, '期末余额', 'QM_LDFZ_QTLDFZ', 3.00, 0.00, '0.00', 92.00),
(93.00, 'BALANCE', 'BALANCE_SHEET', '流动负债合计', 1.00, '年初余额', 'NC_LDFZ_LDFZHJ', 2.00, 0.00, '0.00', 93.00),
(94.00, 'BALANCE', 'BALANCE_SHEET', '流动负债合计', 1.00, '期末余额', 'QM_LDFZ_LDFZHJ', 3.00, 0.00, '0.00', 94.00),
(95.00, 'BALANCE', 'BALANCE_SHEET', '长期借款', 1.00, '年初余额', 'NC_FLDFZ_CQJK', 2.00, 0.00, '0.00', 95.00),
(96.00, 'BALANCE', 'BALANCE_SHEET', '长期借款', 1.00, '期末余额', 'QM_FLDFZ_CQJK', 3.00, 0.00, '0.00', 96.00),
(97.00, 'BALANCE', 'BALANCE_SHEET', '应付债券', 1.00, '年初余额', 'NC_FLDFZ_YFZQ', 2.00, 0.00, '0.00', 97.00),
(98.00, 'BALANCE', 'BALANCE_SHEET', '应付债券', 1.00, '期末余额', 'QM_FLDFZ_YFZQ', 3.00, 0.00, '0.00', 98.00),
(99.00, 'BALANCE', 'BALANCE_SHEET', '长期应付款', 1.00, '年初余额', 'NC_FLDFZ_CQYFK', 2.00, 0.00, '0.00', 99.00),
(100.00, 'BALANCE', 'BALANCE_SHEET', '长期应付款', 1.00, '期末余额', 'QM_FLDFZ_CQYFK', 3.00, 0.00, '0.00', 100.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(101.00, 'BALANCE', 'BALANCE_SHEET', '专项应付款', 1.00, '年初余额', 'NC_FLDFZ_ZXYFK', 2.00, 0.00, '0.00', 101.00),
(102.00, 'BALANCE', 'BALANCE_SHEET', '专项应付款', 1.00, '期末余额', 'QM_FLDFZ_ZXYFK', 3.00, 0.00, '0.00', 102.00),
(103.00, 'BALANCE', 'BALANCE_SHEET', '预计负债', 1.00, '年初余额', 'NC_FLDFZ_YJFZ', 2.00, 0.00, '0.00', 103.00),
(104.00, 'BALANCE', 'BALANCE_SHEET', '预计负债', 1.00, '期末余额', 'QM_FLDFZ_YJFZ', 3.00, 0.00, '0.00', 104.00),
(105.00, 'BALANCE', 'BALANCE_SHEET', '递延收益', 1.00, '年初余额', 'NC_FLDFZ_DYSY', 2.00, 0.00, '0.00', 105.00),
(106.00, 'BALANCE', 'BALANCE_SHEET', '递延收益', 1.00, '期末余额', 'QM_FLDFZ_DYSY', 3.00, 0.00, '0.00', 106.00),
(107.00, 'BALANCE', 'BALANCE_SHEET', '其他非流动负债', 1.00, '年初余额', 'NC_FLDFZ_QTCQFZ', 2.00, 0.00, '0.00', 107.00),
(108.00, 'BALANCE', 'BALANCE_SHEET', '其他非流动负债', 1.00, '期末余额', 'QM_FLDFZ_QTCQFZ', 3.00, 0.00, '0.00', 108.00),
(109.00, 'BALANCE', 'BALANCE_SHEET', '非流动负债合计', 1.00, '年初余额', 'NC_FLDFZ_CQFZHJ', 2.00, 0.00, '0.00', 109.00),
(110.00, 'BALANCE', 'BALANCE_SHEET', '非流动负债合计', 1.00, '期末余额', 'QM_FLDFZ_CQFZHJ', 3.00, 0.00, '0.00', 110.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(111.00, 'BALANCE', 'BALANCE_SHEET', '递延所得税负债', 1.00, '年初余额', 'NC_DYSX_DYSFZ', 2.00, 0.00, '0.00', 111.00),
(112.00, 'BALANCE', 'BALANCE_SHEET', '递延所得税负债', 1.00, '期末余额', 'QM_DYSX_DYSFZ', 3.00, 0.00, '0.00', 112.00),
(113.00, 'BALANCE', 'BALANCE_SHEET', '负债合计', 1.00, '年初余额', 'NC_DYSX_FZHJ', 2.00, 0.00, '0.00', 113.00),
(114.00, 'BALANCE', 'BALANCE_SHEET', '负债合计', 1.00, '期末余额', 'QM_DYSX_FZHJ', 3.00, 0.00, '0.00', 114.00),
(115.00, 'BALANCE', 'BALANCE_SHEET', '实收资本(或股本)', 1.00, '年初余额', 'NC_GDQY_SSZB', 2.00, 0.00, '0.00', 115.00),
(116.00, 'BALANCE', 'BALANCE_SHEET', '实收资本(或股本)', 1.00, '期末余额', 'QM_GDQY_SSZB', 3.00, 0.00, '0.00', 116.00),
(117.00, 'BALANCE', 'BALANCE_SHEET', '减:已归还投资', 1.00, '年初余额', 'NC_GDQY_YGHTZ', 2.00, 0.00, '0.00', 117.00),
(118.00, 'BALANCE', 'BALANCE_SHEET', '减:已归还投资', 1.00, '期末余额', 'QM_GDQY_YGHTZ', 3.00, 0.00, '0.00', 118.00),
(119.00, 'BALANCE', 'BALANCE_SHEET', '实收资本净额', 1.00, '年初余额', 'NC_GDQY_SSZBJE', 2.00, 0.00, '0.00', 119.00),
(120.00, 'BALANCE', 'BALANCE_SHEET', '实收资本净额', 1.00, '期末余额', 'QM_GDQY_SSZBJE', 3.00, 0.00, '0.00', 120.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(121.00, 'BALANCE', 'BALANCE_SHEET', '资本公积', 1.00, '年初余额', 'NC_GDQY_ZBGJ', 2.00, 0.00, '0.00', 121.00),
(122.00, 'BALANCE', 'BALANCE_SHEET', '资本公积', 1.00, '期末余额', 'QM_GDQY_ZBGJ', 3.00, 0.00, '0.00', 122.00),
(123.00, 'BALANCE', 'BALANCE_SHEET', '减:库存股', 1.00, '年初余额', 'NC_GDQY_KCG', 2.00, 0.00, '0.00', 123.00),
(124.00, 'BALANCE', 'BALANCE_SHEET', '减:库存股', 1.00, '期末余额', 'QM_GDQY_KCG', 3.00, 0.00, '0.00', 124.00),
(125.00, 'BALANCE', 'BALANCE_SHEET', '盈余公积', 1.00, '年初余额', 'NC_GDQY_YYGJ', 2.00, 0.00, '0.00', 125.00),
(126.00, 'BALANCE', 'BALANCE_SHEET', '盈余公积', 1.00, '期末余额', 'QM_GDQY_YYGJ', 3.00, 0.00, '0.00', 126.00),
(127.00, 'BALANCE', 'BALANCE_SHEET', '一般风险准备', 1.00, '年初余额', 'NC_GDQY_YBFXZB', 2.00, 0.00, '0.00', 127.00),
(128.00, 'BALANCE', 'BALANCE_SHEET', '一般风险准备', 1.00, '期末余额', 'QM_GDQY_YBFXZB', 3.00, 0.00, '0.00', 128.00),
(129.00, 'BALANCE', 'BALANCE_SHEET', '未分配利润', 1.00, '年初余额', 'NC_GDQY_WFPLR', 2.00, 0.00, '0.00', 129.00),
(130.00, 'BALANCE', 'BALANCE_SHEET', '未分配利润', 1.00, '期末余额', 'QM_GDQY_WFPLR', 3.00, 0.00, '0.00', 130.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(131.00, 'BALANCE', 'BALANCE_SHEET', '归属于母公司所有者权益合计', 1.00, '年初余额', 'NC_GDQY_GSYMGSQYHJ', 2.00, 0.00, '0.00', 131.00),
(132.00, 'BALANCE', 'BALANCE_SHEET', '归属于母公司所有者权益合计', 1.00, '期末余额', 'QM_GDQY_GSYMGSQYHJ', 3.00, 0.00, '0.00', 132.00),
(133.00, 'BALANCE', 'BALANCE_SHEET', '少数股东权益', 1.00, '年初余额', 'NC_GDQY_SSGDQY', 2.00, 0.00, '0.00', 133.00),
(134.00, 'BALANCE', 'BALANCE_SHEET', '少数股东权益', 1.00, '期末余额', 'QM_GDQY_SSGDQY', 3.00, 0.00, '0.00', 134.00),
(135.00, 'BALANCE', 'BALANCE_SHEET', '所有者权益合计', 1.00, '年初余额', 'NC_GDQY_SYZQYHJ', 2.00, 0.00, '0.00', 135.00),
(136.00, 'BALANCE', 'BALANCE_SHEET', '所有者权益合计', 1.00, '期末余额', 'QM_GDQY_SYZQYHJ', 3.00, 0.00, '0.00', 136.00),
(137.00, 'BALANCE', 'BALANCE_SHEET', '负债和所有者权益总计', 1.00, '年初余额', 'NC_GDQY_FZHSYZQY', 2.00, 0.00, '0.00', 137.00),
(138.00, 'BALANCE', 'BALANCE_SHEET', '负债和所有者权益总计', 1.00, '期末余额', 'QM_GDQY_FZHSYZQY', 3.00, 0.00, '0.00', 138.00),
(139.00, 'PROFIT', 'PROFIT_SHEET', '营业收入', 1.00, '本期金额', 'BJ_YYSR', 2.00, 0.00, '0.00', 1.00),
(140.00, 'PROFIT', 'PROFIT_SHEET', '营业收入', 1.00, '上期金额', 'SQ_YYSR', 3.00, 0.00, '0.00', 2.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(141.00, 'PROFIT', 'PROFIT_SHEET', '营业成本', 1.00, '本期金额', 'BJ_YYCB', 2.00, 0.00, '0.00', 3.00),
(142.00, 'PROFIT', 'PROFIT_SHEET', '营业成本', 1.00, '上期金额', 'SQ_YYCB', 3.00, 0.00, '0.00', 4.00),
(143.00, 'PROFIT', 'PROFIT_SHEET', '税金及附加', 1.00, '本期金额', 'BJ_SJJSF', 2.00, 0.00, '0.00', 5.00),
(144.00, 'PROFIT', 'PROFIT_SHEET', '税金及附加', 1.00, '上期金额', 'SQ_SJJSF', 3.00, 0.00, '0.00', 6.00),
(145.00, 'PROFIT', 'PROFIT_SHEET', '销售费用', 1.00, '本期金额', 'BJ_XSFY', 2.00, 0.00, '0.00', 7.00),
(146.00, 'PROFIT', 'PROFIT_SHEET', '销售费用', 1.00, '上期金额', 'SQ_XSFY', 3.00, 0.00, '0.00', 8.00),
(147.00, 'PROFIT', 'PROFIT_SHEET', '管理费用', 1.00, '本期金额', 'BJ_GLFY', 2.00, 0.00, '0.00', 9.00),
(148.00, 'PROFIT', 'PROFIT_SHEET', '管理费用', 1.00, '上期金额', 'SQ_GLFY', 3.00, 0.00, '0.00', 10.00),
(149.00, 'PROFIT', 'PROFIT_SHEET', '研发费用', 1.00, '本期金额', 'BJ_YFFY', 2.00, 0.00, '0.00', 11.00),
(150.00, 'PROFIT', 'PROFIT_SHEET', '研发费用', 1.00, '上期金额', 'SQ_YFFY', 3.00, 0.00, '0.00', 12.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(151.00, 'PROFIT', 'PROFIT_SHEET', '财务费用', 1.00, '本期金额', 'BJ_CWFY', 2.00, 0.00, '0.00', 13.00),
(152.00, 'PROFIT', 'PROFIT_SHEET', '财务费用', 1.00, '上期金额', 'SQ_CWFY', 3.00, 0.00, '0.00', 14.00),
(153.00, 'PROFIT', 'PROFIT_SHEET', '其中:利息费用', 1.00, '本期金额', 'BJ_LXFY', 2.00, 0.00, '0.00', 15.00),
(154.00, 'PROFIT', 'PROFIT_SHEET', '其中:利息费用', 1.00, '上期金额', 'SQ_LXFY', 3.00, 0.00, '0.00', 16.00),
(155.00, 'PROFIT', 'PROFIT_SHEET', '利息收入', 1.00, '本期金额', 'BJ_LRSR', 2.00, 0.00, '0.00', 17.00),
(156.00, 'PROFIT', 'PROFIT_SHEET', '利息收入', 1.00, '上期金额', 'SQ_LRSR', 3.00, 0.00, '0.00', 18.00),
(157.00, 'PROFIT', 'PROFIT_SHEET', '资产减值损失', 1.00, '本期金额', 'BJ_ZCJZSS', 2.00, 0.00, '0.00', 19.00),
(158.00, 'PROFIT', 'PROFIT_SHEET', '资产减值损失', 1.00, '上期金额', 'SQ_ZCJZSS', 3.00, 0.00, '0.00', 20.00),
(159.00, 'PROFIT', 'PROFIT_SHEET', '信用减值损失', 1.00, '本期金额', 'BJ_XYJZSS', 2.00, 0.00, '0.00', 21.00),
(160.00, 'PROFIT', 'PROFIT_SHEET', '信用减值损失', 1.00, '上期金额', 'SQ_XYJZSS', 3.00, 0.00, '0.00', 22.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(161.00, 'PROFIT', 'PROFIT_SHEET', '公允价值变动收益', 1.00, '本期金额', 'BJ_GYJZBD', 2.00, 0.00, '0.00', 23.00),
(162.00, 'PROFIT', 'PROFIT_SHEET', '公允价值变动收益', 1.00, '上期金额', 'SQ_GYJZBD', 3.00, 0.00, '0.00', 24.00),
(163.00, 'PROFIT', 'PROFIT_SHEET', '投资收益', 1.00, '本期金额', 'BJ_TZSY', 2.00, 0.00, '0.00', 25.00),
(164.00, 'PROFIT', 'PROFIT_SHEET', '投资收益', 1.00, '上期金额', 'SQ_TZSY', 3.00, 0.00, '0.00', 26.00),
(165.00, 'PROFIT', 'PROFIT_SHEET', '其中:对联营企业和合营企业的投资收益', 1.00, '本期金额', 'BJ_LYTZSY', 2.00, 0.00, '0.00', 27.00),
(166.00, 'PROFIT', 'PROFIT_SHEET', '其中:对联营企业和合营企业的投资收益', 1.00, '上期金额', 'SQ_LYTZSY', 3.00, 0.00, '0.00', 28.00),
(167.00, 'PROFIT', 'PROFIT_SHEET', '其他收益', 1.00, '本期金额', 'BJ_QTSY', 2.00, 0.00, '0.00', 29.00),
(168.00, 'PROFIT', 'PROFIT_SHEET', '其他收益', 1.00, '上期金额', 'SQ_QTSY', 3.00, 0.00, '0.00', 30.00),
(169.00, 'PROFIT', 'PROFIT_SHEET', '营业利润', 1.00, '本期金额', 'BJ_YYLR', 2.00, 0.00, '0.00', 31.00),
(170.00, 'PROFIT', 'PROFIT_SHEET', '营业利润', 1.00, '上期金额', 'SQ_YYLR', 3.00, 0.00, '0.00', 32.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(171.00, 'PROFIT', 'PROFIT_SHEET', '营业外收入', 1.00, '本期金额', 'BJ_YYWSR', 2.00, 0.00, '0.00', 33.00),
(172.00, 'PROFIT', 'PROFIT_SHEET', '营业外收入', 1.00, '上期金额', 'SQ_YYWSR', 3.00, 0.00, '0.00', 34.00),
(173.00, 'PROFIT', 'PROFIT_SHEET', '营业外支出', 1.00, '本期金额', 'BJ_YYWZC', 2.00, 0.00, '0.00', 35.00),
(174.00, 'PROFIT', 'PROFIT_SHEET', '营业外支出', 1.00, '上期金额', 'SQ_YYWZC', 3.00, 0.00, '0.00', 36.00),
(175.00, 'PROFIT', 'PROFIT_SHEET', '利润总额', 1.00, '本期金额', 'BJ_LRZE', 2.00, 0.00, '0.00', 37.00),
(176.00, 'PROFIT', 'PROFIT_SHEET', '利润总额', 1.00, '上期金额', 'SQ_LRZE', 3.00, 0.00, '0.00', 38.00),
(177.00, 'PROFIT', 'PROFIT_SHEET', '所得税费用', 1.00, '本期金额', 'BJ_SDSFY', 2.00, 0.00, '0.00', 39.00),
(178.00, 'PROFIT', 'PROFIT_SHEET', '所得税费用', 1.00, '上期金额', 'SQ_SDSFY', 3.00, 0.00, '0.00', 40.00),
(179.00, 'PROFIT', 'PROFIT_SHEET', '净利润', 1.00, '本期金额', 'BJ_JLR', 2.00, 0.00, '0.00', 41.00),
(180.00, 'PROFIT', 'PROFIT_SHEET', '净利润', 1.00, '上期金额', 'SQ_JLR', 3.00, 0.00, '0.00', 42.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(181.00, 'PROFIT', 'PROFIT_SHEET', '持续经营净利润', 1.00, '本期金额', 'BJ_CXYJLR', 2.00, 0.00, '0.00', 43.00),
(182.00, 'PROFIT', 'PROFIT_SHEET', '持续经营净利润', 1.00, '上期金额', 'SQ_CXYJLR', 3.00, 0.00, '0.00', 44.00),
(183.00, 'PROFIT', 'PROFIT_SHEET', '终止经营净利润', 1.00, '本期金额', 'BJ_ZSYJLR', 2.00, 0.00, '0.00', 45.00),
(184.00, 'PROFIT', 'PROFIT_SHEET', '终止经营净利润', 1.00, '上期金额', 'SQ_ZSYJLR', 3.00, 0.00, '0.00', 46.00),
(185.00, 'PROFIT', 'PROFIT_SHEET', '综合收益总额', 1.00, '本期金额', 'BJ_ZHSYZE', 2.00, 0.00, '0.00', 47.00),
(186.00, 'PROFIT', 'PROFIT_SHEET', '综合收益总额', 1.00, '上期金额', 'SQ_ZHSYZE', 3.00, 0.00, '0.00', 48.00),
(187.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '销售商品、提供劳务收到的现金', 1.00, '本期金额', 'BJ_XSSPTLWSRDXJ', 2.00, 0.00, '0.00', 1.00),
(188.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '销售商品、提供劳务收到的现金', 1.00, '上期金额', 'SQ_XSSPTLWSRDXJ', 3.00, 0.00, '0.00', 2.00),
(189.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '收到的税费返还', 1.00, '本期金额', 'BJ_SDDDSFFH', 2.00, 0.00, '0.00', 3.00),
(190.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '收到的税费返还', 1.00, '上期金额', 'SQ_SDDDSFFH', 3.00, 0.00, '0.00', 4.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(191.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '收到其他与经营活动有关的现金', 1.00, '本期金额', 'BJ_SDQTYJYHDDXJ', 2.00, 0.00, '0.00', 5.00),
(192.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '收到其他与经营活动有关的现金', 1.00, '上期金额', 'SQ_SDQTYJYHDDXJ', 3.00, 0.00, '0.00', 6.00),
(193.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '经营活动现金流入小计', 1.00, '本期金额', 'BJ_JYHDXJLRXJ', 2.00, 0.00, '0.00', 7.00),
(194.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '经营活动现金流入小计', 1.00, '上期金额', 'SQ_JYHDXJLRXJ', 3.00, 0.00, '0.00', 8.00),
(195.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '购买商品、接受劳务支付的现金', 1.00, '本期金额', 'BJ_GMWJSLWZFDXJ', 2.00, 0.00, '0.00', 9.00),
(196.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '购买商品、接受劳务支付的现金', 1.00, '上期金额', 'SQ_GMWJSLWZFDXJ', 3.00, 0.00, '0.00', 10.00),
(197.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '支付给职工以及为职工支付的现金', 1.00, '本期金额', 'BJ_ZFZGYJWGZFDXJ', 2.00, 0.00, '0.00', 11.00),
(198.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '支付给职工以及为职工支付的现金', 1.00, '上期金额', 'SQ_ZFZGYJWGZFDXJ', 3.00, 0.00, '0.00', 12.00),
(199.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '支付的各项税费', 1.00, '本期金额', 'BJ_ZFDFVAT', 2.00, 0.00, '0.00', 13.00),
(200.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '支付的各项税费', 1.00, '上期金额', 'SQ_ZFDFVAT', 3.00, 0.00, '0.00', 14.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(201.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '支付其他与经营活动有关的现金', 1.00, '本期金额', 'BJ_ZFQTYJYHDDXJ', 2.00, 0.00, '0.00', 15.00),
(202.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '支付其他与经营活动有关的现金', 1.00, '上期金额', 'SQ_ZFQTYJYHDDXJ', 3.00, 0.00, '0.00', 16.00),
(203.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '经营活动现金流出小计', 1.00, '本期金额', 'BJ_JYHDXJLCXJ', 2.00, 0.00, '0.00', 17.00),
(204.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '经营活动现金流出小计', 1.00, '上期金额', 'SQ_JYHDXJLCXJ', 3.00, 0.00, '0.00', 18.00),
(205.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '经营活动产生的现金流量净额', 1.00, '本期金额', 'BJ_JYHDCSDXJLJE', 2.00, 0.00, '0.00', 19.00),
(206.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '经营活动产生的现金流量净额', 1.00, '上期金额', 'SQ_JYHDCSDXJLJE', 3.00, 0.00, '0.00', 20.00),
(207.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '投资活动现金流入小计', 1.00, '本期金额', 'BJ_TZHDXJLRXJ', 2.00, 0.00, '0.00', 21.00),
(208.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '投资活动现金流入小计', 1.00, '上期金额', 'SQ_TZHDXJLRXJ', 3.00, 0.00, '0.00', 22.00),
(209.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '投资活动现金流出小计', 1.00, '本期金额', 'BJ_TZHDXJLCXJ', 2.00, 0.00, '0.00', 23.00),
(210.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '投资活动现金流出小计', 1.00, '上期金额', 'SQ_TZHDXJLCXJ', 3.00, 0.00, '0.00', 24.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(211.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '投资活动产生的现金流量净额', 1.00, '本期金额', 'BJ_TZHDCSDXJLJE', 2.00, 0.00, '0.00', 25.00),
(212.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '投资活动产生的现金流量净额', 1.00, '上期金额', 'SQ_TZHDCSDXJLJE', 3.00, 0.00, '0.00', 26.00),
(213.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '筹资活动现金流入小计', 1.00, '本期金额', 'BJ_CZHDXJLRXJ', 2.00, 0.00, '0.00', 27.00),
(214.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '筹资活动现金流入小计', 1.00, '上期金额', 'SQ_CZHDXJLRXJ', 3.00, 0.00, '0.00', 28.00),
(215.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '筹资活动现金流出小计', 1.00, '本期金额', 'BJ_CZHDXJLCXJ', 2.00, 0.00, '0.00', 29.00),
(216.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '筹资活动现金流出小计', 1.00, '上期金额', 'SQ_CZHDXJLCXJ', 3.00, 0.00, '0.00', 30.00),
(217.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '筹资活动产生的现金流量净额', 1.00, '本期金额', 'BJ_CZHDCSDXJLJE', 2.00, 0.00, '0.00', 31.00),
(218.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '筹资活动产生的现金流量净额', 1.00, '上期金额', 'SQ_CZHDCSDXJLJE', 3.00, 0.00, '0.00', 32.00),
(219.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '汇率变动对现金及现金等价物的影响', 1.00, '本期金额', 'BJ_HLLVBDDXJ', 2.00, 0.00, '0.00', 33.00),
(220.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '汇率变动对现金及现金等价物的影响', 1.00, '上期金额', 'SQ_HLLVBDDXJ', 3.00, 0.00, '0.00', 34.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(221.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '现金及现金等价物净增加额', 1.00, '本期金额', 'BJ_XJJXJDJWJZJE', 2.00, 0.00, '0.00', 35.00),
(222.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '现金及现金等价物净增加额', 1.00, '上期金额', 'SQ_XJJXJDJWJZJE', 3.00, 0.00, '0.00', 36.00),
(223.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '期初现金及现金等价物余额', 1.00, '本期金额', 'BJ_QCXJJXJDJWYE', 2.00, 0.00, '0.00', 37.00),
(224.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '期初现金及现金等价物余额', 1.00, '上期金额', 'SQ_QCXJJXJDJWYE', 3.00, 0.00, '0.00', 38.00),
(225.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '期末现金及现金等价物余额', 1.00, '本期金额', 'BJ_QMXJJXJDJWYE', 2.00, 0.00, '0.00', 39.00),
(226.00, 'CASHFLOW', 'CASH_FLOW_SHEET', '期末现金及现金等价物余额', 1.00, '上期金额', 'SQ_QMXJJXJDJWYE', 3.00, 0.00, '0.00', 40.00),
(227.00, 'KMYE', 'SUBJECT_BALANCE', '科目代码', 1.00, '科目代码', 'SUBJECT_CODE', 1.00, 1.00, '0.00', 1.00),
(228.00, 'KMYE', 'SUBJECT_BALANCE', '科目名称', 1.00, '科目名称', 'SUBJECT_NAME', 2.00, 0.00, '0.00', 2.00),
(229.00, 'KMYE', 'SUBJECT_BALANCE', '科目级次', 1.00, '科目级次', 'SUBJECT_LEVEL', 3.00, 0.00, '0.00', 3.00),
(230.00, 'KMYE', 'SUBJECT_BALANCE', '期初余额', 1.00, '期初余额', 'QC_AMOUNT', 4.00, 0.00, '0.00', 4.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(231.00, 'KMYE', 'SUBJECT_BALANCE', '本期借方', 1.00, '本期借方', 'PERIOD_DEBIT', 5.00, 0.00, '0.00', 5.00),
(232.00, 'KMYE', 'SUBJECT_BALANCE', '本期贷方', 1.00, '本期贷方', 'PERIOD_CREDIT', 6.00, 0.00, '0.00', 6.00),
(233.00, 'KMYE', 'SUBJECT_BALANCE', '期末余额', 1.00, '期末余额', 'QM_AMOUNT', 7.00, 0.00, '0.00', 7.00),
(234.00, 'AGING', 'AGING_ANALYSIS', '核算项目代码', 1.00, '核算项目代码', 'PROJECT_CODE', 1.00, 1.00, '0.00', 1.00),
(235.00, 'AGING', 'AGING_ANALYSIS', '核算项目名称', 1.00, '核算项目名称', 'PROJECT_NAME', 2.00, 0.00, '0.00', 2.00),
(236.00, 'AGING', 'AGING_ANALYSIS', '余额', 1.00, '余额', 'BALANCE', 3.00, 0.00, '0.00', 3.00),
(237.00, 'AGING', 'AGING_ANALYSIS', '信用期限', 1.00, '信用期限', 'CREDIT_PERIOD', 4.00, 0.00, '0.00', 4.00),
(238.00, 'AGING', 'AGING_ANALYSIS', '信用额度', 1.00, '信用额度', 'CREDIT_LINE', 5.00, 0.00, '0.00', 5.00),
(239.00, 'AGING', 'AGING_ANALYSIS', '未到期1至30天', 1.00, '未到期1至30天', 'NOT_DUE1_TO30_DAYS', 6.00, 0.00, '0.00', 6.00),
(240.00, 'AGING', 'AGING_ANALYSIS', '未到期31至90天', 1.00, '未到期31至90天', 'NOT_DUE31_TO90_DAYS', 7.00, 0.00, '0.00', 7.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(241.00, 'AGING', 'AGING_ANALYSIS', '未到期91至180天', 1.00, '未到期91至180天', 'NOT_DUE91_TO180_DAYS', 8.00, 0.00, '0.00', 8.00),
(242.00, 'AGING', 'AGING_ANALYSIS', '未到期181天以上', 1.00, '未到期181天以上', 'NOT_DUE181_DAYS', 9.00, 0.00, '0.00', 9.00),
(243.00, 'AGING', 'AGING_ANALYSIS', '到期1至30天', 1.00, '到期1至30天', 'DUE1_TO30_DAYS', 10.00, 0.00, '0.00', 10.00),
(244.00, 'AGING', 'AGING_ANALYSIS', '到期31至90天', 1.00, '到期31至90天', 'DUE31_TO90_DAYS', 11.00, 0.00, '0.00', 11.00),
(245.00, 'AGING', 'AGING_ANALYSIS', '到期91至180天', 1.00, '到期91至180天', 'DUE91_TO180_DAYS', 12.00, 0.00, '0.00', 12.00),
(246.00, 'AGING', 'AGING_ANALYSIS', '到期181至360天', 1.00, '到期181至360天', 'DUE181_TO360_DAYS', 13.00, 0.00, '0.00', 13.00),
(247.00, 'AGING', 'AGING_ANALYSIS', '到期361至720天', 1.00, '到期361至720天', 'DUE361_TO720_DAYS', 14.00, 0.00, '0.00', 14.00),
(248.00, 'AGING', 'AGING_ANALYSIS', '到期721至1080天', 1.00, '到期721至1080天', 'DUE721_TO1080_DAYS', 15.00, 0.00, '0.00', 15.00),
(249.00, 'AGING', 'AGING_ANALYSIS', '到期1081至1440天', 1.00, '到期1081至1440天', 'DUE1081_TO1440_DAYS', 16.00, 0.00, '0.00', 16.00),
(250.00, 'AGING', 'AGING_ANALYSIS', '到期1441天以上', 1.00, '到期1441天以上', 'DUE1441_DAYS', 17.00, 0.00, '0.00', 17.00);
INSERT INTO t_report_property (id, report_type, report_code, subject_name, subject_level, source_column, column_code, col_index, is_key, default_value, order_no) VALUES
(251.00, 'AGING', 'AGING_ANALYSIS', '到期日', 1.00, '到期日', 'DUE_TODAY', 18.00, 0.00, '0.00', 18.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(1.00, 'A001', '货币资金', 'BALANCE', '资产负债', 'line', 2.00, '元', 1.00, 1.00),
(2.00, 'A002', '交易性金融资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 2.00, 1.00),
(3.00, 'A003', '应收票据', 'BALANCE', '资产负债', 'line', 2.00, '元', 3.00, 1.00),
(4.00, 'A004', '应收账款', 'BALANCE', '资产负债', 'line', 2.00, '元', 4.00, 1.00),
(5.00, 'A005', '预付款项', 'BALANCE', '资产负债', 'line', 2.00, '元', 5.00, 1.00),
(6.00, 'A006', '应收股利', 'BALANCE', '资产负债', 'line', 2.00, '元', 6.00, 1.00),
(7.00, 'A007', '应收利息', 'BALANCE', '资产负债', 'line', 2.00, '元', 7.00, 1.00),
(8.00, 'A008', '其他应收款', 'BALANCE', '资产负债', 'line', 2.00, '元', 8.00, 1.00),
(9.00, 'A009', '存货', 'BALANCE', '资产负债', 'line', 2.00, '元', 9.00, 1.00),
(10.00, 'A010', '待摊费用', 'BALANCE', '资产负债', 'line', 2.00, '元', 10.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(11.00, 'A011', '一年内到期的非流动资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 11.00, 1.00),
(12.00, 'A012', '其他流动资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 12.00, 1.00),
(13.00, 'A013', '流动资产合计', 'BALANCE', '资产负债', 'line', 2.00, '元', 13.00, 1.00),
(14.00, 'A014', '可供出售金融资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 14.00, 1.00),
(15.00, 'A015', '持有至到期投资', 'BALANCE', '资产负债', 'line', 2.00, '元', 15.00, 1.00),
(16.00, 'A016', '长期应收款', 'BALANCE', '资产负债', 'line', 2.00, '元', 16.00, 1.00),
(17.00, 'A017', '长期股权投资', 'BALANCE', '资产负债', 'line', 2.00, '元', 17.00, 1.00),
(18.00, 'A018', '投资性房地产', 'BALANCE', '资产负债', 'line', 2.00, '元', 18.00, 1.00),
(19.00, 'A019', '固定资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 19.00, 1.00),
(20.00, 'A020', '在建工程', 'BALANCE', '资产负债', 'line', 2.00, '元', 20.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(21.00, 'A021', '工程物资', 'BALANCE', '资产负债', 'line', 2.00, '元', 21.00, 1.00),
(22.00, 'A022', '固定资产清理', 'BALANCE', '资产负债', 'line', 2.00, '元', 22.00, 1.00),
(23.00, 'A023', '生产性生物资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 23.00, 1.00),
(24.00, 'A024', '油气资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 24.00, 1.00),
(25.00, 'A025', '无形资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 25.00, 1.00),
(26.00, 'A026', '开发支出', 'BALANCE', '资产负债', 'line', 2.00, '元', 26.00, 1.00),
(27.00, 'A027', '商誉', 'BALANCE', '资产负债', 'line', 2.00, '元', 27.00, 1.00),
(28.00, 'A028', '长期待摊费用', 'BALANCE', '资产负债', 'line', 2.00, '元', 28.00, 1.00),
(29.00, 'A029', '递延所得税资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 29.00, 1.00),
(30.00, 'A030', '其他非流动资产', 'BALANCE', '资产负债', 'line', 2.00, '元', 30.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(31.00, 'A031', '非流动资产合计', 'BALANCE', '资产负债', 'line', 2.00, '元', 31.00, 1.00),
(32.00, 'A032', '资产总计', 'BALANCE', '资产负债', 'line', 2.00, '元', 32.00, 1.00),
(33.00, 'A033', '短期借款', 'BALANCE', '资产负债', 'line', 2.00, '元', 33.00, 1.00),
(34.00, 'A034', '交易性金融负债', 'BALANCE', '资产负债', 'line', 2.00, '元', 34.00, 1.00),
(35.00, 'A035', '应付票据', 'BALANCE', '资产负债', 'line', 2.00, '元', 35.00, 1.00),
(36.00, 'A036', '应付账款', 'BALANCE', '资产负债', 'line', 2.00, '元', 36.00, 1.00),
(37.00, 'A037', '预收款项', 'BALANCE', '资产负债', 'line', 2.00, '元', 37.00, 1.00),
(38.00, 'A038', '应付职工薪酬', 'BALANCE', '资产负债', 'line', 2.00, '元', 38.00, 1.00),
(39.00, 'A039', '应付福利费', 'BALANCE', '资产负债', 'line', 2.00, '元', 39.00, 1.00),
(40.00, 'A040', '应交税费', 'BALANCE', '资产负债', 'line', 2.00, '元', 40.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(41.00, 'A041', '应付利息', 'BALANCE', '资产负债', 'line', 2.00, '元', 41.00, 1.00),
(42.00, 'A042', '应付股利', 'BALANCE', '资产负债', 'line', 2.00, '元', 42.00, 1.00),
(43.00, 'A043', '其他应付款', 'BALANCE', '资产负债', 'line', 2.00, '元', 43.00, 1.00),
(44.00, 'A044', '预提费用', 'BALANCE', '资产负债', 'line', 2.00, '元', 44.00, 1.00),
(45.00, 'A045', '一年内到期的非流动负债', 'BALANCE', '资产负债', 'line', 2.00, '元', 45.00, 1.00),
(46.00, 'A046', '其他流动负债', 'BALANCE', '资产负债', 'line', 2.00, '元', 46.00, 1.00),
(47.00, 'A047', '流动负债合计', 'BALANCE', '资产负债', 'line', 2.00, '元', 47.00, 1.00),
(48.00, 'A048', '长期借款', 'BALANCE', '资产负债', 'line', 2.00, '元', 48.00, 1.00),
(49.00, 'A049', '应付债券', 'BALANCE', '资产负债', 'line', 2.00, '元', 49.00, 1.00),
(50.00, 'A050', '长期应付款', 'BALANCE', '资产负债', 'line', 2.00, '元', 50.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(51.00, 'A051', '专项应付款', 'BALANCE', '资产负债', 'line', 2.00, '元', 51.00, 1.00),
(52.00, 'A052', '预计负债', 'BALANCE', '资产负债', 'line', 2.00, '元', 52.00, 1.00),
(53.00, 'A053', '递延收益', 'BALANCE', '资产负债', 'line', 2.00, '元', 53.00, 1.00),
(54.00, 'A054', '其他非流动负债', 'BALANCE', '资产负债', 'line', 2.00, '元', 54.00, 1.00),
(55.00, 'A055', '非流动负债合计', 'BALANCE', '资产负债', 'line', 2.00, '元', 55.00, 1.00),
(56.00, 'A056', '递延所得税负债', 'BALANCE', '资产负债', 'line', 2.00, '元', 56.00, 1.00),
(57.00, 'A057', '负债合计', 'BALANCE', '资产负债', 'line', 2.00, '元', 57.00, 1.00),
(58.00, 'A058', '实收资本(或股本)', 'BALANCE', '资产负债', 'line', 2.00, '元', 58.00, 1.00),
(59.00, 'A059', '减:已归还投资', 'BALANCE', '资产负债', 'line', 2.00, '元', 59.00, 1.00),
(60.00, 'A060', '实收资本净额', 'BALANCE', '资产负债', 'line', 2.00, '元', 60.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(61.00, 'A061', '资本公积', 'BALANCE', '资产负债', 'line', 2.00, '元', 61.00, 1.00),
(62.00, 'A062', '减:库存股', 'BALANCE', '资产负债', 'line', 2.00, '元', 62.00, 1.00),
(63.00, 'A063', '盈余公积', 'BALANCE', '资产负债', 'line', 2.00, '元', 63.00, 1.00),
(64.00, 'A064', '一般风险准备', 'BALANCE', '资产负债', 'line', 2.00, '元', 64.00, 1.00),
(65.00, 'A065', '未分配利润', 'BALANCE', '资产负债', 'line', 2.00, '元', 65.00, 1.00),
(66.00, 'A066', '归属于母公司所有者权益合计', 'BALANCE', '资产负债', 'line', 2.00, '元', 66.00, 1.00),
(67.00, 'A067', '少数股东权益', 'BALANCE', '资产负债', 'line', 2.00, '元', 67.00, 1.00),
(68.00, 'A068', '所有者权益合计', 'BALANCE', '资产负债', 'line', 2.00, '元', 68.00, 1.00),
(69.00, 'A069', '负债和所有者权益总计', 'BALANCE', '资产负债', 'line', 2.00, '元', 69.00, 1.00),
(70.00, 'P001', '营业收入', 'PROFIT', '利润', 'bar', 2.00, '元', 100.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(71.00, 'P002', '营业成本', 'PROFIT', '利润', 'bar', 2.00, '元', 101.00, 1.00),
(72.00, 'P003', '税金及附加', 'PROFIT', '利润', 'bar', 2.00, '元', 102.00, 1.00),
(73.00, 'P004', '销售费用', 'PROFIT', '利润', 'bar', 2.00, '元', 103.00, 1.00),
(74.00, 'P005', '管理费用', 'PROFIT', '利润', 'bar', 2.00, '元', 104.00, 1.00),
(75.00, 'P006', '研发费用', 'PROFIT', '利润', 'bar', 2.00, '元', 105.00, 1.00),
(76.00, 'P007', '财务费用', 'PROFIT', '利润', 'bar', 2.00, '元', 106.00, 1.00),
(77.00, 'P008', '其中:利息费用', 'PROFIT', '利润', 'bar', 2.00, '元', 107.00, 1.00),
(78.00, 'P009', '利息收入', 'PROFIT', '利润', 'bar', 2.00, '元', 108.00, 1.00),
(79.00, 'P010', '资产减值损失', 'PROFIT', '利润', 'bar', 2.00, '元', 109.00, 1.00),
(80.00, 'P011', '信用减值损失', 'PROFIT', '利润', 'bar', 2.00, '元', 110.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(81.00, 'P012', '公允价值变动收益', 'PROFIT', '利润', 'bar', 2.00, '元', 111.00, 1.00),
(82.00, 'P013', '投资收益', 'PROFIT', '利润', 'bar', 2.00, '元', 112.00, 1.00),
(83.00, 'P014', '其中:对联营企业和合营企业的投资收益', 'PROFIT', '利润', 'bar', 2.00, '元', 113.00, 1.00),
(84.00, 'P015', '其他收益', 'PROFIT', '利润', 'bar', 2.00, '元', 114.00, 1.00),
(85.00, 'P016', '营业利润', 'PROFIT', '利润', 'bar', 2.00, '元', 115.00, 1.00),
(86.00, 'P017', '营业外收入', 'PROFIT', '利润', 'bar', 2.00, '元', 116.00, 1.00),
(87.00, 'P018', '营业外支出', 'PROFIT', '利润', 'bar', 2.00, '元', 117.00, 1.00),
(88.00, 'P019', '利润总额', 'PROFIT', '利润', 'bar', 2.00, '元', 118.00, 1.00),
(89.00, 'P020', '所得税费用', 'PROFIT', '利润', 'bar', 2.00, '元', 119.00, 1.00),
(90.00, 'P021', '净利润', 'PROFIT', '利润', 'bar', 2.00, '元', 120.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(91.00, 'P022', '持续经营净利润', 'PROFIT', '利润', 'bar', 2.00, '元', 121.00, 1.00),
(92.00, 'P023', '终止经营净利润', 'PROFIT', '利润', 'bar', 2.00, '元', 122.00, 1.00),
(93.00, 'P024', '综合收益总额', 'PROFIT', '利润', 'bar', 2.00, '元', 123.00, 1.00),
(94.00, 'C001', '销售商品、提供劳务收到的现金', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 200.00, 1.00),
(95.00, 'C002', '收到的税费返还', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 201.00, 1.00),
(96.00, 'C003', '收到其他与经营活动有关的现金', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 202.00, 1.00),
(97.00, 'C004', '经营活动现金流入小计', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 203.00, 1.00),
(98.00, 'C005', '购买商品、接受劳务支付的现金', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 204.00, 1.00),
(99.00, 'C006', '支付给职工以及为职工支付的现金', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 205.00, 1.00),
(100.00, 'C007', '支付的各项税费', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 206.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(101.00, 'C008', '支付其他与经营活动有关的现金', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 207.00, 1.00),
(102.00, 'C009', '经营活动现金流出小计', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 208.00, 1.00),
(103.00, 'C010', '经营活动产生的现金流量净额', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 209.00, 1.00),
(104.00, 'C011', '投资活动现金流入小计', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 210.00, 1.00),
(105.00, 'C012', '投资活动现金流出小计', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 211.00, 1.00),
(106.00, 'C013', '投资活动产生的现金流量净额', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 212.00, 1.00),
(107.00, 'C014', '筹资活动现金流入小计', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 213.00, 1.00),
(108.00, 'C015', '筹资活动现金流出小计', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 214.00, 1.00),
(109.00, 'C016', '筹资活动产生的现金流量净额', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 215.00, 1.00),
(110.00, 'C017', '汇率变动对现金及现金等价物的影响', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 216.00, 1.00);
INSERT INTO t_code_libr (id, code, code_name, report_type, report_group, chart_type, precision_scale, unit, order_no, is_active) VALUES
(111.00, 'C018', '现金及现金等价物净增加额', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 217.00, 1.00),
(112.00, 'C019', '期初现金及现金等价物余额', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 218.00, 1.00),
(113.00, 'C020', '期末现金及现金等价物余额', 'CASHFLOW', '现金流量', 'bar', 2.00, '元', 219.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(1.00, 't_basi_assets_and_liabilities', 'NC_LDZC_HBZJ', 'NC', 'BALANCE', 'A001', 'COLUMN', NULL, 1.00, 1.00),
(2.00, 't_basi_assets_and_liabilities', 'QM_LDZC_HBZJ', 'QM', 'BALANCE', 'A001', 'COLUMN', NULL, 2.00, 1.00),
(3.00, 't_basi_assets_and_liabilities', 'NC_LDZC_JYXJRZC', 'NC', 'BALANCE', 'A002', 'COLUMN', NULL, 3.00, 1.00),
(4.00, 't_basi_assets_and_liabilities', 'QM_LDZC_JYXJRZC', 'QM', 'BALANCE', 'A002', 'COLUMN', NULL, 4.00, 1.00),
(5.00, 't_basi_assets_and_liabilities', 'NC_LDZC_YSPJ', 'NC', 'BALANCE', 'A003', 'COLUMN', NULL, 5.00, 1.00),
(6.00, 't_basi_assets_and_liabilities', 'QM_LDZC_YSPJ', 'QM', 'BALANCE', 'A003', 'COLUMN', NULL, 6.00, 1.00),
(7.00, 't_basi_assets_and_liabilities', 'NC_LDZC_YSZK', 'NC', 'BALANCE', 'A004', 'COLUMN', NULL, 7.00, 1.00),
(8.00, 't_basi_assets_and_liabilities', 'QM_LDZC_YSZK', 'QM', 'BALANCE', 'A004', 'COLUMN', NULL, 8.00, 1.00),
(9.00, 't_basi_assets_and_liabilities', 'NC_LDZC_YFZK', 'NC', 'BALANCE', 'A005', 'COLUMN', NULL, 9.00, 1.00),
(10.00, 't_basi_assets_and_liabilities', 'QM_LDZC_YFZK', 'QM', 'BALANCE', 'A005', 'COLUMN', NULL, 10.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(11.00, 't_basi_assets_and_liabilities', 'NC_LDZC_YSFL', 'NC', 'BALANCE', 'A006', 'COLUMN', NULL, 11.00, 1.00),
(12.00, 't_basi_assets_and_liabilities', 'QM_LDZC_YSFL', 'QM', 'BALANCE', 'A006', 'COLUMN', NULL, 12.00, 1.00),
(13.00, 't_basi_assets_and_liabilities', 'NC_LDZC_YSLX', 'NC', 'BALANCE', 'A007', 'COLUMN', NULL, 13.00, 1.00),
(14.00, 't_basi_assets_and_liabilities', 'QM_LDZC_YSLX', 'QM', 'BALANCE', 'A007', 'COLUMN', NULL, 14.00, 1.00),
(15.00, 't_basi_assets_and_liabilities', 'NC_LDZC_QTYSK', 'NC', 'BALANCE', 'A008', 'COLUMN', NULL, 15.00, 1.00),
(16.00, 't_basi_assets_and_liabilities', 'QM_LDZC_QTYSK', 'QM', 'BALANCE', 'A008', 'COLUMN', NULL, 16.00, 1.00),
(17.00, 't_basi_assets_and_liabilities', 'NC_LDZC_CH', 'NC', 'BALANCE', 'A009', 'COLUMN', NULL, 17.00, 1.00),
(18.00, 't_basi_assets_and_liabilities', 'QM_LDZC_CH', 'QM', 'BALANCE', 'A009', 'COLUMN', NULL, 18.00, 1.00),
(19.00, 't_basi_assets_and_liabilities', 'NC_LDZC_DTFY', 'NC', 'BALANCE', 'A010', 'COLUMN', NULL, 19.00, 1.00),
(20.00, 't_basi_assets_and_liabilities', 'QM_LDZC_DTFY', 'QM', 'BALANCE', 'A010', 'COLUMN', NULL, 20.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(21.00, 't_basi_assets_and_liabilities', 'NC_LDZC_YNNDQCQZQTZ', 'NC', 'BALANCE', 'A011', 'COLUMN', NULL, 21.00, 1.00),
(22.00, 't_basi_assets_and_liabilities', 'QM_LDZC_YNNDQCQZQTZ', 'QM', 'BALANCE', 'A011', 'COLUMN', NULL, 22.00, 1.00),
(23.00, 't_basi_assets_and_liabilities', 'NC_LDZC_QTLDZC', 'NC', 'BALANCE', 'A012', 'COLUMN', NULL, 23.00, 1.00),
(24.00, 't_basi_assets_and_liabilities', 'QM_LDZC_QTLDZC', 'QM', 'BALANCE', 'A012', 'COLUMN', NULL, 24.00, 1.00),
(25.00, 't_basi_assets_and_liabilities', 'NC_LDZC_HJ', 'NC', 'BALANCE', 'A013', 'COLUMN', NULL, 25.00, 1.00),
(26.00, 't_basi_assets_and_liabilities', 'QM_LDZC_HJ', 'QM', 'BALANCE', 'A013', 'COLUMN', NULL, 26.00, 1.00),
(27.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_KGCSJRZC', 'NC', 'BALANCE', 'A014', 'COLUMN', NULL, 27.00, 1.00),
(28.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_KGCSJRZC', 'QM', 'BALANCE', 'A014', 'COLUMN', NULL, 28.00, 1.00),
(29.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_CYZDQTZ', 'NC', 'BALANCE', 'A015', 'COLUMN', NULL, 29.00, 1.00),
(30.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_CYZDQTZ', 'QM', 'BALANCE', 'A015', 'COLUMN', NULL, 30.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(31.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_CQYSK', 'NC', 'BALANCE', 'A016', 'COLUMN', NULL, 31.00, 1.00),
(32.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_CQYSK', 'QM', 'BALANCE', 'A016', 'COLUMN', NULL, 32.00, 1.00),
(33.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_CQGQTZ', 'NC', 'BALANCE', 'A017', 'COLUMN', NULL, 33.00, 1.00),
(34.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_CQGQTZ', 'QM', 'BALANCE', 'A017', 'COLUMN', NULL, 34.00, 1.00),
(35.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_TZXFDC', 'NC', 'BALANCE', 'A018', 'COLUMN', NULL, 35.00, 1.00),
(36.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_TZXFDC', 'QM', 'BALANCE', 'A018', 'COLUMN', NULL, 36.00, 1.00),
(37.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_GDZC', 'NC', 'BALANCE', 'A019', 'COLUMN', NULL, 37.00, 1.00),
(38.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_GDZC', 'QM', 'BALANCE', 'A019', 'COLUMN', NULL, 38.00, 1.00),
(39.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_ZJGC', 'NC', 'BALANCE', 'A020', 'COLUMN', NULL, 39.00, 1.00),
(40.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_ZJGC', 'QM', 'BALANCE', 'A020', 'COLUMN', NULL, 40.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(41.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_GCWZ', 'NC', 'BALANCE', 'A021', 'COLUMN', NULL, 41.00, 1.00),
(42.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_GCWZ', 'QM', 'BALANCE', 'A021', 'COLUMN', NULL, 42.00, 1.00),
(43.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_GDZCQL', 'NC', 'BALANCE', 'A022', 'COLUMN', NULL, 43.00, 1.00),
(44.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_GDZCQL', 'QM', 'BALANCE', 'A022', 'COLUMN', NULL, 44.00, 1.00),
(45.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_SCXSWZC', 'NC', 'BALANCE', 'A023', 'COLUMN', NULL, 45.00, 1.00),
(46.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_SCXSWZC', 'QM', 'BALANCE', 'A023', 'COLUMN', NULL, 46.00, 1.00),
(47.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_YQZC', 'NC', 'BALANCE', 'A024', 'COLUMN', NULL, 47.00, 1.00),
(48.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_YQZC', 'QM', 'BALANCE', 'A024', 'COLUMN', NULL, 48.00, 1.00),
(49.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_WXZC', 'NC', 'BALANCE', 'A025', 'COLUMN', NULL, 49.00, 1.00),
(50.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_WXZC', 'QM', 'BALANCE', 'A025', 'COLUMN', NULL, 50.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(51.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_KFZC', 'NC', 'BALANCE', 'A026', 'COLUMN', NULL, 51.00, 1.00),
(52.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_KFZC', 'QM', 'BALANCE', 'A026', 'COLUMN', NULL, 52.00, 1.00),
(53.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_SY', 'NC', 'BALANCE', 'A027', 'COLUMN', NULL, 53.00, 1.00),
(54.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_SY', 'QM', 'BALANCE', 'A027', 'COLUMN', NULL, 54.00, 1.00),
(55.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_CQDTFY', 'NC', 'BALANCE', 'A028', 'COLUMN', NULL, 55.00, 1.00),
(56.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_CQDTFY', 'QM', 'BALANCE', 'A028', 'COLUMN', NULL, 56.00, 1.00),
(57.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_DYSDSZC', 'NC', 'BALANCE', 'A029', 'COLUMN', NULL, 57.00, 1.00),
(58.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_DYSDSZC', 'QM', 'BALANCE', 'A029', 'COLUMN', NULL, 58.00, 1.00),
(59.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_QTFLDZC', 'NC', 'BALANCE', 'A030', 'COLUMN', NULL, 59.00, 1.00),
(60.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_QTFLDZC', 'QM', 'BALANCE', 'A030', 'COLUMN', NULL, 60.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(61.00, 't_basi_assets_and_liabilities', 'NC_FLDZC_FLDZCHJ', 'NC', 'BALANCE', 'A031', 'COLUMN', NULL, 61.00, 1.00),
(62.00, 't_basi_assets_and_liabilities', 'QM_FLDZC_FLDZCHJ', 'QM', 'BALANCE', 'A031', 'COLUMN', NULL, 62.00, 1.00),
(63.00, 't_basi_assets_and_liabilities', 'NC_ZCZJ', 'NC', 'BALANCE', 'A032', 'COLUMN', NULL, 63.00, 1.00),
(64.00, 't_basi_assets_and_liabilities', 'QM_ZCZJ', 'QM', 'BALANCE', 'A032', 'COLUMN', NULL, 64.00, 1.00),
(65.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_DQJK', 'NC', 'BALANCE', 'A033', 'COLUMN', NULL, 65.00, 1.00),
(66.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_DQJK', 'QM', 'BALANCE', 'A033', 'COLUMN', NULL, 66.00, 1.00),
(67.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_JYXJRFZ', 'NC', 'BALANCE', 'A034', 'COLUMN', NULL, 67.00, 1.00),
(68.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_JYXJRFZ', 'QM', 'BALANCE', 'A034', 'COLUMN', NULL, 68.00, 1.00),
(69.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YFPJ', 'NC', 'BALANCE', 'A035', 'COLUMN', NULL, 69.00, 1.00),
(70.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YFPJ', 'QM', 'BALANCE', 'A035', 'COLUMN', NULL, 70.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(71.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YFZK', 'NC', 'BALANCE', 'A036', 'COLUMN', NULL, 71.00, 1.00),
(72.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YFZK', 'QM', 'BALANCE', 'A036', 'COLUMN', NULL, 72.00, 1.00),
(73.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YSZK', 'NC', 'BALANCE', 'A037', 'COLUMN', NULL, 73.00, 1.00),
(74.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YSZK', 'QM', 'BALANCE', 'A037', 'COLUMN', NULL, 74.00, 1.00),
(75.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YFGZ', 'NC', 'BALANCE', 'A038', 'COLUMN', NULL, 75.00, 1.00),
(76.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YFGZ', 'QM', 'BALANCE', 'A038', 'COLUMN', NULL, 76.00, 1.00),
(77.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YFFLF', 'NC', 'BALANCE', 'A039', 'COLUMN', NULL, 77.00, 1.00),
(78.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YFFLF', 'QM', 'BALANCE', 'A039', 'COLUMN', NULL, 78.00, 1.00),
(79.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YJSJ', 'NC', 'BALANCE', 'A040', 'COLUMN', NULL, 79.00, 1.00),
(80.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YJSJ', 'QM', 'BALANCE', 'A040', 'COLUMN', NULL, 80.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(81.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YFLX', 'NC', 'BALANCE', 'A041', 'COLUMN', NULL, 81.00, 1.00),
(82.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YFLX', 'QM', 'BALANCE', 'A041', 'COLUMN', NULL, 82.00, 1.00),
(83.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YFGL', 'NC', 'BALANCE', 'A042', 'COLUMN', NULL, 83.00, 1.00),
(84.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YFGL', 'QM', 'BALANCE', 'A042', 'COLUMN', NULL, 84.00, 1.00),
(85.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_QTYFK', 'NC', 'BALANCE', 'A043', 'COLUMN', NULL, 85.00, 1.00),
(86.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_QTYFK', 'QM', 'BALANCE', 'A043', 'COLUMN', NULL, 86.00, 1.00),
(87.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YTFY', 'NC', 'BALANCE', 'A044', 'COLUMN', NULL, 87.00, 1.00),
(88.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YTFY', 'QM', 'BALANCE', 'A044', 'COLUMN', NULL, 88.00, 1.00),
(89.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_YNNDQCQFZ', 'NC', 'BALANCE', 'A045', 'COLUMN', NULL, 89.00, 1.00),
(90.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_YNNDQCQFZ', 'QM', 'BALANCE', 'A045', 'COLUMN', NULL, 90.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(91.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_QTLDFZ', 'NC', 'BALANCE', 'A046', 'COLUMN', NULL, 91.00, 1.00),
(92.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_QTLDFZ', 'QM', 'BALANCE', 'A046', 'COLUMN', NULL, 92.00, 1.00),
(93.00, 't_basi_assets_and_liabilities', 'NC_LDFZ_LDFZHJ', 'NC', 'BALANCE', 'A047', 'COLUMN', NULL, 93.00, 1.00),
(94.00, 't_basi_assets_and_liabilities', 'QM_LDFZ_LDFZHJ', 'QM', 'BALANCE', 'A047', 'COLUMN', NULL, 94.00, 1.00),
(95.00, 't_basi_assets_and_liabilities', 'NC_FLDFZ_CQJK', 'NC', 'BALANCE', 'A048', 'COLUMN', NULL, 95.00, 1.00),
(96.00, 't_basi_assets_and_liabilities', 'QM_FLDFZ_CQJK', 'QM', 'BALANCE', 'A048', 'COLUMN', NULL, 96.00, 1.00),
(97.00, 't_basi_assets_and_liabilities', 'NC_FLDFZ_YFZQ', 'NC', 'BALANCE', 'A049', 'COLUMN', NULL, 97.00, 1.00),
(98.00, 't_basi_assets_and_liabilities', 'QM_FLDFZ_YFZQ', 'QM', 'BALANCE', 'A049', 'COLUMN', NULL, 98.00, 1.00),
(99.00, 't_basi_assets_and_liabilities', 'NC_FLDFZ_CQYFK', 'NC', 'BALANCE', 'A050', 'COLUMN', NULL, 99.00, 1.00),
(100.00, 't_basi_assets_and_liabilities', 'QM_FLDFZ_CQYFK', 'QM', 'BALANCE', 'A050', 'COLUMN', NULL, 100.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(101.00, 't_basi_assets_and_liabilities', 'NC_FLDFZ_ZXYFK', 'NC', 'BALANCE', 'A051', 'COLUMN', NULL, 101.00, 1.00),
(102.00, 't_basi_assets_and_liabilities', 'QM_FLDFZ_ZXYFK', 'QM', 'BALANCE', 'A051', 'COLUMN', NULL, 102.00, 1.00),
(103.00, 't_basi_assets_and_liabilities', 'NC_FLDFZ_YJFZ', 'NC', 'BALANCE', 'A052', 'COLUMN', NULL, 103.00, 1.00),
(104.00, 't_basi_assets_and_liabilities', 'QM_FLDFZ_YJFZ', 'QM', 'BALANCE', 'A052', 'COLUMN', NULL, 104.00, 1.00),
(105.00, 't_basi_assets_and_liabilities', 'NC_FLDFZ_DYSY', 'NC', 'BALANCE', 'A053', 'COLUMN', NULL, 105.00, 1.00),
(106.00, 't_basi_assets_and_liabilities', 'QM_FLDFZ_DYSY', 'QM', 'BALANCE', 'A053', 'COLUMN', NULL, 106.00, 1.00),
(107.00, 't_basi_assets_and_liabilities', 'NC_FLDFZ_QTCQFZ', 'NC', 'BALANCE', 'A054', 'COLUMN', NULL, 107.00, 1.00),
(108.00, 't_basi_assets_and_liabilities', 'QM_FLDFZ_QTCQFZ', 'QM', 'BALANCE', 'A054', 'COLUMN', NULL, 108.00, 1.00),
(109.00, 't_basi_assets_and_liabilities', 'NC_FLDFZ_CQFZHJ', 'NC', 'BALANCE', 'A055', 'COLUMN', NULL, 109.00, 1.00),
(110.00, 't_basi_assets_and_liabilities', 'QM_FLDFZ_CQFZHJ', 'QM', 'BALANCE', 'A055', 'COLUMN', NULL, 110.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(111.00, 't_basi_assets_and_liabilities', 'NC_DYSX_DYSFZ', 'NC', 'BALANCE', 'A056', 'COLUMN', NULL, 111.00, 1.00),
(112.00, 't_basi_assets_and_liabilities', 'QM_DYSX_DYSFZ', 'QM', 'BALANCE', 'A056', 'COLUMN', NULL, 112.00, 1.00),
(113.00, 't_basi_assets_and_liabilities', 'NC_DYSX_FZHJ', 'NC', 'BALANCE', 'A057', 'COLUMN', NULL, 113.00, 1.00),
(114.00, 't_basi_assets_and_liabilities', 'QM_DYSX_FZHJ', 'QM', 'BALANCE', 'A057', 'COLUMN', NULL, 114.00, 1.00),
(115.00, 't_basi_assets_and_liabilities', 'NC_GDQY_SSZB', 'NC', 'BALANCE', 'A058', 'COLUMN', NULL, 115.00, 1.00),
(116.00, 't_basi_assets_and_liabilities', 'QM_GDQY_SSZB', 'QM', 'BALANCE', 'A058', 'COLUMN', NULL, 116.00, 1.00),
(117.00, 't_basi_assets_and_liabilities', 'NC_GDQY_YGHTZ', 'NC', 'BALANCE', 'A059', 'COLUMN', NULL, 117.00, 1.00),
(118.00, 't_basi_assets_and_liabilities', 'QM_GDQY_YGHTZ', 'QM', 'BALANCE', 'A059', 'COLUMN', NULL, 118.00, 1.00),
(119.00, 't_basi_assets_and_liabilities', 'NC_GDQY_SSZBJE', 'NC', 'BALANCE', 'A060', 'COLUMN', NULL, 119.00, 1.00),
(120.00, 't_basi_assets_and_liabilities', 'QM_GDQY_SSZBJE', 'QM', 'BALANCE', 'A060', 'COLUMN', NULL, 120.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(121.00, 't_basi_assets_and_liabilities', 'NC_GDQY_ZBGJ', 'NC', 'BALANCE', 'A061', 'COLUMN', NULL, 121.00, 1.00),
(122.00, 't_basi_assets_and_liabilities', 'QM_GDQY_ZBGJ', 'QM', 'BALANCE', 'A061', 'COLUMN', NULL, 122.00, 1.00),
(123.00, 't_basi_assets_and_liabilities', 'NC_GDQY_KCG', 'NC', 'BALANCE', 'A062', 'COLUMN', NULL, 123.00, 1.00),
(124.00, 't_basi_assets_and_liabilities', 'QM_GDQY_KCG', 'QM', 'BALANCE', 'A062', 'COLUMN', NULL, 124.00, 1.00),
(125.00, 't_basi_assets_and_liabilities', 'NC_GDQY_YYGJ', 'NC', 'BALANCE', 'A063', 'COLUMN', NULL, 125.00, 1.00),
(126.00, 't_basi_assets_and_liabilities', 'QM_GDQY_YYGJ', 'QM', 'BALANCE', 'A063', 'COLUMN', NULL, 126.00, 1.00),
(127.00, 't_basi_assets_and_liabilities', 'NC_GDQY_YBFXZB', 'NC', 'BALANCE', 'A064', 'COLUMN', NULL, 127.00, 1.00),
(128.00, 't_basi_assets_and_liabilities', 'QM_GDQY_YBFXZB', 'QM', 'BALANCE', 'A064', 'COLUMN', NULL, 128.00, 1.00),
(129.00, 't_basi_assets_and_liabilities', 'NC_GDQY_WFPLR', 'NC', 'BALANCE', 'A065', 'COLUMN', NULL, 129.00, 1.00),
(130.00, 't_basi_assets_and_liabilities', 'QM_GDQY_WFPLR', 'QM', 'BALANCE', 'A065', 'COLUMN', NULL, 130.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(131.00, 't_basi_assets_and_liabilities', 'NC_GDQY_GSYMGSQYHJ', 'NC', 'BALANCE', 'A066', 'COLUMN', NULL, 131.00, 1.00),
(132.00, 't_basi_assets_and_liabilities', 'QM_GDQY_GSYMGSQYHJ', 'QM', 'BALANCE', 'A066', 'COLUMN', NULL, 132.00, 1.00),
(133.00, 't_basi_assets_and_liabilities', 'NC_GDQY_SSGDQY', 'NC', 'BALANCE', 'A067', 'COLUMN', NULL, 133.00, 1.00),
(134.00, 't_basi_assets_and_liabilities', 'QM_GDQY_SSGDQY', 'QM', 'BALANCE', 'A067', 'COLUMN', NULL, 134.00, 1.00),
(135.00, 't_basi_assets_and_liabilities', 'NC_GDQY_SYZQYHJ', 'NC', 'BALANCE', 'A068', 'COLUMN', NULL, 135.00, 1.00),
(136.00, 't_basi_assets_and_liabilities', 'QM_GDQY_SYZQYHJ', 'QM', 'BALANCE', 'A068', 'COLUMN', NULL, 136.00, 1.00),
(137.00, 't_basi_assets_and_liabilities', 'NC_GDQY_FZHSYZQY', 'NC', 'BALANCE', 'A069', 'COLUMN', NULL, 137.00, 1.00),
(138.00, 't_basi_assets_and_liabilities', 'QM_GDQY_FZHSYZQY', 'QM', 'BALANCE', 'A069', 'COLUMN', NULL, 138.00, 1.00),
(139.00, 't_basi_profit', 'SQ_YYSR', 'SQ', 'PROFIT', 'P001', 'COLUMN', NULL, 1.00, 1.00),
(140.00, 't_basi_profit', 'BJ_YYSR', 'BJ', 'PROFIT', 'P001', 'COLUMN', NULL, 2.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(141.00, 't_basi_profit', 'SQ_YYCB', 'SQ', 'PROFIT', 'P002', 'COLUMN', NULL, 3.00, 1.00),
(142.00, 't_basi_profit', 'BJ_YYCB', 'BJ', 'PROFIT', 'P002', 'COLUMN', NULL, 4.00, 1.00),
(143.00, 't_basi_profit', 'SQ_SJJSF', 'SQ', 'PROFIT', 'P003', 'COLUMN', NULL, 5.00, 1.00),
(144.00, 't_basi_profit', 'BJ_SJJSF', 'BJ', 'PROFIT', 'P003', 'COLUMN', NULL, 6.00, 1.00),
(145.00, 't_basi_profit', 'SQ_XSFY', 'SQ', 'PROFIT', 'P004', 'COLUMN', NULL, 7.00, 1.00),
(146.00, 't_basi_profit', 'BJ_XSFY', 'BJ', 'PROFIT', 'P004', 'COLUMN', NULL, 8.00, 1.00),
(147.00, 't_basi_profit', 'SQ_GLFY', 'SQ', 'PROFIT', 'P005', 'COLUMN', NULL, 9.00, 1.00),
(148.00, 't_basi_profit', 'BJ_GLFY', 'BJ', 'PROFIT', 'P005', 'COLUMN', NULL, 10.00, 1.00),
(149.00, 't_basi_profit', 'SQ_YFFY', 'SQ', 'PROFIT', 'P006', 'COLUMN', NULL, 11.00, 1.00),
(150.00, 't_basi_profit', 'BJ_YFFY', 'BJ', 'PROFIT', 'P006', 'COLUMN', NULL, 12.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(151.00, 't_basi_profit', 'SQ_CWFY', 'SQ', 'PROFIT', 'P007', 'COLUMN', NULL, 13.00, 1.00),
(152.00, 't_basi_profit', 'BJ_CWFY', 'BJ', 'PROFIT', 'P007', 'COLUMN', NULL, 14.00, 1.00),
(153.00, 't_basi_profit', 'SQ_LXFY', 'SQ', 'PROFIT', 'P008', 'COLUMN', NULL, 15.00, 1.00),
(154.00, 't_basi_profit', 'BJ_LXFY', 'BJ', 'PROFIT', 'P008', 'COLUMN', NULL, 16.00, 1.00),
(155.00, 't_basi_profit', 'SQ_LRSR', 'SQ', 'PROFIT', 'P009', 'COLUMN', NULL, 17.00, 1.00),
(156.00, 't_basi_profit', 'BJ_LRSR', 'BJ', 'PROFIT', 'P009', 'COLUMN', NULL, 18.00, 1.00),
(157.00, 't_basi_profit', 'SQ_ZCJZSS', 'SQ', 'PROFIT', 'P010', 'COLUMN', NULL, 19.00, 1.00),
(158.00, 't_basi_profit', 'BJ_ZCJZSS', 'BJ', 'PROFIT', 'P010', 'COLUMN', NULL, 20.00, 1.00),
(159.00, 't_basi_profit', 'SQ_XYJZSS', 'SQ', 'PROFIT', 'P011', 'COLUMN', NULL, 21.00, 1.00),
(160.00, 't_basi_profit', 'BJ_XYJZSS', 'BJ', 'PROFIT', 'P011', 'COLUMN', NULL, 22.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(161.00, 't_basi_profit', 'SQ_GYJZBD', 'SQ', 'PROFIT', 'P012', 'COLUMN', NULL, 23.00, 1.00),
(162.00, 't_basi_profit', 'BJ_GYJZBD', 'BJ', 'PROFIT', 'P012', 'COLUMN', NULL, 24.00, 1.00),
(163.00, 't_basi_profit', 'SQ_TZSY', 'SQ', 'PROFIT', 'P013', 'COLUMN', NULL, 25.00, 1.00),
(164.00, 't_basi_profit', 'BJ_TZSY', 'BJ', 'PROFIT', 'P013', 'COLUMN', NULL, 26.00, 1.00),
(165.00, 't_basi_profit', 'SQ_LYTZSY', 'SQ', 'PROFIT', 'P014', 'COLUMN', NULL, 27.00, 1.00),
(166.00, 't_basi_profit', 'BJ_LYTZSY', 'BJ', 'PROFIT', 'P014', 'COLUMN', NULL, 28.00, 1.00),
(167.00, 't_basi_profit', 'SQ_QTSY', 'SQ', 'PROFIT', 'P015', 'COLUMN', NULL, 29.00, 1.00),
(168.00, 't_basi_profit', 'BJ_QTSY', 'BJ', 'PROFIT', 'P015', 'COLUMN', NULL, 30.00, 1.00),
(169.00, 't_basi_profit', 'SQ_YYLR', 'SQ', 'PROFIT', 'P016', 'COLUMN', NULL, 31.00, 1.00),
(170.00, 't_basi_profit', 'BJ_YYLR', 'BJ', 'PROFIT', 'P016', 'COLUMN', NULL, 32.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(171.00, 't_basi_profit', 'SQ_YYWSR', 'SQ', 'PROFIT', 'P017', 'COLUMN', NULL, 33.00, 1.00),
(172.00, 't_basi_profit', 'BJ_YYWSR', 'BJ', 'PROFIT', 'P017', 'COLUMN', NULL, 34.00, 1.00),
(173.00, 't_basi_profit', 'SQ_YYWZC', 'SQ', 'PROFIT', 'P018', 'COLUMN', NULL, 35.00, 1.00),
(174.00, 't_basi_profit', 'BJ_YYWZC', 'BJ', 'PROFIT', 'P018', 'COLUMN', NULL, 36.00, 1.00),
(175.00, 't_basi_profit', 'SQ_LRZE', 'SQ', 'PROFIT', 'P019', 'COLUMN', NULL, 37.00, 1.00),
(176.00, 't_basi_profit', 'BJ_LRZE', 'BJ', 'PROFIT', 'P019', 'COLUMN', NULL, 38.00, 1.00),
(177.00, 't_basi_profit', 'SQ_SDSFY', 'SQ', 'PROFIT', 'P020', 'COLUMN', NULL, 39.00, 1.00),
(178.00, 't_basi_profit', 'BJ_SDSFY', 'BJ', 'PROFIT', 'P020', 'COLUMN', NULL, 40.00, 1.00),
(179.00, 't_basi_profit', 'SQ_JLR', 'SQ', 'PROFIT', 'P021', 'COLUMN', NULL, 41.00, 1.00),
(180.00, 't_basi_profit', 'BJ_JLR', 'BJ', 'PROFIT', 'P021', 'COLUMN', NULL, 42.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(181.00, 't_basi_profit', 'SQ_CXYJLR', 'SQ', 'PROFIT', 'P022', 'COLUMN', NULL, 43.00, 1.00),
(182.00, 't_basi_profit', 'BJ_CXYJLR', 'BJ', 'PROFIT', 'P022', 'COLUMN', NULL, 44.00, 1.00),
(183.00, 't_basi_profit', 'SQ_ZSYJLR', 'SQ', 'PROFIT', 'P023', 'COLUMN', NULL, 45.00, 1.00),
(184.00, 't_basi_profit', 'BJ_ZSYJLR', 'BJ', 'PROFIT', 'P023', 'COLUMN', NULL, 46.00, 1.00),
(185.00, 't_basi_profit', 'SQ_ZHSYZE', 'SQ', 'PROFIT', 'P024', 'COLUMN', NULL, 47.00, 1.00),
(186.00, 't_basi_profit', 'BJ_ZHSYZE', 'BJ', 'PROFIT', 'P024', 'COLUMN', NULL, 48.00, 1.00),
(187.00, 't_basi_cash_flow', 'SQ_XSSPTLWSRDXJ', 'SQ', 'CASHFLOW', 'C001', 'COLUMN', NULL, 1.00, 1.00),
(188.00, 't_basi_cash_flow', 'BJ_XSSPTLWSRDXJ', 'BJ', 'CASHFLOW', 'C001', 'COLUMN', NULL, 2.00, 1.00),
(189.00, 't_basi_cash_flow', 'SQ_SDDDSFFH', 'SQ', 'CASHFLOW', 'C002', 'COLUMN', NULL, 3.00, 1.00),
(190.00, 't_basi_cash_flow', 'BJ_SDDDSFFH', 'BJ', 'CASHFLOW', 'C002', 'COLUMN', NULL, 4.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(191.00, 't_basi_cash_flow', 'SQ_SDQTYJYHDDXJ', 'SQ', 'CASHFLOW', 'C003', 'COLUMN', NULL, 5.00, 1.00),
(192.00, 't_basi_cash_flow', 'BJ_SDQTYJYHDDXJ', 'BJ', 'CASHFLOW', 'C003', 'COLUMN', NULL, 6.00, 1.00),
(193.00, 't_basi_cash_flow', 'SQ_JYHDXJLRXJ', 'SQ', 'CASHFLOW', 'C004', 'COLUMN', NULL, 7.00, 1.00),
(194.00, 't_basi_cash_flow', 'BJ_JYHDXJLRXJ', 'BJ', 'CASHFLOW', 'C004', 'COLUMN', NULL, 8.00, 1.00),
(195.00, 't_basi_cash_flow', 'SQ_GMWJSLWZFDXJ', 'SQ', 'CASHFLOW', 'C005', 'COLUMN', NULL, 9.00, 1.00),
(196.00, 't_basi_cash_flow', 'BJ_GMWJSLWZFDXJ', 'BJ', 'CASHFLOW', 'C005', 'COLUMN', NULL, 10.00, 1.00),
(197.00, 't_basi_cash_flow', 'SQ_ZFZGYJWGZFDXJ', 'SQ', 'CASHFLOW', 'C006', 'COLUMN', NULL, 11.00, 1.00),
(198.00, 't_basi_cash_flow', 'BJ_ZFZGYJWGZFDXJ', 'BJ', 'CASHFLOW', 'C006', 'COLUMN', NULL, 12.00, 1.00),
(199.00, 't_basi_cash_flow', 'SQ_ZFDFVAT', 'SQ', 'CASHFLOW', 'C007', 'COLUMN', NULL, 13.00, 1.00),
(200.00, 't_basi_cash_flow', 'BJ_ZFDFVAT', 'BJ', 'CASHFLOW', 'C007', 'COLUMN', NULL, 14.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(201.00, 't_basi_cash_flow', 'SQ_ZFQTYJYHDDXJ', 'SQ', 'CASHFLOW', 'C008', 'COLUMN', NULL, 15.00, 1.00),
(202.00, 't_basi_cash_flow', 'BJ_ZFQTYJYHDDXJ', 'BJ', 'CASHFLOW', 'C008', 'COLUMN', NULL, 16.00, 1.00),
(203.00, 't_basi_cash_flow', 'SQ_JYHDXJLCXJ', 'SQ', 'CASHFLOW', 'C009', 'COLUMN', NULL, 17.00, 1.00),
(204.00, 't_basi_cash_flow', 'BJ_JYHDXJLCXJ', 'BJ', 'CASHFLOW', 'C009', 'COLUMN', NULL, 18.00, 1.00),
(205.00, 't_basi_cash_flow', 'SQ_JYHDCSDXJLJE', 'SQ', 'CASHFLOW', 'C010', 'COLUMN', NULL, 19.00, 1.00),
(206.00, 't_basi_cash_flow', 'BJ_JYHDCSDXJLJE', 'BJ', 'CASHFLOW', 'C010', 'COLUMN', NULL, 20.00, 1.00),
(207.00, 't_basi_cash_flow', 'SQ_TZHDXJLRXJ', 'SQ', 'CASHFLOW', 'C011', 'COLUMN', NULL, 21.00, 1.00),
(208.00, 't_basi_cash_flow', 'BJ_TZHDXJLRXJ', 'BJ', 'CASHFLOW', 'C011', 'COLUMN', NULL, 22.00, 1.00),
(209.00, 't_basi_cash_flow', 'SQ_TZHDXJLCXJ', 'SQ', 'CASHFLOW', 'C012', 'COLUMN', NULL, 23.00, 1.00),
(210.00, 't_basi_cash_flow', 'BJ_TZHDXJLCXJ', 'BJ', 'CASHFLOW', 'C012', 'COLUMN', NULL, 24.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(211.00, 't_basi_cash_flow', 'SQ_TZHDCSDXJLJE', 'SQ', 'CASHFLOW', 'C013', 'COLUMN', NULL, 25.00, 1.00),
(212.00, 't_basi_cash_flow', 'BJ_TZHDCSDXJLJE', 'BJ', 'CASHFLOW', 'C013', 'COLUMN', NULL, 26.00, 1.00),
(213.00, 't_basi_cash_flow', 'SQ_CZHDXJLRXJ', 'SQ', 'CASHFLOW', 'C014', 'COLUMN', NULL, 27.00, 1.00),
(214.00, 't_basi_cash_flow', 'BJ_CZHDXJLRXJ', 'BJ', 'CASHFLOW', 'C014', 'COLUMN', NULL, 28.00, 1.00),
(215.00, 't_basi_cash_flow', 'SQ_CZHDXJLCXJ', 'SQ', 'CASHFLOW', 'C015', 'COLUMN', NULL, 29.00, 1.00),
(216.00, 't_basi_cash_flow', 'BJ_CZHDXJLCXJ', 'BJ', 'CASHFLOW', 'C015', 'COLUMN', NULL, 30.00, 1.00),
(217.00, 't_basi_cash_flow', 'SQ_CZHDCSDXJLJE', 'SQ', 'CASHFLOW', 'C016', 'COLUMN', NULL, 31.00, 1.00),
(218.00, 't_basi_cash_flow', 'BJ_CZHDCSDXJLJE', 'BJ', 'CASHFLOW', 'C016', 'COLUMN', NULL, 32.00, 1.00),
(219.00, 't_basi_cash_flow', 'SQ_HLLVBDDXJ', 'SQ', 'CASHFLOW', 'C017', 'COLUMN', NULL, 33.00, 1.00),
(220.00, 't_basi_cash_flow', 'BJ_HLLVBDDXJ', 'BJ', 'CASHFLOW', 'C017', 'COLUMN', NULL, 34.00, 1.00);
INSERT INTO t_code_mapper (id, source_table, source_column, value_type, report_type, code, map_type, calc_expression, order_no, is_active) VALUES
(221.00, 't_basi_cash_flow', 'SQ_XJJXJDJWJZJE', 'SQ', 'CASHFLOW', 'C018', 'COLUMN', NULL, 35.00, 1.00),
(222.00, 't_basi_cash_flow', 'BJ_XJJXJDJWJZJE', 'BJ', 'CASHFLOW', 'C018', 'COLUMN', NULL, 36.00, 1.00),
(223.00, 't_basi_cash_flow', 'SQ_QCXJJXJDJWYE', 'SQ', 'CASHFLOW', 'C019', 'COLUMN', NULL, 37.00, 1.00),
(224.00, 't_basi_cash_flow', 'BJ_QCXJJXJDJWYE', 'BJ', 'CASHFLOW', 'C019', 'COLUMN', NULL, 38.00, 1.00),
(225.00, 't_basi_cash_flow', 'SQ_QMXJJXJDJWYE', 'SQ', 'CASHFLOW', 'C020', 'COLUMN', NULL, 39.00, 1.00),
(226.00, 't_basi_cash_flow', 'BJ_QMXJJXJDJWYE', 'BJ', 'CASHFLOW', 'C020', 'COLUMN', NULL, 40.00, 1.00);


INSERT INTO t_mode (id, mode_code, mode_name, mode_type, parent_code, calc_expression, result_code, result_name, result_type, unit, precision_scale, warn_mode, warn_lower, warn_upper, warn_level, main_factor, advantage, disadvantage, advise, order_no, is_active, description) VALUES
(1.00, 'RATIO_LD', '流动比率', 'RATIO', NULL, '{A013}/{A047}', 'R101', '流动比率', 'QM', '倍', 2.00, 'range', 1.50, 3.00, 2.00, '流动资产合计与流动负债合计的规模对比', '反映企业短期偿债能力，指标越高短期偿债压力越小', '过高说明流动资产占用过多，资金使用效率偏低', '低于1.5时压降短期借款与应付账款，加快应收账款回款，提高流动资产质量', 1.00, 1.00, '比率分析模型'),
(2.00, 'RATIO_SD', '速动比率', 'RATIO', NULL, '({A013}-{A009}-{A005})/{A047}', 'R102', '速动比率', 'QM', '倍', 2.00, 'range', 0.80, 2.00, 3.00, '扣除存货、预付款项后的速动资产与流动负债之比', '剔除变现能力较差的存货，衡量即时偿债能力', '过低说明短期偿债风险高，过高说明现金类资产闲置', '低于0.8时控制存货采购节奏、加快销售回款并置换高成本短期负债', 2.00, 1.00, '比率分析模型'),
(3.00, 'RATIO_XJ', '现金比率', 'RATIO', NULL, '{A001}/{A047}', 'R103', '现金比率', 'QM', '倍', 2.00, 'down', 0.20, NULL, 2.00, '货币资金与流动负债之比', '直接反映企业可动用现金对短期债务的覆盖程度', '过低存在资金链紧张风险', '低于0.2时安排应收账款保理或银行授信，减少大额资本性支出', 3.00, 1.00, '比率分析模型'),
(4.00, 'RATIO_ZCFZ', '资产负债率', 'RATIO', NULL, '{A057}/{A032}', 'R104', '资产负债率', 'QM', '%', 2.00, 'up', NULL, 0.65, 3.00, '负债合计与资产总计之比', '衡量企业整体财务杠杆与长期偿债能力', '比率过高会加大财务风险与融资成本', '超过65%时控制新增有息负债，优先偿还高息借款，提高权益融资比例', 4.00, 1.00, '比率分析模型');
INSERT INTO t_mode (id, mode_code, mode_name, mode_type, parent_code, calc_expression, result_code, result_name, result_type, unit, precision_scale, warn_mode, warn_lower, warn_upper, warn_level, main_factor, advantage, disadvantage, advise, order_no, is_active, description) VALUES
(5.00, 'RATIO_CQ', '产权比率', 'RATIO', NULL, '{A057}/{A068}', 'R105', '产权比率', 'QM', '%', 2.00, 'up', NULL, 1.20, 2.00, '负债合计与所有者权益合计之比', '反映债权人权益与股东权益的相对关系', '比率越低财务结构越稳健', '超过1.2时通过留存收益补充权益资本，压降负债规模', 5.00, 1.00, '比率分析模型'),
(6.00, 'RATIO_MLL', '毛利率', 'RATIO', NULL, '({P001}-{P002})/{P001}', 'R106', '毛利率', 'QM', '%', 2.00, 'down', 0.25, NULL, 2.00, '营业收入、营业成本及产品结构调整', '体现产品竞争力和成本控制水平', '下降说明成本上升或售价承压', '低于28%时优化产品结构、集中采购降低原材料成本并提升高毛利业务占比', 6.00, 1.00, '比率分析模型'),
(7.00, 'RATIO_JLL', '净利率', 'RATIO', NULL, '{P021}/{P001}', 'R107', '净利率', 'QM', '%', 2.00, 'down', 0.07, NULL, 3.00, '营业收入与期间费用(销售/管理/研发/财务费用)水平', '综合反映企业最终盈利能力', '下降反映费用增长快于收入增长', '低于7%时压缩销售与管理费用，控制研发费用节奏，提高收入质量', 7.00, 1.00, '比率分析模型'),
(8.00, 'RATIO_ROE', '净资产收益率', 'RATIO', NULL, '{P021}/{A068}', 'R108', '净资产收益率', 'QM', '%', 2.00, 'down', 0.02, NULL, 3.00, '净利润与所有者权益(权益乘数、总资产周转率)', '股东投入资本的综合回报水平', '低于行业均值说明资本使用效率不足', '低于8%时提高总资产周转率与权益乘数结构，通过杜邦分析定位薄弱环节', 8.00, 1.00, '比率分析模型');
INSERT INTO t_mode (id, mode_code, mode_name, mode_type, parent_code, calc_expression, result_code, result_name, result_type, unit, precision_scale, warn_mode, warn_lower, warn_upper, warn_level, main_factor, advantage, disadvantage, advise, order_no, is_active, description) VALUES
(9.00, 'RATIO_ROA', '总资产报酬率', 'RATIO', NULL, '{P021}/{A032}', 'R109', '总资产报酬率', 'QM', '%', 2.00, 'down', 0.01, NULL, 2.00, '净利润与资产总计', '衡量全部资产的获利能力', '偏低说明资产利用效率不高', '低于3%时处置低效资产，加快存货与应收账款周转', 9.00, 1.00, '比率分析模型'),
(10.00, 'RATIO_YSZK', '应收账款周转率', 'RATIO', NULL, '{P001}/{A004}', 'R110', '应收账款周转率', 'QM', '次', 2.00, 'down', 0.85, NULL, 3.00, '营业收入与应收账款余额', '反映赊销政策与回款效率', '下降说明回款变慢、坏账风险上升', '低于0.85时收紧信用政策，按账龄进行催收并计提坏账准备', 10.00, 1.00, '比率分析模型'),
(11.00, 'RATIO_CH', '存货周转率', 'RATIO', NULL, '{P002}/{A009}', 'R111', '存货周转率', 'QM', '次', 2.00, 'down', 0.90, NULL, 2.00, '营业成本与存货余额', '反映存货变现速度与库存管理水平', '下降说明库存积压，资金占用增加', '低于0.9时推行以销定产、清理滞销存货并压缩安全库存', 11.00, 1.00, '比率分析模型'),
(12.00, 'RATIO_ZZCZZ', '总资产周转率', 'RATIO', NULL, '{P001}/{A032}', 'R112', '总资产周转率', 'QM', '次', 2.00, 'down', 0.30, NULL, 2.00, '营业收入与资产总计', '衡量资产整体运营效率', '下降说明资产扩张未带来收入同步增长', '低于0.30时优化资产结构，处置闲置资产，提高收入规模', 12.00, 1.00, '比率分析模型');
INSERT INTO t_mode (id, mode_code, mode_name, mode_type, parent_code, calc_expression, result_code, result_name, result_type, unit, precision_scale, warn_mode, warn_lower, warn_upper, warn_level, main_factor, advantage, disadvantage, advise, order_no, is_active, description) VALUES
(13.00, 'RATIO_XJLD', '现金流动负债比', 'RATIO', NULL, '{C010}/{A047}', 'R113', '现金流动负债比', 'QM', '倍', 2.00, 'down', 0.10, NULL, 3.00, '经营活动产生的现金流量净额与流动负债之比', '用经营性现金流衡量短期偿债能力，比流动比率更真实', '过低说明经营活动造血能力不足', '低于0.10时加强应收账款催收、压缩存货与期间费用，改善经营活动现金流', 13.00, 1.00, '比率分析模型'),
(14.00, 'RATIO_LXBZ', '利息保障倍数', 'RATIO', NULL, '({P019}+{P007})/{P007}', 'R114', '利息保障倍数', 'QM', '倍', 2.00, 'down', 3.00, NULL, 2.00, '利润总额、财务费用与利息支出', '反映企业支付利息的能力', '过低说明利息负担过重', '低于3倍时压降有息负债，优化债务期限结构', 14.00, 1.00, '比率分析模型'),
(15.00, 'DUPONT_ROE', '净资产收益率(杜邦分解)', 'DUPONT', NULL, '{P021}/{A068}', 'D101', '净资产收益率(杜邦分解)', 'QM', '%', 2.00, 'none', NULL, NULL, 1.00, '股东投入资本的回报率，由销售净利率、总资产周转率、权益乘数共同决定', NULL, NULL, NULL, 15.00, 1.00, '杜邦分析模型'),
(16.00, 'DUPONT_JLL', '销售净利率', 'DUPONT', 'D101', '{P021}/{P001}', 'D102', '销售净利率', 'QM', '%', 2.00, 'none', NULL, NULL, 1.00, '净利润/营业收入，反映产品盈利能力与费用控制', NULL, NULL, NULL, 16.00, 1.00, '杜邦分析模型');
INSERT INTO t_mode (id, mode_code, mode_name, mode_type, parent_code, calc_expression, result_code, result_name, result_type, unit, precision_scale, warn_mode, warn_lower, warn_upper, warn_level, main_factor, advantage, disadvantage, advise, order_no, is_active, description) VALUES
(17.00, 'DUPONT_ZZCZZ', '总资产周转率', 'DUPONT', 'D101', '{P001}/{A032}', 'D103', '总资产周转率', 'QM', '%', 4.00, 'none', NULL, NULL, 1.00, '营业收入/资产总计，反映资产运营效率', NULL, NULL, NULL, 17.00, 1.00, '杜邦分析模型'),
(18.00, 'DUPONT_QYCS', '权益乘数', 'DUPONT', 'D101', '{A032}/{A068}', 'D104', '权益乘数', 'QM', '%', 4.00, 'none', NULL, NULL, 1.00, '资产总计/所有者权益合计，反映财务杠杆水平', NULL, NULL, NULL, 18.00, 1.00, '杜邦分析模型'),
(19.00, 'WARN_XJ', '资金缺口(概要与预警)', 'WARN', NULL, '{A047}-{A001}', 'W101', '资金缺口(概要与预警)', 'QM', '元', 2.00, 'none', NULL, NULL, 1.00, '流动负债合计与货币资金的差额', '直观反映企业可动用资金对短期债务的覆盖缺口', '缺口为正且较大时说明资金链存在压力', '缺口大于0时加快回款、申请银行授信、延后非刚性的资本性支出', 19.00, 1.00, '资金概要与预警模型'),
(20.00, 'WARN_XJBL', '现金比率预警', 'WARN', NULL, '{A001}/{A047}', 'W102', '现金比率预警', 'QM', '倍', 2.00, 'down', 0.20, NULL, 3.00, '货币资金与流动负债之比', '反映即时偿债能力', '低于0.2说明短期资金紧张', '低于0.2时安排应收账款保理、控制采购付款节奏、压降短期借款', 20.00, 1.00, '资金概要与预警模型');
INSERT INTO t_mode (id, mode_code, mode_name, mode_type, parent_code, calc_expression, result_code, result_name, result_type, unit, precision_scale, warn_mode, warn_lower, warn_upper, warn_level, main_factor, advantage, disadvantage, advise, order_no, is_active, description) VALUES
(21.00, 'WARN_FZ', '资产负债率预警', 'WARN', NULL, '{A057}/{A032}', 'W103', '资产负债率预警', 'QM', '%', 2.00, 'up', NULL, 0.65, 3.00, '负债规模与资产规模', '反映整体财务杠杆风险', '高于65%时融资空间受限、财务费用上升', '超过65%时停止新增有息负债，推进权益融资或留存收益补充资本', 21.00, 1.00, '资金概要与预警模型'),
(22.00, 'WARN_JLR', '盈利预警', 'WARN', NULL, '{P021}', 'W104', '盈利预警', 'QM', '元', 2.00, 'down', 0.00, NULL, 3.00, '营业收入、营业成本及期间费用', '净利润为正说明当期经营成果良好', '净利润转负或大幅下滑说明经营出现问题', '净利润下滑时开展毛利分析、费用专项管控并调整产品报价策略', 22.00, 1.00, '资金概要与预警模型'),
(23.00, 'WARN_XJL', '经营性现金流预警', 'WARN', NULL, '{C010}', 'W105', '经营性现金流预警', 'QM', '元', 2.00, 'down', 0.00, NULL, 3.00, '经营活动产生的现金流量净额', '经营性现金净流入是持续经营的基础', '为负说明经营活动无法自我造血', '为负时压缩存货与应收账款占用，严控赊销与预付比例', 23.00, 1.00, '资金概要与预警模型'),
(24.00, 'PREDICT_LR', '损益预测(线性回归+复合增长率)', 'PREDICT', NULL, 'LINEAR({P021})', 'F101', '损益预测(线性回归+复合增长率)', 'QM', '元', 2.00, 'none', NULL, NULL, 1.00, '以历史净利润为基础，采用线性回归与复合增长率外推未来 3 个月损益', NULL, NULL, NULL, 24.00, 1.00, '损益预测模型');
INSERT INTO t_mode (id, mode_code, mode_name, mode_type, parent_code, calc_expression, result_code, result_name, result_type, unit, precision_scale, warn_mode, warn_lower, warn_upper, warn_level, main_factor, advantage, disadvantage, advise, order_no, is_active, description) VALUES
(25.00, 'PREDICT_JLR', '净利润预测', 'PREDICT', NULL, '{P021}', 'F102', '净利润预测', 'QM', '元', 2.00, 'none', NULL, NULL, 1.00, '历史净利润趋势', NULL, NULL, NULL, 25.00, 1.00, '损益预测模型'),
(26.00, 'PREDICT_SR', '营业收入预测', 'PREDICT', NULL, '{P001}', 'F103', '营业收入预测', 'QM', '元', 2.00, 'none', NULL, NULL, 1.00, '历史营业收入趋势', NULL, NULL, NULL, 26.00, 1.00, '损益预测模型');

-- 资产负债表基础数据(演示月份 2026-04 ~ 2026-09)
INSERT INTO t_basi_assets_and_liabilities (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, NC_LDZC_HBZJ, NC_LDZC_JYXJRZC, NC_LDZC_YSPJ, NC_LDZC_YSZK, NC_LDZC_YFZK, NC_LDZC_YSFL, NC_LDZC_YSLX, NC_LDZC_QTYSK, NC_LDZC_CH, NC_LDZC_DTFY, NC_LDZC_YNNDQCQZQTZ, NC_LDZC_QTLDZC, NC_LDZC_HJ, NC_FLDZC_KGCSJRZC, NC_FLDZC_CYZDQTZ, NC_FLDZC_CQYSK, NC_FLDZC_CQGQTZ, NC_FLDZC_TZXFDC, NC_FLDZC_GDZC, NC_FLDZC_ZJGC, NC_FLDZC_GCWZ, NC_FLDZC_GDZCQL, NC_FLDZC_SCXSWZC, NC_FLDZC_YQZC, NC_FLDZC_WXZC, NC_FLDZC_KFZC, NC_FLDZC_SY, NC_FLDZC_CQDTFY, NC_FLDZC_DYSDSZC, NC_FLDZC_QTFLDZC, NC_FLDZC_FLDZCHJ, NC_ZCZJ, NC_LDFZ_DQJK, NC_LDFZ_JYXJRFZ, NC_LDFZ_YFPJ, NC_LDFZ_YFZK, NC_LDFZ_YSZK, NC_LDFZ_YFGZ, NC_LDFZ_YFFLF, NC_LDFZ_YJSJ, NC_LDFZ_YFLX, NC_LDFZ_YFGL, NC_LDFZ_QTYFK, NC_LDFZ_YTFY, NC_LDFZ_YNNDQCQFZ, NC_LDFZ_QTLDFZ, NC_LDFZ_LDFZHJ, NC_FLDFZ_CQJK, NC_FLDFZ_YFZQ, NC_FLDFZ_CQYFK, NC_FLDFZ_ZXYFK, NC_FLDFZ_YJFZ, NC_FLDFZ_DYSY, NC_FLDFZ_QTCQFZ, NC_FLDFZ_CQFZHJ, NC_DYSX_DYSFZ, NC_DYSX_FZHJ, NC_GDQY_SSZB, NC_GDQY_YGHTZ, NC_GDQY_SSZBJE, NC_GDQY_ZBGJ, NC_GDQY_KCG, NC_GDQY_YYGJ, NC_GDQY_YBFXZB, NC_GDQY_WFPLR, NC_GDQY_GSYMGSQYHJ, NC_GDQY_SSGDQY, NC_GDQY_SYZQYHJ, NC_GDQY_FZHSYZQY, QM_LDZC_HBZJ, QM_LDZC_JYXJRZC, QM_LDZC_YSPJ, QM_LDZC_YSZK, QM_LDZC_YFZK, QM_LDZC_YSFL, QM_LDZC_YSLX, QM_LDZC_QTYSK, QM_LDZC_CH, QM_LDZC_DTFY, QM_LDZC_YNNDQCQZQTZ, QM_LDZC_QTLDZC, QM_LDZC_HJ, QM_FLDZC_KGCSJRZC, QM_FLDZC_CYZDQTZ, QM_FLDZC_CQYSK, QM_FLDZC_CQGQTZ, QM_FLDZC_TZXFDC, QM_FLDZC_GDZC, QM_FLDZC_ZJGC, QM_FLDZC_GCWZ, QM_FLDZC_GDZCQL, QM_FLDZC_SCXSWZC, QM_FLDZC_YQZC, QM_FLDZC_WXZC, QM_FLDZC_KFZC, QM_FLDZC_SY, QM_FLDZC_CQDTFY, QM_FLDZC_DYSDSZC, QM_FLDZC_QTFLDZC, QM_FLDZC_FLDZCHJ, QM_ZCZJ, QM_LDFZ_DQJK, QM_LDFZ_JYXJRFZ, QM_LDFZ_YFPJ, QM_LDFZ_YFZK, QM_LDFZ_YSZK, QM_LDFZ_YFGZ, QM_LDFZ_YFFLF, QM_LDFZ_YJSJ, QM_LDFZ_YFLX, QM_LDFZ_YFGL, QM_LDFZ_QTYFK, QM_LDFZ_YTFY, QM_LDFZ_YNNDQCQFZ, QM_LDFZ_QTLDFZ, QM_LDFZ_LDFZHJ, QM_FLDFZ_CQJK, QM_FLDFZ_YFZQ, QM_FLDFZ_CQYFK, QM_FLDFZ_ZXYFK, QM_FLDFZ_YJFZ, QM_FLDFZ_DYSY, QM_FLDFZ_QTCQFZ, QM_FLDFZ_CQFZHJ, QM_DYSX_DYSFZ, QM_DYSX_FZHJ, QM_GDQY_SSZB, QM_GDQY_YGHTZ, QM_GDQY_SSZBJE, QM_GDQY_ZBGJ, QM_GDQY_KCG, QM_GDQY_YYGJ, QM_GDQY_YBFXZB, QM_GDQY_WFPLR, QM_GDQY_GSYMGSQYHJ, QM_GDQY_SSGDQY, QM_GDQY_SYZQYHJ, QM_GDQY_FZHSYZQY) VALUES
('BS202604', 'BATCH-DEMO', 1.00, '2026', '04', '2026-04', '元', 'root', '2026-04-28 10:00:00', 'Y', 'Y', 1.00, '9335250.00', '0.00', '800000.00', '32200000.00', '1200000.00', '0.00', '0.00', '620000.00', '20580000.00', '0.00', '0.00', '150000.00', '64885250.00', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15500000.00', '2200000.00', '0.00', '0.00', '0.00', '0.00', '3000000.00', '0.00', '0.00', '420000.00', '0.00', '0.00', '22620000.00', '87505250.00', '5000000.00', '0.00', '600000.00', '18032000.00', '2500000.00', '900000.00', '0.00', '700000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '29052000.00', '4000000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4200000.00', '0.00', '33252000.00', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '1733025.00', '0.00', '30520225.00', '54253250.00', '0.00', '54253250.00', '87505250.00', '9335250.00', '0.00', '800000.00', '32200000.00', '1200000.00', '0.00', '0.00', '620000.00', '20580000.00', '0.00', '0.00', '150000.00', '64885250.00', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15500000.00', '2200000.00', '0.00', '0.00', '0.00', '0.00', '3000000.00', '0.00', '0.00', '420000.00', '0.00', '0.00', '22620000.00', '87505250.00', '5000000.00', '0.00', '600000.00', '18032000.00', '2500000.00', '900000.00', '0.00', '700000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '29052000.00', '4000000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4200000.00', '0.00', '33252000.00', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '1733025.00', '0.00', '30520225.00', '54253250.00', '0.00', '54253250.00', '87505250.00');
INSERT INTO t_basi_assets_and_liabilities (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, NC_LDZC_HBZJ, NC_LDZC_JYXJRZC, NC_LDZC_YSPJ, NC_LDZC_YSZK, NC_LDZC_YFZK, NC_LDZC_YSFL, NC_LDZC_YSLX, NC_LDZC_QTYSK, NC_LDZC_CH, NC_LDZC_DTFY, NC_LDZC_YNNDQCQZQTZ, NC_LDZC_QTLDZC, NC_LDZC_HJ, NC_FLDZC_KGCSJRZC, NC_FLDZC_CYZDQTZ, NC_FLDZC_CQYSK, NC_FLDZC_CQGQTZ, NC_FLDZC_TZXFDC, NC_FLDZC_GDZC, NC_FLDZC_ZJGC, NC_FLDZC_GCWZ, NC_FLDZC_GDZCQL, NC_FLDZC_SCXSWZC, NC_FLDZC_YQZC, NC_FLDZC_WXZC, NC_FLDZC_KFZC, NC_FLDZC_SY, NC_FLDZC_CQDTFY, NC_FLDZC_DYSDSZC, NC_FLDZC_QTFLDZC, NC_FLDZC_FLDZCHJ, NC_ZCZJ, NC_LDFZ_DQJK, NC_LDFZ_JYXJRFZ, NC_LDFZ_YFPJ, NC_LDFZ_YFZK, NC_LDFZ_YSZK, NC_LDFZ_YFGZ, NC_LDFZ_YFFLF, NC_LDFZ_YJSJ, NC_LDFZ_YFLX, NC_LDFZ_YFGL, NC_LDFZ_QTYFK, NC_LDFZ_YTFY, NC_LDFZ_YNNDQCQFZ, NC_LDFZ_QTLDFZ, NC_LDFZ_LDFZHJ, NC_FLDFZ_CQJK, NC_FLDFZ_YFZQ, NC_FLDFZ_CQYFK, NC_FLDFZ_ZXYFK, NC_FLDFZ_YJFZ, NC_FLDFZ_DYSY, NC_FLDFZ_QTCQFZ, NC_FLDFZ_CQFZHJ, NC_DYSX_DYSFZ, NC_DYSX_FZHJ, NC_GDQY_SSZB, NC_GDQY_YGHTZ, NC_GDQY_SSZBJE, NC_GDQY_ZBGJ, NC_GDQY_KCG, NC_GDQY_YYGJ, NC_GDQY_YBFXZB, NC_GDQY_WFPLR, NC_GDQY_GSYMGSQYHJ, NC_GDQY_SSGDQY, NC_GDQY_SYZQYHJ, NC_GDQY_FZHSYZQY, QM_LDZC_HBZJ, QM_LDZC_JYXJRZC, QM_LDZC_YSPJ, QM_LDZC_YSZK, QM_LDZC_YFZK, QM_LDZC_YSFL, QM_LDZC_YSLX, QM_LDZC_QTYSK, QM_LDZC_CH, QM_LDZC_DTFY, QM_LDZC_YNNDQCQZQTZ, QM_LDZC_QTLDZC, QM_LDZC_HJ, QM_FLDZC_KGCSJRZC, QM_FLDZC_CYZDQTZ, QM_FLDZC_CQYSK, QM_FLDZC_CQGQTZ, QM_FLDZC_TZXFDC, QM_FLDZC_GDZC, QM_FLDZC_ZJGC, QM_FLDZC_GCWZ, QM_FLDZC_GDZCQL, QM_FLDZC_SCXSWZC, QM_FLDZC_YQZC, QM_FLDZC_WXZC, QM_FLDZC_KFZC, QM_FLDZC_SY, QM_FLDZC_CQDTFY, QM_FLDZC_DYSDSZC, QM_FLDZC_QTFLDZC, QM_FLDZC_FLDZCHJ, QM_ZCZJ, QM_LDFZ_DQJK, QM_LDFZ_JYXJRFZ, QM_LDFZ_YFPJ, QM_LDFZ_YFZK, QM_LDFZ_YSZK, QM_LDFZ_YFGZ, QM_LDFZ_YFFLF, QM_LDFZ_YJSJ, QM_LDFZ_YFLX, QM_LDFZ_YFGL, QM_LDFZ_QTYFK, QM_LDFZ_YTFY, QM_LDFZ_YNNDQCQFZ, QM_LDFZ_QTLDFZ, QM_LDFZ_LDFZHJ, QM_FLDFZ_CQJK, QM_FLDFZ_YFZQ, QM_FLDFZ_CQYFK, QM_FLDFZ_ZXYFK, QM_FLDFZ_YJFZ, QM_FLDFZ_DYSY, QM_FLDFZ_QTCQFZ, QM_FLDFZ_CQFZHJ, QM_DYSX_DYSFZ, QM_DYSX_FZHJ, QM_GDQY_SSZB, QM_GDQY_YGHTZ, QM_GDQY_SSZBJE, QM_GDQY_ZBGJ, QM_GDQY_KCG, QM_GDQY_YYGJ, QM_GDQY_YBFXZB, QM_GDQY_WFPLR, QM_GDQY_GSYMGSQYHJ, QM_GDQY_SSGDQY, QM_GDQY_SYZQYHJ, QM_GDQY_FZHSYZQY) VALUES
('BS202605', 'BATCH-DEMO', 1.00, '2026', '05', '2026-05', '元', 'root', '2026-05-28 10:00:00', 'Y', 'Y', 1.00, '9335250.00', '0.00', '800000.00', '32200000.00', '1200000.00', '0.00', '0.00', '620000.00', '20580000.00', '0.00', '0.00', '150000.00', '64885250.00', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15500000.00', '2200000.00', '0.00', '0.00', '0.00', '0.00', '3000000.00', '0.00', '0.00', '420000.00', '0.00', '0.00', '22620000.00', '87505250.00', '5000000.00', '0.00', '600000.00', '18032000.00', '2500000.00', '900000.00', '0.00', '700000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '29052000.00', '4000000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4200000.00', '0.00', '33252000.00', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '1733025.00', '0.00', '30520225.00', '54253250.00', '0.00', '54253250.00', '87505250.00', '10607490.44', '0.00', '800000.00', '36602563.20', '1200000.00', '0.00', '0.00', '620000.00', '22754082.96', '0.00', '0.00', '150000.00', '72734136.60', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15400000.00', '2300000.00', '0.00', '0.00', '0.00', '0.00', '2950000.00', '0.00', '0.00', '410000.00', '0.00', '0.00', '22560000.00', '95294136.60', '5300000.00', '0.00', '600000.00', '19936910.78', '2560000.00', '920000.00', '0.00', '730000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '31366910.78', '3900000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4100000.00', '0.00', '35466910.78', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '2022011.46', '0.00', '35805214.36', '59827225.82', '0.00', '59827225.82', '95294136.60');
INSERT INTO t_basi_assets_and_liabilities (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, NC_LDZC_HBZJ, NC_LDZC_JYXJRZC, NC_LDZC_YSPJ, NC_LDZC_YSZK, NC_LDZC_YFZK, NC_LDZC_YSFL, NC_LDZC_YSLX, NC_LDZC_QTYSK, NC_LDZC_CH, NC_LDZC_DTFY, NC_LDZC_YNNDQCQZQTZ, NC_LDZC_QTLDZC, NC_LDZC_HJ, NC_FLDZC_KGCSJRZC, NC_FLDZC_CYZDQTZ, NC_FLDZC_CQYSK, NC_FLDZC_CQGQTZ, NC_FLDZC_TZXFDC, NC_FLDZC_GDZC, NC_FLDZC_ZJGC, NC_FLDZC_GCWZ, NC_FLDZC_GDZCQL, NC_FLDZC_SCXSWZC, NC_FLDZC_YQZC, NC_FLDZC_WXZC, NC_FLDZC_KFZC, NC_FLDZC_SY, NC_FLDZC_CQDTFY, NC_FLDZC_DYSDSZC, NC_FLDZC_QTFLDZC, NC_FLDZC_FLDZCHJ, NC_ZCZJ, NC_LDFZ_DQJK, NC_LDFZ_JYXJRFZ, NC_LDFZ_YFPJ, NC_LDFZ_YFZK, NC_LDFZ_YSZK, NC_LDFZ_YFGZ, NC_LDFZ_YFFLF, NC_LDFZ_YJSJ, NC_LDFZ_YFLX, NC_LDFZ_YFGL, NC_LDFZ_QTYFK, NC_LDFZ_YTFY, NC_LDFZ_YNNDQCQFZ, NC_LDFZ_QTLDFZ, NC_LDFZ_LDFZHJ, NC_FLDFZ_CQJK, NC_FLDFZ_YFZQ, NC_FLDFZ_CQYFK, NC_FLDFZ_ZXYFK, NC_FLDFZ_YJFZ, NC_FLDFZ_DYSY, NC_FLDFZ_QTCQFZ, NC_FLDFZ_CQFZHJ, NC_DYSX_DYSFZ, NC_DYSX_FZHJ, NC_GDQY_SSZB, NC_GDQY_YGHTZ, NC_GDQY_SSZBJE, NC_GDQY_ZBGJ, NC_GDQY_KCG, NC_GDQY_YYGJ, NC_GDQY_YBFXZB, NC_GDQY_WFPLR, NC_GDQY_GSYMGSQYHJ, NC_GDQY_SSGDQY, NC_GDQY_SYZQYHJ, NC_GDQY_FZHSYZQY, QM_LDZC_HBZJ, QM_LDZC_JYXJRZC, QM_LDZC_YSPJ, QM_LDZC_YSZK, QM_LDZC_YFZK, QM_LDZC_YSFL, QM_LDZC_YSLX, QM_LDZC_QTYSK, QM_LDZC_CH, QM_LDZC_DTFY, QM_LDZC_YNNDQCQZQTZ, QM_LDZC_QTLDZC, QM_LDZC_HJ, QM_FLDZC_KGCSJRZC, QM_FLDZC_CYZDQTZ, QM_FLDZC_CQYSK, QM_FLDZC_CQGQTZ, QM_FLDZC_TZXFDC, QM_FLDZC_GDZC, QM_FLDZC_ZJGC, QM_FLDZC_GCWZ, QM_FLDZC_GDZCQL, QM_FLDZC_SCXSWZC, QM_FLDZC_YQZC, QM_FLDZC_WXZC, QM_FLDZC_KFZC, QM_FLDZC_SY, QM_FLDZC_CQDTFY, QM_FLDZC_DYSDSZC, QM_FLDZC_QTFLDZC, QM_FLDZC_FLDZCHJ, QM_ZCZJ, QM_LDFZ_DQJK, QM_LDFZ_JYXJRFZ, QM_LDFZ_YFPJ, QM_LDFZ_YFZK, QM_LDFZ_YSZK, QM_LDFZ_YFGZ, QM_LDFZ_YFFLF, QM_LDFZ_YJSJ, QM_LDFZ_YFLX, QM_LDFZ_YFGL, QM_LDFZ_QTYFK, QM_LDFZ_YTFY, QM_LDFZ_YNNDQCQFZ, QM_LDFZ_QTLDFZ, QM_LDFZ_LDFZHJ, QM_FLDFZ_CQJK, QM_FLDFZ_YFZQ, QM_FLDFZ_CQYFK, QM_FLDFZ_ZXYFK, QM_FLDFZ_YJFZ, QM_FLDFZ_DYSY, QM_FLDFZ_QTCQFZ, QM_FLDFZ_CQFZHJ, QM_DYSX_DYSFZ, QM_DYSX_FZHJ, QM_GDQY_SSZB, QM_GDQY_YGHTZ, QM_GDQY_SSZBJE, QM_GDQY_ZBGJ, QM_GDQY_KCG, QM_GDQY_YYGJ, QM_GDQY_YBFXZB, QM_GDQY_WFPLR, QM_GDQY_GSYMGSQYHJ, QM_GDQY_SSGDQY, QM_GDQY_SYZQYHJ, QM_GDQY_FZHSYZQY) VALUES
('BS202606', 'BATCH-DEMO', 1.00, '2026', '06', '2026-06', '元', 'root', '2026-06-28 10:00:00', 'Y', 'Y', 1.00, '9335250.00', '0.00', '800000.00', '32200000.00', '1200000.00', '0.00', '0.00', '620000.00', '20580000.00', '0.00', '0.00', '150000.00', '64885250.00', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15500000.00', '2200000.00', '0.00', '0.00', '0.00', '0.00', '3000000.00', '0.00', '0.00', '420000.00', '0.00', '0.00', '22620000.00', '87505250.00', '5000000.00', '0.00', '600000.00', '18032000.00', '2500000.00', '900000.00', '0.00', '700000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '29052000.00', '4000000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4200000.00', '0.00', '33252000.00', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '1733025.00', '0.00', '30520225.00', '54253250.00', '0.00', '54253250.00', '87505250.00', '11223682.83', '0.00', '800000.00', '37680921.60', '1200000.00', '0.00', '0.00', '620000.00', '22813670.88', '0.00', '0.00', '150000.00', '74488275.31', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15300000.00', '2400000.00', '0.00', '0.00', '0.00', '0.00', '2900000.00', '0.00', '0.00', '400000.00', '0.00', '0.00', '22500000.00', '96988275.31', '5600000.00', '0.00', '600000.00', '19989121.15', '2620000.00', '940000.00', '0.00', '760000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '31829121.15', '3800000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4000000.00', '0.00', '35829121.15', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '2185956.14', '0.00', '36973198.02', '61159154.16', '0.00', '61159154.16', '96988275.31');
INSERT INTO t_basi_assets_and_liabilities (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, NC_LDZC_HBZJ, NC_LDZC_JYXJRZC, NC_LDZC_YSPJ, NC_LDZC_YSZK, NC_LDZC_YFZK, NC_LDZC_YSFL, NC_LDZC_YSLX, NC_LDZC_QTYSK, NC_LDZC_CH, NC_LDZC_DTFY, NC_LDZC_YNNDQCQZQTZ, NC_LDZC_QTLDZC, NC_LDZC_HJ, NC_FLDZC_KGCSJRZC, NC_FLDZC_CYZDQTZ, NC_FLDZC_CQYSK, NC_FLDZC_CQGQTZ, NC_FLDZC_TZXFDC, NC_FLDZC_GDZC, NC_FLDZC_ZJGC, NC_FLDZC_GCWZ, NC_FLDZC_GDZCQL, NC_FLDZC_SCXSWZC, NC_FLDZC_YQZC, NC_FLDZC_WXZC, NC_FLDZC_KFZC, NC_FLDZC_SY, NC_FLDZC_CQDTFY, NC_FLDZC_DYSDSZC, NC_FLDZC_QTFLDZC, NC_FLDZC_FLDZCHJ, NC_ZCZJ, NC_LDFZ_DQJK, NC_LDFZ_JYXJRFZ, NC_LDFZ_YFPJ, NC_LDFZ_YFZK, NC_LDFZ_YSZK, NC_LDFZ_YFGZ, NC_LDFZ_YFFLF, NC_LDFZ_YJSJ, NC_LDFZ_YFLX, NC_LDFZ_YFGL, NC_LDFZ_QTYFK, NC_LDFZ_YTFY, NC_LDFZ_YNNDQCQFZ, NC_LDFZ_QTLDFZ, NC_LDFZ_LDFZHJ, NC_FLDFZ_CQJK, NC_FLDFZ_YFZQ, NC_FLDFZ_CQYFK, NC_FLDFZ_ZXYFK, NC_FLDFZ_YJFZ, NC_FLDFZ_DYSY, NC_FLDFZ_QTCQFZ, NC_FLDFZ_CQFZHJ, NC_DYSX_DYSFZ, NC_DYSX_FZHJ, NC_GDQY_SSZB, NC_GDQY_YGHTZ, NC_GDQY_SSZBJE, NC_GDQY_ZBGJ, NC_GDQY_KCG, NC_GDQY_YYGJ, NC_GDQY_YBFXZB, NC_GDQY_WFPLR, NC_GDQY_GSYMGSQYHJ, NC_GDQY_SSGDQY, NC_GDQY_SYZQYHJ, NC_GDQY_FZHSYZQY, QM_LDZC_HBZJ, QM_LDZC_JYXJRZC, QM_LDZC_YSPJ, QM_LDZC_YSZK, QM_LDZC_YFZK, QM_LDZC_YSFL, QM_LDZC_YSLX, QM_LDZC_QTYSK, QM_LDZC_CH, QM_LDZC_DTFY, QM_LDZC_YNNDQCQZQTZ, QM_LDZC_QTLDZC, QM_LDZC_HJ, QM_FLDZC_KGCSJRZC, QM_FLDZC_CYZDQTZ, QM_FLDZC_CQYSK, QM_FLDZC_CQGQTZ, QM_FLDZC_TZXFDC, QM_FLDZC_GDZC, QM_FLDZC_ZJGC, QM_FLDZC_GCWZ, QM_FLDZC_GDZCQL, QM_FLDZC_SCXSWZC, QM_FLDZC_YQZC, QM_FLDZC_WXZC, QM_FLDZC_KFZC, QM_FLDZC_SY, QM_FLDZC_CQDTFY, QM_FLDZC_DYSDSZC, QM_FLDZC_QTFLDZC, QM_FLDZC_FLDZCHJ, QM_ZCZJ, QM_LDFZ_DQJK, QM_LDFZ_JYXJRFZ, QM_LDFZ_YFPJ, QM_LDFZ_YFZK, QM_LDFZ_YSZK, QM_LDFZ_YFGZ, QM_LDFZ_YFFLF, QM_LDFZ_YJSJ, QM_LDFZ_YFLX, QM_LDFZ_YFGL, QM_LDFZ_QTYFK, QM_LDFZ_YTFY, QM_LDFZ_YNNDQCQFZ, QM_LDFZ_QTLDFZ, QM_LDFZ_LDFZHJ, QM_FLDFZ_CQJK, QM_FLDFZ_YFZQ, QM_FLDFZ_CQYFK, QM_FLDFZ_ZXYFK, QM_FLDFZ_YJFZ, QM_FLDFZ_DYSY, QM_FLDFZ_QTCQFZ, QM_FLDFZ_CQFZHJ, QM_DYSX_DYSFZ, QM_DYSX_FZHJ, QM_GDQY_SSZB, QM_GDQY_YGHTZ, QM_GDQY_SSZBJE, QM_GDQY_ZBGJ, QM_GDQY_KCG, QM_GDQY_YYGJ, QM_GDQY_YBFXZB, QM_GDQY_WFPLR, QM_GDQY_GSYMGSQYHJ, QM_GDQY_SSGDQY, QM_GDQY_SYZQYHJ, QM_GDQY_FZHSYZQY) VALUES
('BS202607', 'BATCH-DEMO', 1.00, '2026', '07', '2026-07', '元', 'root', '2026-07-28 10:00:00', 'Y', 'Y', 1.00, '9335250.00', '0.00', '800000.00', '32200000.00', '1200000.00', '0.00', '0.00', '620000.00', '20580000.00', '0.00', '0.00', '150000.00', '64885250.00', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15500000.00', '2200000.00', '0.00', '0.00', '0.00', '0.00', '3000000.00', '0.00', '0.00', '420000.00', '0.00', '0.00', '22620000.00', '87505250.00', '5000000.00', '0.00', '600000.00', '18032000.00', '2500000.00', '900000.00', '0.00', '700000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '29052000.00', '4000000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4200000.00', '0.00', '33252000.00', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '1733025.00', '0.00', '30520225.00', '54253250.00', '0.00', '54253250.00', '87505250.00', '11668067.00', '0.00', '800000.00', '42588806.40', '1200000.00', '0.00', '0.00', '620000.00', '25143138.72', '0.00', '0.00', '150000.00', '82170012.12', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15200000.00', '2500000.00', '0.00', '0.00', '0.00', '0.00', '2850000.00', '0.00', '0.00', '390000.00', '0.00', '0.00', '22440000.00', '104610012.12', '5900000.00', '0.00', '600000.00', '22030178.69', '2680000.00', '960000.00', '0.00', '790000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '34280178.69', '3700000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '3900000.00', '0.00', '38180178.69', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '2517626.97', '0.00', '41912206.47', '66429833.43', '0.00', '66429833.43', '104610012.12');
INSERT INTO t_basi_assets_and_liabilities (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, NC_LDZC_HBZJ, NC_LDZC_JYXJRZC, NC_LDZC_YSPJ, NC_LDZC_YSZK, NC_LDZC_YFZK, NC_LDZC_YSFL, NC_LDZC_YSLX, NC_LDZC_QTYSK, NC_LDZC_CH, NC_LDZC_DTFY, NC_LDZC_YNNDQCQZQTZ, NC_LDZC_QTLDZC, NC_LDZC_HJ, NC_FLDZC_KGCSJRZC, NC_FLDZC_CYZDQTZ, NC_FLDZC_CQYSK, NC_FLDZC_CQGQTZ, NC_FLDZC_TZXFDC, NC_FLDZC_GDZC, NC_FLDZC_ZJGC, NC_FLDZC_GCWZ, NC_FLDZC_GDZCQL, NC_FLDZC_SCXSWZC, NC_FLDZC_YQZC, NC_FLDZC_WXZC, NC_FLDZC_KFZC, NC_FLDZC_SY, NC_FLDZC_CQDTFY, NC_FLDZC_DYSDSZC, NC_FLDZC_QTFLDZC, NC_FLDZC_FLDZCHJ, NC_ZCZJ, NC_LDFZ_DQJK, NC_LDFZ_JYXJRFZ, NC_LDFZ_YFPJ, NC_LDFZ_YFZK, NC_LDFZ_YSZK, NC_LDFZ_YFGZ, NC_LDFZ_YFFLF, NC_LDFZ_YJSJ, NC_LDFZ_YFLX, NC_LDFZ_YFGL, NC_LDFZ_QTYFK, NC_LDFZ_YTFY, NC_LDFZ_YNNDQCQFZ, NC_LDFZ_QTLDFZ, NC_LDFZ_LDFZHJ, NC_FLDFZ_CQJK, NC_FLDFZ_YFZQ, NC_FLDFZ_CQYFK, NC_FLDFZ_ZXYFK, NC_FLDFZ_YJFZ, NC_FLDFZ_DYSY, NC_FLDFZ_QTCQFZ, NC_FLDFZ_CQFZHJ, NC_DYSX_DYSFZ, NC_DYSX_FZHJ, NC_GDQY_SSZB, NC_GDQY_YGHTZ, NC_GDQY_SSZBJE, NC_GDQY_ZBGJ, NC_GDQY_KCG, NC_GDQY_YYGJ, NC_GDQY_YBFXZB, NC_GDQY_WFPLR, NC_GDQY_GSYMGSQYHJ, NC_GDQY_SSGDQY, NC_GDQY_SYZQYHJ, NC_GDQY_FZHSYZQY, QM_LDZC_HBZJ, QM_LDZC_JYXJRZC, QM_LDZC_YSPJ, QM_LDZC_YSZK, QM_LDZC_YFZK, QM_LDZC_YSFL, QM_LDZC_YSLX, QM_LDZC_QTYSK, QM_LDZC_CH, QM_LDZC_DTFY, QM_LDZC_YNNDQCQZQTZ, QM_LDZC_QTLDZC, QM_LDZC_HJ, QM_FLDZC_KGCSJRZC, QM_FLDZC_CYZDQTZ, QM_FLDZC_CQYSK, QM_FLDZC_CQGQTZ, QM_FLDZC_TZXFDC, QM_FLDZC_GDZC, QM_FLDZC_ZJGC, QM_FLDZC_GCWZ, QM_FLDZC_GDZCQL, QM_FLDZC_SCXSWZC, QM_FLDZC_YQZC, QM_FLDZC_WXZC, QM_FLDZC_KFZC, QM_FLDZC_SY, QM_FLDZC_CQDTFY, QM_FLDZC_DYSDSZC, QM_FLDZC_QTFLDZC, QM_FLDZC_FLDZCHJ, QM_ZCZJ, QM_LDFZ_DQJK, QM_LDFZ_JYXJRFZ, QM_LDFZ_YFPJ, QM_LDFZ_YFZK, QM_LDFZ_YSZK, QM_LDFZ_YFGZ, QM_LDFZ_YFFLF, QM_LDFZ_YJSJ, QM_LDFZ_YFLX, QM_LDFZ_YFGL, QM_LDFZ_QTYFK, QM_LDFZ_YTFY, QM_LDFZ_YNNDQCQFZ, QM_LDFZ_QTLDFZ, QM_LDFZ_LDFZHJ, QM_FLDFZ_CQJK, QM_FLDFZ_YFZQ, QM_FLDFZ_CQYFK, QM_FLDFZ_ZXYFK, QM_FLDFZ_YJFZ, QM_FLDFZ_DYSY, QM_FLDFZ_QTCQFZ, QM_FLDFZ_CQFZHJ, QM_DYSX_DYSFZ, QM_DYSX_FZHJ, QM_GDQY_SSZB, QM_GDQY_YGHTZ, QM_GDQY_SSZBJE, QM_GDQY_ZBGJ, QM_GDQY_KCG, QM_GDQY_YYGJ, QM_GDQY_YBFXZB, QM_GDQY_WFPLR, QM_GDQY_GSYMGSQYHJ, QM_GDQY_SSGDQY, QM_GDQY_SYZQYHJ, QM_GDQY_FZHSYZQY) VALUES
('BS202608', 'BATCH-DEMO', 1.00, '2026', '08', '2026-08', '元', 'root', '2026-08-28 10:00:00', 'Y', 'Y', 1.00, '9335250.00', '0.00', '800000.00', '32200000.00', '1200000.00', '0.00', '0.00', '620000.00', '20580000.00', '0.00', '0.00', '150000.00', '64885250.00', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15500000.00', '2200000.00', '0.00', '0.00', '0.00', '0.00', '3000000.00', '0.00', '0.00', '420000.00', '0.00', '0.00', '22620000.00', '87505250.00', '5000000.00', '0.00', '600000.00', '18032000.00', '2500000.00', '900000.00', '0.00', '700000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '29052000.00', '4000000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4200000.00', '0.00', '33252000.00', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '1733025.00', '0.00', '30520225.00', '54253250.00', '0.00', '54253250.00', '87505250.00', '11366388.28', '0.00', '800000.00', '43266921.60', '1200000.00', '0.00', '0.00', '620000.00', '24935410.08', '0.00', '0.00', '150000.00', '82338719.96', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15100000.00', '2600000.00', '0.00', '0.00', '0.00', '0.00', '2800000.00', '0.00', '0.00', '380000.00', '0.00', '0.00', '22380000.00', '104718719.96', '6200000.00', '0.00', '600000.00', '21848168.83', '2740000.00', '980000.00', '0.00', '820000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '34508168.83', '3600000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '3800000.00', '0.00', '38308168.83', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '2569575.61', '0.00', '41840975.52', '66410551.13', '0.00', '66410551.13', '104718719.96');
INSERT INTO t_basi_assets_and_liabilities (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, NC_LDZC_HBZJ, NC_LDZC_JYXJRZC, NC_LDZC_YSPJ, NC_LDZC_YSZK, NC_LDZC_YFZK, NC_LDZC_YSFL, NC_LDZC_YSLX, NC_LDZC_QTYSK, NC_LDZC_CH, NC_LDZC_DTFY, NC_LDZC_YNNDQCQZQTZ, NC_LDZC_QTLDZC, NC_LDZC_HJ, NC_FLDZC_KGCSJRZC, NC_FLDZC_CYZDQTZ, NC_FLDZC_CQYSK, NC_FLDZC_CQGQTZ, NC_FLDZC_TZXFDC, NC_FLDZC_GDZC, NC_FLDZC_ZJGC, NC_FLDZC_GCWZ, NC_FLDZC_GDZCQL, NC_FLDZC_SCXSWZC, NC_FLDZC_YQZC, NC_FLDZC_WXZC, NC_FLDZC_KFZC, NC_FLDZC_SY, NC_FLDZC_CQDTFY, NC_FLDZC_DYSDSZC, NC_FLDZC_QTFLDZC, NC_FLDZC_FLDZCHJ, NC_ZCZJ, NC_LDFZ_DQJK, NC_LDFZ_JYXJRFZ, NC_LDFZ_YFPJ, NC_LDFZ_YFZK, NC_LDFZ_YSZK, NC_LDFZ_YFGZ, NC_LDFZ_YFFLF, NC_LDFZ_YJSJ, NC_LDFZ_YFLX, NC_LDFZ_YFGL, NC_LDFZ_QTYFK, NC_LDFZ_YTFY, NC_LDFZ_YNNDQCQFZ, NC_LDFZ_QTLDFZ, NC_LDFZ_LDFZHJ, NC_FLDFZ_CQJK, NC_FLDFZ_YFZQ, NC_FLDFZ_CQYFK, NC_FLDFZ_ZXYFK, NC_FLDFZ_YJFZ, NC_FLDFZ_DYSY, NC_FLDFZ_QTCQFZ, NC_FLDFZ_CQFZHJ, NC_DYSX_DYSFZ, NC_DYSX_FZHJ, NC_GDQY_SSZB, NC_GDQY_YGHTZ, NC_GDQY_SSZBJE, NC_GDQY_ZBGJ, NC_GDQY_KCG, NC_GDQY_YYGJ, NC_GDQY_YBFXZB, NC_GDQY_WFPLR, NC_GDQY_GSYMGSQYHJ, NC_GDQY_SSGDQY, NC_GDQY_SYZQYHJ, NC_GDQY_FZHSYZQY, QM_LDZC_HBZJ, QM_LDZC_JYXJRZC, QM_LDZC_YSPJ, QM_LDZC_YSZK, QM_LDZC_YFZK, QM_LDZC_YSFL, QM_LDZC_YSLX, QM_LDZC_QTYSK, QM_LDZC_CH, QM_LDZC_DTFY, QM_LDZC_YNNDQCQZQTZ, QM_LDZC_QTLDZC, QM_LDZC_HJ, QM_FLDZC_KGCSJRZC, QM_FLDZC_CYZDQTZ, QM_FLDZC_CQYSK, QM_FLDZC_CQGQTZ, QM_FLDZC_TZXFDC, QM_FLDZC_GDZC, QM_FLDZC_ZJGC, QM_FLDZC_GCWZ, QM_FLDZC_GDZCQL, QM_FLDZC_SCXSWZC, QM_FLDZC_YQZC, QM_FLDZC_WXZC, QM_FLDZC_KFZC, QM_FLDZC_SY, QM_FLDZC_CQDTFY, QM_FLDZC_DYSDSZC, QM_FLDZC_QTFLDZC, QM_FLDZC_FLDZCHJ, QM_ZCZJ, QM_LDFZ_DQJK, QM_LDFZ_JYXJRFZ, QM_LDFZ_YFPJ, QM_LDFZ_YFZK, QM_LDFZ_YSZK, QM_LDFZ_YFGZ, QM_LDFZ_YFFLF, QM_LDFZ_YJSJ, QM_LDFZ_YFLX, QM_LDFZ_YFGL, QM_LDFZ_QTYFK, QM_LDFZ_YTFY, QM_LDFZ_YNNDQCQFZ, QM_LDFZ_QTLDFZ, QM_LDFZ_LDFZHJ, QM_FLDFZ_CQJK, QM_FLDFZ_YFZQ, QM_FLDFZ_CQYFK, QM_FLDFZ_ZXYFK, QM_FLDFZ_YJFZ, QM_FLDFZ_DYSY, QM_FLDFZ_QTCQFZ, QM_FLDFZ_CQFZHJ, QM_DYSX_DYSFZ, QM_DYSX_FZHJ, QM_GDQY_SSZB, QM_GDQY_YGHTZ, QM_GDQY_SSZBJE, QM_GDQY_ZBGJ, QM_GDQY_KCG, QM_GDQY_YYGJ, QM_GDQY_YBFXZB, QM_GDQY_WFPLR, QM_GDQY_GSYMGSQYHJ, QM_GDQY_SSGDQY, QM_GDQY_SYZQYHJ, QM_GDQY_FZHSYZQY) VALUES
('BS202609', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '元', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00, '9335250.00', '0.00', '800000.00', '32200000.00', '1200000.00', '0.00', '0.00', '620000.00', '20580000.00', '0.00', '0.00', '150000.00', '64885250.00', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15500000.00', '2200000.00', '0.00', '0.00', '0.00', '0.00', '3000000.00', '0.00', '0.00', '420000.00', '0.00', '0.00', '22620000.00', '87505250.00', '5000000.00', '0.00', '600000.00', '18032000.00', '2500000.00', '900000.00', '0.00', '700000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '29052000.00', '4000000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '4200000.00', '0.00', '33252000.00', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '1733025.00', '0.00', '30520225.00', '54253250.00', '0.00', '54253250.00', '87505250.00', '10613169.28', '0.00', '800000.00', '46893000.00', '1200000.00', '0.00', '0.00', '620000.00', '26409285.00', '0.00', '0.00', '150000.00', '86685454.28', '0.00', '0.00', '0.00', '1500000.00', '0.00', '15000000.00', '2700000.00', '0.00', '0.00', '0.00', '0.00', '2750000.00', '0.00', '0.00', '370000.00', '0.00', '0.00', '22320000.00', '109005454.28', '6500000.00', '0.00', '600000.00', '23139564.00', '2800000.00', '1000000.00', '0.00', '850000.00', '0.00', '0.00', '520000.00', '0.00', '800000.00', '0.00', '36209564.00', '3500000.00', '0.00', '0.00', '0.00', '0.00', '200000.00', '0.00', '3700000.00', '0.00', '39909564.00', '20000000.00', '0.00', '20000000.00', '2000000.00', '0.00', '2781853.80', '0.00', '44314036.48', '69095890.28', '0.00', '69095890.28', '109005454.28');
-- 利润表基础数据
INSERT INTO t_basi_profit (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_YYSR, BJ_YYCB, BJ_SJJSF, BJ_XSFY, BJ_GLFY, BJ_YFFY, BJ_CWFY, BJ_LXFY, BJ_LRSR, BJ_ZCJZSS, BJ_XYJZSS, BJ_GYJZBD, BJ_TZSY, BJ_LYTZSY, BJ_QTSY, BJ_YYLR, BJ_YYWSR, BJ_YYWZC, BJ_LRZE, BJ_SDSFY, BJ_JLR, BJ_CXYJLR, BJ_ZSYJLR, BJ_ZHSYZE, SQ_YYSR, SQ_YYCB, SQ_SJJSF, SQ_XSFY, SQ_GLFY, SQ_YFFY, SQ_CWFY, SQ_LXFY, SQ_LRSR, SQ_ZCJZSS, SQ_XYJZSS, SQ_GYJZBD, SQ_TZSY, SQ_LYTZSY, SQ_QTSY, SQ_YYLR, SQ_YYWSR, SQ_YYWZC, SQ_LRZE, SQ_SDSFY, SQ_JLR, SQ_CXYJLR, SQ_ZSYJLR, SQ_ZHSYZE) VALUES
('PL202604', 'BATCH-DEMO', 1.00, '2026', '04', '2026-04', '元', 'root', '2026-04-28 10:00:00', 'Y', 'Y', 1.00, '28000000.00', '19600000.00', '308000.00', '2100000.00', '1800000.00', '900000.00', '185000.00', '150000.00', '42000.00', '112000.00', '98000.00', '0.00', '120000.00', '60000.00', '80000.00', '3097000.00', '30000.00', '20000.00', '3107000.00', '776750.00', '2330250.00', '2330250.00', '0.00', '2330250.00', '26740000.00', '18718000.00', '294140.00', '2005500.00', '1719000.00', '859500.00', '176675.00', '143250.00', '40110.00', '106960.00', '93590.00', '0.00', '114600.00', '57300.00', '76400.00', '2957635.00', '28650.00', '19100.00', '2967185.00', '741796.25', '2225388.75', '2225388.75', '0.00', '2225388.75');
INSERT INTO t_basi_profit (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_YYSR, BJ_YYCB, BJ_SJJSF, BJ_XSFY, BJ_GLFY, BJ_YFFY, BJ_CWFY, BJ_LXFY, BJ_LRSR, BJ_ZCJZSS, BJ_XYJZSS, BJ_GYJZBD, BJ_TZSY, BJ_LYTZSY, BJ_QTSY, BJ_YYLR, BJ_YYWSR, BJ_YYWZC, BJ_LRZE, BJ_SDSFY, BJ_JLR, BJ_CXYJLR, BJ_ZSYJLR, BJ_ZHSYZE, SQ_YYSR, SQ_YYCB, SQ_SJJSF, SQ_XSFY, SQ_GLFY, SQ_YFFY, SQ_CWFY, SQ_LXFY, SQ_LRSR, SQ_ZCJZSS, SQ_XYJZSS, SQ_GYJZBD, SQ_TZSY, SQ_LYTZSY, SQ_QTSY, SQ_YYLR, SQ_YYWSR, SQ_YYWZC, SQ_LRZE, SQ_SDSFY, SQ_JLR, SQ_CXYJLR, SQ_ZSYJLR, SQ_ZHSYZE) VALUES
('PL202605', 'BATCH-DEMO', 1.00, '2026', '05', '2026-05', '元', 'root', '2026-05-28 10:00:00', 'Y', 'Y', 1.00, '30629760.00', '21670555.20', '336927.36', '2173500.00', '1839600.00', '900000.00', '191000.00', '150000.00', '42000.00', '122519.04', '125582.02', '0.00', '120000.00', '60000.00', '80000.00', '3470076.38', '30000.00', '20000.00', '3480076.38', '870019.10', '2610057.29', '2610057.29', '0.00', '2610057.29', '28000000.00', '19600000.00', '308000.00', '2100000.00', '1800000.00', '900000.00', '185000.00', '150000.00', '42000.00', '112000.00', '98000.00', '0.00', '120000.00', '60000.00', '80000.00', '3097000.00', '30000.00', '20000.00', '3107000.00', '776750.00', '2330250.00', '2330250.00', '0.00', '2330250.00');
INSERT INTO t_basi_profit (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_YYSR, BJ_YYCB, BJ_SJJSF, BJ_XSFY, BJ_GLFY, BJ_YFFY, BJ_CWFY, BJ_LXFY, BJ_LRSR, BJ_ZCJZSS, BJ_XYJZSS, BJ_GYJZBD, BJ_TZSY, BJ_LYTZSY, BJ_QTSY, BJ_YYLR, BJ_YYWSR, BJ_YYWZC, BJ_LRZE, BJ_SDSFY, BJ_JLR, BJ_CXYJLR, BJ_ZSYJLR, BJ_ZHSYZE, SQ_YYSR, SQ_YYCB, SQ_SJJSF, SQ_XSFY, SQ_GLFY, SQ_YFFY, SQ_CWFY, SQ_LXFY, SQ_LRSR, SQ_ZCJZSS, SQ_XYJZSS, SQ_GYJZBD, SQ_TZSY, SQ_LYTZSY, SQ_QTSY, SQ_YYLR, SQ_YYWSR, SQ_YYWZC, SQ_LRZE, SQ_SDSFY, SQ_JLR, SQ_CXYJLR, SQ_ZSYJLR, SQ_ZHSYZE) VALUES
('PL202606', 'BATCH-DEMO', 1.00, '2026', '06', '2026-06', '元', 'root', '2026-06-28 10:00:00', 'Y', 'Y', 1.00, '30387840.00', '21727305.60', '334266.24', '2247000.00', '1879200.00', '900000.00', '197000.00', '150000.00', '42000.00', '121551.36', '142822.85', '0.00', '120000.00', '60000.00', '80000.00', '3038693.95', '30000.00', '20000.00', '3048693.95', '762173.49', '2286520.46', '2286520.46', '0.00', '2286520.46', '30629760.00', '21670555.20', '336927.36', '2173500.00', '1839600.00', '900000.00', '191000.00', '150000.00', '42000.00', '122519.04', '125582.02', '0.00', '120000.00', '60000.00', '80000.00', '3470076.38', '30000.00', '20000.00', '3480076.38', '870019.10', '2610057.29', '2610057.29', '0.00', '2610057.29');
INSERT INTO t_basi_profit (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_YYSR, BJ_YYCB, BJ_SJJSF, BJ_XSFY, BJ_GLFY, BJ_YFFY, BJ_CWFY, BJ_LXFY, BJ_LRSR, BJ_ZCJZSS, BJ_XYJZSS, BJ_GYJZBD, BJ_TZSY, BJ_LYTZSY, BJ_QTSY, BJ_YYLR, BJ_YYWSR, BJ_YYWZC, BJ_LRZE, BJ_SDSFY, BJ_JLR, BJ_CXYJLR, BJ_ZSYJLR, BJ_ZHSYZE, SQ_YYSR, SQ_YYCB, SQ_SJJSF, SQ_XSFY, SQ_GLFY, SQ_YFFY, SQ_CWFY, SQ_LXFY, SQ_LRSR, SQ_ZCJZSS, SQ_XYJZSS, SQ_GYJZBD, SQ_TZSY, SQ_LYTZSY, SQ_QTSY, SQ_YYLR, SQ_YYWSR, SQ_YYWZC, SQ_LRZE, SQ_SDSFY, SQ_JLR, SQ_CXYJLR, SQ_ZSYJLR, SQ_ZHSYZE) VALUES
('PL202607', 'BATCH-DEMO', 1.00, '2026', '07', '2026-07', '元', 'root', '2026-07-28 10:00:00', 'Y', 'Y', 1.00, '33143040.00', '23945846.40', '364573.44', '2320500.00', '1918800.00', '900000.00', '203000.00', '150000.00', '42000.00', '132572.16', '175658.11', '0.00', '120000.00', '60000.00', '80000.00', '3382089.89', '30000.00', '20000.00', '3392089.89', '848022.47', '2544067.42', '2544067.42', '0.00', '2544067.42', '30387840.00', '21727305.60', '334266.24', '2247000.00', '1879200.00', '900000.00', '197000.00', '150000.00', '42000.00', '121551.36', '142822.85', '0.00', '120000.00', '60000.00', '80000.00', '3038693.95', '30000.00', '20000.00', '3048693.95', '762173.49', '2286520.46', '2286520.46', '0.00', '2286520.46');
INSERT INTO t_basi_profit (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_YYSR, BJ_YYCB, BJ_SJJSF, BJ_XSFY, BJ_GLFY, BJ_YFFY, BJ_CWFY, BJ_LXFY, BJ_LRSR, BJ_ZCJZSS, BJ_XYJZSS, BJ_GYJZBD, BJ_TZSY, BJ_LYTZSY, BJ_QTSY, BJ_YYLR, BJ_YYWSR, BJ_YYWZC, BJ_LRZE, BJ_SDSFY, BJ_JLR, BJ_CXYJLR, BJ_ZSYJLR, BJ_ZHSYZE, SQ_YYSR, SQ_YYCB, SQ_SJJSF, SQ_XSFY, SQ_GLFY, SQ_YFFY, SQ_CWFY, SQ_LXFY, SQ_LRSR, SQ_ZCJZSS, SQ_XYJZSS, SQ_GYJZBD, SQ_TZSY, SQ_LYTZSY, SQ_QTSY, SQ_YYLR, SQ_YYWSR, SQ_YYWZC, SQ_LRZE, SQ_SDSFY, SQ_JLR, SQ_CXYJLR, SQ_ZSYJLR, SQ_ZHSYZE) VALUES
('PL202608', 'BATCH-DEMO', 1.00, '2026', '08', '2026-08', '元', 'root', '2026-08-28 10:00:00', 'Y', 'Y', 1.00, '32531520.00', '23748009.60', '357846.72', '2394000.00', '1958400.00', '900000.00', '209000.00', '150000.00', '42000.00', '130126.08', '191935.97', '0.00', '120000.00', '60000.00', '80000.00', '2842201.63', '30000.00', '20000.00', '2852201.63', '713050.41', '2139151.22', '2139151.22', '0.00', '2139151.22', '33143040.00', '23945846.40', '364573.44', '2320500.00', '1918800.00', '900000.00', '203000.00', '150000.00', '42000.00', '132572.16', '175658.11', '0.00', '120000.00', '60000.00', '80000.00', '3382089.89', '30000.00', '20000.00', '3392089.89', '848022.47', '2544067.42', '2544067.42', '0.00', '2544067.42');
INSERT INTO t_basi_profit (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_YYSR, BJ_YYCB, BJ_SJJSF, BJ_XSFY, BJ_GLFY, BJ_YFFY, BJ_CWFY, BJ_LXFY, BJ_LRSR, BJ_ZCJZSS, BJ_XYJZSS, BJ_GYJZBD, BJ_TZSY, BJ_LYTZSY, BJ_QTSY, BJ_YYLR, BJ_YYWSR, BJ_YYWZC, BJ_LRZE, BJ_SDSFY, BJ_JLR, BJ_CXYJLR, BJ_ZSYJLR, BJ_ZHSYZE, SQ_YYSR, SQ_YYCB, SQ_SJJSF, SQ_XSFY, SQ_GLFY, SQ_YFFY, SQ_CWFY, SQ_LXFY, SQ_LRSR, SQ_ZCJZSS, SQ_XYJZSS, SQ_GYJZBD, SQ_TZSY, SQ_LYTZSY, SQ_QTSY, SQ_YYLR, SQ_YYWSR, SQ_YYWZC, SQ_LRZE, SQ_SDSFY, SQ_JLR, SQ_CXYJLR, SQ_ZSYJLR, SQ_ZHSYZE) VALUES
('PL202609', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '元', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00, '34104000.00', '25151700.00', '375144.00', '2467500.00', '1998000.00', '900000.00', '215000.00', '150000.00', '42000.00', '136416.00', '221676.00', '0.00', '120000.00', '60000.00', '80000.00', '2838564.00', '30000.00', '20000.00', '2848564.00', '712141.00', '2136423.00', '2136423.00', '0.00', '2136423.00', '32531520.00', '23748009.60', '357846.72', '2394000.00', '1958400.00', '900000.00', '209000.00', '150000.00', '42000.00', '130126.08', '191935.97', '0.00', '120000.00', '60000.00', '80000.00', '2842201.63', '30000.00', '20000.00', '2852201.63', '713050.41', '2139151.22', '2139151.22', '0.00', '2139151.22');
-- 现金流量表基础数据
INSERT INTO t_basi_cash_flow (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_XSSPTLWSRDXJ, BJ_SDDDSFFH, BJ_SDQTYJYHDDXJ, BJ_JYHDXJLRXJ, BJ_GMWJSLWZFDXJ, BJ_ZFZGYJWGZFDXJ, BJ_ZFDFVAT, BJ_ZFQTYJYHDDXJ, BJ_JYHDXJLCXJ, BJ_JYHDCSDXJLJE, BJ_TZHDXJLRXJ, BJ_TZHDXJLCXJ, BJ_TZHDCSDXJLJE, BJ_CZHDXJLRXJ, BJ_CZHDXJLCXJ, BJ_CZHDCSDXJLJE, BJ_HLLVBDDXJ, BJ_XJJXJDJWJZJE, BJ_QCXJJXJDJWYE, BJ_QMXJJXJDJWYE, SQ_XSSPTLWSRDXJ, SQ_SDDDSFFH, SQ_SDQTYJYHDDXJ, SQ_JYHDXJLRXJ, SQ_GMWJSLWZFDXJ, SQ_ZFZGYJWGZFDXJ, SQ_ZFDFVAT, SQ_ZFQTYJYHDDXJ, SQ_JYHDXJLCXJ, SQ_JYHDCSDXJLJE, SQ_TZHDXJLRXJ, SQ_TZHDXJLCXJ, SQ_TZHDCSDXJLJE, SQ_CZHDXJLRXJ, SQ_CZHDXJLCXJ, SQ_CZHDCSDXJLJE, SQ_HLLVBDDXJ, SQ_XJJXJDJWJZJE, SQ_QCXJJXJDJWYE, SQ_QMXJJXJDJWYE) VALUES
('CF202604', 'BATCH-DEMO', 1.00, '2026', '04', '2026-04', '元', 'root', '2026-04-28 10:00:00', 'Y', 'Y', 1.00, '28560000.00', '0.00', '200000.00', '28760000.00', '19600000.00', '2600000.00', '1924750.00', '1200000.00', '25324750.00', '3435250.00', '0.00', '1600000.00', '-1600000.00', '0.00', '500000.00', '-500000.00', '0.00', '1335250.00', '8000000.00', '9335250.00', '27417600.00', '0.00', '192000.00', '27609600.00', '18816000.00', '2496000.00', '1847760.00', '1152000.00', '24311760.00', '3297840.00', '0.00', '1536000.00', '-1536000.00', '0.00', '480000.00', '-480000.00', '0.00', '1281840.00', '7680000.00', '8961840.00');
INSERT INTO t_basi_cash_flow (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_XSSPTLWSRDXJ, BJ_SDDDSFFH, BJ_SDQTYJYHDDXJ, BJ_JYHDXJLRXJ, BJ_GMWJSLWZFDXJ, BJ_ZFZGYJWGZFDXJ, BJ_ZFDFVAT, BJ_ZFQTYJYHDDXJ, BJ_JYHDXJLCXJ, BJ_JYHDCSDXJLJE, BJ_TZHDXJLRXJ, BJ_TZHDXJLCXJ, BJ_TZHDCSDXJLJE, BJ_CZHDXJLRXJ, BJ_CZHDXJLCXJ, BJ_CZHDCSDXJLJE, BJ_HLLVBDDXJ, BJ_XJJXJDJWJZJE, BJ_QCXJJXJDJWYE, BJ_QMXJJXJDJWYE, SQ_XSSPTLWSRDXJ, SQ_SDDDSFFH, SQ_SDQTYJYHDDXJ, SQ_JYHDXJLRXJ, SQ_GMWJSLWZFDXJ, SQ_ZFZGYJWGZFDXJ, SQ_ZFDFVAT, SQ_ZFQTYJYHDDXJ, SQ_JYHDXJLCXJ, SQ_JYHDCSDXJLJE, SQ_TZHDXJLRXJ, SQ_TZHDXJLCXJ, SQ_TZHDCSDXJLJE, SQ_CZHDXJLRXJ, SQ_CZHDXJLCXJ, SQ_CZHDCSDXJLJE, SQ_HLLVBDDXJ, SQ_XJJXJDJWJZJE, SQ_QCXJJXJDJWYE, SQ_QMXJJXJDJWYE) VALUES
('CF202605', 'BATCH-DEMO', 1.00, '2026', '05', '2026-05', '元', 'root', '2026-05-28 10:00:00', 'Y', 'Y', 1.00, '30997317.12', '0.00', '200000.00', '31197317.12', '21757237.42', '2652000.00', '2125839.26', '1200000.00', '27735076.68', '3462240.44', '0.00', '1660000.00', '-1660000.00', '0.00', '530000.00', '-530000.00', '0.00', '1272240.44', '9335250.00', '10607490.44', '28560000.00', '0.00', '200000.00', '28760000.00', '19600000.00', '2600000.00', '1924750.00', '1200000.00', '25324750.00', '3435250.00', '0.00', '1600000.00', '-1600000.00', '0.00', '500000.00', '-500000.00', '0.00', '1335250.00', '8000000.00', '9335250.00');
INSERT INTO t_basi_cash_flow (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_XSSPTLWSRDXJ, BJ_SDDDSFFH, BJ_SDQTYJYHDDXJ, BJ_JYHDXJLRXJ, BJ_GMWJSLWZFDXJ, BJ_ZFZGYJWGZFDXJ, BJ_ZFDFVAT, BJ_ZFQTYJYHDDXJ, BJ_JYHDXJLCXJ, BJ_JYHDCSDXJLJE, BJ_TZHDXJLRXJ, BJ_TZHDXJLCXJ, BJ_TZHDCSDXJLJE, BJ_CZHDXJLRXJ, BJ_CZHDXJLCXJ, BJ_CZHDCSDXJLJE, BJ_HLLVBDDXJ, BJ_XJJXJDJWJZJE, BJ_QCXJJXJDJWYE, BJ_QMXJJXJDJWYE, SQ_XSSPTLWSRDXJ, SQ_SDDDSFFH, SQ_SDQTYJYHDDXJ, SQ_JYHDXJLRXJ, SQ_GMWJSLWZFDXJ, SQ_ZFZGYJWGZFDXJ, SQ_ZFDFVAT, SQ_ZFQTYJYHDDXJ, SQ_JYHDXJLCXJ, SQ_JYHDCSDXJLJE, SQ_TZHDXJLRXJ, SQ_TZHDXJLCXJ, SQ_TZHDCSDXJLJE, SQ_CZHDXJLRXJ, SQ_CZHDXJLCXJ, SQ_CZHDCSDXJLJE, SQ_HLLVBDDXJ, SQ_XJJXJDJWJZJE, SQ_QCXJJXJDJWYE, SQ_QMXJJXJDJWYE) VALUES
('CF202606', 'BATCH-DEMO', 1.00, '2026', '06', '2026-06', '元', 'root', '2026-06-28 10:00:00', 'Y', 'Y', 1.00, '30509391.36', '0.00', '200000.00', '30709391.36', '21901124.04', '2704000.00', '2008074.93', '1200000.00', '27813198.97', '2896192.39', '0.00', '1720000.00', '-1720000.00', '0.00', '560000.00', '-560000.00', '0.00', '616192.39', '10607490.44', '11223682.83', '30997317.12', '0.00', '200000.00', '31197317.12', '21757237.42', '2652000.00', '2125839.26', '1200000.00', '27735076.68', '3462240.44', '0.00', '1660000.00', '-1660000.00', '0.00', '530000.00', '-530000.00', '0.00', '1272240.44', '9335250.00', '10607490.44');
INSERT INTO t_basi_cash_flow (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_XSSPTLWSRDXJ, BJ_SDDDSFFH, BJ_SDQTYJYHDDXJ, BJ_JYHDXJLRXJ, BJ_GMWJSLWZFDXJ, BJ_ZFZGYJWGZFDXJ, BJ_ZFDFVAT, BJ_ZFQTYJYHDDXJ, BJ_JYHDXJLCXJ, BJ_JYHDCSDXJLJE, BJ_TZHDXJLRXJ, BJ_TZHDXJLCXJ, BJ_TZHDCSDXJLJE, BJ_CZHDXJLRXJ, BJ_CZHDXJLCXJ, BJ_CZHDCSDXJLJE, BJ_HLLVBDDXJ, BJ_XJJXJDJWJZJE, BJ_QCXJJXJDJWYE, BJ_QMXJJXJDJWYE, SQ_XSSPTLWSRDXJ, SQ_SDDDSFFH, SQ_SDQTYJYHDDXJ, SQ_JYHDXJLRXJ, SQ_GMWJSLWZFDXJ, SQ_ZFZGYJWGZFDXJ, SQ_ZFDFVAT, SQ_ZFQTYJYHDDXJ, SQ_JYHDXJLCXJ, SQ_JYHDCSDXJLJE, SQ_TZHDXJLRXJ, SQ_TZHDXJLCXJ, SQ_TZHDCSDXJLJE, SQ_CZHDXJLRXJ, SQ_CZHDXJLCXJ, SQ_CZHDCSDXJLJE, SQ_HLLVBDDXJ, SQ_XJJXJDJWJZJE, SQ_QCXJJXJDJWYE, SQ_QMXJJXJDJWYE) VALUES
('CF202607', 'BATCH-DEMO', 1.00, '2026', '07', '2026-07', '元', 'root', '2026-07-28 10:00:00', 'Y', 'Y', 1.00, '33010467.84', '0.00', '200000.00', '33210467.84', '24233196.56', '2756000.00', '2206887.11', '1200000.00', '30396083.67', '2814384.17', '0.00', '1780000.00', '-1780000.00', '0.00', '590000.00', '-590000.00', '0.00', '444384.17', '11223682.83', '11668067.00', '30509391.36', '0.00', '200000.00', '30709391.36', '21901124.04', '2704000.00', '2008074.93', '1200000.00', '27813198.97', '2896192.39', '0.00', '1720000.00', '-1720000.00', '0.00', '560000.00', '-560000.00', '0.00', '616192.39', '10607490.44', '11223682.83');
INSERT INTO t_basi_cash_flow (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_XSSPTLWSRDXJ, BJ_SDDDSFFH, BJ_SDQTYJYHDDXJ, BJ_JYHDXJLRXJ, BJ_GMWJSLWZFDXJ, BJ_ZFZGYJWGZFDXJ, BJ_ZFDFVAT, BJ_ZFQTYJYHDDXJ, BJ_JYHDXJLCXJ, BJ_JYHDCSDXJLJE, BJ_TZHDXJLRXJ, BJ_TZHDXJLCXJ, BJ_TZHDCSDXJLJE, BJ_CZHDXJLRXJ, BJ_CZHDXJLCXJ, BJ_CZHDCSDXJLJE, BJ_HLLVBDDXJ, BJ_XJJXJDJWJZJE, BJ_QCXJJXJDJWYE, BJ_QMXJJXJDJWYE, SQ_XSSPTLWSRDXJ, SQ_SDDDSFFH, SQ_SDQTYJYHDDXJ, SQ_JYHDXJLRXJ, SQ_GMWJSLWZFDXJ, SQ_ZFZGYJWGZFDXJ, SQ_ZFDFVAT, SQ_ZFQTYJYHDDXJ, SQ_JYHDXJLCXJ, SQ_JYHDCSDXJLJE, SQ_TZHDXJLRXJ, SQ_TZHDXJLCXJ, SQ_TZHDCSDXJLJE, SQ_CZHDXJLRXJ, SQ_CZHDXJLCXJ, SQ_CZHDCSDXJLJE, SQ_HLLVBDDXJ, SQ_XJJXJDJWJZJE, SQ_QCXJJXJDJWYE, SQ_QMXJJXJDJWYE) VALUES
('CF202608', 'BATCH-DEMO', 1.00, '2026', '08', '2026-08', '元', 'root', '2026-08-28 10:00:00', 'Y', 'Y', 1.00, '32141141.76', '0.00', '200000.00', '32341141.76', '24127977.75', '2808000.00', '2046842.73', '1200000.00', '30182820.48', '2158321.28', '0.00', '1840000.00', '-1840000.00', '0.00', '620000.00', '-620000.00', '0.00', '-301678.72', '11668067.00', '11366388.28', '33010467.84', '0.00', '200000.00', '33210467.84', '24233196.56', '2756000.00', '2206887.11', '1200000.00', '30396083.67', '2814384.17', '0.00', '1780000.00', '-1780000.00', '0.00', '590000.00', '-590000.00', '0.00', '444384.17', '11223682.83', '11668067.00');
INSERT INTO t_basi_cash_flow (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, JEDW, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE, BJ_XSSPTLWSRDXJ, BJ_SDDDSFFH, BJ_SDQTYJYHDDXJ, BJ_JYHDXJLRXJ, BJ_GMWJSLWZFDXJ, BJ_ZFZGYJWGZFDXJ, BJ_ZFDFVAT, BJ_ZFQTYJYHDDXJ, BJ_JYHDXJLCXJ, BJ_JYHDCSDXJLJE, BJ_TZHDXJLRXJ, BJ_TZHDXJLCXJ, BJ_TZHDCSDXJLJE, BJ_CZHDXJLRXJ, BJ_CZHDXJLCXJ, BJ_CZHDCSDXJLJE, BJ_HLLVBDDXJ, BJ_XJJXJDJWJZJE, BJ_QCXJJXJDJWYE, BJ_QMXJJXJDJWYE, SQ_XSSPTLWSRDXJ, SQ_SDDDSFFH, SQ_SDQTYJYHDDXJ, SQ_JYHDXJLRXJ, SQ_GMWJSLWZFDXJ, SQ_ZFZGYJWGZFDXJ, SQ_ZFDFVAT, SQ_ZFQTYJYHDDXJ, SQ_JYHDXJLCXJ, SQ_JYHDCSDXJLJE, SQ_TZHDXJLRXJ, SQ_TZHDXJLCXJ, SQ_TZHDCSDXJLJE, SQ_CZHDXJLRXJ, SQ_CZHDXJLCXJ, SQ_CZHDCSDXJLJE, SQ_HLLVBDDXJ, SQ_XJJXJDJWJZJE, SQ_QCXJJXJDJWYE, SQ_QMXJJXJDJWYE) VALUES
('CF202609', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '元', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00, '33421920.00', '0.00', '200000.00', '33621920.00', '25654734.00', '2860000.00', '2110405.00', '1200000.00', '31825139.00', '1796781.00', '0.00', '1900000.00', '-1900000.00', '0.00', '650000.00', '-650000.00', '0.00', '-753219.00', '11366388.28', '10613169.28', '32141141.76', '0.00', '200000.00', '32341141.76', '24127977.75', '2808000.00', '2046842.73', '1200000.00', '30182820.48', '2158321.28', '0.00', '1840000.00', '-1840000.00', '0.00', '620000.00', '-620000.00', '0.00', '-301678.72', '11668067.00', '11366388.28');
-- 科目余额表(一级/二级科目)
INSERT INTO t_kmye (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, SUBJECT_CODE, SUBJECT_NAME, SUBJECT_LEVEL, PARENT_CODE, DIRECTION, CURRENCY, QC_DEBIT, QC_CREDIT, QC_AMOUNT, PERIOD_DEBIT, PERIOD_CREDIT, QM_DEBIT, QM_CREDIT, QM_AMOUNT, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('KM202609001', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1001', '库存现金', 1.00, NULL, '借', 'RMB', '45000.00', '0.00', '45000.00', '320000.00', '305000.00', '0.00', '0.00', '60000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609002', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1002', '银行存款', 1.00, '1001', '借', 'RMB', '7955000.00', '0.00', '7955000.00', '12500000.00', '12130000.00', '0.00', '0.00', '8325000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609003', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1122', '应收账款', 1.00, NULL, '借', 'RMB', '11500000.00', '0.00', '11500000.00', '9800000.00', '9900000.00', '0.00', '0.00', '46893000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00);
INSERT INTO t_kmye (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, SUBJECT_CODE, SUBJECT_NAME, SUBJECT_LEVEL, PARENT_CODE, DIRECTION, CURRENCY, QC_DEBIT, QC_CREDIT, QC_AMOUNT, PERIOD_DEBIT, PERIOD_CREDIT, QM_DEBIT, QM_CREDIT, QM_AMOUNT, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('KM202609004', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1123', '预付账款', 1.00, NULL, '借', 'RMB', '1200000.00', '0.00', '1200000.00', '300000.00', '0.00', '0.00', '0.00', '1200000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609005', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1221', '其他应收款', 1.00, NULL, '借', 'RMB', '620000.00', '0.00', '620000.00', '0.00', '0.00', '0.00', '0.00', '620000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609006', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1405', '库存商品', 1.00, NULL, '借', 'RMB', '21127428.00', '0.00', '21127428.00', '0.00', '0.00', '0.00', '0.00', '21127428.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00);
INSERT INTO t_kmye (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, SUBJECT_CODE, SUBJECT_NAME, SUBJECT_LEVEL, PARENT_CODE, DIRECTION, CURRENCY, QC_DEBIT, QC_CREDIT, QC_AMOUNT, PERIOD_DEBIT, PERIOD_CREDIT, QM_DEBIT, QM_CREDIT, QM_AMOUNT, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('KM202609007', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1403', '原材料', 1.00, '1405', '借', 'RMB', '5281857.00', '0.00', '5281857.00', '0.00', '0.00', '0.00', '0.00', '5281857.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609008', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1601', '固定资产', 1.00, NULL, '借', 'RMB', '18000000.00', '0.00', '18000000.00', '0.00', '0.00', '0.00', '0.00', '18000000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609009', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1602', '累计折旧', 1.00, '1601', '借', 'RMB', '-2500000.00', '0.00', '-2500000.00', '0.00', '100000.00', '0.00', '0.00', '-2600000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00);
INSERT INTO t_kmye (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, SUBJECT_CODE, SUBJECT_NAME, SUBJECT_LEVEL, PARENT_CODE, DIRECTION, CURRENCY, QC_DEBIT, QC_CREDIT, QC_AMOUNT, PERIOD_DEBIT, PERIOD_CREDIT, QM_DEBIT, QM_CREDIT, QM_AMOUNT, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('KM202609010', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '1701', '无形资产', 1.00, NULL, '借', 'RMB', '3200000.00', '0.00', '3200000.00', '0.00', '50000.00', '0.00', '0.00', '3150000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609011', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '2001', '短期借款', 1.00, NULL, '借', 'RMB', '6200000.00', '0.00', '6200000.00', '300000.00', '0.00', '0.00', '0.00', '6500000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609012', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '2202', '应付账款', 1.00, NULL, '借', 'RMB', '23500000.00', '0.00', '23500000.00', '0.00', '1200000.00', '0.00', '0.00', '23139564.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00);
INSERT INTO t_kmye (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, SUBJECT_CODE, SUBJECT_NAME, SUBJECT_LEVEL, PARENT_CODE, DIRECTION, CURRENCY, QC_DEBIT, QC_CREDIT, QC_AMOUNT, PERIOD_DEBIT, PERIOD_CREDIT, QM_DEBIT, QM_CREDIT, QM_AMOUNT, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('KM202609013', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '2211', '应付职工薪酬', 1.00, NULL, '借', 'RMB', '980000.00', '0.00', '980000.00', '900000.00', '0.00', '0.00', '0.00', '880000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609014', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '2221', '应交税费', 1.00, NULL, '借', 'RMB', '790000.00', '0.00', '790000.00', '2100000.00', '2260000.00', '0.00', '0.00', '950000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609015', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '2501', '长期借款', 1.00, NULL, '借', 'RMB', '3600000.00', '0.00', '3600000.00', '0.00', '100000.00', '0.00', '0.00', '3500000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00);
INSERT INTO t_kmye (ID, BATCH_ID, ORG_ID, KJYEAR, KJMOTH, KJYEAR_MONTH, SUBJECT_CODE, SUBJECT_NAME, SUBJECT_LEVEL, PARENT_CODE, DIRECTION, CURRENCY, QC_DEBIT, QC_CREDIT, QC_AMOUNT, PERIOD_DEBIT, PERIOD_CREDIT, QM_DEBIT, QM_CREDIT, QM_AMOUNT, IMP_USER, IMP_TIME, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('KM202609016', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '4001', '实收资本', 1.00, NULL, '借', 'RMB', '20000000.00', '0.00', '20000000.00', '0.00', '0.00', '0.00', '0.00', '20000000.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609017', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '4103', '本年利润', 1.00, NULL, '借', 'RMB', '0.00', '0.00', '0.00', '2136423.00', '0.00', '0.00', '0.00', '2136423.00', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00),
('KM202609018', 'BATCH-DEMO', 1.00, '2026', '09', '2026-09', '4104', '利润分配', 1.00, NULL, '借', 'RMB', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '44314036.48', 'root', '2026-09-28 10:00:00', 'Y', 'Y', 1.00);
-- 账龄分析数据(应收/应付/预付/其他应收)
INSERT INTO t_age_analysis (ID, BATCH_ID, PROJECT_CODE, PROJECT_NAME, BALANCE, CREDIT_PERIOD, CREDIT_LINE, NOT_DUE1_TO30_DAYS, NOT_DUE31_TO90_DAYS, NOT_DUE91_TO180_DAYS, NOT_DUE181_DAYS, DUE1_TO30_DAYS, DUE31_TO90_DAYS, DUE91_TO180_DAYS, DUE181_TO360_DAYS, DUE361_TO720_DAYS, DUE721_TO1080_DAYS, DUE1081_TO1440_DAYS, DUE1441_DAYS, DUE_TODAY, AGING_TYPE, IMP_TIME, IMP_USER, KJYEAR, KJMOTH, KJYEAR_MONTH, ORG_ID, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('AG202609001', 'BATCH-DEMO', 'YS001', '徐州重工机械有限公司', '3200000.00', '30.00', '3000000.00', '800000.00', '900000.00', '600000.00', '0.00', '300000.00', '400000.00', '200000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00),
('AG202609002', 'BATCH-DEMO', 'YS002', '江苏华信电气股份有限公司', '2100000.00', '30.00', '2000000.00', '500000.00', '700000.00', '400000.00', '0.00', '200000.00', '200000.00', '100000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00),
('AG202609003', 'BATCH-DEMO', 'YS003', '南京智联信息技术有限公司', '1450000.00', '45.00', '1500000.00', '350000.00', '300000.00', '250000.00', '0.00', '150000.00', '150000.00', '250000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00);
INSERT INTO t_age_analysis (ID, BATCH_ID, PROJECT_CODE, PROJECT_NAME, BALANCE, CREDIT_PERIOD, CREDIT_LINE, NOT_DUE1_TO30_DAYS, NOT_DUE31_TO90_DAYS, NOT_DUE91_TO180_DAYS, NOT_DUE181_DAYS, DUE1_TO30_DAYS, DUE31_TO90_DAYS, DUE91_TO180_DAYS, DUE181_TO360_DAYS, DUE361_TO720_DAYS, DUE721_TO1080_DAYS, DUE1081_TO1440_DAYS, DUE1441_DAYS, DUE_TODAY, AGING_TYPE, IMP_TIME, IMP_USER, KJYEAR, KJMOTH, KJYEAR_MONTH, ORG_ID, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('AG202609004', 'BATCH-DEMO', 'YS004', '苏州恒远物流有限公司', '900000.00', '60.00', '800000.00', '200000.00', '150000.00', '100000.00', '0.00', '100000.00', '150000.00', '200000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00),
('AG202609005', 'BATCH-DEMO', 'YF001', '无锡精工材料有限公司', '5800000.00', '60.00', '6000000.00', '1200000.00', '1500000.00', '900000.00', '0.00', '800000.00', '600000.00', '500000.00', '300000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00),
('AG202609006', 'BATCH-DEMO', 'YF002', '常州科达电子科技有限公司', '3600000.00', '60.00', '4000000.00', '800000.00', '1000000.00', '600000.00', '0.00', '500000.00', '400000.00', '300000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00);
INSERT INTO t_age_analysis (ID, BATCH_ID, PROJECT_CODE, PROJECT_NAME, BALANCE, CREDIT_PERIOD, CREDIT_LINE, NOT_DUE1_TO30_DAYS, NOT_DUE31_TO90_DAYS, NOT_DUE91_TO180_DAYS, NOT_DUE181_DAYS, DUE1_TO30_DAYS, DUE31_TO90_DAYS, DUE91_TO180_DAYS, DUE181_TO360_DAYS, DUE361_TO720_DAYS, DUE721_TO1080_DAYS, DUE1081_TO1440_DAYS, DUE1441_DAYS, DUE_TODAY, AGING_TYPE, IMP_TIME, IMP_USER, KJYEAR, KJMOTH, KJYEAR_MONTH, ORG_ID, IS_SURE, FORMAT_FLAG, ACCOUNT_PORT_TYPE) VALUES
('AG202609007', 'BATCH-DEMO', 'YF003', '泰州联盛机电有限公司', '2400000.00', '90.00', '2500000.00', '500000.00', '600000.00', '400000.00', '0.00', '400000.00', '300000.00', '200000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00),
('AG202609008', 'BATCH-DEMO', 'QT001', '员工备用金及押金', '520000.00', '0.00', '500000.00', '200000.00', '150000.00', '100000.00', '0.00', '70000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00),
('AG202609009', 'BATCH-DEMO', 'YF004', '南通瑞泰包装有限公司', '1200000.00', '30.00', '1200000.00', '400000.00', '500000.00', '300000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '7', '2026-09-28 10:00:00', 'root', '2026', '09', '2026-09', 1.00, 'Y', 'Y', 1.00);
-- 数据仓库转换结果表(编码 + 取数类型 + 数据值)，报告/分析/预测均基于该表计算
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A001', 'NC', '9335250.00', 'ETL', '2026-04-28 11:00:00'),
(2.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A001', 'QM', '9335250.00', 'ETL', '2026-04-28 11:00:00'),
(3.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A002', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(4.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A002', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(5.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A003', 'NC', '800000.00', 'ETL', '2026-04-28 11:00:00'),
(6.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A003', 'QM', '800000.00', 'ETL', '2026-04-28 11:00:00'),
(7.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A004', 'NC', '32200000.00', 'ETL', '2026-04-28 11:00:00'),
(8.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A004', 'QM', '32200000.00', 'ETL', '2026-04-28 11:00:00'),
(9.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A005', 'NC', '1200000.00', 'ETL', '2026-04-28 11:00:00'),
(10.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A005', 'QM', '1200000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(11.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A006', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(12.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A006', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(13.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A007', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(14.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A007', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(15.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A008', 'NC', '620000.00', 'ETL', '2026-04-28 11:00:00'),
(16.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A008', 'QM', '620000.00', 'ETL', '2026-04-28 11:00:00'),
(17.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A009', 'NC', '20580000.00', 'ETL', '2026-04-28 11:00:00'),
(18.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A009', 'QM', '20580000.00', 'ETL', '2026-04-28 11:00:00'),
(19.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A010', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(20.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A010', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(21.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A011', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(22.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A011', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(23.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A012', 'NC', '150000.00', 'ETL', '2026-04-28 11:00:00'),
(24.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A012', 'QM', '150000.00', 'ETL', '2026-04-28 11:00:00'),
(25.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A013', 'NC', '64885250.00', 'ETL', '2026-04-28 11:00:00'),
(26.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A013', 'QM', '64885250.00', 'ETL', '2026-04-28 11:00:00'),
(27.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A014', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(28.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A014', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(29.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A015', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(30.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A015', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(31.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A016', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(32.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A016', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(33.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A017', 'NC', '1500000.00', 'ETL', '2026-04-28 11:00:00'),
(34.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A017', 'QM', '1500000.00', 'ETL', '2026-04-28 11:00:00'),
(35.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A018', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(36.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A018', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(37.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A019', 'NC', '15500000.00', 'ETL', '2026-04-28 11:00:00'),
(38.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A019', 'QM', '15500000.00', 'ETL', '2026-04-28 11:00:00'),
(39.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A020', 'NC', '2200000.00', 'ETL', '2026-04-28 11:00:00'),
(40.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A020', 'QM', '2200000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(41.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A021', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(42.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A021', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(43.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A022', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(44.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A022', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(45.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A023', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(46.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A023', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(47.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A024', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(48.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A024', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(49.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A025', 'NC', '3000000.00', 'ETL', '2026-04-28 11:00:00'),
(50.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A025', 'QM', '3000000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(51.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A026', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(52.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A026', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(53.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A027', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(54.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A027', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(55.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A028', 'NC', '420000.00', 'ETL', '2026-04-28 11:00:00'),
(56.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A028', 'QM', '420000.00', 'ETL', '2026-04-28 11:00:00'),
(57.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A029', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(58.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A029', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(59.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A030', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(60.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A030', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(61.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A031', 'NC', '22620000.00', 'ETL', '2026-04-28 11:00:00'),
(62.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A031', 'QM', '22620000.00', 'ETL', '2026-04-28 11:00:00'),
(63.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A032', 'NC', '87505250.00', 'ETL', '2026-04-28 11:00:00'),
(64.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A032', 'QM', '87505250.00', 'ETL', '2026-04-28 11:00:00'),
(65.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A033', 'NC', '5000000.00', 'ETL', '2026-04-28 11:00:00'),
(66.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A033', 'QM', '5000000.00', 'ETL', '2026-04-28 11:00:00'),
(67.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A034', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(68.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A034', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(69.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A035', 'NC', '600000.00', 'ETL', '2026-04-28 11:00:00'),
(70.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A035', 'QM', '600000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(71.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A036', 'NC', '18032000.00', 'ETL', '2026-04-28 11:00:00'),
(72.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A036', 'QM', '18032000.00', 'ETL', '2026-04-28 11:00:00'),
(73.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A037', 'NC', '2500000.00', 'ETL', '2026-04-28 11:00:00'),
(74.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A037', 'QM', '2500000.00', 'ETL', '2026-04-28 11:00:00'),
(75.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A038', 'NC', '900000.00', 'ETL', '2026-04-28 11:00:00'),
(76.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A038', 'QM', '900000.00', 'ETL', '2026-04-28 11:00:00'),
(77.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A039', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(78.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A039', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(79.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A040', 'NC', '700000.00', 'ETL', '2026-04-28 11:00:00'),
(80.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A040', 'QM', '700000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(81.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A041', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(82.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A041', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(83.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A042', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(84.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A042', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(85.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A043', 'NC', '520000.00', 'ETL', '2026-04-28 11:00:00'),
(86.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A043', 'QM', '520000.00', 'ETL', '2026-04-28 11:00:00'),
(87.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A044', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(88.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A044', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(89.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A045', 'NC', '800000.00', 'ETL', '2026-04-28 11:00:00'),
(90.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A045', 'QM', '800000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(91.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A046', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(92.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A046', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(93.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A047', 'NC', '29052000.00', 'ETL', '2026-04-28 11:00:00'),
(94.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A047', 'QM', '29052000.00', 'ETL', '2026-04-28 11:00:00'),
(95.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A048', 'NC', '4000000.00', 'ETL', '2026-04-28 11:00:00'),
(96.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A048', 'QM', '4000000.00', 'ETL', '2026-04-28 11:00:00'),
(97.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A049', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(98.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A049', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(99.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A050', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(100.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A050', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(101.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A051', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(102.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A051', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(103.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A052', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(104.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A052', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(105.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A053', 'NC', '200000.00', 'ETL', '2026-04-28 11:00:00'),
(106.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A053', 'QM', '200000.00', 'ETL', '2026-04-28 11:00:00'),
(107.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A054', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(108.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A054', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(109.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A055', 'NC', '4200000.00', 'ETL', '2026-04-28 11:00:00'),
(110.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A055', 'QM', '4200000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(111.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A056', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(112.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A056', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(113.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A057', 'NC', '33252000.00', 'ETL', '2026-04-28 11:00:00'),
(114.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A057', 'QM', '33252000.00', 'ETL', '2026-04-28 11:00:00'),
(115.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A058', 'NC', '20000000.00', 'ETL', '2026-04-28 11:00:00'),
(116.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A058', 'QM', '20000000.00', 'ETL', '2026-04-28 11:00:00'),
(117.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A059', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(118.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A059', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(119.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A060', 'NC', '20000000.00', 'ETL', '2026-04-28 11:00:00'),
(120.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A060', 'QM', '20000000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(121.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A061', 'NC', '2000000.00', 'ETL', '2026-04-28 11:00:00'),
(122.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A061', 'QM', '2000000.00', 'ETL', '2026-04-28 11:00:00'),
(123.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A062', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(124.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A062', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(125.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A063', 'NC', '1733025.00', 'ETL', '2026-04-28 11:00:00'),
(126.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A063', 'QM', '1733025.00', 'ETL', '2026-04-28 11:00:00'),
(127.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A064', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(128.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A064', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(129.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A065', 'NC', '30520225.00', 'ETL', '2026-04-28 11:00:00'),
(130.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A065', 'QM', '30520225.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(131.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A066', 'NC', '54253250.00', 'ETL', '2026-04-28 11:00:00'),
(132.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A066', 'QM', '54253250.00', 'ETL', '2026-04-28 11:00:00'),
(133.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A067', 'NC', '0.00', 'ETL', '2026-04-28 11:00:00'),
(134.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A067', 'QM', '0.00', 'ETL', '2026-04-28 11:00:00'),
(135.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A068', 'NC', '54253250.00', 'ETL', '2026-04-28 11:00:00'),
(136.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A068', 'QM', '54253250.00', 'ETL', '2026-04-28 11:00:00'),
(137.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A069', 'NC', '87505250.00', 'ETL', '2026-04-28 11:00:00'),
(138.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'BALANCE', 'A069', 'QM', '87505250.00', 'ETL', '2026-04-28 11:00:00'),
(139.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P001', 'BJ', '28000000.00', 'ETL', '2026-04-28 11:00:00'),
(140.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P001', 'SQ', '26740000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(141.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P002', 'BJ', '19600000.00', 'ETL', '2026-04-28 11:00:00'),
(142.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P002', 'SQ', '18718000.00', 'ETL', '2026-04-28 11:00:00'),
(143.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P003', 'BJ', '308000.00', 'ETL', '2026-04-28 11:00:00'),
(144.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P003', 'SQ', '294140.00', 'ETL', '2026-04-28 11:00:00'),
(145.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P004', 'BJ', '2100000.00', 'ETL', '2026-04-28 11:00:00'),
(146.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P004', 'SQ', '2005500.00', 'ETL', '2026-04-28 11:00:00'),
(147.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P005', 'BJ', '1800000.00', 'ETL', '2026-04-28 11:00:00'),
(148.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P005', 'SQ', '1719000.00', 'ETL', '2026-04-28 11:00:00'),
(149.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P006', 'BJ', '900000.00', 'ETL', '2026-04-28 11:00:00'),
(150.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P006', 'SQ', '859500.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(151.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P007', 'BJ', '185000.00', 'ETL', '2026-04-28 11:00:00'),
(152.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P007', 'SQ', '176675.00', 'ETL', '2026-04-28 11:00:00'),
(153.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P008', 'BJ', '150000.00', 'ETL', '2026-04-28 11:00:00'),
(154.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P008', 'SQ', '143250.00', 'ETL', '2026-04-28 11:00:00'),
(155.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P009', 'BJ', '42000.00', 'ETL', '2026-04-28 11:00:00'),
(156.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P009', 'SQ', '40110.00', 'ETL', '2026-04-28 11:00:00'),
(157.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P010', 'BJ', '112000.00', 'ETL', '2026-04-28 11:00:00'),
(158.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P010', 'SQ', '106960.00', 'ETL', '2026-04-28 11:00:00'),
(159.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P011', 'BJ', '98000.00', 'ETL', '2026-04-28 11:00:00'),
(160.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P011', 'SQ', '93590.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(161.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P012', 'BJ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(162.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P012', 'SQ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(163.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P013', 'BJ', '120000.00', 'ETL', '2026-04-28 11:00:00'),
(164.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P013', 'SQ', '114600.00', 'ETL', '2026-04-28 11:00:00'),
(165.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P014', 'BJ', '60000.00', 'ETL', '2026-04-28 11:00:00'),
(166.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P014', 'SQ', '57300.00', 'ETL', '2026-04-28 11:00:00'),
(167.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P015', 'BJ', '80000.00', 'ETL', '2026-04-28 11:00:00'),
(168.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P015', 'SQ', '76400.00', 'ETL', '2026-04-28 11:00:00'),
(169.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P016', 'BJ', '3097000.00', 'ETL', '2026-04-28 11:00:00'),
(170.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P016', 'SQ', '2957635.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(171.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P017', 'BJ', '30000.00', 'ETL', '2026-04-28 11:00:00'),
(172.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P017', 'SQ', '28650.00', 'ETL', '2026-04-28 11:00:00'),
(173.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P018', 'BJ', '20000.00', 'ETL', '2026-04-28 11:00:00'),
(174.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P018', 'SQ', '19100.00', 'ETL', '2026-04-28 11:00:00'),
(175.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P019', 'BJ', '3107000.00', 'ETL', '2026-04-28 11:00:00'),
(176.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P019', 'SQ', '2967185.00', 'ETL', '2026-04-28 11:00:00'),
(177.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P020', 'BJ', '776750.00', 'ETL', '2026-04-28 11:00:00'),
(178.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P020', 'SQ', '741796.25', 'ETL', '2026-04-28 11:00:00'),
(179.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P021', 'BJ', '2330250.00', 'ETL', '2026-04-28 11:00:00'),
(180.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P021', 'SQ', '2225388.75', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(181.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P022', 'BJ', '2330250.00', 'ETL', '2026-04-28 11:00:00'),
(182.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P022', 'SQ', '2225388.75', 'ETL', '2026-04-28 11:00:00'),
(183.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P023', 'BJ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(184.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P023', 'SQ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(185.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P024', 'BJ', '2330250.00', 'ETL', '2026-04-28 11:00:00'),
(186.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'PROFIT', 'P024', 'SQ', '2225388.75', 'ETL', '2026-04-28 11:00:00'),
(187.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C001', 'BJ', '28560000.00', 'ETL', '2026-04-28 11:00:00'),
(188.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C001', 'SQ', '27417600.00', 'ETL', '2026-04-28 11:00:00'),
(189.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C002', 'BJ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(190.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C002', 'SQ', '0.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(191.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C003', 'BJ', '200000.00', 'ETL', '2026-04-28 11:00:00'),
(192.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C003', 'SQ', '192000.00', 'ETL', '2026-04-28 11:00:00'),
(193.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C004', 'BJ', '28760000.00', 'ETL', '2026-04-28 11:00:00'),
(194.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C004', 'SQ', '27609600.00', 'ETL', '2026-04-28 11:00:00'),
(195.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C005', 'BJ', '19600000.00', 'ETL', '2026-04-28 11:00:00'),
(196.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C005', 'SQ', '18816000.00', 'ETL', '2026-04-28 11:00:00'),
(197.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C006', 'BJ', '2600000.00', 'ETL', '2026-04-28 11:00:00'),
(198.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C006', 'SQ', '2496000.00', 'ETL', '2026-04-28 11:00:00'),
(199.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C007', 'BJ', '1924750.00', 'ETL', '2026-04-28 11:00:00'),
(200.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C007', 'SQ', '1847760.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(201.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C008', 'BJ', '1200000.00', 'ETL', '2026-04-28 11:00:00'),
(202.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C008', 'SQ', '1152000.00', 'ETL', '2026-04-28 11:00:00'),
(203.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C009', 'BJ', '25324750.00', 'ETL', '2026-04-28 11:00:00'),
(204.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C009', 'SQ', '24311760.00', 'ETL', '2026-04-28 11:00:00'),
(205.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C010', 'BJ', '3435250.00', 'ETL', '2026-04-28 11:00:00'),
(206.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C010', 'SQ', '3297840.00', 'ETL', '2026-04-28 11:00:00'),
(207.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C011', 'BJ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(208.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C011', 'SQ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(209.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C012', 'BJ', '1600000.00', 'ETL', '2026-04-28 11:00:00'),
(210.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C012', 'SQ', '1536000.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(211.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C013', 'BJ', '-1600000.00', 'ETL', '2026-04-28 11:00:00'),
(212.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C013', 'SQ', '-1536000.00', 'ETL', '2026-04-28 11:00:00'),
(213.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C014', 'BJ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(214.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C014', 'SQ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(215.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C015', 'BJ', '500000.00', 'ETL', '2026-04-28 11:00:00'),
(216.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C015', 'SQ', '480000.00', 'ETL', '2026-04-28 11:00:00'),
(217.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C016', 'BJ', '-500000.00', 'ETL', '2026-04-28 11:00:00'),
(218.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C016', 'SQ', '-480000.00', 'ETL', '2026-04-28 11:00:00'),
(219.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C017', 'BJ', '0.00', 'ETL', '2026-04-28 11:00:00'),
(220.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C017', 'SQ', '0.00', 'ETL', '2026-04-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(221.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C018', 'BJ', '1335250.00', 'ETL', '2026-04-28 11:00:00'),
(222.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C018', 'SQ', '1281840.00', 'ETL', '2026-04-28 11:00:00'),
(223.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C019', 'BJ', '8000000.00', 'ETL', '2026-04-28 11:00:00'),
(224.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C019', 'SQ', '7680000.00', 'ETL', '2026-04-28 11:00:00'),
(225.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C020', 'BJ', '9335250.00', 'ETL', '2026-04-28 11:00:00'),
(226.00, 'ETL-DEMO', 1.00, '2026', '04', '2026-04', 'CASHFLOW', 'C020', 'SQ', '8961840.00', 'ETL', '2026-04-28 11:00:00'),
(227.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A001', 'NC', '9335250.00', 'ETL', '2026-05-28 11:00:00'),
(228.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A001', 'QM', '10607490.44', 'ETL', '2026-05-28 11:00:00'),
(229.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A002', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(230.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A002', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(231.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A003', 'NC', '800000.00', 'ETL', '2026-05-28 11:00:00'),
(232.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A003', 'QM', '800000.00', 'ETL', '2026-05-28 11:00:00'),
(233.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A004', 'NC', '32200000.00', 'ETL', '2026-05-28 11:00:00'),
(234.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A004', 'QM', '36602563.20', 'ETL', '2026-05-28 11:00:00'),
(235.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A005', 'NC', '1200000.00', 'ETL', '2026-05-28 11:00:00'),
(236.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A005', 'QM', '1200000.00', 'ETL', '2026-05-28 11:00:00'),
(237.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A006', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(238.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A006', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(239.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A007', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(240.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A007', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(241.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A008', 'NC', '620000.00', 'ETL', '2026-05-28 11:00:00'),
(242.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A008', 'QM', '620000.00', 'ETL', '2026-05-28 11:00:00'),
(243.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A009', 'NC', '20580000.00', 'ETL', '2026-05-28 11:00:00'),
(244.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A009', 'QM', '22754082.96', 'ETL', '2026-05-28 11:00:00'),
(245.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A010', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(246.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A010', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(247.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A011', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(248.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A011', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(249.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A012', 'NC', '150000.00', 'ETL', '2026-05-28 11:00:00'),
(250.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A012', 'QM', '150000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(251.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A013', 'NC', '64885250.00', 'ETL', '2026-05-28 11:00:00'),
(252.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A013', 'QM', '72734136.60', 'ETL', '2026-05-28 11:00:00'),
(253.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A014', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(254.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A014', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(255.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A015', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(256.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A015', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(257.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A016', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(258.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A016', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(259.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A017', 'NC', '1500000.00', 'ETL', '2026-05-28 11:00:00'),
(260.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A017', 'QM', '1500000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(261.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A018', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(262.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A018', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(263.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A019', 'NC', '15500000.00', 'ETL', '2026-05-28 11:00:00'),
(264.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A019', 'QM', '15400000.00', 'ETL', '2026-05-28 11:00:00'),
(265.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A020', 'NC', '2200000.00', 'ETL', '2026-05-28 11:00:00'),
(266.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A020', 'QM', '2300000.00', 'ETL', '2026-05-28 11:00:00'),
(267.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A021', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(268.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A021', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(269.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A022', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(270.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A022', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(271.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A023', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(272.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A023', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(273.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A024', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(274.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A024', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(275.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A025', 'NC', '3000000.00', 'ETL', '2026-05-28 11:00:00'),
(276.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A025', 'QM', '2950000.00', 'ETL', '2026-05-28 11:00:00'),
(277.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A026', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(278.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A026', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(279.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A027', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(280.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A027', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(281.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A028', 'NC', '420000.00', 'ETL', '2026-05-28 11:00:00'),
(282.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A028', 'QM', '410000.00', 'ETL', '2026-05-28 11:00:00'),
(283.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A029', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(284.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A029', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(285.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A030', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(286.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A030', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(287.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A031', 'NC', '22620000.00', 'ETL', '2026-05-28 11:00:00'),
(288.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A031', 'QM', '22560000.00', 'ETL', '2026-05-28 11:00:00'),
(289.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A032', 'NC', '87505250.00', 'ETL', '2026-05-28 11:00:00'),
(290.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A032', 'QM', '95294136.60', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(291.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A033', 'NC', '5000000.00', 'ETL', '2026-05-28 11:00:00'),
(292.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A033', 'QM', '5300000.00', 'ETL', '2026-05-28 11:00:00'),
(293.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A034', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(294.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A034', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(295.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A035', 'NC', '600000.00', 'ETL', '2026-05-28 11:00:00'),
(296.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A035', 'QM', '600000.00', 'ETL', '2026-05-28 11:00:00'),
(297.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A036', 'NC', '18032000.00', 'ETL', '2026-05-28 11:00:00'),
(298.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A036', 'QM', '19936910.78', 'ETL', '2026-05-28 11:00:00'),
(299.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A037', 'NC', '2500000.00', 'ETL', '2026-05-28 11:00:00'),
(300.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A037', 'QM', '2560000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(301.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A038', 'NC', '900000.00', 'ETL', '2026-05-28 11:00:00'),
(302.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A038', 'QM', '920000.00', 'ETL', '2026-05-28 11:00:00'),
(303.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A039', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(304.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A039', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(305.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A040', 'NC', '700000.00', 'ETL', '2026-05-28 11:00:00'),
(306.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A040', 'QM', '730000.00', 'ETL', '2026-05-28 11:00:00'),
(307.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A041', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(308.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A041', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(309.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A042', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(310.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A042', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(311.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A043', 'NC', '520000.00', 'ETL', '2026-05-28 11:00:00'),
(312.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A043', 'QM', '520000.00', 'ETL', '2026-05-28 11:00:00'),
(313.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A044', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(314.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A044', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(315.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A045', 'NC', '800000.00', 'ETL', '2026-05-28 11:00:00'),
(316.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A045', 'QM', '800000.00', 'ETL', '2026-05-28 11:00:00'),
(317.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A046', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(318.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A046', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(319.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A047', 'NC', '29052000.00', 'ETL', '2026-05-28 11:00:00'),
(320.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A047', 'QM', '31366910.78', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(321.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A048', 'NC', '4000000.00', 'ETL', '2026-05-28 11:00:00'),
(322.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A048', 'QM', '3900000.00', 'ETL', '2026-05-28 11:00:00'),
(323.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A049', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(324.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A049', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(325.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A050', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(326.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A050', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(327.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A051', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(328.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A051', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(329.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A052', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(330.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A052', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(331.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A053', 'NC', '200000.00', 'ETL', '2026-05-28 11:00:00'),
(332.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A053', 'QM', '200000.00', 'ETL', '2026-05-28 11:00:00'),
(333.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A054', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(334.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A054', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(335.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A055', 'NC', '4200000.00', 'ETL', '2026-05-28 11:00:00'),
(336.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A055', 'QM', '4100000.00', 'ETL', '2026-05-28 11:00:00'),
(337.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A056', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(338.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A056', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(339.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A057', 'NC', '33252000.00', 'ETL', '2026-05-28 11:00:00'),
(340.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A057', 'QM', '35466910.78', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(341.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A058', 'NC', '20000000.00', 'ETL', '2026-05-28 11:00:00'),
(342.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A058', 'QM', '20000000.00', 'ETL', '2026-05-28 11:00:00'),
(343.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A059', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(344.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A059', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(345.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A060', 'NC', '20000000.00', 'ETL', '2026-05-28 11:00:00'),
(346.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A060', 'QM', '20000000.00', 'ETL', '2026-05-28 11:00:00'),
(347.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A061', 'NC', '2000000.00', 'ETL', '2026-05-28 11:00:00'),
(348.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A061', 'QM', '2000000.00', 'ETL', '2026-05-28 11:00:00'),
(349.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A062', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(350.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A062', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(351.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A063', 'NC', '1733025.00', 'ETL', '2026-05-28 11:00:00'),
(352.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A063', 'QM', '2022011.46', 'ETL', '2026-05-28 11:00:00'),
(353.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A064', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(354.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A064', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00'),
(355.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A065', 'NC', '30520225.00', 'ETL', '2026-05-28 11:00:00'),
(356.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A065', 'QM', '35805214.36', 'ETL', '2026-05-28 11:00:00'),
(357.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A066', 'NC', '54253250.00', 'ETL', '2026-05-28 11:00:00'),
(358.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A066', 'QM', '59827225.82', 'ETL', '2026-05-28 11:00:00'),
(359.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A067', 'NC', '0.00', 'ETL', '2026-05-28 11:00:00'),
(360.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A067', 'QM', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(361.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A068', 'NC', '54253250.00', 'ETL', '2026-05-28 11:00:00'),
(362.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A068', 'QM', '59827225.82', 'ETL', '2026-05-28 11:00:00'),
(363.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A069', 'NC', '87505250.00', 'ETL', '2026-05-28 11:00:00'),
(364.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'BALANCE', 'A069', 'QM', '95294136.60', 'ETL', '2026-05-28 11:00:00'),
(365.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P001', 'BJ', '30629760.00', 'ETL', '2026-05-28 11:00:00'),
(366.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P001', 'SQ', '28000000.00', 'ETL', '2026-05-28 11:00:00'),
(367.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P002', 'BJ', '21670555.20', 'ETL', '2026-05-28 11:00:00'),
(368.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P002', 'SQ', '19600000.00', 'ETL', '2026-05-28 11:00:00'),
(369.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P003', 'BJ', '336927.36', 'ETL', '2026-05-28 11:00:00'),
(370.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P003', 'SQ', '308000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(371.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P004', 'BJ', '2173500.00', 'ETL', '2026-05-28 11:00:00'),
(372.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P004', 'SQ', '2100000.00', 'ETL', '2026-05-28 11:00:00'),
(373.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P005', 'BJ', '1839600.00', 'ETL', '2026-05-28 11:00:00'),
(374.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P005', 'SQ', '1800000.00', 'ETL', '2026-05-28 11:00:00'),
(375.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P006', 'BJ', '900000.00', 'ETL', '2026-05-28 11:00:00'),
(376.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P006', 'SQ', '900000.00', 'ETL', '2026-05-28 11:00:00'),
(377.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P007', 'BJ', '191000.00', 'ETL', '2026-05-28 11:00:00'),
(378.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P007', 'SQ', '185000.00', 'ETL', '2026-05-28 11:00:00'),
(379.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P008', 'BJ', '150000.00', 'ETL', '2026-05-28 11:00:00'),
(380.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P008', 'SQ', '150000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(381.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P009', 'BJ', '42000.00', 'ETL', '2026-05-28 11:00:00'),
(382.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P009', 'SQ', '42000.00', 'ETL', '2026-05-28 11:00:00'),
(383.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P010', 'BJ', '122519.04', 'ETL', '2026-05-28 11:00:00'),
(384.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P010', 'SQ', '112000.00', 'ETL', '2026-05-28 11:00:00'),
(385.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P011', 'BJ', '125582.02', 'ETL', '2026-05-28 11:00:00'),
(386.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P011', 'SQ', '98000.00', 'ETL', '2026-05-28 11:00:00'),
(387.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P012', 'BJ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(388.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P012', 'SQ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(389.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P013', 'BJ', '120000.00', 'ETL', '2026-05-28 11:00:00'),
(390.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P013', 'SQ', '120000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(391.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P014', 'BJ', '60000.00', 'ETL', '2026-05-28 11:00:00'),
(392.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P014', 'SQ', '60000.00', 'ETL', '2026-05-28 11:00:00'),
(393.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P015', 'BJ', '80000.00', 'ETL', '2026-05-28 11:00:00'),
(394.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P015', 'SQ', '80000.00', 'ETL', '2026-05-28 11:00:00'),
(395.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P016', 'BJ', '3470076.38', 'ETL', '2026-05-28 11:00:00'),
(396.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P016', 'SQ', '3097000.00', 'ETL', '2026-05-28 11:00:00'),
(397.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P017', 'BJ', '30000.00', 'ETL', '2026-05-28 11:00:00'),
(398.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P017', 'SQ', '30000.00', 'ETL', '2026-05-28 11:00:00'),
(399.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P018', 'BJ', '20000.00', 'ETL', '2026-05-28 11:00:00'),
(400.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P018', 'SQ', '20000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(401.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P019', 'BJ', '3480076.38', 'ETL', '2026-05-28 11:00:00'),
(402.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P019', 'SQ', '3107000.00', 'ETL', '2026-05-28 11:00:00'),
(403.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P020', 'BJ', '870019.10', 'ETL', '2026-05-28 11:00:00'),
(404.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P020', 'SQ', '776750.00', 'ETL', '2026-05-28 11:00:00'),
(405.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P021', 'BJ', '2610057.29', 'ETL', '2026-05-28 11:00:00'),
(406.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P021', 'SQ', '2330250.00', 'ETL', '2026-05-28 11:00:00'),
(407.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P022', 'BJ', '2610057.29', 'ETL', '2026-05-28 11:00:00'),
(408.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P022', 'SQ', '2330250.00', 'ETL', '2026-05-28 11:00:00'),
(409.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P023', 'BJ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(410.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P023', 'SQ', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(411.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P024', 'BJ', '2610057.29', 'ETL', '2026-05-28 11:00:00'),
(412.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'PROFIT', 'P024', 'SQ', '2330250.00', 'ETL', '2026-05-28 11:00:00'),
(413.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C001', 'BJ', '30997317.12', 'ETL', '2026-05-28 11:00:00'),
(414.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C001', 'SQ', '28560000.00', 'ETL', '2026-05-28 11:00:00'),
(415.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C002', 'BJ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(416.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C002', 'SQ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(417.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C003', 'BJ', '200000.00', 'ETL', '2026-05-28 11:00:00'),
(418.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C003', 'SQ', '200000.00', 'ETL', '2026-05-28 11:00:00'),
(419.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C004', 'BJ', '31197317.12', 'ETL', '2026-05-28 11:00:00'),
(420.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C004', 'SQ', '28760000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(421.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C005', 'BJ', '21757237.42', 'ETL', '2026-05-28 11:00:00'),
(422.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C005', 'SQ', '19600000.00', 'ETL', '2026-05-28 11:00:00'),
(423.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C006', 'BJ', '2652000.00', 'ETL', '2026-05-28 11:00:00'),
(424.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C006', 'SQ', '2600000.00', 'ETL', '2026-05-28 11:00:00'),
(425.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C007', 'BJ', '2125839.26', 'ETL', '2026-05-28 11:00:00'),
(426.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C007', 'SQ', '1924750.00', 'ETL', '2026-05-28 11:00:00'),
(427.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C008', 'BJ', '1200000.00', 'ETL', '2026-05-28 11:00:00'),
(428.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C008', 'SQ', '1200000.00', 'ETL', '2026-05-28 11:00:00'),
(429.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C009', 'BJ', '27735076.68', 'ETL', '2026-05-28 11:00:00'),
(430.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C009', 'SQ', '25324750.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(431.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C010', 'BJ', '3462240.44', 'ETL', '2026-05-28 11:00:00'),
(432.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C010', 'SQ', '3435250.00', 'ETL', '2026-05-28 11:00:00'),
(433.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C011', 'BJ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(434.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C011', 'SQ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(435.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C012', 'BJ', '1660000.00', 'ETL', '2026-05-28 11:00:00'),
(436.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C012', 'SQ', '1600000.00', 'ETL', '2026-05-28 11:00:00'),
(437.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C013', 'BJ', '-1660000.00', 'ETL', '2026-05-28 11:00:00'),
(438.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C013', 'SQ', '-1600000.00', 'ETL', '2026-05-28 11:00:00'),
(439.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C014', 'BJ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(440.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C014', 'SQ', '0.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(441.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C015', 'BJ', '530000.00', 'ETL', '2026-05-28 11:00:00'),
(442.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C015', 'SQ', '500000.00', 'ETL', '2026-05-28 11:00:00'),
(443.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C016', 'BJ', '-530000.00', 'ETL', '2026-05-28 11:00:00'),
(444.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C016', 'SQ', '-500000.00', 'ETL', '2026-05-28 11:00:00'),
(445.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C017', 'BJ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(446.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C017', 'SQ', '0.00', 'ETL', '2026-05-28 11:00:00'),
(447.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C018', 'BJ', '1272240.44', 'ETL', '2026-05-28 11:00:00'),
(448.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C018', 'SQ', '1335250.00', 'ETL', '2026-05-28 11:00:00'),
(449.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C019', 'BJ', '9335250.00', 'ETL', '2026-05-28 11:00:00'),
(450.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C019', 'SQ', '8000000.00', 'ETL', '2026-05-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(451.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C020', 'BJ', '10607490.44', 'ETL', '2026-05-28 11:00:00'),
(452.00, 'ETL-DEMO', 1.00, '2026', '05', '2026-05', 'CASHFLOW', 'C020', 'SQ', '9335250.00', 'ETL', '2026-05-28 11:00:00'),
(453.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A001', 'NC', '9335250.00', 'ETL', '2026-06-28 11:00:00'),
(454.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A001', 'QM', '11223682.83', 'ETL', '2026-06-28 11:00:00'),
(455.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A002', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(456.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A002', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(457.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A003', 'NC', '800000.00', 'ETL', '2026-06-28 11:00:00'),
(458.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A003', 'QM', '800000.00', 'ETL', '2026-06-28 11:00:00'),
(459.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A004', 'NC', '32200000.00', 'ETL', '2026-06-28 11:00:00'),
(460.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A004', 'QM', '37680921.60', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(461.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A005', 'NC', '1200000.00', 'ETL', '2026-06-28 11:00:00'),
(462.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A005', 'QM', '1200000.00', 'ETL', '2026-06-28 11:00:00'),
(463.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A006', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(464.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A006', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(465.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A007', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(466.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A007', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(467.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A008', 'NC', '620000.00', 'ETL', '2026-06-28 11:00:00'),
(468.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A008', 'QM', '620000.00', 'ETL', '2026-06-28 11:00:00'),
(469.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A009', 'NC', '20580000.00', 'ETL', '2026-06-28 11:00:00'),
(470.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A009', 'QM', '22813670.88', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(471.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A010', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(472.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A010', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(473.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A011', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(474.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A011', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(475.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A012', 'NC', '150000.00', 'ETL', '2026-06-28 11:00:00'),
(476.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A012', 'QM', '150000.00', 'ETL', '2026-06-28 11:00:00'),
(477.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A013', 'NC', '64885250.00', 'ETL', '2026-06-28 11:00:00'),
(478.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A013', 'QM', '74488275.31', 'ETL', '2026-06-28 11:00:00'),
(479.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A014', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(480.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A014', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(481.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A015', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(482.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A015', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(483.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A016', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(484.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A016', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(485.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A017', 'NC', '1500000.00', 'ETL', '2026-06-28 11:00:00'),
(486.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A017', 'QM', '1500000.00', 'ETL', '2026-06-28 11:00:00'),
(487.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A018', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(488.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A018', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(489.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A019', 'NC', '15500000.00', 'ETL', '2026-06-28 11:00:00'),
(490.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A019', 'QM', '15300000.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(491.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A020', 'NC', '2200000.00', 'ETL', '2026-06-28 11:00:00'),
(492.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A020', 'QM', '2400000.00', 'ETL', '2026-06-28 11:00:00'),
(493.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A021', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(494.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A021', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(495.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A022', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(496.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A022', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(497.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A023', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(498.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A023', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(499.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A024', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(500.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A024', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(501.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A025', 'NC', '3000000.00', 'ETL', '2026-06-28 11:00:00'),
(502.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A025', 'QM', '2900000.00', 'ETL', '2026-06-28 11:00:00'),
(503.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A026', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(504.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A026', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(505.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A027', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(506.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A027', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(507.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A028', 'NC', '420000.00', 'ETL', '2026-06-28 11:00:00'),
(508.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A028', 'QM', '400000.00', 'ETL', '2026-06-28 11:00:00'),
(509.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A029', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(510.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A029', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(511.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A030', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(512.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A030', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(513.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A031', 'NC', '22620000.00', 'ETL', '2026-06-28 11:00:00'),
(514.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A031', 'QM', '22500000.00', 'ETL', '2026-06-28 11:00:00'),
(515.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A032', 'NC', '87505250.00', 'ETL', '2026-06-28 11:00:00'),
(516.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A032', 'QM', '96988275.31', 'ETL', '2026-06-28 11:00:00'),
(517.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A033', 'NC', '5000000.00', 'ETL', '2026-06-28 11:00:00'),
(518.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A033', 'QM', '5600000.00', 'ETL', '2026-06-28 11:00:00'),
(519.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A034', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(520.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A034', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(521.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A035', 'NC', '600000.00', 'ETL', '2026-06-28 11:00:00'),
(522.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A035', 'QM', '600000.00', 'ETL', '2026-06-28 11:00:00'),
(523.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A036', 'NC', '18032000.00', 'ETL', '2026-06-28 11:00:00'),
(524.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A036', 'QM', '19989121.15', 'ETL', '2026-06-28 11:00:00'),
(525.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A037', 'NC', '2500000.00', 'ETL', '2026-06-28 11:00:00'),
(526.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A037', 'QM', '2620000.00', 'ETL', '2026-06-28 11:00:00'),
(527.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A038', 'NC', '900000.00', 'ETL', '2026-06-28 11:00:00'),
(528.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A038', 'QM', '940000.00', 'ETL', '2026-06-28 11:00:00'),
(529.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A039', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(530.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A039', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(531.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A040', 'NC', '700000.00', 'ETL', '2026-06-28 11:00:00'),
(532.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A040', 'QM', '760000.00', 'ETL', '2026-06-28 11:00:00'),
(533.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A041', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(534.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A041', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(535.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A042', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(536.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A042', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(537.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A043', 'NC', '520000.00', 'ETL', '2026-06-28 11:00:00'),
(538.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A043', 'QM', '520000.00', 'ETL', '2026-06-28 11:00:00'),
(539.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A044', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(540.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A044', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(541.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A045', 'NC', '800000.00', 'ETL', '2026-06-28 11:00:00'),
(542.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A045', 'QM', '800000.00', 'ETL', '2026-06-28 11:00:00'),
(543.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A046', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(544.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A046', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(545.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A047', 'NC', '29052000.00', 'ETL', '2026-06-28 11:00:00'),
(546.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A047', 'QM', '31829121.15', 'ETL', '2026-06-28 11:00:00'),
(547.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A048', 'NC', '4000000.00', 'ETL', '2026-06-28 11:00:00'),
(548.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A048', 'QM', '3800000.00', 'ETL', '2026-06-28 11:00:00'),
(549.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A049', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(550.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A049', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(551.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A050', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(552.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A050', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(553.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A051', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(554.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A051', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(555.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A052', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(556.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A052', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(557.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A053', 'NC', '200000.00', 'ETL', '2026-06-28 11:00:00'),
(558.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A053', 'QM', '200000.00', 'ETL', '2026-06-28 11:00:00'),
(559.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A054', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(560.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A054', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(561.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A055', 'NC', '4200000.00', 'ETL', '2026-06-28 11:00:00'),
(562.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A055', 'QM', '4000000.00', 'ETL', '2026-06-28 11:00:00'),
(563.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A056', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(564.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A056', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(565.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A057', 'NC', '33252000.00', 'ETL', '2026-06-28 11:00:00'),
(566.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A057', 'QM', '35829121.15', 'ETL', '2026-06-28 11:00:00'),
(567.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A058', 'NC', '20000000.00', 'ETL', '2026-06-28 11:00:00'),
(568.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A058', 'QM', '20000000.00', 'ETL', '2026-06-28 11:00:00'),
(569.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A059', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(570.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A059', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(571.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A060', 'NC', '20000000.00', 'ETL', '2026-06-28 11:00:00'),
(572.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A060', 'QM', '20000000.00', 'ETL', '2026-06-28 11:00:00'),
(573.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A061', 'NC', '2000000.00', 'ETL', '2026-06-28 11:00:00'),
(574.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A061', 'QM', '2000000.00', 'ETL', '2026-06-28 11:00:00'),
(575.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A062', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(576.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A062', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(577.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A063', 'NC', '1733025.00', 'ETL', '2026-06-28 11:00:00'),
(578.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A063', 'QM', '2185956.14', 'ETL', '2026-06-28 11:00:00'),
(579.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A064', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(580.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A064', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(581.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A065', 'NC', '30520225.00', 'ETL', '2026-06-28 11:00:00'),
(582.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A065', 'QM', '36973198.02', 'ETL', '2026-06-28 11:00:00'),
(583.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A066', 'NC', '54253250.00', 'ETL', '2026-06-28 11:00:00'),
(584.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A066', 'QM', '61159154.16', 'ETL', '2026-06-28 11:00:00'),
(585.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A067', 'NC', '0.00', 'ETL', '2026-06-28 11:00:00'),
(586.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A067', 'QM', '0.00', 'ETL', '2026-06-28 11:00:00'),
(587.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A068', 'NC', '54253250.00', 'ETL', '2026-06-28 11:00:00'),
(588.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A068', 'QM', '61159154.16', 'ETL', '2026-06-28 11:00:00'),
(589.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A069', 'NC', '87505250.00', 'ETL', '2026-06-28 11:00:00'),
(590.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'BALANCE', 'A069', 'QM', '96988275.31', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(591.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P001', 'BJ', '30387840.00', 'ETL', '2026-06-28 11:00:00'),
(592.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P001', 'SQ', '30629760.00', 'ETL', '2026-06-28 11:00:00'),
(593.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P002', 'BJ', '21727305.60', 'ETL', '2026-06-28 11:00:00'),
(594.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P002', 'SQ', '21670555.20', 'ETL', '2026-06-28 11:00:00'),
(595.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P003', 'BJ', '334266.24', 'ETL', '2026-06-28 11:00:00'),
(596.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P003', 'SQ', '336927.36', 'ETL', '2026-06-28 11:00:00'),
(597.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P004', 'BJ', '2247000.00', 'ETL', '2026-06-28 11:00:00'),
(598.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P004', 'SQ', '2173500.00', 'ETL', '2026-06-28 11:00:00'),
(599.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P005', 'BJ', '1879200.00', 'ETL', '2026-06-28 11:00:00'),
(600.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P005', 'SQ', '1839600.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(601.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P006', 'BJ', '900000.00', 'ETL', '2026-06-28 11:00:00'),
(602.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P006', 'SQ', '900000.00', 'ETL', '2026-06-28 11:00:00'),
(603.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P007', 'BJ', '197000.00', 'ETL', '2026-06-28 11:00:00'),
(604.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P007', 'SQ', '191000.00', 'ETL', '2026-06-28 11:00:00'),
(605.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P008', 'BJ', '150000.00', 'ETL', '2026-06-28 11:00:00'),
(606.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P008', 'SQ', '150000.00', 'ETL', '2026-06-28 11:00:00'),
(607.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P009', 'BJ', '42000.00', 'ETL', '2026-06-28 11:00:00'),
(608.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P009', 'SQ', '42000.00', 'ETL', '2026-06-28 11:00:00'),
(609.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P010', 'BJ', '121551.36', 'ETL', '2026-06-28 11:00:00'),
(610.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P010', 'SQ', '122519.04', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(611.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P011', 'BJ', '142822.85', 'ETL', '2026-06-28 11:00:00'),
(612.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P011', 'SQ', '125582.02', 'ETL', '2026-06-28 11:00:00'),
(613.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P012', 'BJ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(614.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P012', 'SQ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(615.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P013', 'BJ', '120000.00', 'ETL', '2026-06-28 11:00:00'),
(616.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P013', 'SQ', '120000.00', 'ETL', '2026-06-28 11:00:00'),
(617.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P014', 'BJ', '60000.00', 'ETL', '2026-06-28 11:00:00'),
(618.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P014', 'SQ', '60000.00', 'ETL', '2026-06-28 11:00:00'),
(619.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P015', 'BJ', '80000.00', 'ETL', '2026-06-28 11:00:00'),
(620.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P015', 'SQ', '80000.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(621.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P016', 'BJ', '3038693.95', 'ETL', '2026-06-28 11:00:00'),
(622.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P016', 'SQ', '3470076.38', 'ETL', '2026-06-28 11:00:00'),
(623.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P017', 'BJ', '30000.00', 'ETL', '2026-06-28 11:00:00'),
(624.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P017', 'SQ', '30000.00', 'ETL', '2026-06-28 11:00:00'),
(625.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P018', 'BJ', '20000.00', 'ETL', '2026-06-28 11:00:00'),
(626.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P018', 'SQ', '20000.00', 'ETL', '2026-06-28 11:00:00'),
(627.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P019', 'BJ', '3048693.95', 'ETL', '2026-06-28 11:00:00'),
(628.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P019', 'SQ', '3480076.38', 'ETL', '2026-06-28 11:00:00'),
(629.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P020', 'BJ', '762173.49', 'ETL', '2026-06-28 11:00:00'),
(630.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P020', 'SQ', '870019.10', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(631.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P021', 'BJ', '2286520.46', 'ETL', '2026-06-28 11:00:00'),
(632.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P021', 'SQ', '2610057.29', 'ETL', '2026-06-28 11:00:00'),
(633.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P022', 'BJ', '2286520.46', 'ETL', '2026-06-28 11:00:00'),
(634.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P022', 'SQ', '2610057.29', 'ETL', '2026-06-28 11:00:00'),
(635.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P023', 'BJ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(636.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P023', 'SQ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(637.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P024', 'BJ', '2286520.46', 'ETL', '2026-06-28 11:00:00'),
(638.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'PROFIT', 'P024', 'SQ', '2610057.29', 'ETL', '2026-06-28 11:00:00'),
(639.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C001', 'BJ', '30509391.36', 'ETL', '2026-06-28 11:00:00'),
(640.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C001', 'SQ', '30997317.12', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(641.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C002', 'BJ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(642.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C002', 'SQ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(643.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C003', 'BJ', '200000.00', 'ETL', '2026-06-28 11:00:00'),
(644.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C003', 'SQ', '200000.00', 'ETL', '2026-06-28 11:00:00'),
(645.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C004', 'BJ', '30709391.36', 'ETL', '2026-06-28 11:00:00'),
(646.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C004', 'SQ', '31197317.12', 'ETL', '2026-06-28 11:00:00'),
(647.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C005', 'BJ', '21901124.04', 'ETL', '2026-06-28 11:00:00'),
(648.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C005', 'SQ', '21757237.42', 'ETL', '2026-06-28 11:00:00'),
(649.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C006', 'BJ', '2704000.00', 'ETL', '2026-06-28 11:00:00'),
(650.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C006', 'SQ', '2652000.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(651.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C007', 'BJ', '2008074.93', 'ETL', '2026-06-28 11:00:00'),
(652.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C007', 'SQ', '2125839.26', 'ETL', '2026-06-28 11:00:00'),
(653.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C008', 'BJ', '1200000.00', 'ETL', '2026-06-28 11:00:00'),
(654.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C008', 'SQ', '1200000.00', 'ETL', '2026-06-28 11:00:00'),
(655.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C009', 'BJ', '27813198.97', 'ETL', '2026-06-28 11:00:00'),
(656.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C009', 'SQ', '27735076.68', 'ETL', '2026-06-28 11:00:00'),
(657.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C010', 'BJ', '2896192.39', 'ETL', '2026-06-28 11:00:00'),
(658.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C010', 'SQ', '3462240.44', 'ETL', '2026-06-28 11:00:00'),
(659.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C011', 'BJ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(660.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C011', 'SQ', '0.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(661.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C012', 'BJ', '1720000.00', 'ETL', '2026-06-28 11:00:00'),
(662.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C012', 'SQ', '1660000.00', 'ETL', '2026-06-28 11:00:00'),
(663.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C013', 'BJ', '-1720000.00', 'ETL', '2026-06-28 11:00:00'),
(664.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C013', 'SQ', '-1660000.00', 'ETL', '2026-06-28 11:00:00'),
(665.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C014', 'BJ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(666.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C014', 'SQ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(667.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C015', 'BJ', '560000.00', 'ETL', '2026-06-28 11:00:00'),
(668.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C015', 'SQ', '530000.00', 'ETL', '2026-06-28 11:00:00'),
(669.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C016', 'BJ', '-560000.00', 'ETL', '2026-06-28 11:00:00'),
(670.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C016', 'SQ', '-530000.00', 'ETL', '2026-06-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(671.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C017', 'BJ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(672.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C017', 'SQ', '0.00', 'ETL', '2026-06-28 11:00:00'),
(673.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C018', 'BJ', '616192.39', 'ETL', '2026-06-28 11:00:00'),
(674.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C018', 'SQ', '1272240.44', 'ETL', '2026-06-28 11:00:00'),
(675.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C019', 'BJ', '10607490.44', 'ETL', '2026-06-28 11:00:00'),
(676.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C019', 'SQ', '9335250.00', 'ETL', '2026-06-28 11:00:00'),
(677.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C020', 'BJ', '11223682.83', 'ETL', '2026-06-28 11:00:00'),
(678.00, 'ETL-DEMO', 1.00, '2026', '06', '2026-06', 'CASHFLOW', 'C020', 'SQ', '10607490.44', 'ETL', '2026-06-28 11:00:00'),
(679.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A001', 'NC', '9335250.00', 'ETL', '2026-07-28 11:00:00'),
(680.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A001', 'QM', '11668067.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(681.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A002', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(682.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A002', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(683.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A003', 'NC', '800000.00', 'ETL', '2026-07-28 11:00:00'),
(684.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A003', 'QM', '800000.00', 'ETL', '2026-07-28 11:00:00'),
(685.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A004', 'NC', '32200000.00', 'ETL', '2026-07-28 11:00:00'),
(686.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A004', 'QM', '42588806.40', 'ETL', '2026-07-28 11:00:00'),
(687.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A005', 'NC', '1200000.00', 'ETL', '2026-07-28 11:00:00'),
(688.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A005', 'QM', '1200000.00', 'ETL', '2026-07-28 11:00:00'),
(689.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A006', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(690.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A006', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(691.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A007', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(692.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A007', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(693.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A008', 'NC', '620000.00', 'ETL', '2026-07-28 11:00:00'),
(694.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A008', 'QM', '620000.00', 'ETL', '2026-07-28 11:00:00'),
(695.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A009', 'NC', '20580000.00', 'ETL', '2026-07-28 11:00:00'),
(696.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A009', 'QM', '25143138.72', 'ETL', '2026-07-28 11:00:00'),
(697.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A010', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(698.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A010', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(699.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A011', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(700.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A011', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(701.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A012', 'NC', '150000.00', 'ETL', '2026-07-28 11:00:00'),
(702.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A012', 'QM', '150000.00', 'ETL', '2026-07-28 11:00:00'),
(703.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A013', 'NC', '64885250.00', 'ETL', '2026-07-28 11:00:00'),
(704.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A013', 'QM', '82170012.12', 'ETL', '2026-07-28 11:00:00'),
(705.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A014', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(706.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A014', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(707.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A015', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(708.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A015', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(709.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A016', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(710.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A016', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(711.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A017', 'NC', '1500000.00', 'ETL', '2026-07-28 11:00:00'),
(712.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A017', 'QM', '1500000.00', 'ETL', '2026-07-28 11:00:00'),
(713.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A018', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(714.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A018', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(715.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A019', 'NC', '15500000.00', 'ETL', '2026-07-28 11:00:00'),
(716.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A019', 'QM', '15200000.00', 'ETL', '2026-07-28 11:00:00'),
(717.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A020', 'NC', '2200000.00', 'ETL', '2026-07-28 11:00:00'),
(718.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A020', 'QM', '2500000.00', 'ETL', '2026-07-28 11:00:00'),
(719.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A021', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(720.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A021', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(721.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A022', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(722.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A022', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(723.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A023', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(724.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A023', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(725.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A024', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(726.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A024', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(727.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A025', 'NC', '3000000.00', 'ETL', '2026-07-28 11:00:00'),
(728.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A025', 'QM', '2850000.00', 'ETL', '2026-07-28 11:00:00'),
(729.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A026', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(730.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A026', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(731.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A027', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(732.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A027', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(733.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A028', 'NC', '420000.00', 'ETL', '2026-07-28 11:00:00'),
(734.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A028', 'QM', '390000.00', 'ETL', '2026-07-28 11:00:00'),
(735.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A029', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(736.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A029', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(737.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A030', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(738.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A030', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(739.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A031', 'NC', '22620000.00', 'ETL', '2026-07-28 11:00:00'),
(740.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A031', 'QM', '22440000.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(741.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A032', 'NC', '87505250.00', 'ETL', '2026-07-28 11:00:00'),
(742.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A032', 'QM', '104610012.12', 'ETL', '2026-07-28 11:00:00'),
(743.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A033', 'NC', '5000000.00', 'ETL', '2026-07-28 11:00:00'),
(744.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A033', 'QM', '5900000.00', 'ETL', '2026-07-28 11:00:00'),
(745.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A034', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(746.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A034', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(747.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A035', 'NC', '600000.00', 'ETL', '2026-07-28 11:00:00'),
(748.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A035', 'QM', '600000.00', 'ETL', '2026-07-28 11:00:00'),
(749.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A036', 'NC', '18032000.00', 'ETL', '2026-07-28 11:00:00'),
(750.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A036', 'QM', '22030178.69', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(751.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A037', 'NC', '2500000.00', 'ETL', '2026-07-28 11:00:00'),
(752.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A037', 'QM', '2680000.00', 'ETL', '2026-07-28 11:00:00'),
(753.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A038', 'NC', '900000.00', 'ETL', '2026-07-28 11:00:00'),
(754.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A038', 'QM', '960000.00', 'ETL', '2026-07-28 11:00:00'),
(755.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A039', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(756.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A039', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(757.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A040', 'NC', '700000.00', 'ETL', '2026-07-28 11:00:00'),
(758.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A040', 'QM', '790000.00', 'ETL', '2026-07-28 11:00:00'),
(759.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A041', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(760.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A041', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(761.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A042', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(762.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A042', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(763.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A043', 'NC', '520000.00', 'ETL', '2026-07-28 11:00:00'),
(764.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A043', 'QM', '520000.00', 'ETL', '2026-07-28 11:00:00'),
(765.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A044', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(766.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A044', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(767.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A045', 'NC', '800000.00', 'ETL', '2026-07-28 11:00:00'),
(768.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A045', 'QM', '800000.00', 'ETL', '2026-07-28 11:00:00'),
(769.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A046', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(770.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A046', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(771.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A047', 'NC', '29052000.00', 'ETL', '2026-07-28 11:00:00'),
(772.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A047', 'QM', '34280178.69', 'ETL', '2026-07-28 11:00:00'),
(773.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A048', 'NC', '4000000.00', 'ETL', '2026-07-28 11:00:00'),
(774.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A048', 'QM', '3700000.00', 'ETL', '2026-07-28 11:00:00'),
(775.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A049', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(776.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A049', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(777.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A050', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(778.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A050', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(779.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A051', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(780.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A051', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(781.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A052', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(782.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A052', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(783.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A053', 'NC', '200000.00', 'ETL', '2026-07-28 11:00:00'),
(784.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A053', 'QM', '200000.00', 'ETL', '2026-07-28 11:00:00'),
(785.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A054', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(786.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A054', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(787.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A055', 'NC', '4200000.00', 'ETL', '2026-07-28 11:00:00'),
(788.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A055', 'QM', '3900000.00', 'ETL', '2026-07-28 11:00:00'),
(789.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A056', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(790.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A056', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(791.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A057', 'NC', '33252000.00', 'ETL', '2026-07-28 11:00:00'),
(792.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A057', 'QM', '38180178.69', 'ETL', '2026-07-28 11:00:00'),
(793.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A058', 'NC', '20000000.00', 'ETL', '2026-07-28 11:00:00'),
(794.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A058', 'QM', '20000000.00', 'ETL', '2026-07-28 11:00:00'),
(795.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A059', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(796.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A059', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(797.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A060', 'NC', '20000000.00', 'ETL', '2026-07-28 11:00:00'),
(798.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A060', 'QM', '20000000.00', 'ETL', '2026-07-28 11:00:00'),
(799.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A061', 'NC', '2000000.00', 'ETL', '2026-07-28 11:00:00'),
(800.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A061', 'QM', '2000000.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(801.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A062', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(802.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A062', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(803.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A063', 'NC', '1733025.00', 'ETL', '2026-07-28 11:00:00'),
(804.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A063', 'QM', '2517626.97', 'ETL', '2026-07-28 11:00:00'),
(805.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A064', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(806.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A064', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(807.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A065', 'NC', '30520225.00', 'ETL', '2026-07-28 11:00:00'),
(808.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A065', 'QM', '41912206.47', 'ETL', '2026-07-28 11:00:00'),
(809.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A066', 'NC', '54253250.00', 'ETL', '2026-07-28 11:00:00'),
(810.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A066', 'QM', '66429833.43', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(811.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A067', 'NC', '0.00', 'ETL', '2026-07-28 11:00:00'),
(812.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A067', 'QM', '0.00', 'ETL', '2026-07-28 11:00:00'),
(813.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A068', 'NC', '54253250.00', 'ETL', '2026-07-28 11:00:00'),
(814.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A068', 'QM', '66429833.43', 'ETL', '2026-07-28 11:00:00'),
(815.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A069', 'NC', '87505250.00', 'ETL', '2026-07-28 11:00:00'),
(816.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'BALANCE', 'A069', 'QM', '104610012.12', 'ETL', '2026-07-28 11:00:00'),
(817.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P001', 'BJ', '33143040.00', 'ETL', '2026-07-28 11:00:00'),
(818.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P001', 'SQ', '30387840.00', 'ETL', '2026-07-28 11:00:00'),
(819.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P002', 'BJ', '23945846.40', 'ETL', '2026-07-28 11:00:00'),
(820.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P002', 'SQ', '21727305.60', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(821.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P003', 'BJ', '364573.44', 'ETL', '2026-07-28 11:00:00'),
(822.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P003', 'SQ', '334266.24', 'ETL', '2026-07-28 11:00:00'),
(823.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P004', 'BJ', '2320500.00', 'ETL', '2026-07-28 11:00:00'),
(824.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P004', 'SQ', '2247000.00', 'ETL', '2026-07-28 11:00:00'),
(825.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P005', 'BJ', '1918800.00', 'ETL', '2026-07-28 11:00:00'),
(826.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P005', 'SQ', '1879200.00', 'ETL', '2026-07-28 11:00:00'),
(827.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P006', 'BJ', '900000.00', 'ETL', '2026-07-28 11:00:00'),
(828.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P006', 'SQ', '900000.00', 'ETL', '2026-07-28 11:00:00'),
(829.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P007', 'BJ', '203000.00', 'ETL', '2026-07-28 11:00:00'),
(830.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P007', 'SQ', '197000.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(831.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P008', 'BJ', '150000.00', 'ETL', '2026-07-28 11:00:00'),
(832.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P008', 'SQ', '150000.00', 'ETL', '2026-07-28 11:00:00'),
(833.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P009', 'BJ', '42000.00', 'ETL', '2026-07-28 11:00:00'),
(834.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P009', 'SQ', '42000.00', 'ETL', '2026-07-28 11:00:00'),
(835.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P010', 'BJ', '132572.16', 'ETL', '2026-07-28 11:00:00'),
(836.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P010', 'SQ', '121551.36', 'ETL', '2026-07-28 11:00:00'),
(837.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P011', 'BJ', '175658.11', 'ETL', '2026-07-28 11:00:00'),
(838.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P011', 'SQ', '142822.85', 'ETL', '2026-07-28 11:00:00'),
(839.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P012', 'BJ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(840.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P012', 'SQ', '0.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(841.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P013', 'BJ', '120000.00', 'ETL', '2026-07-28 11:00:00'),
(842.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P013', 'SQ', '120000.00', 'ETL', '2026-07-28 11:00:00'),
(843.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P014', 'BJ', '60000.00', 'ETL', '2026-07-28 11:00:00'),
(844.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P014', 'SQ', '60000.00', 'ETL', '2026-07-28 11:00:00'),
(845.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P015', 'BJ', '80000.00', 'ETL', '2026-07-28 11:00:00'),
(846.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P015', 'SQ', '80000.00', 'ETL', '2026-07-28 11:00:00'),
(847.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P016', 'BJ', '3382089.89', 'ETL', '2026-07-28 11:00:00'),
(848.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P016', 'SQ', '3038693.95', 'ETL', '2026-07-28 11:00:00'),
(849.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P017', 'BJ', '30000.00', 'ETL', '2026-07-28 11:00:00'),
(850.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P017', 'SQ', '30000.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(851.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P018', 'BJ', '20000.00', 'ETL', '2026-07-28 11:00:00'),
(852.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P018', 'SQ', '20000.00', 'ETL', '2026-07-28 11:00:00'),
(853.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P019', 'BJ', '3392089.89', 'ETL', '2026-07-28 11:00:00'),
(854.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P019', 'SQ', '3048693.95', 'ETL', '2026-07-28 11:00:00'),
(855.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P020', 'BJ', '848022.47', 'ETL', '2026-07-28 11:00:00'),
(856.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P020', 'SQ', '762173.49', 'ETL', '2026-07-28 11:00:00'),
(857.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P021', 'BJ', '2544067.42', 'ETL', '2026-07-28 11:00:00'),
(858.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P021', 'SQ', '2286520.46', 'ETL', '2026-07-28 11:00:00'),
(859.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P022', 'BJ', '2544067.42', 'ETL', '2026-07-28 11:00:00'),
(860.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P022', 'SQ', '2286520.46', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(861.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P023', 'BJ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(862.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P023', 'SQ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(863.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P024', 'BJ', '2544067.42', 'ETL', '2026-07-28 11:00:00'),
(864.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'PROFIT', 'P024', 'SQ', '2286520.46', 'ETL', '2026-07-28 11:00:00'),
(865.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C001', 'BJ', '33010467.84', 'ETL', '2026-07-28 11:00:00'),
(866.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C001', 'SQ', '30509391.36', 'ETL', '2026-07-28 11:00:00'),
(867.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C002', 'BJ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(868.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C002', 'SQ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(869.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C003', 'BJ', '200000.00', 'ETL', '2026-07-28 11:00:00'),
(870.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C003', 'SQ', '200000.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(871.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C004', 'BJ', '33210467.84', 'ETL', '2026-07-28 11:00:00'),
(872.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C004', 'SQ', '30709391.36', 'ETL', '2026-07-28 11:00:00'),
(873.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C005', 'BJ', '24233196.56', 'ETL', '2026-07-28 11:00:00'),
(874.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C005', 'SQ', '21901124.04', 'ETL', '2026-07-28 11:00:00'),
(875.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C006', 'BJ', '2756000.00', 'ETL', '2026-07-28 11:00:00'),
(876.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C006', 'SQ', '2704000.00', 'ETL', '2026-07-28 11:00:00'),
(877.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C007', 'BJ', '2206887.11', 'ETL', '2026-07-28 11:00:00'),
(878.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C007', 'SQ', '2008074.93', 'ETL', '2026-07-28 11:00:00'),
(879.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C008', 'BJ', '1200000.00', 'ETL', '2026-07-28 11:00:00'),
(880.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C008', 'SQ', '1200000.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(881.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C009', 'BJ', '30396083.67', 'ETL', '2026-07-28 11:00:00'),
(882.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C009', 'SQ', '27813198.97', 'ETL', '2026-07-28 11:00:00'),
(883.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C010', 'BJ', '2814384.17', 'ETL', '2026-07-28 11:00:00'),
(884.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C010', 'SQ', '2896192.39', 'ETL', '2026-07-28 11:00:00'),
(885.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C011', 'BJ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(886.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C011', 'SQ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(887.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C012', 'BJ', '1780000.00', 'ETL', '2026-07-28 11:00:00'),
(888.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C012', 'SQ', '1720000.00', 'ETL', '2026-07-28 11:00:00'),
(889.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C013', 'BJ', '-1780000.00', 'ETL', '2026-07-28 11:00:00'),
(890.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C013', 'SQ', '-1720000.00', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(891.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C014', 'BJ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(892.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C014', 'SQ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(893.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C015', 'BJ', '590000.00', 'ETL', '2026-07-28 11:00:00'),
(894.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C015', 'SQ', '560000.00', 'ETL', '2026-07-28 11:00:00'),
(895.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C016', 'BJ', '-590000.00', 'ETL', '2026-07-28 11:00:00'),
(896.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C016', 'SQ', '-560000.00', 'ETL', '2026-07-28 11:00:00'),
(897.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C017', 'BJ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(898.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C017', 'SQ', '0.00', 'ETL', '2026-07-28 11:00:00'),
(899.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C018', 'BJ', '444384.17', 'ETL', '2026-07-28 11:00:00'),
(900.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C018', 'SQ', '616192.39', 'ETL', '2026-07-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(901.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C019', 'BJ', '11223682.83', 'ETL', '2026-07-28 11:00:00'),
(902.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C019', 'SQ', '10607490.44', 'ETL', '2026-07-28 11:00:00'),
(903.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C020', 'BJ', '11668067.00', 'ETL', '2026-07-28 11:00:00'),
(904.00, 'ETL-DEMO', 1.00, '2026', '07', '2026-07', 'CASHFLOW', 'C020', 'SQ', '11223682.83', 'ETL', '2026-07-28 11:00:00'),
(905.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A001', 'NC', '9335250.00', 'ETL', '2026-08-28 11:00:00'),
(906.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A001', 'QM', '11366388.28', 'ETL', '2026-08-28 11:00:00'),
(907.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A002', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(908.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A002', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(909.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A003', 'NC', '800000.00', 'ETL', '2026-08-28 11:00:00'),
(910.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A003', 'QM', '800000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(911.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A004', 'NC', '32200000.00', 'ETL', '2026-08-28 11:00:00'),
(912.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A004', 'QM', '43266921.60', 'ETL', '2026-08-28 11:00:00'),
(913.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A005', 'NC', '1200000.00', 'ETL', '2026-08-28 11:00:00'),
(914.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A005', 'QM', '1200000.00', 'ETL', '2026-08-28 11:00:00'),
(915.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A006', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(916.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A006', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(917.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A007', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(918.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A007', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(919.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A008', 'NC', '620000.00', 'ETL', '2026-08-28 11:00:00'),
(920.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A008', 'QM', '620000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(921.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A009', 'NC', '20580000.00', 'ETL', '2026-08-28 11:00:00'),
(922.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A009', 'QM', '24935410.08', 'ETL', '2026-08-28 11:00:00'),
(923.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A010', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(924.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A010', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(925.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A011', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(926.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A011', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(927.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A012', 'NC', '150000.00', 'ETL', '2026-08-28 11:00:00'),
(928.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A012', 'QM', '150000.00', 'ETL', '2026-08-28 11:00:00'),
(929.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A013', 'NC', '64885250.00', 'ETL', '2026-08-28 11:00:00'),
(930.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A013', 'QM', '82338719.96', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(931.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A014', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(932.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A014', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(933.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A015', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(934.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A015', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(935.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A016', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(936.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A016', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(937.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A017', 'NC', '1500000.00', 'ETL', '2026-08-28 11:00:00'),
(938.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A017', 'QM', '1500000.00', 'ETL', '2026-08-28 11:00:00'),
(939.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A018', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(940.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A018', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(941.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A019', 'NC', '15500000.00', 'ETL', '2026-08-28 11:00:00'),
(942.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A019', 'QM', '15100000.00', 'ETL', '2026-08-28 11:00:00'),
(943.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A020', 'NC', '2200000.00', 'ETL', '2026-08-28 11:00:00'),
(944.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A020', 'QM', '2600000.00', 'ETL', '2026-08-28 11:00:00'),
(945.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A021', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(946.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A021', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(947.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A022', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(948.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A022', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(949.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A023', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(950.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A023', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(951.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A024', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(952.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A024', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(953.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A025', 'NC', '3000000.00', 'ETL', '2026-08-28 11:00:00'),
(954.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A025', 'QM', '2800000.00', 'ETL', '2026-08-28 11:00:00'),
(955.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A026', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(956.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A026', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(957.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A027', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(958.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A027', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(959.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A028', 'NC', '420000.00', 'ETL', '2026-08-28 11:00:00'),
(960.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A028', 'QM', '380000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(961.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A029', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(962.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A029', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(963.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A030', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(964.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A030', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(965.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A031', 'NC', '22620000.00', 'ETL', '2026-08-28 11:00:00'),
(966.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A031', 'QM', '22380000.00', 'ETL', '2026-08-28 11:00:00'),
(967.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A032', 'NC', '87505250.00', 'ETL', '2026-08-28 11:00:00'),
(968.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A032', 'QM', '104718719.96', 'ETL', '2026-08-28 11:00:00'),
(969.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A033', 'NC', '5000000.00', 'ETL', '2026-08-28 11:00:00'),
(970.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A033', 'QM', '6200000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(971.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A034', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(972.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A034', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(973.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A035', 'NC', '600000.00', 'ETL', '2026-08-28 11:00:00'),
(974.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A035', 'QM', '600000.00', 'ETL', '2026-08-28 11:00:00'),
(975.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A036', 'NC', '18032000.00', 'ETL', '2026-08-28 11:00:00'),
(976.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A036', 'QM', '21848168.83', 'ETL', '2026-08-28 11:00:00'),
(977.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A037', 'NC', '2500000.00', 'ETL', '2026-08-28 11:00:00'),
(978.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A037', 'QM', '2740000.00', 'ETL', '2026-08-28 11:00:00'),
(979.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A038', 'NC', '900000.00', 'ETL', '2026-08-28 11:00:00'),
(980.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A038', 'QM', '980000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(981.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A039', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(982.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A039', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(983.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A040', 'NC', '700000.00', 'ETL', '2026-08-28 11:00:00'),
(984.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A040', 'QM', '820000.00', 'ETL', '2026-08-28 11:00:00'),
(985.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A041', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(986.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A041', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(987.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A042', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(988.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A042', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(989.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A043', 'NC', '520000.00', 'ETL', '2026-08-28 11:00:00'),
(990.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A043', 'QM', '520000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(991.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A044', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(992.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A044', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(993.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A045', 'NC', '800000.00', 'ETL', '2026-08-28 11:00:00'),
(994.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A045', 'QM', '800000.00', 'ETL', '2026-08-28 11:00:00'),
(995.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A046', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(996.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A046', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(997.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A047', 'NC', '29052000.00', 'ETL', '2026-08-28 11:00:00'),
(998.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A047', 'QM', '34508168.83', 'ETL', '2026-08-28 11:00:00'),
(999.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A048', 'NC', '4000000.00', 'ETL', '2026-08-28 11:00:00'),
(1000.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A048', 'QM', '3600000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1001.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A049', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1002.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A049', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1003.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A050', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1004.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A050', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1005.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A051', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1006.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A051', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1007.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A052', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1008.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A052', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1009.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A053', 'NC', '200000.00', 'ETL', '2026-08-28 11:00:00'),
(1010.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A053', 'QM', '200000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1011.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A054', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1012.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A054', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1013.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A055', 'NC', '4200000.00', 'ETL', '2026-08-28 11:00:00'),
(1014.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A055', 'QM', '3800000.00', 'ETL', '2026-08-28 11:00:00'),
(1015.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A056', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1016.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A056', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1017.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A057', 'NC', '33252000.00', 'ETL', '2026-08-28 11:00:00'),
(1018.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A057', 'QM', '38308168.83', 'ETL', '2026-08-28 11:00:00'),
(1019.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A058', 'NC', '20000000.00', 'ETL', '2026-08-28 11:00:00'),
(1020.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A058', 'QM', '20000000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1021.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A059', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1022.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A059', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1023.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A060', 'NC', '20000000.00', 'ETL', '2026-08-28 11:00:00'),
(1024.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A060', 'QM', '20000000.00', 'ETL', '2026-08-28 11:00:00'),
(1025.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A061', 'NC', '2000000.00', 'ETL', '2026-08-28 11:00:00'),
(1026.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A061', 'QM', '2000000.00', 'ETL', '2026-08-28 11:00:00'),
(1027.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A062', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1028.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A062', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1029.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A063', 'NC', '1733025.00', 'ETL', '2026-08-28 11:00:00'),
(1030.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A063', 'QM', '2569575.61', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1031.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A064', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1032.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A064', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1033.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A065', 'NC', '30520225.00', 'ETL', '2026-08-28 11:00:00'),
(1034.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A065', 'QM', '41840975.52', 'ETL', '2026-08-28 11:00:00'),
(1035.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A066', 'NC', '54253250.00', 'ETL', '2026-08-28 11:00:00'),
(1036.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A066', 'QM', '66410551.13', 'ETL', '2026-08-28 11:00:00'),
(1037.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A067', 'NC', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1038.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A067', 'QM', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1039.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A068', 'NC', '54253250.00', 'ETL', '2026-08-28 11:00:00'),
(1040.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A068', 'QM', '66410551.13', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1041.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A069', 'NC', '87505250.00', 'ETL', '2026-08-28 11:00:00'),
(1042.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'BALANCE', 'A069', 'QM', '104718719.96', 'ETL', '2026-08-28 11:00:00'),
(1043.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P001', 'BJ', '32531520.00', 'ETL', '2026-08-28 11:00:00'),
(1044.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P001', 'SQ', '33143040.00', 'ETL', '2026-08-28 11:00:00'),
(1045.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P002', 'BJ', '23748009.60', 'ETL', '2026-08-28 11:00:00'),
(1046.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P002', 'SQ', '23945846.40', 'ETL', '2026-08-28 11:00:00'),
(1047.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P003', 'BJ', '357846.72', 'ETL', '2026-08-28 11:00:00'),
(1048.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P003', 'SQ', '364573.44', 'ETL', '2026-08-28 11:00:00'),
(1049.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P004', 'BJ', '2394000.00', 'ETL', '2026-08-28 11:00:00'),
(1050.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P004', 'SQ', '2320500.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1051.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P005', 'BJ', '1958400.00', 'ETL', '2026-08-28 11:00:00'),
(1052.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P005', 'SQ', '1918800.00', 'ETL', '2026-08-28 11:00:00'),
(1053.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P006', 'BJ', '900000.00', 'ETL', '2026-08-28 11:00:00'),
(1054.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P006', 'SQ', '900000.00', 'ETL', '2026-08-28 11:00:00'),
(1055.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P007', 'BJ', '209000.00', 'ETL', '2026-08-28 11:00:00'),
(1056.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P007', 'SQ', '203000.00', 'ETL', '2026-08-28 11:00:00'),
(1057.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P008', 'BJ', '150000.00', 'ETL', '2026-08-28 11:00:00'),
(1058.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P008', 'SQ', '150000.00', 'ETL', '2026-08-28 11:00:00'),
(1059.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P009', 'BJ', '42000.00', 'ETL', '2026-08-28 11:00:00'),
(1060.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P009', 'SQ', '42000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1061.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P010', 'BJ', '130126.08', 'ETL', '2026-08-28 11:00:00'),
(1062.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P010', 'SQ', '132572.16', 'ETL', '2026-08-28 11:00:00'),
(1063.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P011', 'BJ', '191935.97', 'ETL', '2026-08-28 11:00:00'),
(1064.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P011', 'SQ', '175658.11', 'ETL', '2026-08-28 11:00:00'),
(1065.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P012', 'BJ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1066.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P012', 'SQ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1067.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P013', 'BJ', '120000.00', 'ETL', '2026-08-28 11:00:00'),
(1068.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P013', 'SQ', '120000.00', 'ETL', '2026-08-28 11:00:00'),
(1069.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P014', 'BJ', '60000.00', 'ETL', '2026-08-28 11:00:00'),
(1070.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P014', 'SQ', '60000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1071.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P015', 'BJ', '80000.00', 'ETL', '2026-08-28 11:00:00'),
(1072.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P015', 'SQ', '80000.00', 'ETL', '2026-08-28 11:00:00'),
(1073.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P016', 'BJ', '2842201.63', 'ETL', '2026-08-28 11:00:00'),
(1074.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P016', 'SQ', '3382089.89', 'ETL', '2026-08-28 11:00:00'),
(1075.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P017', 'BJ', '30000.00', 'ETL', '2026-08-28 11:00:00'),
(1076.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P017', 'SQ', '30000.00', 'ETL', '2026-08-28 11:00:00'),
(1077.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P018', 'BJ', '20000.00', 'ETL', '2026-08-28 11:00:00'),
(1078.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P018', 'SQ', '20000.00', 'ETL', '2026-08-28 11:00:00'),
(1079.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P019', 'BJ', '2852201.63', 'ETL', '2026-08-28 11:00:00'),
(1080.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P019', 'SQ', '3392089.89', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1081.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P020', 'BJ', '713050.41', 'ETL', '2026-08-28 11:00:00'),
(1082.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P020', 'SQ', '848022.47', 'ETL', '2026-08-28 11:00:00'),
(1083.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P021', 'BJ', '2139151.22', 'ETL', '2026-08-28 11:00:00'),
(1084.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P021', 'SQ', '2544067.42', 'ETL', '2026-08-28 11:00:00'),
(1085.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P022', 'BJ', '2139151.22', 'ETL', '2026-08-28 11:00:00'),
(1086.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P022', 'SQ', '2544067.42', 'ETL', '2026-08-28 11:00:00'),
(1087.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P023', 'BJ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1088.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P023', 'SQ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1089.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P024', 'BJ', '2139151.22', 'ETL', '2026-08-28 11:00:00'),
(1090.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'PROFIT', 'P024', 'SQ', '2544067.42', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1091.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C001', 'BJ', '32141141.76', 'ETL', '2026-08-28 11:00:00'),
(1092.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C001', 'SQ', '33010467.84', 'ETL', '2026-08-28 11:00:00'),
(1093.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C002', 'BJ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1094.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C002', 'SQ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1095.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C003', 'BJ', '200000.00', 'ETL', '2026-08-28 11:00:00'),
(1096.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C003', 'SQ', '200000.00', 'ETL', '2026-08-28 11:00:00'),
(1097.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C004', 'BJ', '32341141.76', 'ETL', '2026-08-28 11:00:00'),
(1098.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C004', 'SQ', '33210467.84', 'ETL', '2026-08-28 11:00:00'),
(1099.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C005', 'BJ', '24127977.75', 'ETL', '2026-08-28 11:00:00'),
(1100.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C005', 'SQ', '24233196.56', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1101.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C006', 'BJ', '2808000.00', 'ETL', '2026-08-28 11:00:00'),
(1102.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C006', 'SQ', '2756000.00', 'ETL', '2026-08-28 11:00:00'),
(1103.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C007', 'BJ', '2046842.73', 'ETL', '2026-08-28 11:00:00'),
(1104.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C007', 'SQ', '2206887.11', 'ETL', '2026-08-28 11:00:00'),
(1105.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C008', 'BJ', '1200000.00', 'ETL', '2026-08-28 11:00:00'),
(1106.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C008', 'SQ', '1200000.00', 'ETL', '2026-08-28 11:00:00'),
(1107.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C009', 'BJ', '30182820.48', 'ETL', '2026-08-28 11:00:00'),
(1108.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C009', 'SQ', '30396083.67', 'ETL', '2026-08-28 11:00:00'),
(1109.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C010', 'BJ', '2158321.28', 'ETL', '2026-08-28 11:00:00'),
(1110.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C010', 'SQ', '2814384.17', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1111.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C011', 'BJ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1112.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C011', 'SQ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1113.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C012', 'BJ', '1840000.00', 'ETL', '2026-08-28 11:00:00'),
(1114.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C012', 'SQ', '1780000.00', 'ETL', '2026-08-28 11:00:00'),
(1115.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C013', 'BJ', '-1840000.00', 'ETL', '2026-08-28 11:00:00'),
(1116.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C013', 'SQ', '-1780000.00', 'ETL', '2026-08-28 11:00:00'),
(1117.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C014', 'BJ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1118.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C014', 'SQ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1119.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C015', 'BJ', '620000.00', 'ETL', '2026-08-28 11:00:00'),
(1120.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C015', 'SQ', '590000.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1121.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C016', 'BJ', '-620000.00', 'ETL', '2026-08-28 11:00:00'),
(1122.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C016', 'SQ', '-590000.00', 'ETL', '2026-08-28 11:00:00'),
(1123.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C017', 'BJ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1124.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C017', 'SQ', '0.00', 'ETL', '2026-08-28 11:00:00'),
(1125.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C018', 'BJ', '-301678.72', 'ETL', '2026-08-28 11:00:00'),
(1126.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C018', 'SQ', '444384.17', 'ETL', '2026-08-28 11:00:00'),
(1127.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C019', 'BJ', '11668067.00', 'ETL', '2026-08-28 11:00:00'),
(1128.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C019', 'SQ', '11223682.83', 'ETL', '2026-08-28 11:00:00'),
(1129.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C020', 'BJ', '11366388.28', 'ETL', '2026-08-28 11:00:00'),
(1130.00, 'ETL-DEMO', 1.00, '2026', '08', '2026-08', 'CASHFLOW', 'C020', 'SQ', '11668067.00', 'ETL', '2026-08-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1131.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A001', 'NC', '9335250.00', 'ETL', '2026-09-28 11:00:00'),
(1132.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A001', 'QM', '10613169.28', 'ETL', '2026-09-28 11:00:00'),
(1133.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A002', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1134.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A002', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1135.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A003', 'NC', '800000.00', 'ETL', '2026-09-28 11:00:00'),
(1136.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A003', 'QM', '800000.00', 'ETL', '2026-09-28 11:00:00'),
(1137.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A004', 'NC', '32200000.00', 'ETL', '2026-09-28 11:00:00'),
(1138.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A004', 'QM', '46893000.00', 'ETL', '2026-09-28 11:00:00'),
(1139.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A005', 'NC', '1200000.00', 'ETL', '2026-09-28 11:00:00'),
(1140.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A005', 'QM', '1200000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1141.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A006', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1142.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A006', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1143.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A007', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1144.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A007', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1145.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A008', 'NC', '620000.00', 'ETL', '2026-09-28 11:00:00'),
(1146.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A008', 'QM', '620000.00', 'ETL', '2026-09-28 11:00:00'),
(1147.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A009', 'NC', '20580000.00', 'ETL', '2026-09-28 11:00:00'),
(1148.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A009', 'QM', '26409285.00', 'ETL', '2026-09-28 11:00:00'),
(1149.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A010', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1150.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A010', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1151.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A011', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1152.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A011', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1153.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A012', 'NC', '150000.00', 'ETL', '2026-09-28 11:00:00'),
(1154.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A012', 'QM', '150000.00', 'ETL', '2026-09-28 11:00:00'),
(1155.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A013', 'NC', '64885250.00', 'ETL', '2026-09-28 11:00:00'),
(1156.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A013', 'QM', '86685454.28', 'ETL', '2026-09-28 11:00:00'),
(1157.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A014', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1158.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A014', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1159.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A015', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1160.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A015', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1161.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A016', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1162.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A016', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1163.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A017', 'NC', '1500000.00', 'ETL', '2026-09-28 11:00:00'),
(1164.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A017', 'QM', '1500000.00', 'ETL', '2026-09-28 11:00:00'),
(1165.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A018', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1166.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A018', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1167.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A019', 'NC', '15500000.00', 'ETL', '2026-09-28 11:00:00'),
(1168.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A019', 'QM', '15000000.00', 'ETL', '2026-09-28 11:00:00'),
(1169.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A020', 'NC', '2200000.00', 'ETL', '2026-09-28 11:00:00'),
(1170.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A020', 'QM', '2700000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1171.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A021', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1172.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A021', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1173.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A022', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1174.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A022', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1175.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A023', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1176.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A023', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1177.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A024', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1178.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A024', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1179.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A025', 'NC', '3000000.00', 'ETL', '2026-09-28 11:00:00'),
(1180.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A025', 'QM', '2750000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1181.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A026', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1182.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A026', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1183.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A027', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1184.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A027', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1185.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A028', 'NC', '420000.00', 'ETL', '2026-09-28 11:00:00'),
(1186.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A028', 'QM', '370000.00', 'ETL', '2026-09-28 11:00:00'),
(1187.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A029', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1188.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A029', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1189.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A030', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1190.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A030', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1191.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A031', 'NC', '22620000.00', 'ETL', '2026-09-28 11:00:00'),
(1192.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A031', 'QM', '22320000.00', 'ETL', '2026-09-28 11:00:00'),
(1193.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A032', 'NC', '87505250.00', 'ETL', '2026-09-28 11:00:00'),
(1194.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A032', 'QM', '109005454.28', 'ETL', '2026-09-28 11:00:00'),
(1195.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A033', 'NC', '5000000.00', 'ETL', '2026-09-28 11:00:00'),
(1196.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A033', 'QM', '6500000.00', 'ETL', '2026-09-28 11:00:00'),
(1197.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A034', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1198.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A034', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1199.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A035', 'NC', '600000.00', 'ETL', '2026-09-28 11:00:00'),
(1200.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A035', 'QM', '600000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1201.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A036', 'NC', '18032000.00', 'ETL', '2026-09-28 11:00:00'),
(1202.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A036', 'QM', '23139564.00', 'ETL', '2026-09-28 11:00:00'),
(1203.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A037', 'NC', '2500000.00', 'ETL', '2026-09-28 11:00:00'),
(1204.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A037', 'QM', '2800000.00', 'ETL', '2026-09-28 11:00:00'),
(1205.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A038', 'NC', '900000.00', 'ETL', '2026-09-28 11:00:00'),
(1206.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A038', 'QM', '1000000.00', 'ETL', '2026-09-28 11:00:00'),
(1207.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A039', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1208.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A039', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1209.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A040', 'NC', '700000.00', 'ETL', '2026-09-28 11:00:00'),
(1210.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A040', 'QM', '850000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1211.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A041', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1212.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A041', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1213.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A042', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1214.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A042', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1215.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A043', 'NC', '520000.00', 'ETL', '2026-09-28 11:00:00'),
(1216.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A043', 'QM', '520000.00', 'ETL', '2026-09-28 11:00:00'),
(1217.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A044', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1218.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A044', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1219.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A045', 'NC', '800000.00', 'ETL', '2026-09-28 11:00:00'),
(1220.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A045', 'QM', '800000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1221.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A046', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1222.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A046', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1223.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A047', 'NC', '29052000.00', 'ETL', '2026-09-28 11:00:00'),
(1224.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A047', 'QM', '36209564.00', 'ETL', '2026-09-28 11:00:00'),
(1225.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A048', 'NC', '4000000.00', 'ETL', '2026-09-28 11:00:00'),
(1226.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A048', 'QM', '3500000.00', 'ETL', '2026-09-28 11:00:00'),
(1227.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A049', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1228.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A049', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1229.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A050', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1230.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A050', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1231.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A051', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1232.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A051', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1233.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A052', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1234.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A052', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1235.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A053', 'NC', '200000.00', 'ETL', '2026-09-28 11:00:00'),
(1236.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A053', 'QM', '200000.00', 'ETL', '2026-09-28 11:00:00'),
(1237.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A054', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1238.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A054', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1239.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A055', 'NC', '4200000.00', 'ETL', '2026-09-28 11:00:00'),
(1240.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A055', 'QM', '3700000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1241.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A056', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1242.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A056', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1243.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A057', 'NC', '33252000.00', 'ETL', '2026-09-28 11:00:00'),
(1244.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A057', 'QM', '39909564.00', 'ETL', '2026-09-28 11:00:00'),
(1245.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A058', 'NC', '20000000.00', 'ETL', '2026-09-28 11:00:00'),
(1246.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A058', 'QM', '20000000.00', 'ETL', '2026-09-28 11:00:00'),
(1247.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A059', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1248.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A059', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1249.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A060', 'NC', '20000000.00', 'ETL', '2026-09-28 11:00:00'),
(1250.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A060', 'QM', '20000000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1251.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A061', 'NC', '2000000.00', 'ETL', '2026-09-28 11:00:00'),
(1252.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A061', 'QM', '2000000.00', 'ETL', '2026-09-28 11:00:00'),
(1253.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A062', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1254.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A062', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1255.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A063', 'NC', '1733025.00', 'ETL', '2026-09-28 11:00:00'),
(1256.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A063', 'QM', '2781853.80', 'ETL', '2026-09-28 11:00:00'),
(1257.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A064', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1258.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A064', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1259.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A065', 'NC', '30520225.00', 'ETL', '2026-09-28 11:00:00'),
(1260.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A065', 'QM', '44314036.48', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1261.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A066', 'NC', '54253250.00', 'ETL', '2026-09-28 11:00:00'),
(1262.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A066', 'QM', '69095890.28', 'ETL', '2026-09-28 11:00:00'),
(1263.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A067', 'NC', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1264.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A067', 'QM', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1265.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A068', 'NC', '54253250.00', 'ETL', '2026-09-28 11:00:00'),
(1266.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A068', 'QM', '69095890.28', 'ETL', '2026-09-28 11:00:00'),
(1267.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A069', 'NC', '87505250.00', 'ETL', '2026-09-28 11:00:00'),
(1268.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'BALANCE', 'A069', 'QM', '109005454.28', 'ETL', '2026-09-28 11:00:00'),
(1269.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P001', 'BJ', '34104000.00', 'ETL', '2026-09-28 11:00:00'),
(1270.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P001', 'SQ', '32531520.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1271.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P002', 'BJ', '25151700.00', 'ETL', '2026-09-28 11:00:00'),
(1272.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P002', 'SQ', '23748009.60', 'ETL', '2026-09-28 11:00:00'),
(1273.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P003', 'BJ', '375144.00', 'ETL', '2026-09-28 11:00:00'),
(1274.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P003', 'SQ', '357846.72', 'ETL', '2026-09-28 11:00:00'),
(1275.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P004', 'BJ', '2467500.00', 'ETL', '2026-09-28 11:00:00'),
(1276.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P004', 'SQ', '2394000.00', 'ETL', '2026-09-28 11:00:00'),
(1277.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P005', 'BJ', '1998000.00', 'ETL', '2026-09-28 11:00:00'),
(1278.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P005', 'SQ', '1958400.00', 'ETL', '2026-09-28 11:00:00'),
(1279.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P006', 'BJ', '900000.00', 'ETL', '2026-09-28 11:00:00'),
(1280.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P006', 'SQ', '900000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1281.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P007', 'BJ', '215000.00', 'ETL', '2026-09-28 11:00:00'),
(1282.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P007', 'SQ', '209000.00', 'ETL', '2026-09-28 11:00:00'),
(1283.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P008', 'BJ', '150000.00', 'ETL', '2026-09-28 11:00:00'),
(1284.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P008', 'SQ', '150000.00', 'ETL', '2026-09-28 11:00:00'),
(1285.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P009', 'BJ', '42000.00', 'ETL', '2026-09-28 11:00:00'),
(1286.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P009', 'SQ', '42000.00', 'ETL', '2026-09-28 11:00:00'),
(1287.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P010', 'BJ', '136416.00', 'ETL', '2026-09-28 11:00:00'),
(1288.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P010', 'SQ', '130126.08', 'ETL', '2026-09-28 11:00:00'),
(1289.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P011', 'BJ', '221676.00', 'ETL', '2026-09-28 11:00:00'),
(1290.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P011', 'SQ', '191935.97', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1291.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P012', 'BJ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1292.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P012', 'SQ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1293.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P013', 'BJ', '120000.00', 'ETL', '2026-09-28 11:00:00'),
(1294.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P013', 'SQ', '120000.00', 'ETL', '2026-09-28 11:00:00'),
(1295.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P014', 'BJ', '60000.00', 'ETL', '2026-09-28 11:00:00'),
(1296.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P014', 'SQ', '60000.00', 'ETL', '2026-09-28 11:00:00'),
(1297.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P015', 'BJ', '80000.00', 'ETL', '2026-09-28 11:00:00'),
(1298.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P015', 'SQ', '80000.00', 'ETL', '2026-09-28 11:00:00'),
(1299.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P016', 'BJ', '2838564.00', 'ETL', '2026-09-28 11:00:00'),
(1300.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P016', 'SQ', '2842201.63', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1301.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P017', 'BJ', '30000.00', 'ETL', '2026-09-28 11:00:00'),
(1302.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P017', 'SQ', '30000.00', 'ETL', '2026-09-28 11:00:00'),
(1303.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P018', 'BJ', '20000.00', 'ETL', '2026-09-28 11:00:00'),
(1304.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P018', 'SQ', '20000.00', 'ETL', '2026-09-28 11:00:00'),
(1305.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P019', 'BJ', '2848564.00', 'ETL', '2026-09-28 11:00:00'),
(1306.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P019', 'SQ', '2852201.63', 'ETL', '2026-09-28 11:00:00'),
(1307.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P020', 'BJ', '712141.00', 'ETL', '2026-09-28 11:00:00'),
(1308.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P020', 'SQ', '713050.41', 'ETL', '2026-09-28 11:00:00'),
(1309.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P021', 'BJ', '2136423.00', 'ETL', '2026-09-28 11:00:00'),
(1310.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P021', 'SQ', '2139151.22', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1311.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P022', 'BJ', '2136423.00', 'ETL', '2026-09-28 11:00:00'),
(1312.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P022', 'SQ', '2139151.22', 'ETL', '2026-09-28 11:00:00'),
(1313.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P023', 'BJ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1314.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P023', 'SQ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1315.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P024', 'BJ', '2136423.00', 'ETL', '2026-09-28 11:00:00'),
(1316.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'PROFIT', 'P024', 'SQ', '2139151.22', 'ETL', '2026-09-28 11:00:00'),
(1317.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C001', 'BJ', '33421920.00', 'ETL', '2026-09-28 11:00:00'),
(1318.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C001', 'SQ', '32141141.76', 'ETL', '2026-09-28 11:00:00'),
(1319.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C002', 'BJ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1320.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C002', 'SQ', '0.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1321.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C003', 'BJ', '200000.00', 'ETL', '2026-09-28 11:00:00'),
(1322.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C003', 'SQ', '200000.00', 'ETL', '2026-09-28 11:00:00'),
(1323.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C004', 'BJ', '33621920.00', 'ETL', '2026-09-28 11:00:00'),
(1324.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C004', 'SQ', '32341141.76', 'ETL', '2026-09-28 11:00:00'),
(1325.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C005', 'BJ', '25654734.00', 'ETL', '2026-09-28 11:00:00'),
(1326.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C005', 'SQ', '24127977.75', 'ETL', '2026-09-28 11:00:00'),
(1327.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C006', 'BJ', '2860000.00', 'ETL', '2026-09-28 11:00:00'),
(1328.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C006', 'SQ', '2808000.00', 'ETL', '2026-09-28 11:00:00'),
(1329.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C007', 'BJ', '2110405.00', 'ETL', '2026-09-28 11:00:00'),
(1330.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C007', 'SQ', '2046842.73', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1331.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C008', 'BJ', '1200000.00', 'ETL', '2026-09-28 11:00:00'),
(1332.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C008', 'SQ', '1200000.00', 'ETL', '2026-09-28 11:00:00'),
(1333.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C009', 'BJ', '31825139.00', 'ETL', '2026-09-28 11:00:00'),
(1334.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C009', 'SQ', '30182820.48', 'ETL', '2026-09-28 11:00:00'),
(1335.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C010', 'BJ', '1796781.00', 'ETL', '2026-09-28 11:00:00'),
(1336.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C010', 'SQ', '2158321.28', 'ETL', '2026-09-28 11:00:00'),
(1337.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C011', 'BJ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1338.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C011', 'SQ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1339.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C012', 'BJ', '1900000.00', 'ETL', '2026-09-28 11:00:00'),
(1340.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C012', 'SQ', '1840000.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1341.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C013', 'BJ', '-1900000.00', 'ETL', '2026-09-28 11:00:00'),
(1342.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C013', 'SQ', '-1840000.00', 'ETL', '2026-09-28 11:00:00'),
(1343.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C014', 'BJ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1344.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C014', 'SQ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1345.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C015', 'BJ', '650000.00', 'ETL', '2026-09-28 11:00:00'),
(1346.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C015', 'SQ', '620000.00', 'ETL', '2026-09-28 11:00:00'),
(1347.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C016', 'BJ', '-650000.00', 'ETL', '2026-09-28 11:00:00'),
(1348.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C016', 'SQ', '-620000.00', 'ETL', '2026-09-28 11:00:00'),
(1349.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C017', 'BJ', '0.00', 'ETL', '2026-09-28 11:00:00'),
(1350.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C017', 'SQ', '0.00', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_report_result (id, batch_id, org_id, kjyear, kjmoth, kjyear_month, report_type, code, value_type, result_value, data_source, create_time) VALUES
(1351.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C018', 'BJ', '-753219.00', 'ETL', '2026-09-28 11:00:00'),
(1352.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C018', 'SQ', '-301678.72', 'ETL', '2026-09-28 11:00:00'),
(1353.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C019', 'BJ', '11366388.28', 'ETL', '2026-09-28 11:00:00'),
(1354.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C019', 'SQ', '11668067.00', 'ETL', '2026-09-28 11:00:00'),
(1355.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C020', 'BJ', '10613169.28', 'ETL', '2026-09-28 11:00:00'),
(1356.00, 'ETL-DEMO', 1.00, '2026', '09', '2026-09', 'CASHFLOW', 'C020', 'SQ', '11366388.28', 'ETL', '2026-09-28 11:00:00');
INSERT INTO t_message_info (id, title, content, info_type, publish_user, publish_time, status, read_count) VALUES
(1.00, '2026年9月财务分析结果已生成', '本月资产负债率 39.6%、流动比率保持1.8倍以上，但净利率与应收账款周转率出现下滑趋势，请关注预警提示并及时调整。', 'REPORT', 'root', '2026-09-29 09:00:00', 1.00, 12.00),
(2.00, '关于应收款项账龄催收的通知', '截至2026年9月，应收账款账龄中到期91至180天部分占比上升，请销售部门配合财务部按客户开展专项催收。', 'WARN', 'cwzj', '2026-09-29 10:30:00', 1.00, 8.00),
(3.00, '金蝶K8数据导入规范说明', '每月3日前完成三大报表及科目余额表导出并导入本系统，报表名称必须与系统取值配置一致，导入后执行数据全量转换。', 'NOTICE', 'cwry', '2026-09-25 14:00:00', 1.00, 20.00);
INSERT INTO t_import_log (id, batch_id, report_type, report_name, file_name, total_rows, success_rows, fail_rows, status, message, imp_user, start_time, end_time) VALUES
(1.00, 'BATCH-DEMO', 'BALANCE', '资产负债表', '资产负债表_2026-09.xlsx', 69.00, 69.00, 0.00, 'SUCCESS', '导入成功', 'root', '2026-09-28 10:00:00', '2026-09-28 10:00:06'),
(2.00, 'BATCH-DEMO', 'PROFIT', '利润表', '利润表_2026-09.xlsx', 24.00, 24.00, 0.00, 'SUCCESS', '导入成功', 'root', '2026-09-28 10:01:00', '2026-09-28 10:01:03'),
(3.00, 'BATCH-DEMO', 'CASHFLOW', '现金流量表', '现金流量表_2026-09.xlsx', 20.00, 20.00, 0.00, 'SUCCESS', '导入成功', 'cwry', '2026-09-28 10:02:00', '2026-09-28 10:02:02'),
(4.00, 'ETL-DEMO', 'TRANSFORM', '数据转换', '-', 226.00, 226.00, 0.00, 'SUCCESS', '数据全量转换完成', 'root', '2026-09-28 11:00:00', '2026-09-28 11:00:12');
INSERT INTO t_report (id, report_code, report_name, report_type, org_id, kjyear_month, summary, content, creator, create_time) VALUES
(1.00, 'INVEST-2026-09', '智能装备产线扩建项目投资预测报告', 'INVESTMENT', 1.00, '2026-09', '项目总投资1200万元，预计年新增收入1600万元，NPV 365.42万元，IRR 21.35%，静态投资回收期3.8年，项目可行。', '投资总额:1200万元;折现率:10%;建设期:12个月;年新增收入:1600万元;年运营成本:1120万元;NPV:365.42万元;IRR:21.35%;回收期:3.8年;结论:建议投资', 'root', '2026-09-30 16:00:00');

