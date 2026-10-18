<template>
  <view class="page">
    <AppHeader title="比率分析" :subtitle="'报告期 ' + periodText(data.period)" eyebrow="RATIO ANALYSIS" back compact />
    <view class="score-card card">
      <view>
        <text class="score-label">综合财务健康分</text>
        <text class="score-num">{{ data.healthScore || '--' }}</text>
      </view>
      <view class="score-track"><view class="score-fill" :style="{ width: (data.healthScore || 0) + '%' }"></view></view>
    </view>

    <view v-for="(category, key) in data.categories || {}" :key="key" class="category card">
      <view class="category-head">
        <text class="category-name">{{ category.name }}</text>
        <text class="category-count">{{ (category.items || []).length }} 项</text>
      </view>
      <view v-for="(item, index) in category.items || []" :key="index" class="ratio-item">
        <view class="ratio-main">
          <view class="row">
            <text class="ratio-name">{{ item.name }}</text>
            <text class="pill" :class="item.status === 'watch' ? 'warn' : item.status === 'risk' ? 'risk' : ''">
              {{ statusText(item.status) }}
            </text>
          </view>
          <text class="formula">{{ item.formula }}</text>
          <text class="benchmark">参考：{{ item.benchmark }}</text>
        </view>
        <view class="ratio-value">
          <text class="num">{{ item.value }}</text>
          <text class="unit">{{ item.unit }}</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import AppHeader from '../../components/AppHeader.vue'
import { get } from '../../common/request'
import { periodText, statusText } from '../../common/format'

export default {
  components: { AppHeader },
  data() { return { data: {}, periodText, statusText } },
  onLoad() { this.load() },
  methods: {
    async load() { try { this.data = await get('/api/analysis/ratio') } catch (e) { this.data = {} } }
  }
}
</script>

<style>
.score-card { background: linear-gradient(130deg, #172b49, #1c4a5d); color: #fff; }
.score-label { font-size: 23rpx; color: rgba(255,255,255,0.6); }
.score-num { display: block; margin-top: 6rpx; font-family: "DIN Alternate", sans-serif; font-size: 68rpx; font-weight: 700; }
.score-track { margin-top: 18rpx; height: 12rpx; background: rgba(255,255,255,0.14); border-radius: 999rpx; overflow: hidden; }
.score-fill { height: 100%; background: linear-gradient(90deg, #d8a03d, #20b6ad); border-radius: 999rpx; }
.category-head { display: flex; justify-content: space-between; align-items: center; padding-bottom: 18rpx; border-bottom: 1rpx solid #eef1f5; }
.category-name { font-size: 29rpx; font-weight: 600; color: #22314a; }
.category-count { font-size: 21rpx; color: #99a3b1; }
.ratio-item { display: flex; align-items: center; padding: 22rpx 0; border-bottom: 1rpx solid #f1f3f6; }
.ratio-item:last-child { border-bottom: none; }
.ratio-main { flex: 1; }
.ratio-name { color: #2a3951; font-size: 25rpx; font-weight: 500; }
.formula { display: block; margin-top: 8rpx; color: #909baa; font-size: 19rpx; }
.benchmark { display: block; margin-top: 4rpx; color: #a8b0bc; font-size: 19rpx; }
.ratio-value { width: 150rpx; text-align: right; }
.num { font-family: "DIN Alternate", sans-serif; color: #182842; font-size: 36rpx; font-weight: 700; }
.unit { margin-left: 4rpx; color: #8e99a9; font-size: 19rpx; }
</style>
