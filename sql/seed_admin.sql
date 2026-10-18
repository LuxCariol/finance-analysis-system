USE financial_analysis;

-- 演示公司
INSERT INTO t_org_info
(id, ORG_NAME, SHORT_NAME, ORG_REMARK, BUSINESS_NUM, LEGALER_NAME, PAID_CAPITAL, CONFUSING_CAPITAL,
 REGISTERED_ADDR, INDUSTRY, IS_LIST, ORG_PROPERTY, RES_PERSON_NAME, ORG_TOTAL_PER, RES_PERSON_TEL,
 REGISTERED_DATE, ORG_ADDR, SHARES, CUST_TYPE, REPORT_LIMIT, parent_id)
VALUES
(1, '示范制造有限公司', '示范制造', '用于金融财务分析实训的演示企业，主营智能制造设备与工业零部件的研发、生产和销售。',
 '91440101MA5DEMO001', '张明', '5000万元', '5000万元', '广州市黄埔区科学大道88号', '装备制造', '0', '2',
 '李华', 320, '13800138000', '2015-06-18', '广州市黄埔区科学大道88号', 'DEMO001', '1', '3', NULL)
ON DUPLICATE KEY UPDATE ORG_NAME=VALUES(ORG_NAME);

INSERT INTO t_org_info
(id, ORG_NAME, SHORT_NAME, ORG_REMARK, BUSINESS_NUM, LEGALER_NAME, PAID_CAPITAL, CONFUSING_CAPITAL,
 REGISTERED_ADDR, INDUSTRY, IS_LIST, ORG_PROPERTY, RES_PERSON_NAME, ORG_TOTAL_PER, RES_PERSON_TEL,
 REGISTERED_DATE, ORG_ADDR, SHARES, CUST_TYPE, REPORT_LIMIT, parent_id)
VALUES
(2, '示范商贸有限公司', '示范商贸', '负责集团供应链与区域销售业务的演示公司。',
 '91440101MA5DEMO002', '王芳', '1200万元', '1200万元', '广州市天河区珠江新城华夏路10号', '批发零售', '1', '2',
 '陈强', 86, '13900139000', '2018-03-12', '广州市天河区珠江新城华夏路10号', 'DEMO002', '1', '3', NULL)
ON DUPLICATE KEY UPDATE ORG_NAME=VALUES(ORG_NAME);

-- 管理员角色与账号
INSERT INTO t_sys_role (id, name, user_id, description, create_time)
VALUES (1, '超级管理员', 1, '拥有系统全部菜单和数据权限', NOW())
ON DUPLICATE KEY UPDATE description=VALUES(description);

INSERT INTO t_sys_user_role (user_id, role_id)
SELECT 1, 1 WHERE NOT EXISTS (SELECT 1 FROM t_sys_user_role WHERE user_id=1 AND role_id=1);

UPDATE t_sys_user SET org_id=1, description='系统根账号' WHERE id=1;

INSERT INTO t_sys_user
(id, user_name, account_name, pwd, locked, account_type, create_user_id, description, create_time,
 account_port_type, type, chrild_type, org_id, url)
VALUES
(2, '财务分析员', 'analyst', 'E10ADC3949BA59ABBE56E057F20F883E', 0, 1, 1, '演示用财务分析员账号',
 NOW(), 3, 0, NULL, 1, NULL)
ON DUPLICATE KEY UPDATE user_name=VALUES(user_name), pwd=VALUES(pwd), org_id=VALUES(org_id);

INSERT INTO t_sys_user_role (user_id, role_id)
SELECT 2, 1 WHERE NOT EXISTS (SELECT 1 FROM t_sys_user_role WHERE user_id=2 AND role_id=1);

-- 超级管理员默认拥有全部菜单和按钮权限
INSERT INTO t_sys_role_action (res_id, role_id)
SELECT r.id, 1 FROM t_sys_resources r
WHERE NOT EXISTS (
    SELECT 1 FROM t_sys_role_action a WHERE a.res_id = r.id AND a.role_id = 1
);

