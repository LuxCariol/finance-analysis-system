<template>
  <view class="page home-page">
    <AppHeader :title="org.orgName || '企业经营报告'" :subtitle="'报告期 ' + periodText(data.period)" eyebrow="BUSINESS REVIEW">
      <template #right>
        <view class="news-btn" @click="go('/pages/news/list')">资讯</view>
      </template>
    </AppHeader>

    <view v-if="loading" class="loading">正在生成经营报告…</view>
    <view v-else-if="data.metrics">
      <view class="hero card">
        <view class="score-ring" :style="ringStyle">
          <view class="score-inner">
            <text class="score-number">{{ data.healthScore }}</text>
            <text class="score-label">财务健康分</text>
          </view>
        </view>
        <view class="hero-copy">
          <text class="hero-title">本期经营概览</text>
          <text class="hero-text">{{ data.summary }}</text>
          <view class="tag-row">
            <text class="pill">数据已更新</text>
            <text class="pill" :class="riskClass">{{ riskText }}</text>
          </view>
        </view>
      </view>

      <view class="metric-grid">
        <MetricCard label="营业收入" :value="compactMoney(metrics.revenue)" unit="元" tone="teal" />
        <MetricCard label="净利润" :value="compactMoney(metrics.netProfit)" unit="元" tone="gold" />
        <MetricCard label="资产总额" :value="compactMoney(metrics.totalAssets)" unit="元" />
        <MetricCard label="经营现金净额" :value="compactMoney(metrics.operatingCash)" unit="元"
          :tone="Number(metrics.operatingCash) >= 0 ? 'teal' : 'red'" />
      </view>

      <view class="quick-grid">
        <view class="quick-card" @click="go('/pages/reports/profit')">
          <text class="quick-icon">P</text>
          <text class="quick-title">利润表</text>
          <text class="quick-sub">收入与利润明细</text>
        </view>
        <view class="quick-card" @click="go('/pages/reports/balance')">
          <text class="quick-icon">B</text>
          <text class="quick-title">资产负债表</text>
          <text class="quick-sub">资产负债结构</text>
        </view>
        <view class="quick-card" @click="go('/pages/reports/cashflow')">
          <text class="quick-icon">C</text>
          <text class="quick-title">现金流量表</text>
          <text class="quick-sub">经营投资筹资</text>
        </view>
        <view class="quick-card" @click="go('/pages/investment/index')">
          <text class="quick-icon">I</text>
          <text class="quick-title">投资预测</text>
          <text class="quick-sub">NPV 与 IRR</text>
        </view>
      </view>

      <view class="section-title">风险与建议</view>
      <view class="card alert-list">
        <view v-for="(alert, index) in data.alerts" :key="index" class="alert-item">
          <view class="alert-dot" :class="alert.level"></view>
          <view class="alert-body">
            <view class="row">
              <text class="alert-title">{{ alert.title }}</text>
              <text class="alert-value">{{ alert.value }}</text>
            </view>
            <text class="alert-text">{{ alert.suggestion }}</text>
          </view>
        </view>
      </view>

      <view class="section-title">经营建议</view>
      <view class="card suggestion-list">
        <view v-for="(item, index) in data.suggestions" :key="index" class="suggestion">
          <text class="index">{{ String(index + 1).padStart(2, '0') }}</text>
          <text class="text">{{ item }}</text>
        </view>
      </view>
    </view>
    <EmptyState v-else title="暂无经营报告" desc="请先在后台导入三大报表数据" />
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import MetricCard from '../../components/MetricCard.vue'
import EmptyState from '../../components/EmptyState.vue'
import { get } from '../../common/request'
import { compactMoney, periodText } from '../../common/format'

