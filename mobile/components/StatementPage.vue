<template>
  <view class="page statement-page">
    <AppHeader title="财务报表" :back="back">
      <template #filters>
        <FilterBar :year="year" :mode="mode" @mode-change="mode = $event" @year-change="changeYear" />
      </template>
      <template #tabs>
        <TopTabs :tabs="tabs" :active="active" @change="changeTab" />
      </template>
    </AppHeader>

    <view v-if="loading" class="placeholder">正在加载财务数据…</view>
    <view v-else-if="active === 'ratio'">
      <view class="ratio-table table">
        <view class="table-head ratio-head">
          <view class="ratio-name-head">类目</view>
          <view class="ratio-value-head">数值</view>
          <view class="ratio-value-head">上年同期</view>
          <view class="ratio-value-head">上期</view>
        </view>
        <view v-for="category in ratio.categories || []" :key="category.name">
          <view class="ratio-category">
            <view class="ratio-bar"></view>
            <text>{{ category.name }}</text>
          </view>
          <view v-for="item in category.items || []" :key="item.key" class="table-row ratio-row">
            <view class="ratio-name">{{ item.name }}</view>
            <view class="ratio-value">{{ valueText(item.value, item.unit) }}</view>
            <view class="ratio-value">{{ valueText(item.yearAgo, item.unit) }}</view>
            <view class="ratio-value">{{ valueText(item.prevPeriod, item.unit) }}</view>
          </view>
        </view>
      </view>
    </view>
    <view v-else>
      <view class="statement-summary">
        <view v-for="(metric, index) in summaryMetrics" :key="index" class="summary-metric" :class="{ last: index === summaryMetrics.length - 1 }">
          <text class="metric-label">{{ metric.label }}</text>
          <view class="metric-value-line">
            <text class="metric-value money">{{ metric.value }}</text>
            <text class="metric-unit">{{ metric.unit }}</text>
          </view>
          <view v-if="metric.yoy !== undefined" class="metric-yoy">
            <text>同比 </text>
            <text :class="Number(metric.yoy) >= 0 ? 'up' : 'down'">{{ Number(metric.yoy) >= 0 ? '↑' : '↓' }}{{ formatNumber(Math.abs(Number(metric.yoy))) }}%</text>
          </view>
        </view>
      </view>
      <view class="data-update">数据已更新 北京时间：{{ period }}</view>

      <SectionTitle :title="sectionTitle" more="报表明细 ›" @more="openReport" />
      <view class="narrative">
        <text class="narrative-text" :class="{ collapsed: !narrativeOpen }">{{ narrative }}</text>
        <text class="narrative-expand" @click="narrativeOpen = !narrativeOpen">{{ narrativeOpen ? '收起⌃' : '展开⌄' }}</text>
      </view>

      <SectionTitle :title="active === 'balance' ? '预警' : '主要指标'" />
      <view v-if="active === 'balance'" class="no-alert">无预警数据</view>
      <view v-else class="metric-lines">
        <view v-for="(item, index) in secondaryMetrics" :key="index" class="metric-line">
          <text class="metric-line-name">{{ item.label }}</text>
          <text class="metric-line-value money">{{ item.display }}</text>
        </view>
      </view>

      <SectionTitle title="主要指标变动趋势" />
      <view class="chart-block">
        <LineChart
          v-if="chartLabels.length"
          :labels="chartLabels"
          :series="chartSeries"
          :height="310"
          unit="万元"
          :x-tick-count="4"
        />
        <view v-else class="placeholder">暂无趋势数据</view>
      </view>
    </view>
    <BottomNav active="analysis" />
  </view>
</template>

<script>
import AppHeader from './AppHeader.vue'
import FilterBar from './FilterBar.vue'
import TopTabs from './TopTabs.vue'
import BottomNav from './BottomNav.vue'
import SectionTitle from './SectionTitle.vue'
import LineChart from './LineChart.vue'
import { get } from '../common/request'

