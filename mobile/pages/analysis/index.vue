<template>
  <view class="page">
    <AppHeader title="财务分析" :subtitle="'报告期 ' + periodText(data.period)" eyebrow="FINANCIAL ANALYSIS">
      <template #right>
        <view class="score">{{ data.overview ? data.overview.healthScore : '--' }}<text>分</text></view>
      </template>
    </AppHeader>

    <view class="overview card">
      <text class="overview-title">多维度经营诊断</text>
      <text class="overview-text">从资产负债、利润、现金流和财务比率四个维度识别经营变化，辅助管理层制定下一步计划。</text>
      <view class="ratio-tags">
        <text class="pill">偿债</text>
        <text class="pill">盈利</text>
        <text class="pill">营运</text>
        <text class="pill">现金流</text>
      </view>
    </view>

    <view class="analysis-grid">
      <view class="analysis-card" v-for="(section, index) in data.sections || []" :key="section.key" @click="open(section)">
        <view class="icon" :class="'tone-' + index">{{ index === 0 ? 'B' : index === 1 ? 'P' : index === 2 ? 'C' : 'R' }}</view>
        <text class="name">{{ section.title }}</text>
        <text class="sub">{{ section.subtitle }}</text>
        <text class="arrow">查看分析 ›</text>
      </view>
    </view>

    <view class="section-title">关键指标</view>
    <view class="card metrics">
      <view class="metric-row" v-for="(item, index) in keyMetrics" :key="index">
        <text class="metric-label">{{ item.label }}</text>
        <text class="metric-value money">{{ item.value }}</text>
      </view>
    </view>

    <view class="card ageing" @click="openAging">
      <view>
        <text class="age-title">账龄分析</text>
        <text class="age-sub">查看应收、应付及其他往来款的账龄结构</text>
      </view>
      <text class="age-arrow">›</text>
    </view>
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import { get } from '../../common/request'
import { compactMoney, periodText } from '../../common/format'

export default {
  components: { AppHeader },
  data() { return { data: {}, periodText } },
  computed: {
    keyMetrics() {
      const o = this.data.overview || {}
      return [
        { label: '营业收入', value: compactMoney(o.revenue) + ' 元' },
        { label: '净利润', value: compactMoney(o.netProfit) + ' 元' },
        { label: '资产总额', value: compactMoney(o.totalAssets) + ' 元' },
        { label: '资产负债率', value: this.ratio('debtRatio') + '%' }
      ]
    }
  },
  onShow() { this.load() },
  methods: {
    async load() { try { this.data = await get('/api/analysis/home') } catch (e) { this.data = {} } },
    ratio(key) {
      const categories = (this.data.overview || {}).ratios || {}
      for (const name in categories) {
        const item = (categories[name].items || []).find(value => value.key === key)
        if (item) return item.value
      }
      return '--'
    },
    open(section) {
      if (section.key === 'ratio') uni.navigateTo({ url: '/pages/analysis/ratio' })
      else uni.navigateTo({ url: '/pages/analysis/' + section.key })
    },
    openAging() { uni.navigateTo({ url: '/pages/finance/detail?type=aging' }) }
  }
}
</script>

<style>
.score { font-family: "DIN Alternate", sans-serif; font-size: 42rpx; font-weight: 700; }
.score text { font-size: 20rpx; margin-left: 4rpx; opacity: 0.6; }
.overview { background: linear-gradient(130deg, #182e4d, #1e4960); color: #fff; }
.overview-title { font-size: 30rpx; font-weight: 600; }
.overview-text { display: block; margin-top: 14rpx; font-size: 22rpx; line-height: 1.7; color: rgba(255,255,255,0.65); }
.ratio-tags { margin-top: 22rpx; }
.ratio-tags .pill { margin-right: 12rpx; background: rgba(255,255,255,0.12); color: rgba(255,255,255,0.82); }
.analysis-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18rpx; }
.analysis-card { background: #fff; border-radius: 24rpx; padding: 26rpx; display: flex; flex-direction: column; box-shadow: 0 10rpx 26rpx rgba(18,35,63,0.06); }
.icon { width: 56rpx; height: 56rpx; line-height: 56rpx; border-radius: 16rpx; text-align: center; font-weight: 700; font-size: 22rpx; background: #e8f5f4; color: #0d7c78; }
.tone-1 { background: #fbf2df; color: #b97d19; }
.tone-2 { background: #eaf0fa; color: #4569a8; }
.tone-3 { background: #f8ebeb; color: #c25b55; }
.name { margin-top: 20rpx; font-size: 28rpx; font-weight: 600; color: #22314a; }
.sub { margin-top: 8rpx; font-size: 21rpx; line-height: 1.5; color: #8e99a9; }
.arrow { margin-top: 20rpx; font-size: 21rpx; color: #0d7c78; }
.metric-row { display: flex; justify-content: space-between; padding: 20rpx 0; border-bottom: 1rpx solid #f0f2f5; }
.metric-row:last-child { border-bottom: none; }
.metric-label { color: #7c889a; font-size: 23rpx; }
.metric-value { color: #233149; font-size: 25rpx; }
.ageing { display: flex; align-items: center; justify-content: space-between; background: linear-gradient(120deg, #fff, #f8f0de); }
.age-title { font-size: 28rpx; font-weight: 600; color: #24324a; }
.age-sub { display: block; margin-top: 8rpx; font-size: 21rpx; color: #8c96a6; }
.age-arrow { font-size: 44rpx; color: #c9a45d; }
</style>
