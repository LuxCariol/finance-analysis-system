<template>
  <view class="bars">
    <view v-for="(item, index) in normalized" :key="index" class="bar-row">
      <view class="bar-label">{{ item.label }}</view>
      <view class="bar-track">
        <view class="bar-fill" :style="{ width: item.width + '%', background: colors[index % colors.length] }"></view>
      </view>
      <view class="bar-value">{{ item.display }}</view>
    </view>
  </view>
</template>

<script>
import { COLORS } from '../common/config'
import { compactMoney } from '../common/format'

export default {
  props: {
    items: { type: Array, default: () => [] },
    percentMode: Boolean
  },
  data() {
    return { colors: COLORS }
  },
  computed: {
    normalized() {
      const values = this.items.map(item => Math.abs(Number(item.value || 0)))
      const max = Math.max(...values, 1)
      return this.items.map(item => ({
        label: item.label || item.name,
        width: Math.max(3, Math.abs(Number(item.value || 0)) / max * 100),
        display: this.percentMode ? Number(item.value || 0).toFixed(1) + '%' : compactMoney(item.value)
      }))
    }
  }
}
</script>

<style>
.bars { padding: 4rpx 0; }
.bar-row { display: flex; align-items: center; margin-bottom: 22rpx; }
.bar-label { width: 150rpx; color: #667386; font-size: 23rpx; overflow: hidden; white-space: nowrap; }
.bar-track { flex: 1; height: 18rpx; background: #f0f3f7; border-radius: 999rpx; overflow: hidden; }
.bar-fill { height: 100%; border-radius: 999rpx; transition: width 0.4s ease; }
.bar-value { width: 132rpx; text-align: right; color: #24324a; font-size: 23rpx; font-weight: 600; }
</style>