export default {
  components: { AppHeader, FilterBar, TopTabs, BottomNav, SectionTitle, LineChart },
  props: {
    initialTab: { type: String, default: 'balance' },
    back: { type: Boolean, default: false }
  },
  data() {
    return {
      active: this.initialTab,
      year: '2021',
      mode: 'year',
      loading: true,
      narrativeOpen: false,
      statement: {},
      annual: {},
      ratio: {},
      profitChart: {},
      cashChart: {},
      analysisProfit: {},
      analysisCash: {},
      tabs: [
        { key: 'balance', label: '资产负债表' },
        { key: 'profit', label: '利润表' },
        { key: 'cashflow', label: '现金流量表' },
        { key: 'ratio', label: '比率分析' }
      ]
    }
  },
  computed: {
    period() {
      return this.year + '12'
    },
    summaryMetrics() {
      if (this.active === 'balance') {
        return [
          { label: '资产总计', value: this.formatNumber(this.statement.assetTotal), unit: '万', yoy: this.statement.assetYoy },
          { label: '负债总计', value: this.formatNumber(this.statement.liabilityTotal), unit: '万', yoy: this.statement.liabilityYoy },
          { label: '所有者权益', value: this.formatNumber(this.statement.equityTotal), unit: '万', yoy: this.statement.equityYoy }
        ]
      }
      if (this.active === 'profit') {
        const items = this.annual.items || []
        const revenue = items.find(item => item.field === 'ZYYWSR') || {}
        const total = items.find(item => item.field === 'LRZE') || {}
        return [
          { label: '营业收入', value: this.formatNumber(revenue.value), unit: '万', yoy: revenue.yoy },
          { label: '利润总额', value: this.formatNumber(total.value), unit: '万', yoy: total.yoy },
          { label: '净利润', value: this.formatNumber(this.annual.netProfit), unit: '万', yoy: this.yoy(this.annual.netProfit, this.annual.previousNetProfit) }
        ]
      }
      const items = this.analysisCash.items || []
      return [
        { label: '经营现金流净额', value: this.formatNumber(this.toWan(this.itemValue(items, '经营现金流净额'))), unit: '万' },
        { label: '投资现金流净额', value: this.formatNumber(this.toWan(this.itemValue(items, '投资现金流净额'))), unit: '万' },
        { label: '筹资现金流净额', value: this.formatNumber(this.toWan(this.itemValue(items, '筹资现金流净额'))), unit: '万' }
      ]
    },
    sectionTitle() {
      if (this.active === 'profit') return '利润表'
      if (this.active === 'cashflow') return '现金流量表'
      return '概述'
    },
    narrative() {
      if (this.active === 'profit') {
        const items = this.annual.items || []
        const revenue = items.find(item => item.field === 'ZYYWSR') || {}
        const cost = items.find(item => item.field === 'ZYYWCB') || {}
        const profit = this.annual.netProfit || 0
        const previous = this.annual.previousNetProfit || 0
        const change = Number(profit) - Number(previous)
        return change < 0
          ? '本期净利润为Rmb' + this.formatNumber(profit) + '万元，比上年同期减少Rmb' + this.formatNumber(Math.abs(change)) + '万元。主要受营业成本由上年同期的Rmb' + this.formatNumber(cost.previous) + '万元增加至本期的Rmb' + this.formatNumber(cost.value) + '万元影响，建议结合成本结构、产品售价和期间费用进一步分析。'
          : '本期净利润为Rmb' + this.formatNumber(profit) + '万元，营业收入为Rmb' + this.formatNumber(revenue.value) + '万元，经营成果较上年同期改善。建议继续关注收入质量、成本费用和现金流匹配情况。'
      }
      if (this.active === 'cashflow') {
        return '本期现金及现金等价物净增加额受经营、投资和筹资活动共同影响。建议重点关注经营活动现金净流量与营业收入的匹配程度，并结合回款周期和付款安排做好资金计划。'
      }
      return this.statement.narrative || '暂无本期财务报告。'
    },
    secondaryMetrics() {
      if (this.active === 'profit') {
        return (this.annual.items || [])
          .filter(item => ['ZYYWSR', 'ZYYWCB', 'ZYYWSJJFJ', 'XSFY', 'GLFY', 'CWFY', 'YYLR', 'LRZE'].indexOf(item.field) >= 0)
          .map(item => ({ label: item.name, display: this.formatNumber(item.value) + ' 万' }))
      }
      return (this.analysisCash.items || []).map(item => ({
        label: item.name,
        display: this.formatNumber(this.toWan(item.value)) + ' 万'
      }))
    },
    chartLabels() {
      if (this.active === 'balance') {
        return (this.statement.trend || [])
          .filter(item => String(item.period).indexOf(this.year) === 0)
          .map(item => item.period)
      }
      if (this.active === 'profit') return this.profitChart.periods || []
      return this.cashChart.periods || []
    },
    chartSeries() {
      if (this.active === 'balance') {
        const rows = (this.statement.trend || []).filter(item => String(item.period).indexOf(this.year) === 0)
        return [
          { name: '总资产', values: rows.map(item => this.toWan(item.assets)) },
          { name: '负债', values: rows.map(item => this.toWan(item.liabilities)) },
          { name: '所有者权益', values: rows.map(item => this.toWan(item.equity)) }
        ]
      }
      return (this.active === 'profit' ? this.profitChart.series : this.cashChart.series) || []
    }
  },
  mounted() {
    this.loadAll()
  },
  methods: {
    async loadAll() {
      this.loading = true
      const period = this.period
      const year = this.year
      try {
        const results = await Promise.all([
          get('/api/finance/statement-overview', { period }),
          get('/api/finance/annual-profit', { year }),
          get('/api/analysis/ratio-comparison', { period }),
          get('/api/analysis/profit/chart'),
          get('/api/analysis/cashflow/chart'),
          get('/api/analysis/profit', { period }),
          get('/api/analysis/cashflow', { period })
        ])
        this.statement = results[0] || {}
        this.annual = results[1] || {}
        this.ratio = results[2] || {}
        this.profitChart = results[3] || {}
        this.cashChart = results[4] || {}
        this.analysisProfit = results[5] || {}
        this.analysisCash = results[6] || {}
      } catch (error) {
        this.statement = {}
        this.annual = {}
        this.ratio = {}
      } finally {
        this.loading = false
      }
    },
    changeYear(year) {
      this.year = year
      this.loadAll()
    },
    changeTab(tab) {
      this.active = tab
      this.narrativeOpen = false
    },
    openReport() {
      if (this.active === 'balance') uni.navigateTo({ url: '/pages/reports/balance?year=' + this.year })
      else if (this.active === 'profit') uni.navigateTo({ url: '/pages/reports/profit?year=' + this.year })
      else if (this.active === 'cashflow') uni.navigateTo({ url: '/pages/reports/cashflow?year=' + this.year })
    },
    formatNumber(value) {
      return Number(value || 0).toFixed(2)
    },
    valueText(value, unit) {
      if (value === null || value === undefined || value === '') return '--'
      const number = Number(value)
      const text = number.toFixed(2)
      if (unit === '%') return text + '%'
      if (unit === '万元') return text + ' 万'
      return text
    },
    yoy(current, previous) {
      const now = Number(current || 0)
      const before = Number(previous || 0)
      return before === 0 ? 0 : (now - before) / Math.abs(before) * 100
    },
    toWan(value) {
      return Number(value || 0) / 10000
    },
    itemValue(items, name) {
      const item = (items || []).find(row => row.name === name)
      return item ? item.value : 0
    }
  }
}
</script>

