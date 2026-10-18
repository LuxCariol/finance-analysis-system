# 移动端 API

所有受保护接口在请求头携带：

```text
X-Token: <登录返回的 token>
```

统一响应：

```json
{ "code": 200, "message": "success", "data": {}, "timestamp": 1710000000000 }
```

## 登录与用户

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| POST | `/api/auth/login` | `{ "account": "root", "password": "123456" }` |
| POST | `/api/auth/logout` | 退出 |
| GET | `/api/auth/profile` | 当前用户和企业 |
| PUT | `/api/auth/profile` | 修改用户名、备注、密码 |

## 经营报告和数据总览

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/api/home/report` | 首页企业经营报告、指标、健康分、建议 |
| GET | `/api/finance/overview` | 金融数据总览 |
| GET | `/api/finance/summary-warning` | 概要数据与预警 |

参数：`orgId`（可选，默认登录用户关联公司）、`period`（可选，默认最新期间）。

## 三大报表

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/api/report/profit` | 利润表项目 |
| GET | `/api/report/balance` | 资产负债表项目 |
| GET | `/api/report/cashflow` | 现金流量表项目 |
| GET | `/api/report/account-balance` | 科目余额表，支持 `keyword` |

## 财务分析

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/api/analysis/home` | 分析模块首页 |
| GET | `/api/analysis/balance` | 资产负债分析 |
| GET | `/api/analysis/profit` | 利润分析 |
| GET | `/api/analysis/cashflow` | 现金流量分析 |
| GET | `/api/analysis/profit/chart` | 利润折线图数据 |
| GET | `/api/analysis/cashflow/chart` | 现金流量柱状图/趋势数据 |
| GET | `/api/analysis/ratio` | 四类财务比率 |

比率分析返回：

- `shortTerm`：流动比率、速动比率、现金比率、营运资金
- `longTerm`：资产负债率、产权比率、权益乘数、利息保障倍数
- `profitability`：毛利率、营业利润率、净利率、ROA、ROE
- `operation`：应收账款周转率、存货周转率、总资产周转率、经营现金净流量

## 明细、账龄和趋势

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/api/finance/detail?code=ZCFZ-G` | 单个编码详情 |
| GET | `/api/finance/detail/chart?code=LR-A` | 单个编码月度趋势 |
| GET | `/api/finance/aging?type=7` | 账龄数据，type 取值 3-8 |

## 预测

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET/POST | `/api/forecast/profit` | 损益预测，POST 可传 `months`、`growthAdjustment` |
| POST | `/api/investment/preview` | 投资预测预提交 |
| POST | `/api/investment/forecast` | 完整投资测算 |

投资测算可传字段：`initialInvestment`、`projectYears`、`discountRate`、`taxRate`、`vatRate`、`annualRevenue`、`annualCost`、`loanAmount`、`loanRate`、`loanYears`、`salvageRate`、`revenueGrowth`、`costGrowth`。

返回 NPV、IRR、回收期、逐年利润/增值税/借款还本付息/项目现金流/全资本现金流。

## 资讯

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/api/news?limit=10` | 资讯列表 |
