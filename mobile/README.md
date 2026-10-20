# uni-app 移动端

## 运行

1. 用 HBuilderX 打开本目录。
2. 修改 `common/config.js` 的 `API_BASE`：
   - USB 真机：使用 `http://127.0.0.1:8006`，并确保已执行 `tools/setup-adb-reverse.ps1`
   - 局域网真机：改为 `http://电脑局域网IP:8006`，且手机与电脑网络必须允许互访
   - 电脑 IP 变化后，可执行 `tools/set-mobile-api.ps1 -ApiHost 新IP`
3. 运行到浏览器或 App 基座。

登录页也可以直接修改“服务器地址”，该地址会保存在手机本地，无需每次改源码。

## 与效果图对应的页面

| 页面 | 路径 |
| --- | --- |
| 企业报告 | `pages/home/home` |
| 财务报表 / 资产负债表 | `pages/analysis/index` |
| 财务报表 / 比率分析 | `pages/analysis/index?tab=ratio` |
| 明细（类目、金额、同比、环比） | `pages/reports/profit` |
| 其他应收款账龄 | `pages/finance/detail?type=aging&agingType=4` |
| 损益表预测 | `pages/forecast/profit` |
| 投资预测结果 | `pages/investment/index` |

主色为 `#3bbfe7`，表格表头为 `#e6e6e6`，正文文字为 `#303133`，
页签选中色为 `#198cff`，底部导航使用 `static/tabBar` 中的蓝色/灰色图标。

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
- `components/AppHeader.vue`：蓝色顶部标题、返回按钮、筛选与页签插槽
- `components/FilterBar.vue`：整年/整月/自定义/年份筛选
- `components/TopTabs.vue`：资产负债表、利润表、现金流量表、比率分析页签
- `components/BottomNav.vue`：报告、分析、预测、我的
- `components/SectionTitle.vue`：灰底分区标题和蓝色标记
- `components/LineChart.vue`：趋势折线图
- `components/DonutChart.vue`：账龄占比环形图

## 接口约定

所有请求通过 `common/request.js` 自动携带 `X-Token`。若接口返回 401，会自动回到登录页。