-- 财务数据模块菜单
INSERT INTO t_sys_resources
(id, name, parent_id, res_key, type, res_url, order_no, icon, btn, is_hide, description)
VALUES
(200, '财务数据管理', 0, 'financeData', '0', '/', 2, 'icon-bar-chart', NULL, 0, '财务数据管理'),
(210, '公司管理', 200, 'orgInfo', '1', '/orgInfo/orgInfoIndex', 1, 'icon-building', NULL, 0, '财务数据管理>>公司管理'),
(220, '利润表', 200, 'tBasiProfit', '1', '/report/tBasiProfitIndex', 2, 'icon-list-alt', NULL, 0, '财务数据管理>>利润表'),
(221, '资产负债表', 200, 'tBasiAssets', '1', '/report/tBasiAssetsAndLiabilitiesIndex', 3, 'icon-table', NULL, 0, '财务数据管理>>资产负债表'),
(222, '现金流量表', 200, 'tBasiCashFlow', '1', '/report/tBasiCashFlowIndex', 4, 'icon-exchange', NULL, 0, '财务数据管理>>现金流量表'),
(223, '科目余额表', 200, 'tKmye', '1', '/report/tKmyeIndex', 5, 'icon-book', NULL, 0, '财务数据管理>>科目余额表'),
(224, '账龄分析', 200, 'ageAnalysis', '1', '/report/planTAgeAnalysisIndex', 6, 'icon-time', NULL, 0, '财务数据管理>>账龄分析'),
(225, '批量导入', 200, 'bulkImport', '1', '/report/bulkImportIndex', 7, 'icon-cloud-upload', NULL, 0, '财务数据管理>>批量导入'),
(300, '编码与算法', 0, 'codeAndMode', '0', '/', 3, 'icon-code', NULL, 0, '编码与算法'),
(310, '编码字典', 300, 'codeLibr', '1', '/codeLibr/codeLibrIndex', 1, 'icon-list-ul', NULL, 0, '编码与算法>>编码字典'),
(311, '编码映射', 300, 'codeMapper', '1', '/codeLibr/codeMapperIndex', 2, 'icon-random', NULL, 0, '编码与算法>>编码映射'),
(312, '数据转换', 300, 'dataFormat', '1', '/report/tReportResultIndex', 3, 'icon-refresh', NULL, 0, '编码与算法>>数据转换'),
(313, '算法配置', 300, 'tMode', '1', '/mode/tModeIndex', 4, 'icon-cogs', NULL, 0, '编码与算法>>算法配置'),
(400, '资讯管理', 0, 'messageInfo', '0', '/', 4, 'icon-comments', NULL, 0, '资讯管理'),
(410, '资讯管理', 400, 'msg', '1', '/msg/msgIndex', 1, 'icon-comment', NULL, 0, '资讯管理>>资讯列表')
ON DUPLICATE KEY UPDATE name=VALUES(name), parent_id=VALUES(parent_id), res_url=VALUES(res_url), order_no=VALUES(order_no);