<style>
.statement-page {
  background: #ffffff;
}

.statement-summary {
  min-height: 238rpx;
  padding: 24rpx 8rpx 20rpx;
  display: flex;
  align-items: flex-start;
  background: #ffffff;
}

.summary-metric {
  flex: 1;
  min-width: 0;
  padding: 0 14rpx 0 22rpx;
  border-right: 1rpx solid #f0f0f0;
}

.summary-metric.last {
  border-right: none;
}

.metric-label {
  display: block;
  color: #666666;
  font-size: 26rpx;
  line-height: 34rpx;
  white-space: nowrap;
}

.metric-value-line {
  margin-top: 12rpx;
  display: flex;
  align-items: baseline;
  white-space: nowrap;
}

.metric-value {
  font-size: 33rpx;
  font-weight: 500;
  color: #303133;
}

.metric-unit {
  margin-left: 2rpx;
  font-size: 24rpx;
  color: #303133;
}

.metric-yoy {
  margin-top: 10rpx;
  color: #303133;
  font-size: 24rpx;
  white-space: nowrap;
}

.metric-yoy .up {
  color: #ff0000;
}

.metric-yoy .down {
  color: #00a65a;
}

.data-update {
  height: 48rpx;
  padding: 0 24rpx;
  line-height: 38rpx;
  color: #999999;
  font-size: 22rpx;
  border-bottom: 1rpx solid #eeeeee;
}

