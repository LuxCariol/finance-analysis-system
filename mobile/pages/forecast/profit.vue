<template>
  <view class="page">
    <AppHeader title="损益表预测" subtitle="基于历史趋势的滚动预测" eyebrow="PROFIT FORECAST">
      <template #right>
        <view class="news-btn" @click="goInvestment">投资预测</view>
      </template>
    </AppHeader>

    <view class="card control">
      <view class="control-row">
        <text class="label">预测月数</text>
        <view class="stepper">
          <view class="step" @click="changeMonths(-1)">−</view>
          <text>{{ months }}</text>
          <view class="step" @click="changeMonths(1)">＋</view>
        </view>
      </view>
      <view class="control-row">
        <text class="label">增长调整幅度</text>
        <view class="growth">
          <input v-model="growth" type="digit" class="growth-input" />
          <text>%</text>
        </view>
      </view>
      <view class="btn-primary" @click="runForecast">{{ loading ? '计算中…' : '生成预测' }}</view>
    </view>

    <view v-if="data.forecast" class="card">
      <view class="row">
        <text class="card-title">收入趋势与预测</text>
        <text class="pill">{{ data.confidence }}置信度</text>
      </view>
      <LineChart :labels="chartLabels" :series="chartSeries" />
    </view>

    <view v-if="data.forecast" class="card">
      <view class="row period-row">
        <text class="muted">期间</text><text class="muted">收入</text><text class="muted">净利润</text>
      </view>
      <view v-for="(row, index) in data.forecast" :key="index" class="period-row">
        <text>{{ periodText(row.period) }}</text>
        <text class="money">{{ compactMoney(row.revenue) }}</text>
        <text class="money">{{ compactMoney(row.netProfit) }}</text>
      </view>
    </view>

    <view class="card method" v-if="data.method">
      <text class="method-title">预测方法</text>
      <text class="method-text">{{ data.method }}。{{ data.note }}</text>
    </view>

    <view class="card invest-entry" @click="goInvestment">
      <view>
        <text class="invest-title">资本投资测算</text>
        <text class="invest-sub">计算 NPV、IRR、回收期与全资本现金流</text>
      </view>
      <text class="invest-arrow">›</text>
    </view>
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import LineChart from '../../components/LineChart.vue'
import { get } from '../../common/request'
import { compactMoney, periodText } from '../../common/format'

export default {
  components: { AppHeader, LineChart },
  data() {
    return { months: 6, growth: 0, data: {}, loading: false, periodText, compactMoney }
  },
  computed: {
    chartLabels() {
      return [...(this.data.historyPeriods || []), ...(this.data.forecastPeriods || [])]
    },
    chartSeries() {
      return [{
        name: '营业收入',
        values: [...(this.data.historyRevenue || []), ...(this.data.forecastRevenue || [])]
      }]
    }
  },
  onShow() { this.runForecast() },
  methods: {
    changeMonths(delta) {
      this.months = Math.max(1, Math.min(12, this.months + delta))
    },
    async runForecast() {
      this.loading = true
      try {
        this.data = await get('/api/forecast/profit', { months: this.months, growthAdjustment: this.growth })
      } catch (e) {
        this.data = {}
      } finally {
        this.loading = false
      }
    },
    goInvestment() { uni.navigateTo({ url: '/pages/investment/index' }) }
  }
}
</script>

<style>
.news-btn { padding: 8rpx 20rpx; border: 1rpx solid rgba(255,255,255,0.3); border-radius: 999rpx; font-size: 22rpx; color: rgba(255,255,255,0.85); }
.control-row { display: flex; align-items: center; justify-content: space-between; padding: 12rpx 0 24rpx; }
.label { font-size: 25rpx; color: #607086; }
.stepper { display: flex; align-items: center; background: #f2f5f9; border-radius: 14rpx; padding: 4rpx; }
.step { width: 56rpx; height: 52rpx; line-height: 52rpx; text-align: center; color: #0d7c78; font-size: 30rpx; background: #fff; border-radius: 11rpx; }
.stepper text { width: 64rpx; text-align: center; font-size: 25rpx; font-weight: 600; }
.growth { display: flex; align-items: center; color: #6b788b; font-size: 24rpx; }
.growth-input { width: 110rpx; height: 58rpx; line-height: 58rpx; text-align: right; border-bottom: 1rpx solid #d8e0e8; margin-right: 8rpx; color: #1e2c43; }
.card-title { font-size: 29rpx; font-weight: 600; color: #22314a; }
.period-row { display: flex; justify-content: space-between; align-items: center; padding: 18rpx 0; border-bottom: 1rpx solid #f1f3f6; font-size: 22rpx; color: #56657a; }
.period-row text { flex: 1; }
.period-row text:nth-child(2), .period-row text:nth-child(3) { text-align: right; }
.period-row:last-child { border-bottom: none; }
.method { background: #f4f8f7; }
.method-title { font-size: 25rpx; color: #0d7c78; font-weight: 600; }
.method-text { display: block; margin-top: 10rpx; color: #647383; font-size: 21rpx; line-height: 1.65; }
.invest-entry { display: flex; justify-content: space-between; align-items: center; background: linear-gradient(120deg, #fff, #f8f0df); }
.invest-title { font-size: 28rpx; font-weight: 600; color: #24324a; }
.invest-sub { display: block; margin-top: 8rpx; color: #8a96a7; font-size: 21rpx; }
.invest-arrow { font-size: 44rpx; color: #c9a45d; }
</style>
