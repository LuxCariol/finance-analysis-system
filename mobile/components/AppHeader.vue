<template>
  <view class="header" :class="{ compact }">
    <view class="header-glow"></view>
    <view class="header-row">
      <view v-if="back" class="back" @click="goBack">‹</view>
      <view class="titles">
        <text class="eyebrow">{{ eyebrow }}</text>
        <text class="title">{{ title }}</text>
        <text v-if="subtitle" class="subtitle">{{ subtitle }}</text>
      </view>
      <view class="right"><slot name="right"></slot></view>
    </view>
  </view>
</template>

<script>
export default {
  props: {
    title: String,
    subtitle: String,
    eyebrow: { type: String, default: 'FINANCIAL INSIGHT' },
    back: Boolean,
    compact: Boolean
  },
  methods: {
    goBack() {
      uni.navigateBack({ delta: 1 })
    }
  }
}
</script>

<style>
.header {
  position: relative;
  overflow: hidden;
  margin: 0 -28rpx 26rpx;
  padding: calc(var(--status-bar-height) + 28rpx) 32rpx 38rpx;
  background: linear-gradient(142deg, #12233f 0%, #18365e 58%, #0d6a68 100%);
  color: #fff;
}

.header.compact {
  padding-top: calc(var(--status-bar-height) + 18rpx);
  padding-bottom: 28rpx;
}

.header-glow {
  position: absolute;
  width: 360rpx;
  height: 360rpx;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(35, 189, 178, 0.28), rgba(35, 189, 178, 0));
  right: -120rpx;
  top: -160rpx;
}

.header-row {
  position: relative;
  display: flex;
  align-items: flex-start;
}

.back {
  width: 58rpx;
  font-size: 54rpx;
  line-height: 1;
  margin-top: 2rpx;
}

.titles {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.eyebrow {
  font-size: 18rpx;
  letter-spacing: 4rpx;
  opacity: 0.55;
}

.title {
  margin-top: 10rpx;
  font-size: 40rpx;
  font-weight: 700;
  letter-spacing: 1rpx;
}

.subtitle {
  margin-top: 10rpx;
  font-size: 23rpx;
  line-height: 1.6;
  color: rgba(255, 255, 255, 0.72);
}

.right {
  margin-left: 16rpx;
}
</style>
