# uni-app 移动端

## 运行

1. 用 HBuilderX 打开本目录。
2. 修改 `common/config.js` 的 `API_BASE`：
   - H5 本地调试：`http://localhost:8006`
   - 真机：`http://电脑局域网IP:8006`
3. 运行到浏览器或 App 基座。

## 目录

- `pages/login`：登录
- `pages/home`：企业经营报告
- `pages/reports`：三大报表明细
- `pages/analysis`：财务分析首页、资产负债、利润、现金流、比率
- `pages/finance`：明细趋势、账龄和科目余额
- `pages/forecast`：损益预测
- `pages/investment`：投资预测
- `pages/profile`：个人中心
- `pages/news`：财经资讯
- `components`：指标卡、柱状图、折线图、报表行、空状态

## 接口约定

所有请求通过 `common/request.js` 自动携带 `X-Token`。若接口返回 401，会自动回到登录页。
