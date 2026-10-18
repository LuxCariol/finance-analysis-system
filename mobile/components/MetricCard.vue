<template>
  <view class="metric-card" :class="tone">
    <text class="metric-label">{{ label }}</text>
    <view class="metric-value">
      <text class="metric-number">{{ value }}</text>
      <text class="metric-unit">{{ unit }}</text>
    </view>
    <text v-if="hint" class="metric-hint">{{ hint }}</text>
  </view>
</template>

<script>
export default {
  props: {
    label: String,
    value: [String, Number],
    unit: { type: String, default: '元' },
    hint: String,
    tone: { type: String, default: 'navy' }
  }
}
</script>

<style>
.metric-card {
  min-height: 150rpx;
  padding: 26rpx;
  border-radius: 22rpx;
  background: #fff;
  box-sizing: border-box;
  position: relative;
  overflow: hidden;
}

.metric-card::after {
  content: '';
  position: absolute;
  right: -34rpx;
  bottom: -48rpx;
  width: 130rpx;
  height: 130rpx;
  border-radius: 50%;
  background: rgba(13, 124, 120, 0.07);
}

.metric-card.teal::after { background: rgba(13, 124, 120, 0.1); }
.metric-card.gold::after { background: rgba(216, 160, 61, 0.13); }
.metric-card.red::after { background: rgba(194, 72, 72, 0.1); }

.metric-label {
  display: block;
  color: #7b8798;
  font-size: 23rpx;
}

.metric-value {
  margin-top: 16rpx;
  display: flex;
  align-items: baseline;
}

.metric-number {
  font-family: "DIN Alternate", "Arial Narrow", sans-serif;
  font-size: 36rpx;
  font-weight: 700;
  color: #15243b;
}

.metric-unit {
  margin-left: 8rpx;
  font-size: 20rpx;
  color: #8b96a6;
}

.metric-hint {
  display: block;
  margin-top: 12rpx;
  color: #0d7c78;
  font-size: 21rpx;
}
</style>
