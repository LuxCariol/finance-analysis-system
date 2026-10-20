<template>
  <view class="section-title">
    <view class="section-left">
      <view class="marker"></view>
      <text class="title">{{ title }}</text>
    </view>
    <view class="section-right" @click="$emit('more')">
      <slot>
        <text v-if="more" class="more">{{ more }}</text>
      </slot>
    </view>
  </view>
</template>

<script>
export default {
  props: {
    title: { type: String, default: '' },
    more: { type: String, default: '' }
  }
}
</script>

<style>
.section-title {
  height: 72rpx;
  padding: 0 24rpx 0 12rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: #f3efef;
  color: #303133;
  border-top: 1rpx solid #f3efef;
  border-bottom: 1rpx solid #f3efef;
}

.section-left {
  display: flex;
  align-items: center;
}

.marker {
  width: 20rpx;
  height: 34rpx;
  margin-right: 6rpx;
  position: relative;
}

.marker::before,
.marker::after {
  content: "";
  position: absolute;
  left: 1rpx;
  width: 8rpx;
  height: 20rpx;
  border-radius: 2rpx;
  background: #3bbfe7;
  transform: skewX(-24deg);
}

.marker::before {
  top: 2rpx;
}

.marker::after {
  top: 15rpx;
}

.title {
  font-size: 27rpx;
  color: #303133;
}

.more {
  font-size: 24rpx;
  color: #666666;
}
</style>