export default {
  components: { AppHeader, MetricCard, EmptyState },
  data() {
    return {
      loading: true,
      data: {},
      org: {},
      periodText
    }
  },
  computed: {
    metrics() {
      return this.data.metrics || {}
    },
    ringStyle() {
      const score = Number(this.data.healthScore || 0)
      return {
        background: `conic-gradient(#20b6ad ${score * 3.6}deg, rgba(255,255,255,0.12) 0deg)`
      }
    },
    riskClass() {
      return Number(this.data.healthScore || 0) >= 75 ? '' : Number(this.data.healthScore || 0) >= 60 ? 'warn' : 'risk'
    },
    riskText() {
      return Number(this.data.healthScore || 0) >= 75 ? '整体稳健' : Number(this.data.healthScore || 0) >= 60 ? '需要关注' : '存在风险'
    }
  },
  onShow() {
    this.load()
  },
  methods: {
    compactMoney,
    async load() {
      this.loading = true
      try {
        this.data = await get('/api/home/report')
        this.org = this.data.metrics.org || {}
      } catch (error) {
        this.data = {}
      } finally {
        this.loading = false
      }
    },
    go(url) {
      uni.navigateTo({ url })
    }
  }
}
</script>

<style>
.news-btn { padding: 8rpx 20rpx; border: 1rpx solid rgba(255,255,255,0.3); border-radius: 999rpx; font-size: 22rpx; color: rgba(255,255,255,0.85); }
.loading { text-align: center; padding: 100rpx 0; color: #8b96a6; font-size: 25rpx; }
.hero { display: flex; align-items: center; background: linear-gradient(130deg, #172b49, #1b425e); color: #fff; }
.score-ring { width: 160rpx; height: 160rpx; border-radius: 50%; padding: 12rpx; box-sizing: border-box; flex-shrink: 0; }
.score-inner { width: 100%; height: 100%; border-radius: 50%; background: #172b49; display: flex; flex-direction: column; align-items: center; justify-content: center; }
.score-number { font-family: "DIN Alternate", sans-serif; font-size: 44rpx; font-weight: 700; }
.score-label { margin-top: 2rpx; font-size: 18rpx; color: rgba(255,255,255,0.55); }
.hero-copy { margin-left: 26rpx; flex: 1; }
.hero-title { font-size: 30rpx; font-weight: 600; }
.hero-text { display: block; margin-top: 12rpx; font-size: 22rpx; line-height: 1.65; color: rgba(255,255,255,0.65); }
.tag-row { margin-top: 16rpx; }
.tag-row .pill { margin-right: 10rpx; background: rgba(255,255,255,0.12); color: rgba(255,255,255,0.82); }
.tag-row .pill.warn { background: rgba(216,160,61,0.22); color: #f1c777; }
.tag-row .pill.risk { background: rgba(194,72,72,0.25); color: #f09a9a; }
.metric-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18rpx; }
.quick-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18rpx; margin-top: 24rpx; }
.quick-card { background: #fff; border-radius: 22rpx; padding: 24rpx; display: flex; flex-direction: column; box-shadow: 0 10rpx 26rpx rgba(18,35,63,0.06); }
.quick-icon { width: 52rpx; height: 52rpx; line-height: 52rpx; text-align: center; border-radius: 14rpx; background: #e8f5f4; color: #0d7c78; font-weight: 700; font-size: 23rpx; }
.quick-title { margin-top: 16rpx; font-size: 27rpx; font-weight: 600; color: #22314a; }
.quick-sub { margin-top: 6rpx; font-size: 20rpx; color: #9aa5b4; }
.alert-list { padding-top: 6rpx; padding-bottom: 6rpx; }
.alert-item { display: flex; padding: 20rpx 0; border-bottom: 1rpx solid #f0f2f5; }
.alert-item:last-child { border-bottom: none; }
.alert-dot { width: 12rpx; height: 12rpx; border-radius: 50%; background: #d8a03d; margin: 9rpx 16rpx 0 0; flex-shrink: 0; }
.alert-dot.high { background: #c85b54; }
.alert-dot.info { background: #0d7c78; }
.alert-body { flex: 1; }
.alert-title { font-size: 25rpx; color: #24324a; font-weight: 600; }
.alert-value { font-size: 22rpx; color: #8b96a6; }
.alert-text { display: block; margin-top: 8rpx; font-size: 21rpx; line-height: 1.6; color: #7b8798; }
.suggestion { display: flex; padding: 18rpx 0; border-bottom: 1rpx solid #f0f2f5; }
.suggestion:last-child { border-bottom: none; }
.index { width: 54rpx; color: #d8a03d; font-family: "DIN Alternate", sans-serif; font-size: 24rpx; font-weight: 700; }
.text { flex: 1; color: #5c6a7f; font-size: 22rpx; line-height: 1.65; }
</style>
