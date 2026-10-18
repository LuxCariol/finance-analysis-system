<template>
  <view class="page">
    <AppHeader title="现金流量表明细" :subtitle="periodText(data.period)" eyebrow="CASH FLOW" back compact />
    <view class="card summary">
      <view class="row">
        <text class="muted">报表项目</text>
        <text class="pill">{{ (data.items || []).length }} 项</text>
      </view>
      <text class="summary-text">按经营、投资和筹资活动展示现金流入流出，点击项目查看月度趋势。</text>
    </view>
    <view class="card"><ReportItems :items="data.items || []" @select="openDetail" /></view>
  </view>
</template>
<script>
import AppHeader from '../../components/AppHeader.vue'
import ReportItems from '../../components/ReportItems.vue'
import { get } from '../../common/request'
import { periodText } from '../../common/format'
export default {
  components: { AppHeader, ReportItems },
  data() { return { data: {}, periodText } },
  onLoad() { this.load() },
  methods: {
    async load() { try { this.data = await get('/api/report/cashflow') } catch (e) { this.data = {} } },
    openDetail(item) {
      const code = item.CODE_NO || item.codeNo
      if (code) uni.navigateTo({ url: '/pages/finance/detail?code=' + encodeURIComponent(code) })
    }
  }
}
</script>
<style>
.summary { background: linear-gradient(130deg, #fff, #edf3fb); }
.summary-text { display: block; margin-top: 14rpx; color: #6b788b; font-size: 22rpx; line-height: 1.6; }
</style>