-- 页面按钮
INSERT INTO t_sys_resources
(id, name, parent_id, res_key, type, res_url, order_no, icon, btn, is_hide, description)
VALUES
(21001, '新增公司', 210, 'org_add', '2', '/', 1, NULL, 'addFunOrg,addFunOrg,btn btn-xs btn-info,新增', 0, '新增公司'),
(21002, '编辑公司', 210, 'org_edit', '2', '/', 2, NULL, 'editOrg,editOrg,btn btn-xs btn-info,编辑', 0, '编辑公司'),
(22001, '导入利润表', 220, 'profit_upload', '2', '/', 1, NULL, 'upload,upload,btn btn-xs btn-success,导入', 0, '导入利润表'),
(22101, '导入资产负债表', 221, 'assets_upload', '2', '/', 1, NULL, 'upload,upload,btn btn-xs btn-success,导入', 0, '导入资产负债表'),
(22201, '导入现金流量表', 222, 'cash_upload', '2', '/', 1, NULL, 'upload,upload,btn btn-xs btn-success,导入', 0, '导入现金流量表'),
(22301, '导入科目余额表', 223, 'kmye_upload', '2', '/', 1, NULL, 'upload,upload,btn btn-xs btn-success,导入', 0, '导入科目余额表'),
(22401, '导入账龄分析', 224, 'age_upload', '2', '/', 1, NULL, 'upload,upload,btn btn-xs btn-success,导入', 0, '导入账龄分析'),
(22501, '批量导入', 225, 'bulk_upload', '2', '/', 1, NULL, 'upload,upload,btn btn-xs btn-success,批量导入', 0, '批量导入'),
(31001, '新增编码字典', 310, 'codeLibr_add', '2', '/', 1, NULL, 'addCodeLibr,addCodeLibr,btn btn-xs btn-info,新增', 0, '新增编码字典'),
(31002, '编辑编码字典', 310, 'codeLibr_edit', '2', '/', 2, NULL, 'editCodeLibr,editCodeLibr,btn btn-xs btn-info,编辑', 0, '编辑编码字典'),
(31003, '删除编码字典', 310, 'codeLibr_delete', '2', '/', 3, NULL, 'delCodeLibr,delCodeLibr,btn btn-xs btn-danger,删除', 0, '删除编码字典'),
(31101, '新增编码映射', 311, 'codeMapper_add', '2', '/', 1, NULL, 'addCodeMapper,addCodeMapper,btn btn-xs btn-info,新增', 0, '新增编码映射'),
(31102, '编辑编码映射', 311, 'codeMapper_edit', '2', '/', 2, NULL, 'editCodeMapper,editCodeMapper,btn btn-xs btn-info,编辑', 0, '编辑编码映射'),
(31103, '删除编码映射', 311, 'codeMapper_delete', '2', '/', 3, NULL, 'delCodeMapper,delCodeMapper,btn btn-xs btn-danger,删除', 0, '删除编码映射'),
(31201, '执行数据转换', 312, 'dataFormat_all', '2', '/', 1, NULL, 'dataFormatAll,dataFormatAll,btn btn-xs btn-success,数据转换', 0, '执行数据转换'),
(31301, '新增算法配置', 313, 'mode_add', '2', '/', 1, NULL, 'addTMode,addTMode,btn btn-xs btn-info,新增', 0, '新增算法配置'),
(31302, '编辑算法配置', 313, 'mode_edit', '2', '/', 2, NULL, 'editTMode,editTMode,btn btn-xs btn-info,编辑', 0, '编辑算法配置'),
(31303, '删除算法配置', 313, 'mode_delete', '2', '/', 3, NULL, 'delTMode,delTMode,btn btn-xs btn-danger,删除', 0, '删除算法配置'),
(41001, '新增资讯', 410, 'msg_add', '2', '/', 1, NULL, 'addMsg,addMsg,btn btn-xs btn-info,新增', 0, '新增资讯'),
(41002, '编辑资讯', 410, 'msg_edit', '2', '/', 2, NULL, 'editMsg,editMsg,btn btn-xs btn-info,编辑', 0, '编辑资讯'),
(41003, '删除资讯', 410, 'msg_delete', '2', '/', 3, NULL, 'delMsg,delMsg,btn btn-xs btn-danger,删除', 0, '删除资讯')
ON DUPLICATE KEY UPDATE name=VALUES(name), parent_id=VALUES(parent_id), btn=VALUES(btn), order_no=VALUES(order_no);

-- 系统字典演示数据
INSERT INTO t_sys_dictionary (cn_name, en_name, flag, remark, create_time, create_user_id, update_time, update_user_id)
VALUES ('报表标准', 'report_standard', '1', '公司管理中的报表格式选项', NOW(), 1, NOW(), 1)
ON DUPLICATE KEY UPDATE remark=VALUES(remark);
SET @dict_id = (SELECT id FROM t_sys_dictionary WHERE en_name='report_standard' LIMIT 1);
INSERT INTO t_sys_dictionary_detail (name, value, remark, dictionary_id)
SELECT '金蝶KIS旗舰版格式', '3', '用于本项目演示数据', @dict_id
WHERE NOT EXISTS (SELECT 1 FROM t_sys_dictionary_detail WHERE dictionary_id=@dict_id AND value='3');
INSERT INTO t_sys_dictionary_detail (name, value, remark, dictionary_id)
SELECT '企业会计准则', '1', '标准企业报表', @dict_id
WHERE NOT EXISTS (SELECT 1 FROM t_sys_dictionary_detail WHERE dictionary_id=@dict_id AND value='1');
INSERT INTO t_sys_dictionary_detail (name, value, remark, dictionary_id)
SELECT '小企业会计准则', '2', '小企业报表', @dict_id
WHERE NOT EXISTS (SELECT 1 FROM t_sys_dictionary_detail WHERE dictionary_id=@dict_id AND value='2');

-- 演示资讯
INSERT INTO t_message_info (ARRY_QUE, TITLE, CONTENT, VIEW_NUM, AUTHOR, UP_DATE, UP_PERSON, UP_PERSON_TEL, CREATE_TIME, CREATE_USER, UPDATE_TIME, UPDATE_USER, CLZZ)
SELECT '1', '财务分析系统上线通知', '金融财务分析系统已完成核心功能建设，支持三大报表导入、比率分析与投资预测。', 128, '系统管理员', CURDATE(), '系统管理员', '13800138000', NOW(), 'admin', NOW(), 'admin', 1
WHERE NOT EXISTS (SELECT 1 FROM t_message_info WHERE TITLE='财务分析系统上线通知');
