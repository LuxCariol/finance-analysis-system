# 金融财务分析系统（PC端后台管理系统）

> 技术要求：SpringBoot 整合 SSM（Spring + SpringMVC + MyBatis）开发 PC 端后台管理系统。
> 本工程只包含 **浏览器端（PC 后台管理端）**，未包含 uni-app 小程序/APP 端。
> 系统采用 ETL + 配置化处理技术，将金蝶 K8 财务数据抽取、转换后存入数据仓库，通过算法模型配置得到财务分析结果（比率分析、资金概要与预警、杜邦分析、投资计算、损益预测等），并以曲线图、柱状图、饼图与文字说明进行可视化展示。

---

## 目录

1. [项目简介](#一项目简介)
2. [技术架构与运行环境](#二技术架构与运行环境)
3. [功能清单](#三功能清单)
4. [工程目录结构](#四工程目录结构)
5. [快速运行（免安装数据库）](#五快速运行免安装数据库)
6. [正式部署（MySQL 8 + Redis + Nginx，CentOS 7）](#六正式部署centos-7)
7. [数据库设计](#七数据库设计)
8. [核心设计说明](#八核心设计说明)
9. [接口清单](#九接口清单)
10. [账号与演示数据](#十账号与演示数据)
11. [与五份设计文档的对应关系](#十一与五份设计文档的对应关系)
12. [常见问题](#十二常见问题)

---

## 一、项目简介

**金融财务分析系统**面向公司高层及财务人员，对财务数据进行分析与预警，并对公司运营提供指导：

```
金蝶K8导出财务报表(Excel)
        ↓  ① 数据导入（取值版/位置版配置化解析）
系统基础表 t_basi_assets_and_liabilities / t_basi_profit / t_basi_cash_flow / t_kmye / t_age_analysis
        ↓  ② ETL 数据转换（编码映射 t_code_mapper）
数据仓库结果表 t_report_result（编码 + 取数类型 + 数据值）
        ↓  ③ 算法模型计算（t_mode 配置化算法）
比率分析 / 资金概要与预警 / 杜邦分析 / 投资计算 / 损益预测
        ↓  ④ 浏览器端可视化（曲线图、柱状图、饼图 + 文字说明 + 预警调整建议）
企业经营报告、三大报表报告、指标明细、预警记录
```

系统由 **数据导入、模型管理、财务报表、财务分析、预测、系统管理** 几大部分组成；不支持金蝶 K8 的财务明细、财务对账、银企直连等功能，专注于财务分析结果计算与可视化。

## 二、技术架构与运行环境

| 层次 | 技术 |
| --- | --- |
| 前端（PC端浏览器） | HTML5 + CSS3 + 原生 JavaScript + ECharts（CDN，未联网时自动使用内置 SVG 图表兜底） |
| 控制层 | Spring MVC（`@RestController`，统一 JSON 返回 `code/message/data`） |
| 业务层 | Spring `@Service` + 事务管理 + 配置化算法表达式引擎 |
| 持久层 | MyBatis（注解 + XML 动态 SQL，宽表动态写入） |
| 数据库 | MySQL 8.0（默认演示可用 H2 免安装数据库） |
| 缓存 | Redis（未部署时自动降级为 JVM 内存缓存，不影响运行） |
| 连接池 | 阿里 Druid |
| Excel | Apache POI 5.2.5（导入解析 + 模板生成） |
| 其他 | Lombok、Logback（日志文件 `./logs/finance-analysis.log`） |

**开发环境**：Windows 10 / JDK 1.8 / IDEA 2022.3 / MySQL 8.0 / Redis 3.0 / Maven 3.5+
**部署环境**：CentOS 7 / Nginx 1.23 / MySQL 8.0 / Redis 7.0 / JDK 1.8 / Maven 3.5

## 三、功能清单

| 模块 | 功能 | 页面 |
| --- | --- | --- |
| 登录 | 账号密码（MD5 加盐）登录、菜单权限、退出 | `/web/login.html` |
| 首页概览 | 关键指标卡片、收入利润趋势、核心比率、预警提示、导入情况、资讯 | 首页概览 |
| 数据导入 | 资产负债表 / 利润表 / 现金流量表 / 科目余额表 / 账龄分析导入，模板下载、覆盖或跳过、批量 100 条入库、失败回滚、导入日志 | 数据导入 |
| 模型管理 | 报表与取值配置（取值版/位置版）、编码映射、编码字典、算法配置、数据转换(ETL)、资讯管理 | 模型管理 |
| 财务报表 | 企业经营报告、资产负债表、利润表、现金流量表（本期/上期或年初/期末对比、小计、图表） | 财务报表 |
| 财务分析 | 比率分析（偿债/营运/盈利）、资金概要与预警、杜邦分析、投资计算（NPV/IRR/回收期） | 财务分析 |
| 预测 | 损益预测（线性回归 + 复合增长率，另附存储过程实现）、投资预测报告（存入 `t_report`） | 预测 |
| 系统管理 | 用户、角色（菜单权限）、菜单、公司、系统字典 | 系统管理 |

## 四、工程目录结构

```
finance-analysis-system
├── pom.xml                                  Maven 配置（SpringBoot 2.7.18 + SSM + 可选依赖）
├── README.md                                本文档
├── src/main/java/com/qst/finance
│   ├── FinanceApplication.java              启动类
│   ├── common/                              统一返回、分页、异常、树结构、常量
│   ├── config/                              应用参数、拦截器、MVC 配置、缓存配置
│   ├── cache/                               缓存服务（Redis + 内存降级）
│   ├── util/                                MD5、Excel、表达式引擎、树、日期、Map 工具
│   ├── model/                               实体与 DTO（用户、角色、菜单、编码、算法、结果…）
│   ├── mapper/                              MyBatis 数据访问接口（XML 见 resources/mapper）
│   ├── service/ + service/impl/             业务服务与实现
│   ├── service/support/                     表结构缓存、模板生成、算法取值辅助
│   └── controller/                          REST 接口
├── src/main/resources
│   ├── application.yml / application-h2.yml / application-mysql.yml
│   ├── mapper/*.xml                         MyBatis 动态 SQL
│   ├── db/schema.sql                        建表脚本（MySQL8 与 H2 通用）
│   ├── db/data.sql                          初始化数据与演示数据
│   └── static/web/**                        前端页面（登录、框架、各功能页面）
└── deploy
    ├── index_mysql.sql                      MySQL 索引优化脚本
    ├── proc_profit_forecast.sql             损益预测存储过程（MySQL 版）
    ├── nginx.conf                           Nginx 反向代理/集群示例
    ├── start.sh / stop.sh                   Linux 启停脚本
```

## 五、快速运行（免安装数据库）

默认使用 **H2 内存数据库（MySQL 兼容模式）**，无需安装 MySQL/Redis，启动即可看到完整功能与演示数据（2026-04 ~ 2026-09 共 6 个月）。

```bash
cd finance-analysis-system
mvn clean package -DskipTests      # 打包（首次会下载依赖）
java -jar target/finance-analysis-system.jar --spring.profiles.active=h2
```

浏览器访问 <http://localhost:8080/web/login.html>，账号 `root / 123456`。

> 若使用 IDEA：直接运行 `com.qst.finance.FinanceApplication`（`application.yml` 中默认 `active: h2`）。
> H2 控制台：<http://localhost:8080/h2-console>，JDBC URL 见 `application-h2.yml`。

## 六、正式部署（CentOS 7）

### 1. 准备数据库与缓存

```bash
# MySQL 8：创建数据库（首次启动时程序也会用 createDatabaseIfNotExist 自动创建）
mysql -uroot -p -e "CREATE DATABASE IF NOT EXISTS cw_finance DEFAULT CHARACTER SET utf8mb4;"

# 初始化表结构与数据（可用 Navicat 导入这两个文件，或让程序首次启动自动执行）
mysql -uroot -p cw_finance < src/main/resources/db/schema.sql
mysql -uroot -p cw_finance < src/main/resources/db/data.sql
mysql -uroot -p cw_finance < deploy/index_mysql.sql          # 索引优化(可选)
mysql -uroot -p cw_finance < deploy/proc_profit_forecast.sql # 损益预测存储过程(可选)

redis-server /etc/redis.conf &                                # 启动 Redis(可选)
```

### 2. 修改连接配置

编辑 `src/main/resources/application-mysql.yml` 中的 `url / username / password / redis.host`，与现场环境保持一致。

### 3. 打包并启动

```bash
mvn clean package -DskipTests
sh deploy/start.sh mysql          # 内部执行 java -jar ... --spring.profiles.active=mysql
sh deploy/stop.sh                 # 停止
```

日志：`logs/console.log`、`logs/finance-analysis.log`（对应《概要设计》5.5 `/app/cw/log/my.log`）。

### 4. Nginx 反向代理与双机集群

把 `deploy/nginx.conf` 中的 `upstream` 地址改为两台应用服务器地址，放到 `/etc/nginx/conf.d/finance.conf`，然后 `nginx -s reload`。

> 集群部署时注意：会话保存在单机内存，生产建议将登录令牌放入 Redis（本项目已提供 `CacheService`，扩展时将 Session 替换为 Redis Token 即可）。

## 七、数据库设计

命名规则遵循《数据库设计》：`t_sys` 系统表、`t_basi` 元数据（基础）表，其余为业务表。

| 分类 | 表名 | 说明 |
| --- | --- | --- |
| 系统管理 | t_sys_user、t_sys_role、t_sys_resources、t_sys_user_role、t_sys_role_action、t_sys_user_action、t_sys_dictionary、t_sys_dictionary_detail、t_org_info | 用户、角色、菜单、权限、字典、公司 |
| 数据导入（基础表） | t_basi_assets_and_liabilities（150+列）、t_basi_profit、t_basi_cash_flow、t_kmye（科目余额表）、t_age_analysis（账龄） | 接收金蝶 K8 三大报表、科目余额表、账龄数据 |
| 模型管理 | t_report_name（报表模板）、t_report_property（取值版/位置版）、t_code_libr（编码字典）、t_code_mapper（编码映射）、t_mode（算法模型） | 配置化处理核心 |
| 数据仓库与输出 | t_report_result（转换结果）、t_report（报告）、t_warn_record（预警）、t_import_log（导入/转换日志）、t_message_info（资讯） | 结果存储与日志 |

> 完整字段见 `src/main/resources/db/schema.sql`（与《数据库设计.doc》表 5.1~5.8 一致，字段名做了规范化整理）。

## 八、核心设计说明

### 1. 数据导入：取值版 / 位置版配置化

`t_report_property` 保存三种配置信息，导入程序据此解析任意格式的金蝶报表：

- `subject_name`：Excel 中科目名称（横向取值版）或列标题（明细表）
- `source_column`：Excel 表头列名（如 年初余额 / 期末余额 / 本期金额 / 上期金额）
- `column_code`：目标基础表字段（如 `QM_ZCZJ`）
- `is_key`：明细表（科目余额表、账龄分析）中标识"行主键列"

报表模式由 `t_report_name.map_mode` 决定：`WIDE` = 横向取值版（一行一个科目，合并为一条宽表记录）；`LONG` = 明细表（一行一条记录）。

导入过程：文件解析 → 表头行智能定位 → 表头信息区解析会计年月/公司 → 按配置映射字段 → 每 100 条批量入库（失败整体回滚）→ 写入导入日志；重复导入可选择 **覆盖** 或 **跳过**。

### 2. ETL 数据转换与编码映射

点击【模型管理 - 数据转换】后执行：

1. 读取基础表数据，按 `t_code_mapper` 配置（来源表 + 来源字段 + 取数类型 → 目标编码）生成编码数据；
2. 写入数据仓库结果表 `t_report_result`（唯一键维度：公司 + 会计年月 + 报表类型 + 编码 + 取数类型）；
3. 更新基础表 `FORMAT_FLAG='Y'`；
4. 自动执行算法模型，写入算法结果（`data_source='ALGO'`）与预警记录 `t_warn_record`。

### 3. 算法表达式引擎（配置化核心）

算法直接配置在 `t_mode.calc_expression` 字段中，业务人员改算法无需改代码：

| 语法 | 说明 | 示例 |
| --- | --- | --- |
| `{编码}` | 取该编码默认取数类型值（资产负债=期末，利润/现金流量=本期） | `{A013}/{A047}` |
| `{编码@类型}` | 指定取数类型：NC 年初 / QM 期末 / BJ 本期 / SQ 上期 | `{A032@NC}` |
| 四则运算 | `+ - * / ( )` | `({A013}-{A009}-{A005})/{A047}` |
| 比较运算 | `> >= < <= == !=`（返回 1/0） | `IF({A057}/{A032}>0.65,1,0)` |
| 函数 | `SUM AVG MIN MAX ABS ROUND SQRT IF SAFEDIV LINEAR` | `ROUND({P021}/{P001},4)` |

除数为 0 时返回 0，避免财务指标出现异常值。

### 4. 预警标准与调整建议

`t_mode` 中每个指标可配置：

- `warn_mode`：`up` 高于上限预警 / `down` 低于下限预警 / `range` 超出区间预警 / `none` 不预警
- `warn_lower`、`warn_upper`、`warn_level`（1 提示 / 2 警告 / 3 严重）
- `main_factor` 主要因素、`advantage` 优点、`disadvantage` 缺点、`advise` 调整建议

指标达到警戒线后，系统自动生成预警说明与调整建议，并同步展示在首页概览、比率分析、资金概要与预警、企业经营报告中。

### 5. 投资计算与损益预测

- **投资计算**：NPV（净现值）、IRR（二分法求内部收益率）、ROI、静态投资回收期，支持逐期现金流或"年收入 − 年成本"两种输入方式；
- **损益预测**：最小二乘线性回归（`y = a + b·x`）+ 复合增长率双重校验，输出未来 3 期营业收入与净利润（`LINEAR({P021})`）；MySQL 环境亦可调用存储过程 `p_profit_forecast`。

## 九、接口清单

统一返回：`{"code":0,"message":"操作成功","data":...}`，`code=0` 为成功，`401` 表示登录失效，`500` 表示业务/系统异常。

| 接口 | 方法 | 说明 |
| --- | --- | --- |
| `/api/auth/login`、`/logout`、`/current`、`/menu`、`/dict`、`/cache` | POST/GET | 登录认证与菜单权限 |
| `/api/sys/user/*`、`/api/sys/role/*`、`/api/sys/menu/*`、`/api/sys/org/*`、`/api/sys/dict/*` | GET/POST | 系统管理 |
| `/api/import/templates`、`/upload`、`/template`、`/logs` | GET/POST | 数据导入与模板下载 |
| `/api/etl/transform`、`/status`、`/warn` | POST/GET | 数据转换与预警 |
| `/api/model/report/*`、`/property/*`、`/libr/*`、`/mapper/*`、`/mode/*`、`/news/*` | GET/POST | 模型管理（含算法试算 `/api/model/mode/test`） |
| `/api/report/balance`、`/profit`、`/cashflow`、`/codes`、`/kmye`、`/aging` | GET | 财务报表数据 |
| `/api/analysis/dashboard`、`/ratio`、`/fund`、`/dupont`、`/enterprise`、`/forecast`、`/investment`、`/investment/report(s)` | GET/POST | 分析与预测 |

## 十、账号与演示数据

| 账号 | 密码 | 角色 | 权限范围 |
| --- | --- | --- | --- |
| root | 123456 | 超级管理员 | 全部功能 |
| cwzj | 123456 | 财务总监 | 除系统管理外全部功能 |
| cwry | 123456 | 财务人员 | 数据导入、模型管理、报表与分析 |
| gg | 123456 | 公司高层/投资者 | 报表、分析、预测（只读查看） |

演示数据：2026-04 ~ 2026-09 共 6 个月三大报表基础数据、科目余额表、账龄数据、113 个数据仓库编码与 226 条编码映射、23 个算法模型、3 类资讯。

其中 2026-09 触发的预警示例：

- **净利率 6.26%** 低于预警下限 7.00%（严重）
- **应收账款周转率 0.73 次** 低于预警下限 0.85 次（严重）
- **现金流动负债比 0.05 倍** 低于预警下限 0.10 倍（严重）

## 十一、与五份设计文档的对应关系

| 文档 | 对应实现 |
| --- | --- |
| 《项目立项》 | 技术选型（SpringBoot + SSM + MySQL + Redis + Nginx）、数据流程（K8→Excel→映射→算法→可视化）、部署方案 |
| 《项目需求分析》 | 4 类角色权限、数据导入（三大报表/科目余额表/账龄分析）、模型管理（编码映射/算法配置/数据转换/资讯/编码字典）、系统管理（菜单/公司/角色/用户/字典）、企业报告、财务分析、预测、在线顾问（资讯）、非功能需求 |
| 《概要设计》 | MVC 分层、功能结构与技术架构、界面定义与关系、内部接口（统一 code/message/data）、部署视图、出错处理、安全保密（MD5 加盐、Session 校验） |
| 《详细设计》 | Controller/Service/Mapper/Model 分层命名规范、接口与实现类（`XxxService` + `XxxServiceImpl`）、菜单管理、用户管理、算法配置的类设计 |
| 《数据库设计》 | 表名前缀规则、系统表、基础表（含 150+ 字段的资产负债基础表）、配置表、结果表、索引优化与安全性设计 |

## 十二、常见问题

**1. 启动报 Redis 连接异常？**
系统已做降级处理：Redis 不可用时自动使用 JVM 内存缓存，登录与功能不受影响（首页右上角会显示"缓存: 内存"）。生产环境建议启动 Redis。

**2. 中文乱码？**
确保数据库字符集为 `utf8mb4`，并且在 JDBC URL 中保留 `characterEncoding=utf8`；Excel 模板请使用系统提供的模板下载。

**3. 导入提示"未能识别会计年月"？**
在导入页面手动选择会计年月即可（文件表头信息区缺失时使用页面选择值）。

**4. 页面图表空白？**
图表默认从 CDN 加载 ECharts，内网环境会自动使用内置 SVG 渲染曲线图/柱状图/饼图；也可把 echarts.min.js 放到 `static/web/js/` 下并修改页面引用。

**5. 分析页面没有数据？**
依次执行：数据导入 → 模型管理/数据转换（数据全量转换）→ 分析页面查询；或直接使用系统内置的 2026-04 ~ 2026-09 演示数据。
