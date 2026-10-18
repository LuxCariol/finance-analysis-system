<template>
  <view class="page">
    <AppHeader title="资产负债分析" :subtitle="periodText(data.period)" eyebrow="BALANCE ANALYSIS" back compact />
    <view class="card">
      <view class="row"><text class="card-title">资产与负债结构</text><text class="pill">单位：元</text></view>
      <BarChart :items="chartItems" />
    </view>
    <view class="section-title">重点项目</view>
    <view class="card">
      <view v-for="(item, index) in data.items || []" :key="index" class="item">
        <text class="name">{{ item.name }}</text>
        <text class="value money">{{ compactMoney(item.value) }}</text>
      </view>
    </view>
    <view class="card insight">
      <text class="insight-title">分析提示</text>
      <text class="insight-text">关注流动资产对流动负债的覆盖能力，以及应收账款和存货占用资金的变化。若负债率持续上升，应同步关注利息保障倍数和融资期限结构。</text>
    </view>
  </view>
</template>
<script>
import AppHeader from '../../components/AppHeader.vue'
import BarChart from '../../components/BarChart.vue'
import { get } from '../../common/request'
import { compactMoney, periodText } from '../../common/format'
export default {
  components: { AppHeader, BarChart },
  data() { return { data: {}, periodText } },
  computed: { chartItems() { return (this.data.chart || []).map(item => ({ label: item.name, value: item.value })) } },
  onLoad() { this.load() },
  methods: {
    compactMoney,
    async load() { try { this.data = await get('/api/analysis/balance') } catch (e) { this.data = {} } }
  }
}
</script>
<style>
.card-title { font-size: 29rpx; font-weight: 600; color: #22314a; }
.item { display: flex; justify-content: space-between; padding: 19rpx 0; border-bottom: 1rpx solid #f0f2f5; }
.item:last-child { border-bottom: none; }
.name { color: #6d7a8d; font-size: 24rpx; }
.value { color: #24324a; font-size: 25rpx; }
.insight { background: #f3f8f7; }
.insight-title { font-size: 26rpx; color: #0d7c78; font-weight: 600; }
.insight-text { display: block; margin-top: 12rpx; color: #617282; font-size: 22rpx; line-height: 1.7; }
</style>
