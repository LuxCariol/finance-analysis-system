# 金融财务分析系统（实训项目）

本项目根据 `软件项目高级实战与优化资料分享` 中的 SQL、金蝶报表样例和后台页面重构，所有新代码、脚本和文档均位于本目录，原始资料目录未做修改。

## 目录结构

| 目录 | 内容 |
| --- | --- |
| `backend` | Spring Boot 2.7 + JSP + JdbcTemplate 后端，同时提供后台页面和移动端 REST 接口 |
| `web` | 独立 Vue 3 + Element Plus + ECharts 现代 Web 管理端 |
| `mobile` | uni-app 移动端，包含登录、经营报告、三大报表、财务分析、比率分析、损益预测、投资预测、个人中心 |
| `sql` | 建库脚本、管理员/菜单种子数据、编码字典和算法配置数据 |
| `docs` | 运行说明、API 清单、任务对照和验收记录 |
| `tools` | 样例数据检查和接口冒烟测试脚本 |

## 快速启动

### 1. 初始化数据库

本机 MySQL 8 默认账号为 `root/123456`，与 `backend/src/main/resources/application.yml` 一致。

```powershell
mysql -uroot -p123456 --default-character-set=utf8mb4 -e "source D:/code/CodexProgram/ShixunCode/financial-analysis/sql/financial_analysis.sql"
mysql -uroot -p123456 --default-character-set=utf8mb4 -e "source D:/code/CodexProgram/ShixunCode/financial-analysis/sql/seed_admin.sql"
```

数据库名为 `financial_analysis`，不会覆盖原始 `financial_01`。首次启动时，后端会自动从 `backend/src/main/resources/demo-data/2021` 导入 2021 年 1 月至 12 月的金蝶样例报表，并生成数据转换结果。

### 2. 启动后端

```powershell
cd D:\code\CodexProgram\ShixunCode\financial-analysis\backend
mvn -B -DskipTests package
java -jar target\financial-analysis.war
```

现代 Web 管理端：<http://localhost:8006/web/>

原 JSP 管理端保留作兼容：<http://localhost:8006/admin/pc/login>

演示账号：

| 账号 | 密码 | 说明 |
| --- | --- | --- |
| `root` | `123456` | 超级管理员 |
| `analyst` | `123456` | 财务分析员 |

### 3. 启动移动端

用 HBuilderX 打开 `mobile` 目录，先运行到浏览器或 App 基座。`mobile/common/config.js` 中的 `API_BASE` 默认是 `http://localhost:8006`；真机运行时请改成电脑局域网 IP，例如 `http://192.168.1.20:8006`。

移动端使用后端登录接口获取 token，并保存到本地存储。后端已开启 `/api/**` 跨域配置。

手机真机运行请单独查看 [手机真机运行说明](docs/手机真机运行说明.md)，其中包含局域网 IP、防火墙、HBuilderX 真机基座和常见问题。

## 已实现的功能

后台：用户登录、菜单管理、角色管理、系统字典、用户管理（含密码初始化、权限分配、个人资料）、公司管理、利润表、资产负债表、现金流量表、科目余额表、账龄分析、单表导入、批量导入、编码字典、编码映射、数据转换、算法配置、资讯管理。

移动端接口：登录/资料、经营报告、金融数据总览、三大报表明细、分析首页、资产负债/利润/现金流量分析、比率分析、损益预测、项目投资测算、数据详情趋势、账龄与科目余额、风险摘要、资讯列表。

## 说明

- 报表导入按金蝶导出文件中的项目名称、行次和会计期间解析，单表导入会替换同一公司、同一期间的数据。
- `t_age_analysis` 原始表没有 `BATCH_ID` 字段，代码已按真实表结构调整。
- 数据转换从 `t_code_mapper.BASI_FIELD` 映射到 `t_code_libr.CODE_NO`，生成 `t_report_result` 和 `t_report`，供移动端图表使用。
- 投资测算为教学用简化模型，实际项目决策前需复核营运资金、税费、折旧和融资条件。

详细验收步骤见 [docs/验收说明.md](docs/验收说明.md)，接口清单见 [docs/API.md](docs/API.md)。

明天现场演示前先运行 `tools\demo-check.ps1` 做环境自检，演示顺序和讲解话术见 [docs/明天展示流程.md](docs/明天展示流程.md)。

完整任务与缺口审计见 [docs/代码审计报告.md](docs/代码审计报告.md)。