.narrative {
  position: relative;
  min-height: 214rpx;
  padding: 24rpx 24rpx 28rpx;
  background: #ffffff;
}

.narrative-text {
  font-size: 26rpx;
  line-height: 40rpx;
  color: #303133;
  word-break: break-all;
}

.narrative-text.collapsed {
  display: -webkit-box;
  -webkit-line-clamp: 4;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.narrative-expand {
  position: absolute;
  right: 24rpx;
  bottom: 22rpx;
  padding-left: 12rpx;
  background: #ffffff;
  font-size: 24rpx;
  line-height: 40rpx;
  color: #666666;
}

.no-alert {
  min-height: 94rpx;
  padding: 24rpx;
  color: #666666;
  font-size: 26rpx;
  background: #ffffff;
}

.metric-lines {
  padding: 4rpx 24rpx 14rpx;
  background: #ffffff;
}

.metric-line {
  height: 62rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1rpx solid #f0f0f0;
}

.metric-line:last-child {
  border-bottom: none;
}

.metric-line-name {
  font-size: 25rpx;
  color: #555555;
}

.metric-line-value {
  font-size: 25rpx;
  color: #303133;
}

.chart-block {
  padding: 18rpx 20rpx 12rpx;
  background: #ffffff;
}

.ratio-table {
  padding-top: 0;
}

.ratio-head {
  height: 76rpx;
  font-size: 24rpx;
}

.ratio-name-head {
  width: 44%;
  text-align: center;
}

.ratio-value-head {
  width: 16%;
  text-align: center;
}

.ratio-value-head:nth-child(2) {
  width: 23%;
}

.ratio-value-head:last-child {
  width: 17%;
}

.ratio-category {
  height: 66rpx;
  padding-left: 18rpx;
  display: flex;
  align-items: center;
  color: #303133;
  font-size: 26rpx;
  background: #ffffff;
}

.ratio-bar {
  width: 8rpx;
  height: 28rpx;
  margin-right: 10rpx;
  background: #3bbfe7;
}

.ratio-row {
  min-height: 66rpx;
  font-size: 26rpx;
}

.ratio-name {
  width: 44%;
  padding-left: 48rpx;
  color: #303133;
}

.ratio-value {
  width: 16%;
  text-align: center;
  color: #303133;
  font-family: "DIN Alternate", "Arial Narrow", Arial, sans-serif;
  font-size: 25rpx;
}

.ratio-value:nth-child(2) {
  width: 23%;
}

.ratio-value:nth-child(4) {
  width: 17%;
}
</style>
